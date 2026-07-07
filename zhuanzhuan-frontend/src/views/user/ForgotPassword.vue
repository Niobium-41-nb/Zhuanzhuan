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
        <h1 class="auth-title">找回密码</h1>
        <p class="auth-desc">验证您的注册邮箱以重置密码</p>
      </div>

      <!-- Step 1: Enter email & get code -->
      <el-form v-if="step === 1" ref="formRef1" :model="form" :rules="rules1" label-width="0" class="auth-form">
        <el-form-item prop="email">
          <el-input v-model="form.email" placeholder="请输入注册邮箱" size="large" :prefix-icon="Message" />
        </el-form-item>
        <el-form-item prop="code">
          <div class="code-row">
            <el-input v-model="form.code" placeholder="验证码" size="large" :prefix-icon="Key" class="code-input" />
            <el-button
              class="code-btn"
              :disabled="codeSending"
              @click="sendResetCode"
            >{{ codeBtnText }}</el-button>
          </div>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" size="large" @click="handleNext" :loading="loading" class="auth-submit">下一步</el-button>
        </el-form-item>
      </el-form>

      <!-- Step 2: Set new password -->
      <el-form v-else ref="formRef2" :model="form" :rules="rules2" label-width="0" class="auth-form">
        <el-form-item prop="newPassword">
          <el-input v-model="form.newPassword" type="password" placeholder="新密码（8-20位，字母+数字）" size="large" show-password :prefix-icon="Lock" />
        </el-form-item>
        <el-form-item prop="confirmPassword">
          <el-input v-model="form.confirmPassword" type="password" placeholder="确认新密码" size="large" show-password :prefix-icon="Lock" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" size="large" @click="handleReset" :loading="loading" class="auth-submit">重置密码</el-button>
        </el-form-item>
        <div class="step-back">
          <el-button text type="primary" @click="step = 1" :disabled="loading">
            <el-icon><ArrowLeft /></el-icon> 返回上一步
          </el-button>
        </div>
      </el-form>

      <div class="auth-footer">
        想起密码了？<router-link to="/login">返回登录</router-link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Message, Lock, Key, ArrowLeft } from '@element-plus/icons-vue'
import { userApi } from '@/api'

const router = useRouter()
const formRef1 = ref()
const formRef2 = ref()
const loading = ref(false)
const codeSending = ref(false)
const codeBtnText = ref('获取验证码')
const step = ref(1)

const form = reactive({
  email: '',
  code: '',
  newPassword: '',
  confirmPassword: ''
})

const rules1 = {
  email: [
    { required: true, message: '请输入邮箱', trigger: 'blur' },
    { type: 'email', message: '邮箱格式不正确', trigger: 'blur' }
  ],
  code: [{ required: true, message: '请输入验证码', trigger: 'blur' }]
}

const validateConfirmPassword = (_rule: any, value: string, callback: any) => {
  if (!value) {
    callback(new Error('请确认新密码'))
  } else if (value !== form.newPassword) {
    callback(new Error('两次输入的密码不一致'))
  } else {
    callback()
  }
}

const rules2 = {
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    { pattern: /^(?=.*[A-Za-z])(?=.*\d).{8,20}$/, message: '密码需8-20位，包含字母和数字', trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, message: '请确认新密码', trigger: 'blur' },
    { validator: validateConfirmPassword, trigger: 'blur' }
  ]
}

async function sendResetCode() {
  if (!form.email) {
    ElMessage.warning('请先输入邮箱')
    return
  }
  // 简单邮箱格式校验
  if (!/^[\w.\-]+@[\w\-]+(\.[\w\-]+)+$/.test(form.email)) {
    ElMessage.warning('邮箱格式不正确')
    return
  }
  codeSending.value = true
  try {
    await userApi.sendCode({ target: form.email, type: 'reset' })
    ElMessage.success('验证码已发送至您的邮箱')
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

async function handleNext() {
  const valid = await formRef1.value.validate().catch(() => false)
  if (!valid) return
  step.value = 2
}

async function handleReset() {
  const valid = await formRef2.value.validate().catch(() => false)
  if (!valid) return
  loading.value = true
  try {
    await userApi.resetPassword({
      target: form.email,
      code: form.code,
      newPassword: form.newPassword
    })
    ElMessage.success('密码重置成功，请使用新密码登录')
    router.push('/login')
  } catch (_) {} finally {
    loading.value = false
  }
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
  animation: cardIn 0.5s ease-out;
}

@keyframes cardIn {
  from { opacity: 0; transform: translateY(20px) scale(0.97); }
  to { opacity: 1; transform: translateY(0) scale(1); }
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
  transition: transform 0.4s ease;
}

.auth-logo-icon:hover {
  transform: rotate(0deg) scale(1.1);
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

.step-back {
  text-align: center;
  margin-top: 4px;
}
</style>
