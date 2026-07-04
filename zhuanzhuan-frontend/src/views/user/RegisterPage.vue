<template>
  <div class="register-page">
    <el-card class="register-card">
      <h2>注册</h2>
      <el-form ref="formRef" :model="form" :rules="rules" label-width="0">
        <el-form-item prop="username">
          <el-input v-model="form.username" placeholder="用户名" size="large" />
        </el-form-item>
        <el-form-item prop="email">
          <el-input v-model="form.email" placeholder="邮箱" size="large" />
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="form.password" type="password" placeholder="密码（8-20位，字母+数字）" size="large" show-password />
        </el-form-item>
        <el-form-item prop="code">
          <el-input v-model="form.code" placeholder="验证码" size="large" style="width:calc(100% - 120px)">
            <template #append>
              <el-button @click="sendCode" :disabled="codeSending">{{ codeBtnText }}</el-button>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" size="large" @click="handleRegister" :loading="loading" style="width:100%">注册</el-button>
        </el-form-item>
      </el-form>
      <div class="links"><router-link to="/login">已有账号？立即登录</router-link></div>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
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
  await userApi.sendCode({ target: form.email, type: 'register' })
  ElMessage.success('验证码已发送')
  let count = 60; codeBtnText.value = `${count}s`
  const timer = setInterval(() => { count--; codeBtnText.value = `${count}s`; if (count <= 0) { clearInterval(timer); codeBtnText.value = '获取验证码'; codeSending.value = false } }, 1000)
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
.register-page { display: flex; justify-content: center; align-items: center; min-height: 100vh; background: #f5f7fa; }
.register-card { width: 420px; }
.register-card h2 { text-align: center; margin-bottom: 24px; }
.links { text-align: center; margin-top: 16px; }
.links a { color: #409eff; text-decoration: none; }
</style>
