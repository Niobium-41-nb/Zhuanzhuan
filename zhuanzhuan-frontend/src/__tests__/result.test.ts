import { describe, it, expect } from 'vitest'

describe('Result', () => {
  it('should create success result', () => {
    const result = { code: 200, message: 'success', data: 'hello' }
    expect(result.code).toBe(200)
    expect(result.data).toBe('hello')
  })

  it('should create error result', () => {
    const result = { code: 400, message: '参数错误', data: null }
    expect(result.code).toBe(400)
    expect(result.message).toBe('参数错误')
  })

  it('should create page result', () => {
    const result = {
      code: 200,
      message: 'success',
      data: [{ id: 1, title: '测试商品' }],
      total: 1,
      page: 1,
      size: 20,
      pages: 1
    }
    expect(result.data).toHaveLength(1)
    expect(result.total).toBe(1)
  })
})
