// ============================================================
// 转转（Zhuanzhuan）TypeScript 类型定义
// ============================================================

// ============ 通用 ============
export interface ApiResponse<T = any> {
  code: number
  message: string
  data: T
}

export interface PageResult<T> {
  records: T[]
  total: number
  page: number
  size: number
}

// ============ 用户 ============
export interface User {
  userId: number
  username: string
  nickname: string
  email: string
  phone: string
  avatar: string
  bio: string
  gender: number // 0-未知 1-男 2-女
  role: 'user' | 'admin'
  status: number // 0-禁用 1-正常
  creditScore: number
  productCount?: number
  lastLoginAt: string
  createdAt: string
}

export interface LoginDTO {
  account: string
  password: string
  code?: string
}

export interface RegisterDTO {
  username: string
  password: string
  email?: string
  phone?: string
  code: string
}

export interface LoginResult {
  accessToken: string
  refreshToken: string
  expiresIn: number
  user: User
}

export interface Address {
  id?: number
  userId?: number
  receiver: string
  phone: string
  province: string
  city: string
  district: string
  detail: string
  isDefault: number // 0-非默认 1-默认
}

// ============ 商品 ============
export interface Product {
  id: number
  title: string
  description: string
  price: number
  originalPrice?: number
  condition: string
  categoryId: number
  coverImage: string
  images?: ProductImage[]
  status: '待审核' | '在售' | '已下架' | '已售出' | '审核驳回'
  viewCount: number
  favoriteCount: number
  category?: {
    id: number
    name: string
    parentName?: string
  }
  seller?: {
    userId: number
    nickname: string
    avatar: string
    creditScore: number
    productCount?: number
  }
  isFavorited?: boolean
  createdAt: string
}

export interface ProductListVO {
  id: number
  title: string
  price: number
  originalPrice?: number
  condition: string
  coverImage: string
  status: string
  categoryId: number
  categoryName?: string
  seller?: {
    userId: number
    nickname: string
    avatar: string
    creditScore: number
  }
  viewCount: number
  favoriteCount: number
  createdAt: string
}

export interface ProductImage {
  id: number
  productId?: number
  url: string
  sortOrder: number
}

export interface Category {
  id: number
  name: string
  parentId?: number
  children?: Category[]
}

// ============ 订单 ============
export interface Order {
  orderId: number
  orderNo: string
  buyerId: number
  sellerId: number
  productId: number
  productTitle?: string
  productImage?: string
  buyerName?: string
  sellerName?: string
  totalPrice: number
  status: '待付款' | '待发货' | '待收货' | '已完成' | '已取消'
  buyerRemark?: string
  shippingName?: string
  shippingPhone?: string
  shippingAddress?: string
  logisticsCompany?: string
  logisticsNo?: string
  paidAt?: string
  shippedAt?: string
  receivedAt?: string
  createdAt: string
}

export interface CartItem {
  id: number
  productId: number
  quantity: number
  selected: number
  title?: string
  coverImage?: string
  price?: number
  status?: string
}

export interface Review {
  reviewId?: number
  orderId: number
  rating: number
  content: string
  createdAt?: string
}

// ============ 消息 ============
export interface Message {
  id: number
  fromUserId: number
  toUserId: number
  content: string
  isRead: number
  createdAt: string
}

export interface Announcement {
  id?: number
  title: string
  content: string
  status: number
  adminId?: number
  createdAt?: string
}

// ============ 统计 ============
export interface Statistics {
  userCount: number
  todayRegisterCount: number
  productCount: number
  todayProductCount: number
  orderCount: number
  todayOrderCount: number
}
