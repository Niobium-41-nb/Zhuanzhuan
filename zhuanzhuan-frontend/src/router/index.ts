import { createRouter, createWebHistory } from 'vue-router'
import { isLoggedIn, getUserInfo } from '@/utils/auth'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      component: () => import('@/layouts/MainLayout.vue'),
      children: [
        { path: '', name: 'Home', component: () => import('@/views/home/HomePage.vue'), meta: { title: '首页' } },
        { path: 'product/list', name: 'ProductList', component: () => import('@/views/product/ProductList.vue'), meta: { title: '商品列表' } },
        { path: 'product/:id', name: 'ProductDetail', component: () => import('@/views/product/ProductDetail.vue'), meta: { title: '商品详情' } },
        { path: 'product/publish', name: 'ProductPublish', component: () => import('@/views/product/ProductPublish.vue'), meta: { title: '发布商品', requiresAuth: true } },
        { path: 'cart', name: 'Cart', component: () => import('@/views/order/CartPage.vue'), meta: { title: '购物车', requiresAuth: true } },
        { path: 'order/list', name: 'OrderList', component: () => import('@/views/order/OrderList.vue'), meta: { title: '订单列表', requiresAuth: true } },
        { path: 'order/:id', name: 'OrderDetail', component: () => import('@/views/order/OrderDetail.vue'), meta: { title: '订单详情', requiresAuth: true } },
        { path: 'user/profile', name: 'UserProfile', component: () => import('@/views/user/UserProfile.vue'), meta: { title: '个人中心', requiresAuth: true } },
        { path: 'user/address', name: 'AddressManage', component: () => import('@/views/user/AddressManage.vue'), meta: { title: '地址管理', requiresAuth: true } },
        { path: 'user/my-products', name: 'MyProducts', component: () => import('@/views/product/MyProducts.vue'), meta: { title: '我的商品', requiresAuth: true } },
        { path: 'user/favorites', name: 'UserFavorites', component: () => import('@/views/user/UserFavorites.vue'), meta: { title: '我的收藏', requiresAuth: true } },
        { path: 'message', name: 'Message', component: () => import('@/views/message/MessagePage.vue'), meta: { title: '站内信', requiresAuth: true } },
        { path: 'guide', name: 'Guide', component: () => import('@/views/home/GuidePage.vue'), meta: { title: '使用指南' } },
        { path: 'contact', name: 'Contact', component: () => import('@/views/home/ContactPage.vue'), meta: { title: '联系我们' } }
      ]
    },
    {
      path: '/admin',
      component: () => import('@/layouts/AdminLayout.vue'),
      meta: { requiresAuth: true, requiresAdmin: true },
      children: [
        { path: 'users', name: 'AdminUsers', component: () => import('@/views/admin/AdminUsers.vue'), meta: { title: '用户管理' } },
        { path: 'products', name: 'AdminProducts', component: () => import('@/views/admin/AdminProducts.vue'), meta: { title: '商品审核' } },
        { path: 'orders', name: 'AdminOrders', component: () => import('@/views/admin/AdminOrders.vue'), meta: { title: '订单管理' } },
        { path: 'stats', name: 'AdminStats', component: () => import('@/views/admin/AdminStats.vue'), meta: { title: '数据统计' } },
        { path: 'announcements', name: 'AdminAnnouncements', component: () => import('@/views/admin/AdminAnnouncements.vue'), meta: { title: '公告管理' } }
      ]
    },
    { path: '/login', name: 'Login', component: () => import('@/views/user/LoginPage.vue'), meta: { title: '登录' } },
    { path: '/register', name: 'Register', component: () => import('@/views/user/RegisterPage.vue'), meta: { title: '注册' } },
    { path: '/forgot-password', name: 'ForgotPassword', component: () => import('@/views/user/ForgotPassword.vue'), meta: { title: '找回密码' } }
  ]
})

router.beforeEach((to, _from, next) => {
  document.title = `${to.meta.title} - 转转`
  if (to.meta.requiresAuth && !isLoggedIn()) {
    next('/login')
    return
  }
  if (to.meta.requiresAdmin) {
    const userInfo = getUserInfo()
    if (!userInfo || userInfo.role !== 'admin') {
      next('/')
      return
    }
  }
  next()
})

export default router
