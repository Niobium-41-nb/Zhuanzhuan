import request from '@/utils/request'

export const userApi = {
  register(data: any) { return request.post('/user/register', data) },
  login(data: any) { return request.post('/user/login', data) },
  logout() { return request.post('/user/logout') },
  refresh(data: any) { return request.post('/user/refresh', data) },
  sendCode(data: any) { return request.post('/user/code', data) },
  resetPassword(data: any) { return request.post('/user/password/reset', data) },
  getUserInfo() { return request.get('/user/info') },
  updateUserInfo(data: any) { return request.put('/user/info', data) },
  uploadAvatar(data: any) { return request.post('/user/avatar', data) },
  getAddresses() { return request.get('/user/address') },
  addAddress(data: any) { return request.post('/user/address', data) },
  updateAddress(id: number, data: any) { return request.put(`/user/address/${id}`, data) },
  deleteAddress(id: number) { return request.delete(`/user/address/${id}`) },
  setDefaultAddress(id: number) { return request.put(`/user/address/${id}/default`) }
}

export const productApi = {
  getList(params: any) { return request.get('/product/list', { params }) },
  getDetail(id: number) { return request.get(`/product/${id}`) },
  publish(data: any) { return request.post('/product', data) },
  update(id: number, data: any) { return request.put(`/product/${id}`, data) },
  delete(id: number) { return request.delete(`/product/${id}`) },
  updateStatus(id: number, data: any) { return request.put(`/product/${id}/status`, data) },
  toggleFavorite(data: any) { return request.post('/product/favorite', data) },
  getFavoriteList(params: any) { return request.get('/product/favorite/list', { params }) },
  getCategories() { return request.get('/category/list') },
  uploadImage(formData: FormData) { return request.post('/upload/image', formData, { headers: { 'Content-Type': 'multipart/form-data' } }) }
}

export const orderApi = {
  create(data: any) { return request.post('/order', data) },
  getList(params: any) { return request.get('/order/list', { params }) },
  getDetail(id: number) { return request.get(`/order/${id}`) },
  cancel(id: number) { return request.put(`/order/${id}/cancel`) },
  pay(id: number) { return request.put(`/order/${id}/pay`) },
  ship(id: number, data: any) { return request.put(`/order/${id}/ship`, data) },
  receive(id: number) { return request.put(`/order/${id}/receive`) },
  review(id: number, data: any) { return request.post(`/order/${id}/review`, data) },
  getLogs(id: number) { return request.get(`/order/${id}/log`) }
}

export const cartApi = {
  add(data: any) { return request.post('/cart', data) },
  getList() { return request.get('/cart/list') },
  update(id: number, data: any) { return request.put(`/cart/${id}`, data) },
  delete(id: number) { return request.delete(`/cart/${id}`) }
}

export const messageApi = {
  getConversations() { return request.get('/message/conversations') },
  getConversation(userId: number, params: any) { return request.get(`/message/conversation/${userId}`, { params }) },
  send(data: any) { return request.post('/message/send', data) },
  markRead(userId: number) { return request.put(`/message/read/${userId}`) },
  getUnreadCount() { return request.get('/message/unread/count') }
}

export const notificationApi = {
  getList(params: any) { return request.get('/notification/list', { params }) },
  markRead(id: number) { return request.put(`/notification/read/${id}`) },
  getUnreadCount() { return request.get('/notification/unread/count') }
}

export const adminApi = {
  // Users
  getUsers(params: any) { return request.get('/admin/users', { params }) },
  updateUserStatus(id: number, data: any) { return request.put(`/admin/user/${id}/status`, data) },
  updateUserRole(id: number, data: any) { return request.put(`/admin/user/${id}/role`, data) },
  // Products
  getProductList(params: any) { return request.get('/admin/products', { params }) },
  getReviewList(params: any) { return request.get('/admin/product/review', { params }) },
  reviewProduct(id: number, data: any) { return request.put(`/admin/product/review/${id}`, data) },
  adminUpdateProduct(id: number, data: any) { return request.put(`/admin/product/${id}`, data) },
  offlineProduct(id: number) { return request.put(`/admin/product/${id}/offline`) },
  adminDeleteProduct(id: number) { return request.delete(`/admin/product/${id}`) },
  // Orders
  getOrders(params: any) { return request.get('/admin/orders', { params }) },
  getOrderDetail(id: number) { return request.get(`/admin/order/${id}`) },
  updateOrderStatus(id: number, data: any) { return request.put(`/admin/order/${id}/status`, data) },
  // Statistics
  getStatistics() { return request.get('/admin/statistics') },
  getStatisticsDetail(params: any) { return request.get('/admin/statistics/detail', { params }) },
  // Announcements
  getAnnouncements() { return request.get('/admin/announcement') },
  createAnnouncement(data: any) { return request.post('/admin/announcement', data) },
  updateAnnouncement(id: number, data: any) { return request.put(`/admin/announcement/${id}`, data) },
  deleteAnnouncement(id: number) { return request.delete(`/admin/announcement/${id}`) }
}

export const indexApi = {
  getRecommend() { return request.get('/index/recommend') },
  getStatistics() { return request.get('/index/statistics') },
  getAnnouncements() { return request.get('/announcement/list') }
}
