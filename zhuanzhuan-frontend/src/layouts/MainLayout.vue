<template>
  <div class="main-layout">
    <header class="main-header" :class="{ scrolled: isScrolled }">
      <div class="header-inner">
        <div class="header-left">
          <router-link to="/" class="logo">
            <span class="logo-icon">转</span>
            <span class="logo-text">转转</span>
          </router-link>
          <nav class="main-nav">
            <router-link to="/" class="nav-link">首页</router-link>
            <router-link to="/product/list" class="nav-link">商品</router-link>
            <router-link to="/product/publish" class="nav-link" v-if="userStore.isLoggedIn">发布</router-link>
          </nav>
        </div>
        <div class="header-right">
          <template v-if="userStore.isLoggedIn">
            <router-link to="/cart" class="header-action">
              <el-icon size="20"><ShoppingCart /></el-icon>
            </router-link>
            <router-link to="/message" class="header-action" title="消息">
              <el-badge :value="unreadCount" :hidden="unreadCount === 0">
                <el-icon size="20"><ChatDotSquare /></el-icon>
              </el-badge>
            </router-link>
            <el-popover placement="bottom" :width="320" trigger="click">
              <template #reference>
                <span class="header-action" title="通知">
                  <el-badge :value="notifUnread" :hidden="notifUnread === 0">
                    <el-icon size="20"><Bell /></el-icon>
                  </el-badge>
                </span>
              </template>
              <div class="notif-popover">
                <div class="notif-pop-header">系统通知</div>
                <div v-if="!notifications.length" class="notif-empty">暂无通知</div>
                <div v-for="n in notifications.slice(0,10)" :key="n.id" class="notif-item" :class="{ unread: !n.isRead }" @click="readNotif(n)">
                  <p class="notif-title">{{ n.title }}</p>
                  <p class="notif-content">{{ n.content }}</p>
                  <span class="notif-time">{{ formatNotifTime(n.createdAt) }}</span>
                </div>
              </div>
            </el-popover>
            <div class="user-menu">
              <el-dropdown trigger="click" @command="handleUserCommand">
                <span class="user-trigger">
                  <el-avatar :size="32" :src="userStore.userInfo?.avatar">
                    {{ (userStore.userInfo?.nickname || userStore.userInfo?.username)?.[0] }}
                  </el-avatar>
                  <span class="username">{{ userStore.userInfo?.nickname || userStore.userInfo?.username }}</span>
                  <el-icon><ArrowDown /></el-icon>
                </span>
                <template #dropdown>
                  <el-dropdown-menu>
                    <el-dropdown-item command="profile">个人中心</el-dropdown-item>
                    <el-dropdown-item command="myProducts">我的商品</el-dropdown-item>
                    <el-dropdown-item command="orders">我的订单</el-dropdown-item>
                    <el-dropdown-item command="favorites">我的收藏</el-dropdown-item>
                    <el-dropdown-item command="address">地址管理</el-dropdown-item>
                    <el-dropdown-item v-if="userStore.isAdmin" command="admin" divided>管理后台</el-dropdown-item>
                    <el-dropdown-item command="logout" divided>退出登录</el-dropdown-item>
                  </el-dropdown-menu>
                </template>
              </el-dropdown>
            </div>
          </template>
          <template v-else>
            <router-link to="/login" class="header-action-link">登录</router-link>
            <router-link to="/register" class="header-register-btn">注册</router-link>
          </template>
        </div>
      </div>
    </header>
    <main class="main-content">
      <router-view />
    </main>
    <footer class="main-footer">
      <div class="footer-inner">
        <div class="footer-brand">
          <span class="footer-logo">转</span>
          <span class="footer-name">转转</span>
          <p class="footer-desc">校园二手物品交易平台 · 安全 · 便捷 · 可靠</p>
        </div>
        <div class="footer-links">
          <div class="footer-col">
            <h4>功能</h4>
            <router-link to="/product/list">浏览商品</router-link>
            <router-link to="/product/publish">发布商品</router-link>
          </div>
          <div class="footer-col">
            <h4>帮助</h4>
            <router-link to="/guide">使用指南</router-link>
            <router-link to="/contact">联系我们</router-link>
          </div>
        </div>
        <div class="footer-bottom">
          <p>© 2026 转转 - 校园二手物品交易平台</p>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { onMounted, onUnmounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/user'
import { messageApi, notificationApi } from '@/api'
import { ChatDotSquare, Bell } from '@element-plus/icons-vue'

const router = useRouter()
const userStore = useUserStore()
const unreadCount = ref(0)
const notifUnread = ref(0)
const notifications = ref<any[]>([])
const isScrolled = ref(false)

let scrollHandler: (() => void) | null = null
let refreshTimer: ReturnType<typeof setInterval> | null = null

onMounted(async () => {
  if (userStore.isLoggedIn) {
    try {
      const res = await messageApi.getUnreadCount()
      unreadCount.value = res.data?.count || 0
    } catch (_) {}
    try {
      const nRes = await notificationApi.getUnreadCount()
      notifUnread.value = nRes.data?.count || 0
      loadNotifications()
    } catch (_) {}
    // 每30秒刷新一次未读数
    refreshTimer = setInterval(refreshUnread, 30000)
  }
  scrollHandler = () => { isScrolled.value = window.scrollY > 10 }
  window.addEventListener('scroll', scrollHandler, { passive: true })
})

onUnmounted(() => {
  if (scrollHandler) window.removeEventListener('scroll', scrollHandler)
  if (refreshTimer) clearInterval(refreshTimer)
})

async function refreshUnread() {
  try {
    const res = await messageApi.getUnreadCount()
    unreadCount.value = res.data?.count || 0
    const nRes = await notificationApi.getUnreadCount()
    notifUnread.value = nRes.data?.count || 0
  } catch (_) {}
}

async function loadNotifications() {
  try {
    const res = await notificationApi.getList({ page: 1, size: 10 })
    notifications.value = res.data || []
  } catch (_) {}
}

async function readNotif(n: any) {
  if (!n.isRead) {
    await notificationApi.markRead(n.id)
    n.isRead = 1
    notifUnread.value = Math.max(0, notifUnread.value - 1)
  }
  // 根据通知类型跳转
  if (n.type === 'order') router.push('/order/list')
  else if (n.type === 'review') router.push('/order/list')
  else router.push('/message')
}

function formatNotifTime(t: string) {
  if (!t) return ''
  const d = new Date(t)
  const now = new Date()
  const diff = now.getTime() - d.getTime()
  if (diff < 3600000) return Math.floor(diff / 60000) + '分钟前'
  if (diff < 86400000) return Math.floor(diff / 3600000) + '小时前'
  return d.toLocaleDateString('zh-CN')
}

function handleUserCommand(command: string) {
  switch (command) {
    case 'profile': router.push('/user/profile'); break
    case 'myProducts': router.push('/user/my-products'); break
    case 'orders': router.push('/order/list'); break
    case 'favorites': router.push('/user/favorites'); break
    case 'address': router.push('/user/address'); break
    case 'admin': router.push('/admin/users'); break
    case 'logout':
      userStore.logout()
      router.push('/')
      break
  }
}
</script>

<style scoped>
/* ===== Header ===== */
.main-header {
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border-bottom: 1px solid transparent;
  position: sticky;
  top: 0;
  z-index: 100;
  height: var(--header-height);
  transition: all 0.3s ease;
}

.main-header.scrolled {
  border-bottom-color: var(--c-border);
  box-shadow: 0 1px 8px rgba(0, 0, 0, 0.06);
  background: rgba(255, 255, 255, 0.95);
}

.header-inner {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: 0 24px;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 40px;
}

/* Logo */
.logo {
  display: flex;
  align-items: center;
  gap: 8px;
  text-decoration: none;
}

.logo-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  background: var(--c-primary);
  color: white;
  font-family: 'ZCOOL QingKe HuangYou', sans-serif;
  font-size: 20px;
  border-radius: var(--radius-sm);
  transform: rotate(-8deg);
  transition: transform 0.3s ease;
}

.logo:hover .logo-icon {
  transform: rotate(0deg);
}

.logo-text {
  font-family: 'ZCOOL QingKe HuangYou', sans-serif;
  font-size: 22px;
  color: var(--c-primary-dark);
  letter-spacing: 2px;
}

/* Navigation */
.main-nav {
  display: flex;
  gap: 8px;
}

.nav-link {
  padding: 8px 16px;
  border-radius: var(--radius-sm);
  font-size: 14px;
  font-weight: 500;
  color: var(--c-text-secondary);
  transition: all 0.2s;
}

.nav-link:hover {
  color: var(--c-primary);
  background: var(--c-primary-bg);
}

.nav-link.router-link-exact-active {
  color: var(--c-primary);
  font-weight: 600;
}

/* Header Right */
.header-right {
  display: flex;
  align-items: center;
  gap: 12px;
}

.header-action {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  border-radius: 50%;
  color: var(--c-text-secondary);
  transition: all 0.2s;
}

.header-action:hover {
  background: var(--c-border-light);
  color: var(--c-primary);
}

/* User Menu */
.user-trigger {
  display: flex;
  align-items: center;
  gap: 8px;
  cursor: pointer;
  padding: 4px 8px;
  border-radius: var(--radius-sm);
  transition: background 0.2s;
}

.user-trigger:hover {
  background: var(--c-border-light);
}

.username {
  font-size: 14px;
  color: var(--c-text);
  max-width: 80px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

/* Auth Actions */
.header-action-link {
  padding: 8px 20px;
  border-radius: var(--radius-sm);
  font-size: 14px;
  font-weight: 500;
  color: var(--c-text-secondary);
  transition: all 0.2s;
}

.header-action-link:hover {
  color: var(--c-primary);
}

.header-register-btn {
  padding: 8px 24px;
  border-radius: var(--radius-sm);
  font-size: 14px;
  font-weight: 600;
  color: white;
  background: var(--c-primary);
  transition: all 0.2s;
}

.header-register-btn:hover {
  background: var(--c-primary-dark);
  transform: translateY(-1px);
  box-shadow: var(--shadow-md);
}

/* ===== Main Content ===== */
.main-content {
  flex: 1;
  max-width: var(--max-width);
  width: 100%;
  margin: 0 auto;
  padding: 24px;
}

/* ===== Footer ===== */
.main-footer {
  background: var(--c-surface);
  border-top: 1px solid var(--c-border);
  margin-top: 60px;
}

.footer-inner {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: 48px 24px 24px;
}

.footer-brand {
  text-align: center;
  margin-bottom: 32px;
}

.footer-logo {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  background: var(--c-primary);
  color: white;
  font-family: 'ZCOOL QingKe HuangYou', sans-serif;
  font-size: 22px;
  border-radius: var(--radius-sm);
  margin-right: 8px;
}

.footer-name {
  font-family: 'ZCOOL QingKe HuangYou', sans-serif;
  font-size: 24px;
  color: var(--c-primary-dark);
  vertical-align: middle;
}

.footer-desc {
  color: var(--c-muted);
  font-size: 13px;
  margin-top: 8px;
}

.footer-links {
  display: flex;
  justify-content: center;
  gap: 60px;
  margin-bottom: 32px;
}

.footer-col h4 {
  font-size: 13px;
  font-weight: 600;
  color: var(--c-text);
  margin-bottom: 12px;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.footer-col a {
  display: block;
  font-size: 13px;
  color: var(--c-text-secondary);
  margin-bottom: 8px;
  transition: color 0.2s;
}

.footer-col a:hover {
  color: var(--c-primary);
}

.footer-bottom {
  text-align: center;
  padding-top: 24px;
  border-top: 1px solid var(--c-border-light);
}

.footer-bottom p {
  color: var(--c-muted);
  font-size: 12px;
}

/* Notification Popover */
.notif-popover {
  max-height: 400px;
  overflow-y: auto;
}

.notif-pop-header {
  font-weight: 700;
  font-size: 14px;
  padding-bottom: 10px;
  border-bottom: 1px solid var(--c-border-light);
  margin-bottom: 4px;
}

.notif-empty {
  padding: 24px;
  text-align: center;
  color: var(--c-muted);
  font-size: 13px;
}

.notif-item {
  padding: 10px 4px;
  border-bottom: 1px solid var(--c-border-light);
  cursor: pointer;
  transition: background 0.15s;
}

.notif-item:hover {
  background: var(--c-primary-bg);
}

.notif-item.unread {
  background: #F0F9F4;
}

.notif-title {
  font-size: 13px;
  font-weight: 600;
  color: var(--c-text);
  margin: 0 0 4px;
}

.notif-content {
  font-size: 12px;
  color: var(--c-text-secondary);
  margin: 0 0 4px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.notif-time {
  font-size: 11px;
  color: var(--c-muted);
}
</style>
