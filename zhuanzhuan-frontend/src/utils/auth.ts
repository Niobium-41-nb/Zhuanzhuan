const TOKEN_KEY = 'accessToken'
const REFRESH_KEY = 'refreshToken'
const USER_KEY = 'userInfo'

export function getToken(): string | null {
  return localStorage.getItem(TOKEN_KEY)
}

export function setToken(token: string) {
  localStorage.setItem(TOKEN_KEY, token)
}

export function getRefreshToken(): string | null {
  return localStorage.getItem(REFRESH_KEY)
}

export function setRefreshToken(token: string) {
  localStorage.setItem(REFRESH_KEY, token)
}

export function getUserInfo(): any {
  const info = localStorage.getItem(USER_KEY)
  return info ? JSON.parse(info) : null
}

export function setUserInfo(info: any) {
  localStorage.setItem(USER_KEY, JSON.stringify(info))
}

export function clearAuth() {
  localStorage.removeItem(TOKEN_KEY)
  localStorage.removeItem(REFRESH_KEY)
  localStorage.removeItem(USER_KEY)
}

export function isLoggedIn(): boolean {
  return !!getToken()
}
