<template>
  <div class="profile-page">
    <h2>个人中心</h2>
    <el-row :gutter="20">
      <el-col :span="8">
        <el-card>
          <div class="avatar-section">
            <el-avatar :size="80" :src="userStore.userInfo?.avatar" />
            <h3>{{ userStore.userInfo?.nickname || userStore.userInfo?.username }}</h3>
            <p class="role-tag">{{ userStore.userInfo?.role === 'admin' ? '管理员' : '普通用户' }}</p>
            <p>信誉分：{{ userStore.userInfo?.creditScore }}</p>
          </div>
          <el-divider />
          <el-menu :router="true">
            <el-menu-item index="/user/profile"><el-icon><User /></el-icon>个人信息</el-menu-item>
            <el-menu-item index="/user/address"><el-icon><Location /></el-icon>收货地址</el-menu-item>
            <el-menu-item index="/user/favorites"><el-icon><Star /></el-icon>我的收藏</el-menu-item>
            <el-menu-item index="/order/list"><el-icon><List /></el-icon>我的订单</el-menu-item>
          </el-menu>
        </el-card>
      </el-col>
      <el-col :span="16">
        <el-card>
          <template #header><span>编辑资料</span></template>
          <el-form :model="form" label-width="100px">
            <el-form-item label="昵称"><el-input v-model="form.nickname" /></el-form-item>
            <el-form-item label="简介"><el-input v-model="form.bio" type="textarea" :rows="3" /></el-form-item>
            <el-form-item label="性别">
              <el-radio-group v-model="form.gender">
                <el-radio :value="0">保密</el-radio>
                <el-radio :value="1">男</el-radio>
                <el-radio :value="2">女</el-radio>
              </el-radio-group>
            </el-form-item>
            <el-form-item><el-button type="primary" @click="save">保存</el-button></el-form-item>
          </el-form>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { useUserStore } from '@/stores/user'
import { userApi } from '@/api'

const userStore = useUserStore()
const form = reactive({ nickname: '', bio: '', gender: 0 })

onMounted(() => {
  const info = userStore.userInfo
  if (info) {
    form.nickname = info.nickname || ''
    form.bio = info.bio || ''
    form.gender = info.gender ?? 0
  }
})

async function save() {
  await userApi.updateUserInfo(form)
  ElMessage.success('保存成功')
  userStore.fetchUserInfo()
}
</script>

<style scoped>
.avatar-section { text-align: center; padding: 20px 0; }
.role-tag { color: #409eff; font-size: 12px; }
</style>
