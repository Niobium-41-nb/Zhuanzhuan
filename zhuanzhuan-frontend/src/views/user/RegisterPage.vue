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
        <h1 class="auth-title">加入转转</h1>
        <p class="auth-desc">开启你的校园二手交易之旅</p>
      </div>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="0" class="auth-form">
        <el-form-item prop="username">
          <el-input v-model="form.username" placeholder="用户名" size="large" :prefix-icon="User" />
        </el-form-item>
        <el-form-item prop="email">
          <el-input v-model="form.email" placeholder="邮箱" size="large" :prefix-icon="Message" />
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="form.password" type="password" placeholder="密码（8-20位，字母+数字）" size="large" show-password :prefix-icon="Lock" />
        </el-form-item>
        <el-form-item prop="code">
          <div class="code-row">
            <el-input v-model="form.code" placeholder="验证码" size="large" :prefix-icon="Key" class="code-input" />
            <el-button
              class="code-btn"
              :disabled="codeSending"
              @click="sendCode"
            >{{ codeBtnText }}</el-button>
          </div>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" size="large" @click="handleRegister" :loading="loading" class="auth-submit">注册</el-button>
        </el-form-item>
      </el-form>
      <div class="auth-footer">
        已有账号？<router-link to="/login">立即登录</router-link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { User, Message, Lock, Key } from '@element-plus/icons-vue'
import { userApi } from '@/api'

const router = useRouter()
const formRef = ref()
const loading = ref(false)
const codeSending = ref(false)
const codeBtnText = ref('获取验证码')
const form = reactive({ username: '', email: '', password: '', code: '' })
const rules = {
  username: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  email: [{ required: true, message: '请输入邮箱', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
  code: [{ required: true, message: '请输入验证码', trigger: 'blur' }]
}

async function sendCode() {
  if (!form.email) { ElMessage.warning('请先输入邮箱'); return }
  codeSending.value = true
  try {
    await userApi.sendCode({ target: form.email, type: 'register' })
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

async function handleRegister() {
  const valid = await formRef.value.validate().catch(() => false)
  if (!valid) return
  loading.value = true
  try {
    await userApi.register(form)
    ElMessage.success('注册成功')
    router.push('/login')
  } catch (_) {} finally { loading.value = false }
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
  width: 440px;
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

.code-row {
  display: flex;
  gap: 12px;
  width: 100%;
}

.code-input {
  flex: 1;
}

.code-btn {
  width: 130px;
  flex-shrink: 0;
  height: 40px;
}
</style>
