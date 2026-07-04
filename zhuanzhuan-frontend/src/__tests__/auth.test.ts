import { describe, it, expect } from 'vitest'

describe('Auth Utils', () => {
  beforeEach(() => {
    localStorage.clear()
  })

  it('should store and retrieve token', async () => {
    const { setToken, getToken } = await import('@/utils/auth')
    setToken('test-token')
    expect(getToken()).toBe('test-token')
  })

  it('should clear auth data', async () => {
    const { setToken, clearAuth, getToken } = await import('@/utils/auth')
    setToken('test-token')
    clearAuth()
    expect(getToken()).toBeNull()
  })

  it('should check login status', async () => {
    const { setToken, isLoggedIn } = await import('@/utils/auth')
    expect(isLoggedIn()).toBe(false)
    setToken('test-token')
    expect(isLoggedIn()).toBe(true)
  })
})
