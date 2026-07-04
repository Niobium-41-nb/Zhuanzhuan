<template>
  <div class="auth-page">
    <div class="auth-bg">
      <div class="auth-shape auth-shape-1"></div>
      <div class="auth-shape auth-shape-2"></div>
    </div>
    <div class="auth-card">
      <div class="auth-header">
        <router-link to="/" class="auth-logo">
          <span class="auth-logo-icon">转</span>
        </router-link>
        <h1 class="auth-title">欢迎回来</h1>
        <p class="auth-desc">登录你的转转账号</p>
      </div>

      <el-tabs v-model="loginMode" class="auth-tabs" @tab-change="resetForm">
        <el-tab-pane label="密码登录" name="password">
          <el-form ref="formRef" :model="form" :rules="rules" label-width="0" class="auth-form">
            <el-form-item prop="account">
              <el-input v-model="form.account" placeholder="用户名 / 邮箱 / 手机号" size="large" :prefix-icon="User" />
            </el-form-item>
            <el-form-item prop="password">
              <el-input v-model="form.password" type="password" placeholder="密码" size="large" show-password :prefix-icon="Lock" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" size="large" @click="handleLogin" :loading="loading" class="auth-submit">登录</el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>

        <el-tab-pane label="验证码登录" name="code">
          <el-form ref="codeFormRef" :model="codeForm" :rules="codeRules" label-width="0" class="auth-form">
            <el-form-item prop="phone">
              <el-input v-model="codeForm.phone" placeholder="手机号" size="large" :prefix-icon="Iphone" maxlength="11" />
            </el-form-item>
            <el-form-item prop="code">
              <div class="code-row">
                <el-input v-model="codeForm.code" placeholder="验证码" size="large" :prefix-icon="Key" class="code-input" />
                <el-button class="code-btn" :disabled="codeSending" @click="sendSmsCode">
                  {{ codeBtnText }}
                </el-button>
              </div>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" size="large" @click="handleCodeLogin" :loading="codeLoading" class="auth-submit">登录</el-button>
            </el-form-item>
          </el-form>
        </el-tab-pane>
      </el-tabs>

      <div class="auth-footer">
        还没有账号？<router-link to="/register">立即注册</router-link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { User, Lock, Iphone, Key } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'
import { userApi } from '@/api'

const router = useRouter()
const userStore = useUserStore()

const loginMode = ref('password')

// === 密码登录 ===
const formRef = ref()
const loading = ref(false)
const form = reactive({ account: '', password: '' })
const rules = {
  account: [{ required: true, message: '请输入账号', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
}

async function handleLogin() {
  const valid = await formRef.value.validate().catch(() => false)
  if (!valid) return
  loading.value = true
  try {
    await userStore.login(form)
    ElMessage.success('登录成功')
    router.push('/')
  } catch (_) {} finally {
    loading.value = false
  }
}

// === 验证码登录 ===
const codeFormRef = ref()
const codeLoading = ref(false)
const codeSending = ref(false)
const codeBtnText = ref('获取验证码')
const codeForm = reactive({ phone: '', code: '' })
const codeRules = {
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '手机号格式不正确', trigger: 'blur' }
  ],
  code: [{ required: true, message: '请输入验证码', trigger: 'blur' }]
}

async function sendSmsCode() {
  if (!/^1[3-9]\d{9}$/.test(codeForm.phone)) {
    ElMessage.warning('请输入正确的手机号')
    return
  }
  codeSending.value = true
  try {
    await userApi.sendCode({ target: codeForm.phone, type: 'sms' })
    ElMessage.success('验证码已发送')
    let count = 60
    codeBtnText.value = `${count}s`
    const timer = setInterval(() => {
      count--
      codeBtnText.value = `${count}s`
      if (count <= 0) {
        clearInterval(timer)
        codeBtnText.value = '获取验证码'
        codeSending.value = false
      }
    }, 1000)
  } catch (_) {
    codeSending.value = false
    codeBtnText.value = '获取验证码'
  }
}

async function handleCodeLogin() {
  const valid = await codeFormRef.value.validate().catch(() => false)
  if (!valid) return
  codeLoading.value = true
  try {
    await userStore.loginByPhone({ account: codeForm.phone, code: codeForm.code })
    ElMessage.success('登录成功')
    router.push('/')
  } catch (_) {} finally {
    codeLoading.value = false
  }
}

function resetForm() {
  form.account = ''
  form.password = ''
  codeForm.phone = ''
  codeForm.code = ''
  formRef.value?.clearValidate()
  codeFormRef.value?.clearValidate()
}
</script>

<style scoped>
.auth-page {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(135deg, #1B4332 0%, #2D6A4F 50%, #40916C 100%);
  position: relative;
  overflow: hidden;
}

.auth-bg {
  position: absolute;
  inset: 0;
  pointer-events: none;
}

.auth-shape {
  position: absolute;
  border-radius: 50%;
  opacity: 0.08;
}

.auth-shape-1 {
  width: 500px; height: 500px;
  background: var(--c-warm);
  top: -150px; right: -100px;
  animation: floatAuth 10s ease-in-out infinite;
}

.auth-shape-2 {
  width: 350px; height: 350px;
  background: var(--c-primary-light);
  bottom: -100px; left: -80px;
  animation: floatAuth 8s ease-in-out infinite reverse;
}

@keyframes floatAuth {
  0%, 100% { transform: translate(0, 0) scale(1); }
  50% { transform: translate(20px, -20px) scale(1.05); }
}

.auth-card {
  background: var(--c-surface);
  border-radius: var(--radius-lg);
  padding: 48px 40px 40px;
  width: 420px;
  max-width: 90vw;
  box-shadow: 0 20px 60px rgba(0,0,0,0.2);
  position: relative;
  z-index: 1;
}

.auth-header {
  text-align: center;
  margin-bottom: 32px;
}

.auth-logo-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 48px;
  background: var(--c-primary);
  color: white;
  font-family: 'ZCOOL QingKe HuangYou', sans-serif;
  font-size: 26px;
  border-radius: var(--radius-md);
  transform: rotate(-8deg);
  margin-bottom: 16px;
}

.auth-title {
  font-size: 24px;
  font-weight: 700;
  color: var(--c-text);
  margin-bottom: 8px;
}

.auth-desc {
  color: var(--c-text-secondary);
  font-size: 14px;
}

.auth-form {
  margin-bottom: 24px;
}

.auth-submit {
  width: 100%;
  height: 48px;
  font-size: 16px;
  font-weight: 600;
  border-radius: var(--radius-sm);
}

.auth-tabs {
  margin-bottom: 8px;
}

.auth-tabs :deep(.el-tabs__item) {
  font-size: 15px;
  font-weight: 600;
  color: var(--c-text-secondary);
}

.auth-tabs :deep(.el-tabs__item.is-active) {
  color: var(--c-primary);
}

.auth-tabs :deep(.el-tabs__active-bar) {
  background: var(--c-primary);
}

.code-row {
  display: flex;
  gap: 12px;
}

.code-input {
  flex: 1;
}

.code-btn {
  flex-shrink: 0;
  width: 120px;
  height: 48px;
  font-size: 14px;
  border-radius: var(--radius-sm);
}

.auth-footer {
  text-align: center;
  font-size: 14px;
  color: var(--c-text-secondary);
}

.auth-footer a {
  color: var(--c-primary);
  font-weight: 600;
}

.auth-footer a:hover {
  text-decoration: underline;
}
</style>
