import axios from 'axios'
import { ElMessage } from 'element-plus'
import router from '@/router'
import { getToken, getRefreshToken, setToken, setRefreshToken, clearAuth } from './auth'

const request = axios.create({
  baseURL: '/api/v1',
  timeout: 15000,
  headers: { 'Content-Type': 'application/json' }
})

// ============ Token 刷新机制 ============
let isRefreshing = false
let failedQueue: Array<{
  resolve: (value?: unknown) => void
  reject: (reason?: unknown) => void
}> = []

function processQueue(error: unknown, token: string | null = null) {
  failedQueue.forEach(prom => {
    if (error) {
      prom.reject(error)
    } else {
      prom.resolve(token)
    }
  })
  failedQueue = []
}

// Request interceptor - add token
request.interceptors.request.use(
  config => {
    const token = getToken()
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  error => Promise.reject(error)
)

// Response interceptor
request.interceptors.response.use(
  response => {
    const res = response.data
    if (res.code === 200 || res.code === 201) {
      return res
    }
    ElMessage.error(res.message || '请求失败')
    if (res.code === 401) {
      clearAuth()
      router.push('/login')
    }
    return Promise.reject(new Error(res.message))
  },
  async error => {
    const originalRequest = error.config

    // 401 且不是刷新 Token 的请求 → 尝试刷新
    if (error.response?.status === 401 && !originalRequest._retry) {
      if (isRefreshing) {
        // 有刷新在进行中，将请求加入队列
        return new Promise((resolve, reject) => {
          failedQueue.push({ resolve, reject })
        }).then(token => {
          originalRequest.headers.Authorization = `Bearer ${token}`
          return request(originalRequest)
        })
      }

      originalRequest._retry = true
      isRefreshing = true

      const refreshToken = getRefreshToken()
      if (!refreshToken) {
        isRefreshing = false
        clearAuth()
        router.push('/login')
        return Promise.reject(error)
      }

      try {
        const res = await axios.post('/api/v1/user/refresh', { refreshToken })
        const data = res.data.data
        if (data) {
          setToken(data.accessToken)
          setRefreshToken(data.refreshToken)
          processQueue(null, data.accessToken)
          originalRequest.headers.Authorization = `Bearer ${data.accessToken}`
          return request(originalRequest)
        }
      } catch (refreshError) {
        processQueue(refreshError, null)
        clearAuth()
        router.push('/login')
        return Promise.reject(refreshError)
      } finally {
        isRefreshing = false
      }
    }

    // 区分不同类型的错误
    if (error.code === 'ECONNABORTED') {
      ElMessage.error('请求超时，请检查网络连接')
    } else if (!error.response) {
      ElMessage.error('网络连接失败，请检查网络')
    } else if (error.response.status >= 500) {
      ElMessage.error('服务器错误，请稍后重试')
    } else if (error.response.status === 403) {
      ElMessage.error('权限不足')
    } else if (error.response.status === 404) {
      ElMessage.error('请求的资源不存在')
    } else {
      ElMessage.error(error.response.data?.message || '请求失败')
    }
    return Promise.reject(error)
  }
)

export default request
