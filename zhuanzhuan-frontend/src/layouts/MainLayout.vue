<template>
  <div class="main-layout">
    <header class="main-header">
      <div class="header-inner">
        <router-link to="/" class="logo">转转</router-link>
        <div class="header-right">
          <template v-if="userStore.isLoggedIn">
            <router-link to="/message">
              <el-badge :value="unreadCount" :hidden="unreadCount === 0">
                <el-button text><el-icon><Message /></el-icon>消息</el-button>
              </el-badge>
            </router-link>
            <router-link to="/user/profile">
              <el-avatar :size="32" :src="userStore.userInfo?.avatar" />
              <span class="username">{{ userStore.userInfo?.nickname || userStore.userInfo?.username }}</span>
            </router-link>
            <el-button text @click="handleLogout">退出</el-button>
          </template>
          <template v-else>
            <router-link to="/login"><el-button>登录</el-button></router-link>
            <router-link to="/register"><el-button type="primary">注册</el-button></router-link>
          </template>
        </div>
      </div>
    </header>
    <main class="main-content">
      <router-view />
    </main>
    <footer class="main-footer">
      <p>© 2026 转转 - 校园二手物品交易平台</p>
    </footer>
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/user'
import { messageApi } from '@/api'

const router = useRouter()
const userStore = useUserStore()
const unreadCount = ref(0)

onMounted(async () => {
  if (userStore.isLoggedIn) {
    try {
      const res = await messageApi.getUnreadCount()
      unreadCount.value = res.data.count
    } catch (_) {}
  }
})

function handleLogout() {
  userStore.logout()
  router.push('/')
}
</script>

<style scoped>
.main-layout { min-height: 100vh; display: flex; flex-direction: column; }
.main-header { background: #fff; border-bottom: 1px solid #e4e7ed; position: sticky; top: 0; z-index: 100; }
.header-inner { max-width: 1200px; margin: 0 auto; padding: 0 20px; height: 60px; display: flex; align-items: center; justify-content: space-between; }
.logo { font-size: 24px; font-weight: bold; color: #409eff; text-decoration: none; }
.header-right { display: flex; align-items: center; gap: 16px; }
.username { margin-left: 8px; color: #606266; }
.main-content { flex: 1; max-width: 1200px; width: 100%; margin: 20px auto; padding: 0 20px; }
.main-footer { text-align: center; padding: 20px; color: #909399; font-size: 14px; border-top: 1px solid #e4e7ed; }
</style>
