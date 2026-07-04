import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { userApi } from '@/api'
import { setToken, setRefreshToken, setUserInfo, clearAuth, getToken, getUserInfo } from '@/utils/auth'

export const useUserStore = defineStore('user', () => {
  const token = ref(getToken())
  const userInfo = ref(getUserInfo())

  const isLoggedIn = computed(() => !!token.value)
  const isAdmin = computed(() => userInfo.value?.role === 'admin')

  async function login(credentials: any) {
    const res = await userApi.login(credentials)
    token.value = res.data.accessToken
    setToken(res.data.accessToken)
    setRefreshToken(res.data.refreshToken)
    userInfo.value = res.data.user
    setUserInfo(res.data.user)
    return res.data
  }

  async function register(data: any) {
    return await userApi.register(data)
  }

  async function fetchUserInfo() {
    const res = await userApi.getUserInfo()
    userInfo.value = res.data
    setUserInfo(res.data)
    return res.data
  }

  function logout() {
    token.value = null
    userInfo.value = null
    clearAuth()
  }

  return { token, userInfo, isLoggedIn, isAdmin, login, register, fetchUserInfo, logout }
})
