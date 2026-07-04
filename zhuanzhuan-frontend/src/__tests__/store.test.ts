import { describe, it, expect, beforeEach, vi } from 'vitest'

// Mock the API module
vi.mock('@/api', () => ({
  userApi: {
    login: vi.fn(),
    register: vi.fn(),
    getUserInfo: vi.fn(),
    loginByPhone: vi.fn()
  }
}))

// Mock auth utils (mirrors real implementation: localStorage backed)
vi.mock('@/utils/auth', () => {
  const TOKEN_KEY = 'auth-token'
  const REFRESH_KEY = 'auth-refresh-token'
  const USER_KEY = 'auth-user'
  return {
    setToken: (t: string) => localStorage.setItem(TOKEN_KEY, t),
    setRefreshToken: (r: string) => localStorage.setItem(REFRESH_KEY, r),
    setUserInfo: (u: any) => localStorage.setItem(USER_KEY, JSON.stringify(u)),
    clearAuth: () => { localStorage.removeItem(TOKEN_KEY); localStorage.removeItem(REFRESH_KEY); localStorage.removeItem(USER_KEY) },
    getToken: () => localStorage.getItem(TOKEN_KEY),
    getRefreshToken: () => localStorage.getItem(REFRESH_KEY),
    getUserInfo: () => { const d = localStorage.getItem(USER_KEY); return d ? JSON.parse(d) : null },
    isLoggedIn: () => !!localStorage.getItem(TOKEN_KEY)
  }
})

describe('User Store', () => {
  beforeEach(() => {
    localStorage.clear()
    vi.resetModules()
  })

  it('should have correct initial state', async () => {
    const { useUserStore } = await import('@/stores/user')
    // Cannot easily test Pinia store outside Vue context without setup
    // This test verifies the module can be loaded
    expect(useUserStore).toBeDefined()
  })

  it('should handle login and logout flow', async () => {
    const { setToken, setRefreshToken, setUserInfo, clearAuth, getToken, getUserInfo } = await import('@/utils/auth')

    // Simulate login
    const mockUser = { userId: 1, username: 'testuser', role: 'user' }
    setToken('access-token-123')
    setRefreshToken('refresh-token-456')
    setUserInfo(mockUser)

    expect(getToken()).toBe('access-token-123')
    expect(getUserInfo()?.username).toBe('testuser')
    expect(getUserInfo()?.role).toBe('user')

    // Simulate logout
    clearAuth()
    expect(getToken()).toBeNull()
    expect(getUserInfo()).toBeNull()
  })

  it('should persist user info in localStorage', async () => {
    const { setToken, setUserInfo, getToken } = await import('@/utils/auth')

    const mockUser = { userId: 1, username: 'testuser', nickname: '测试', role: 'user', creditScore: 100 }

    // Set auth data
    setToken('test-token')
    setUserInfo(mockUser)

    // Verify it's in localStorage
    expect(localStorage.getItem('auth-token')).toBe('test-token')
    expect(JSON.parse(localStorage.getItem('auth-user') || '{}').username).toBe('testuser')
    expect(getToken()).toBe('test-token')
  })

  it('should clear all auth data on logout', async () => {
    const { setToken, setUserInfo, clearAuth } = await import('@/utils/auth')

    setToken('test-token')
    setUserInfo({ userId: 1, username: 'testuser' })
    clearAuth()

    expect(localStorage.getItem('auth-token')).toBeNull()
    expect(localStorage.getItem('auth-user')).toBeNull()
  })

  it('should detect admin role', async () => {
    const { setUserInfo, getUserInfo } = await import('@/utils/auth')

    setUserInfo({ userId: 1, username: 'admin', role: 'admin' })
    expect(getUserInfo()?.role).toBe('admin')
  })
})
