import axios from 'axios'
import { ElMessage } from 'element-plus'
import router from '@/router'

const request = axios.create({
  baseURL: '/api/v1',
  timeout: 15000,
  headers: { 'Content-Type': 'application/json' }
})

// Request interceptor - add token
request.interceptors.request.use(
  config => {
    const token = localStorage.getItem('accessToken')
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
      localStorage.removeItem('accessToken')
      localStorage.removeItem('refreshToken')
      localStorage.removeItem('userInfo')
      router.push('/login')
    }
    return Promise.reject(new Error(res.message))
  },
  error => {
    ElMessage.error('网络错误')
    return Promise.reject(error)
  }
)

export default request
