/**
 * 商品封面图片工具
 * 为没有封面的商品提供真实的 Unsplash 高清图片作为默认封面
 */

import type { ProductListVO, ProductImage } from '@/types'

/** 各分类对应的真实商品图片（Unsplash 精选商品摄影） */
const CATEGORY_IMAGES: Record<string, string> = {
  '电子产品': 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=400&h=300&fit=crop',       // 电子产品
  '数码': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400&h=300&fit=crop',          // 数码产品
  '手机': 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=400&h=300&fit=crop',            // 手机
  '电脑': 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400&h=300&fit=crop',            // 电脑
  '书籍': 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=400&h=300&fit=crop',            // 书籍
  '学习': 'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=400&h=300&fit=crop',            // 学习用品
  '生活用品': 'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=400&h=300&fit=crop',           // 生活用品
  '服饰': 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&h=300&fit=crop',               // 服饰
  '运动': 'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=400&h=300&fit=crop',            // 运动
  '美妆': 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400&h=300&fit=crop',            // 美妆
  '乐器': 'https://images.unsplash.com/photo-1519892300165-cb5542fb47c7?w=400&h=300&fit=crop',            // 乐器
}

/** 兜底默认商品图片（多张随机） */
const DEFAULT_IMAGES = [
  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=300&fit=crop', // 商品摆拍
  'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=400&h=300&fit=crop', // 购物袋
  'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=400&h=300&fit=crop',    // 购物
  'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=400&h=300&fit=crop', // 购物场景
  'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400&h=300&fit=crop', // 商店
]

/**
 * 根据分类名称获取对应的真实商品封面图片
 * @param categoryName 分类名称
 * @param productId 商品 ID（用于兜底时生成不同图片）
 */
export function getCategoryCover(categoryName?: string, productId?: number): string {
  if (!categoryName || !CATEGORY_IMAGES[categoryName]) {
    // 用商品 ID 作为种子，从 DEFAULT_IMAGES 中选取固定的图片
    const index = productId ? Math.abs(productId) % DEFAULT_IMAGES.length : Math.floor(Math.random() * DEFAULT_IMAGES.length)
    return DEFAULT_IMAGES[index]
  }
  return CATEGORY_IMAGES[categoryName]
}

/**
 * 获取商品封面（优先使用真实封面，否则用分类对应的真实图片兜底）
 * @param item 商品列表项
 */
export function getProductCover(item: { coverImage?: string | null; categoryName?: string; id?: number }): string {
  return item.coverImage || getCategoryCover(item.categoryName, item.id)
}

/**
 * 获取订单商品封面（优先使用真实图片，否则用兜底图片）
 * @param imageUrl 商品图片 URL
 * @param productTitle 商品标题（可选，用于生成不同兜底）
 * @param productId 商品 ID（可选）
 */
export function getOrderProductImage(imageUrl?: string | null, productTitle?: string, productId?: number): string {
  return imageUrl || getCategoryCover(undefined, productId ?? (productTitle ? productTitle.length : 0))
}
