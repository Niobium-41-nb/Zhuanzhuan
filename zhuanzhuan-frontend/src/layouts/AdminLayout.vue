<template>
  <div class="admin-layout">
    <el-container style="height: 100vh">
      <el-aside width="220px">
        <div class="admin-logo">转转 · 管理后台</div>
        <el-menu :router="true" :default-active="route.path">
          <el-menu-item index="/admin/users"><el-icon><User /></el-icon>用户管理</el-menu-item>
          <el-menu-item index="/admin/products"><el-icon><Goods /></el-icon>商品审核</el-menu-item>
          <el-menu-item index="/admin/orders"><el-icon><List /></el-icon>订单管理</el-menu-item>
          <el-menu-item index="/admin/stats"><el-icon><DataAnalysis /></el-icon>数据统计</el-menu-item>
          <el-menu-item index="/admin/announcements"><el-icon><Bell /></el-icon>公告管理</el-menu-item>
          <el-divider />
          <el-menu-item index="/"><el-icon><HomeFilled /></el-icon>返回前台</el-menu-item>
        </el-menu>
      </el-aside>
      <el-container>
        <el-header class="admin-header">
          <span>欢迎回来，{{ userStore.userInfo?.nickname }}</span>
          <el-button text @click="handleLogout">退出登录</el-button>
        </el-header>
        <el-main><router-view /></el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script setup lang="ts">
import { useRoute, useRouter } from 'vue-router'
import { useUserStore } from '@/stores/user'

const route = useRoute()
const router = useRouter()
const userStore = useUserStore()

function handleLogout() {
  userStore.logout()
  router.push('/login')
}
</script>

<style scoped>
.admin-logo { height: 60px; display: flex; align-items: center; justify-content: center; font-size: 16px; font-weight: bold; color: #409eff; border-bottom: 1px solid #e4e7ed; }
.admin-header { display: flex; align-items: center; justify-content: space-between; background: #fff; border-bottom: 1px solid #e4e7ed; padding: 0 20px; }
.el-aside { background: #304156; }
.el-aside .el-menu { border-right: none; }
</style>
