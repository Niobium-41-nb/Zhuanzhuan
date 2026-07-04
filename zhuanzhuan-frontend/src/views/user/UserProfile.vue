<template>
  <div class="profile-page">
    <el-row :gutter="24">
      <!-- Sidebar -->
      <el-col :span="7">
        <el-card class="sidebar-card">
          <div class="avatar-section">
            <div class="avatar-wrap" @click="triggerUpload">
              <el-avatar :size="88" :src="avatarUrl" class="profile-avatar">
                {{ (userStore.userInfo?.nickname || userStore.userInfo?.username)?.[0] }}
              </el-avatar>
              <div class="avatar-overlay">
                <el-icon size="24"><Camera /></el-icon>
                <span>更换头像</span>
              </div>
            </div>
            <input
              ref="fileInputRef"
              type="file"
              accept="image/jpeg,image/png,image/gif,image/webp"
              style="display:none"
              @change="handleFileSelect"
            />
            <h3 class="profile-name">{{ userStore.userInfo?.nickname || userStore.userInfo?.username }}</h3>
            <p class="profile-role">{{ userStore.userInfo?.role === 'admin' ? '管理员' : '普通用户' }}</p>
            <div class="profile-credit">
              <span class="credit-dot"></span>
              信誉分 {{ userStore.userInfo?.creditScore }}
            </div>
          </div>
          <el-divider style="margin:16px 0" />
          <el-menu :router="true" class="profile-menu">
            <el-menu-item index="/user/profile">
              <el-icon><User /></el-icon>
              <span>个人信息</span>
            </el-menu-item>
            <el-menu-item index="/user/address">
              <el-icon><Location /></el-icon>
              <span>收货地址</span>
            </el-menu-item>
            <el-menu-item index="/user/favorites">
              <el-icon><Star /></el-icon>
              <span>我的收藏</span>
            </el-menu-item>
            <el-menu-item index="/order/list">
              <el-icon><List /></el-icon>
              <span>我的订单</span>
            </el-menu-item>
          </el-menu>
        </el-card>
      </el-col>

      <!-- Main Content -->
      <el-col :span="17">
        <el-card class="main-card">
          <template #header><span class="card-title">编辑资料</span></template>
          <el-form :model="form" label-width="80px" class="profile-form">
            <el-form-item label="昵称">
              <el-input v-model="form.nickname" placeholder="给自己取个昵称" maxlength="20" show-word-limit />
            </el-form-item>
            <el-form-item label="简介">
              <el-input v-model="form.bio" type="textarea" :rows="4" placeholder="介绍下自己..." maxlength="200" show-word-limit />
            </el-form-item>
            <el-form-item label="性别">
              <el-radio-group v-model="form.gender">
                <el-radio :value="0">保密</el-radio>
                <el-radio :value="1">男</el-radio>
                <el-radio :value="2">女</el-radio>
              </el-radio-group>
            </el-form-item>
            <el-divider />
            <el-form-item>
              <el-button type="primary" @click="save" :loading="saving" size="large" class="save-btn">保存修改</el-button>
            </el-form-item>
          </el-form>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { Camera, User, Location, Star, List } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'
import { userApi, productApi } from '@/api'

const userStore = useUserStore()
const fileInputRef = ref<HTMLInputElement>()
const avatarUrl = ref(userStore.userInfo?.avatar || '')
const saving = ref(false)
const uploading = ref(false)

const form = reactive({ nickname: '', bio: '', gender: 0 })

onMounted(() => {
  const info = userStore.userInfo
  if (info) {
    form.nickname = info.nickname || ''
    form.bio = info.bio || ''
    form.gender = info.gender ?? 0
  }
})

function triggerUpload() {
  fileInputRef.value?.click()
}

async function handleFileSelect(e: Event) {
  const input = e.target as HTMLInputElement
  const file = input.files?.[0]
  if (!file) return

  // Preview
  const blobUrl = URL.createObjectURL(file)
  avatarUrl.value = blobUrl

  uploading.value = true
  try {
    // Step 1: Upload file to /upload/image
    const formData = new FormData()
    formData.append('file', file)
    const uploadRes = await productApi.uploadImage(formData)
    const imageUrl = uploadRes.data.url

    // Step 2: Save avatar URL to user profile
    await userApi.uploadAvatar({ avatar: imageUrl })

    // Step 3: Refresh user info
    await userStore.fetchUserInfo()
    avatarUrl.value = userStore.userInfo?.avatar || imageUrl

    ElMessage.success('头像更新成功')
  } catch (_) {
    avatarUrl.value = userStore.userInfo?.avatar || ''
    ElMessage.error('头像上传失败')
  } finally {
    uploading.value = false
    input.value = '' // Reset input
  }
}

async function save() {
  saving.value = true
  try {
    await userApi.updateUserInfo(form)
    ElMessage.success('保存成功')
    await userStore.fetchUserInfo()
  } catch (_) {
    ElMessage.error('保存失败')
  } finally {
    saving.value = false
  }
}
</script>

<style scoped>
.profile-page {
  max-width: 1000px;
  margin: 0 auto;
}

/* Sidebar */
.sidebar-card {
  border-radius: var(--radius-md);
}

.avatar-section {
  text-align: center;
  padding: 8px 0;
}

.avatar-wrap {
  position: relative;
  display: inline-block;
  cursor: pointer;
  border-radius: 50%;
  overflow: hidden;
}

.profile-avatar {
  display: block;
  border: 3px solid var(--c-border-light);
  transition: filter 0.3s;
}

.avatar-overlay {
  position: absolute;
  inset: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 4px;
  background: rgba(0,0,0,0.5);
  color: white;
  font-size: 12px;
  opacity: 0;
  transition: opacity 0.3s;
  border-radius: 50%;
}

.avatar-wrap:hover .avatar-overlay {
  opacity: 1;
}

.avatar-wrap:hover .profile-avatar {
  filter: brightness(0.8);
}

.profile-name {
  font-size: 18px;
  font-weight: 700;
  margin-top: 12px;
  color: var(--c-text);
}

.profile-role {
  font-size: 12px;
  color: var(--c-primary);
  margin-top: 4px;
}

.profile-credit {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  margin-top: 8px;
  font-size: 13px;
  color: var(--c-text-secondary);
}

.credit-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: var(--c-primary-light);
}

.profile-menu {
  border-right: none !important;
}

.profile-menu .el-menu-item {
  border-radius: var(--radius-sm);
  margin: 2px 0;
}

.profile-menu .el-menu-item.is-active {
  background: var(--c-primary-bg);
  color: var(--c-primary);
}

/* Main Card */
.main-card {
  border-radius: var(--radius-md);
}

.card-title {
  font-size: 16px;
  font-weight: 600;
}

.profile-form {
  padding: 8px 0;
}

.save-btn {
  min-width: 140px;
}

/* Responsive */
@media (max-width: 768px) {
  .profile-page .el-row {
    flex-direction: column;
  }
}
</style>
