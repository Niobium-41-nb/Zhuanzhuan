<template>
  <div class="payment-page" v-if="order">
    <!-- Step 1: Payment Method Selection -->
    <div class="payment-card" v-if="step === 'select'">
      <div class="card-header">
        <h2>确认支付</h2>
      </div>

      <!-- Order Summary -->
      <div class="order-summary">
        <div class="summary-item">
          <span class="summary-label">商品</span>
          <span class="summary-value">{{ order.productTitle }}</span>
        </div>
        <div class="summary-item">
          <span class="summary-label">订单号</span>
          <span class="summary-value mono">{{ order.orderNo }}</span>
        </div>
        <div class="summary-item total">
          <span class="summary-label">应付金额</span>
          <span class="summary-value price">¥{{ order.totalPrice }}</span>
        </div>
      </div>

      <!-- Payment Methods -->
      <div class="pay-methods">
        <h3>选择支付方式</h3>
        <div class="method-list">
          <div
            class="method-item"
            :class="{ active: selectedMethod === 'wechat' }"
            @click="selectedMethod = 'wechat'"
          >
            <span class="method-icon wechat-icon">微</span>
            <span class="method-name">微信支付</span>
          </div>
          <div
            class="method-item"
            :class="{ active: selectedMethod === 'alipay' }"
            @click="selectedMethod = 'alipay'"
          >
            <span class="method-icon alipay-icon">支</span>
            <span class="method-name">支付宝</span>
          </div>
          <div
            class="method-item"
            :class="{ active: selectedMethod === 'campus' }"
            @click="selectedMethod = 'campus'"
          >
            <span class="method-icon campus-icon">校</span>
            <span class="method-name">校园卡</span>
          </div>
        </div>
      </div>

      <!-- Action -->
      <div class="pay-actions">
        <el-button @click="goBack" size="large">返回</el-button>
        <el-button type="primary" size="large" @click="confirmPay" :disabled="!selectedMethod">
          确认支付 ¥{{ order.totalPrice }}
        </el-button>
      </div>
    </div>

    <!-- Step 2: Processing -->
    <div class="payment-card processing-card" v-if="step === 'processing'">
      <div class="processing-content">
        <div class="spinner-wrapper">
          <div class="spinner"></div>
        </div>
        <h3>正在处理支付...</h3>
        <p class="processing-desc">请稍候，正在连接到支付网关</p>
        <div class="processing-dots">
          <span class="dot" v-for="i in 3" :key="i" :style="{ animationDelay: (i - 1) * 0.2 + 's' }"></span>
        </div>
      </div>
    </div>

    <!-- Step 3: Success -->
    <div class="payment-card success-card" v-if="step === 'success'">
      <div class="success-content">
        <div class="checkmark-wrapper">
          <svg class="checkmark" viewBox="0 0 52 52">
            <circle class="checkmark-circle" cx="26" cy="26" r="25" fill="none" />
            <path class="checkmark-check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8" />
          </svg>
        </div>
        <h3>支付成功</h3>
        <p class="success-desc">¥{{ order.totalPrice }} 已支付</p>
        <p class="redirect-hint">{{ countdown }} 秒后自动跳转至订单详情...</p>
        <el-button type="primary" size="large" @click="goToOrder">查看订单</el-button>
      </div>
    </div>

    <!-- Step 4: Error -->
    <div class="payment-card error-card" v-if="step === 'error'">
      <div class="error-content">
        <div class="error-icon-wrapper">
          <svg class="error-icon" viewBox="0 0 52 52">
            <circle cx="26" cy="26" r="25" fill="none" stroke="var(--c-accent)" stroke-width="2" />
            <line x1="16" y1="16" x2="36" y2="36" stroke="var(--c-accent)" stroke-width="2.5" stroke-linecap="round" />
            <line x1="36" y1="16" x2="16" y2="36" stroke="var(--c-accent)" stroke-width="2.5" stroke-linecap="round" />
          </svg>
        </div>
        <h3>支付失败</h3>
        <p class="error-desc">{{ errorMsg }}</p>
        <div class="error-actions">
          <el-button @click="goBack" size="large">返回订单</el-button>
          <el-button type="primary" size="large" @click="retryPay">重新支付</el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { orderApi } from '@/api'

const route = useRoute()
const router = useRouter()
const order = ref<any>(null)
const step = ref<'select' | 'processing' | 'success' | 'error'>('select')
const selectedMethod = ref<string | null>(null)
const errorMsg = ref('支付时出现异常，请重试')
const countdown = ref(2)
let countdownTimer: ReturnType<typeof setInterval> | null = null

onMounted(async () => {
  await loadOrder()
})

onUnmounted(() => {
  if (countdownTimer) clearInterval(countdownTimer)
})

async function loadOrder() {
  try {
    const id = Number(route.params.id)
    const res = await orderApi.getDetail(id)
    order.value = res.data
    if (order.value.status !== '待付款') {
      ElMessage.warning('该订单当前状态不需要支付')
      router.replace(`/order/${id}`)
    }
  } catch (_) {
    ElMessage.error('订单不存在')
    router.replace('/order/list')
  }
}

async function confirmPay() {
  step.value = 'processing'

  // Simulate processing delay
  await new Promise(resolve => setTimeout(resolve, 1500 + Math.random() * 1000))

  try {
    await orderApi.pay(order.value.orderId)
    step.value = 'success'
    startCountdown()
  } catch (e: any) {
    errorMsg.value = e?.response?.data?.message || '支付时出现异常，请重试'
    step.value = 'error'
  }
}

function startCountdown() {
  countdown.value = 2
  countdownTimer = setInterval(() => {
    countdown.value--
    if (countdown.value <= 0) {
      if (countdownTimer) clearInterval(countdownTimer)
      goToOrder()
    }
  }, 1000)
}

function goToOrder() {
  router.replace(`/order/${order.value.orderId}`)
}

function goBack() {
  router.replace(`/order/${order.value.orderId}`)
}

function retryPay() {
  step.value = 'select'
}
</script>

<style scoped>
.payment-page {
  max-width: 480px;
  margin: 0 auto;
  padding: 40px 20px;
}

.payment-card {
  background: var(--c-surface);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-lg);
  border: 1px solid var(--c-border);
  overflow: hidden;
}

.card-header {
  padding: 24px 28px 0;
}

.card-header h2 {
  font-size: 20px;
  font-weight: 600;
  color: var(--c-text);
}

/* ===== Order Summary ===== */
.order-summary {
  padding: 20px 28px;
  margin: 20px 28px 0;
  background: var(--c-border-light);
  border-radius: var(--radius-md);
}

.summary-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 8px 0;
}

.summary-item:not(:last-child) {
  border-bottom: 1px solid var(--c-border);
}

.summary-item.total {
  padding-top: 12px;
  margin-top: 4px;
}

.summary-label {
  font-size: 14px;
  color: var(--c-text-secondary);
}

.summary-value {
  font-size: 14px;
  color: var(--c-text);
  text-align: right;
  max-width: 60%;
  word-break: break-all;
}

.summary-value.mono {
  font-family: 'SF Mono', 'Consolas', 'Monaco', monospace;
  font-size: 13px;
}

.summary-value.price {
  font-size: 22px;
  font-weight: 700;
  color: var(--c-accent);
}

/* ===== Payment Methods ===== */
.pay-methods {
  padding: 24px 28px;
}

.pay-methods h3 {
  font-size: 15px;
  font-weight: 500;
  color: var(--c-text-secondary);
  margin-bottom: 16px;
}

.method-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.method-item {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 14px 18px;
  border: 2px solid var(--c-border);
  border-radius: var(--radius-md);
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
}

.method-item:hover {
  border-color: var(--c-primary-light);
  background: var(--c-primary-bg);
}

.method-item.active {
  border-color: var(--c-primary);
  background: var(--c-primary-bg);
  box-shadow: 0 0 0 3px rgba(45, 106, 79, 0.12);
}

.method-icon {
  width: 40px;
  height: 40px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  font-weight: 700;
  color: white;
  flex-shrink: 0;
}

.wechat-icon {
  background: linear-gradient(135deg, #07C160, #06AD56);
}

.alipay-icon {
  background: linear-gradient(135deg, #1677FF, #0958D9);
}

.campus-icon {
  background: linear-gradient(135deg, var(--c-primary), var(--c-primary-dark));
}

.method-name {
  font-size: 15px;
  font-weight: 500;
  color: var(--c-text);
}

/* ===== Actions ===== */
.pay-actions {
  padding: 0 28px 28px;
  display: flex;
  gap: 12px;
  justify-content: flex-end;
}

/* ===== Processing Step ===== */
.processing-card {
  padding: 60px 40px;
  text-align: center;
}

.processing-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
}

.spinner-wrapper {
  margin-bottom: 8px;
}

.spinner {
  width: 48px;
  height: 48px;
  border: 3px solid var(--c-border);
  border-top-color: var(--c-primary);
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to { transform: rotate(360deg); }
}

.processing-content h3 {
  font-size: 18px;
  font-weight: 600;
  color: var(--c-text);
}

.processing-desc {
  font-size: 14px;
  color: var(--c-text-secondary);
}

.processing-dots {
  display: flex;
  gap: 6px;
  margin-top: 4px;
}

.processing-dots .dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: var(--c-primary-light);
  animation: dotPulse 1.2s ease-in-out infinite;
}

@keyframes dotPulse {
  0%, 80%, 100% { opacity: 0.2; transform: scale(0.8); }
  40% { opacity: 1; transform: scale(1); }
}

/* ===== Success Step ===== */
.success-card {
  padding: 60px 40px;
  text-align: center;
}

.success-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
}

.checkmark-wrapper {
  margin-bottom: 8px;
}

.checkmark {
  width: 72px;
  height: 72px;
}

.checkmark-circle {
  stroke: var(--c-primary);
  stroke-width: 2;
  stroke-dasharray: 166;
  stroke-dashoffset: 166;
  animation: stroke 0.6s cubic-bezier(0.65, 0, 0.45, 1) forwards;
}

.checkmark-check {
  stroke: var(--c-primary);
  stroke-width: 2.5;
  stroke-linecap: round;
  stroke-linejoin: round;
  stroke-dasharray: 48;
  stroke-dashoffset: 48;
  animation: stroke 0.3s cubic-bezier(0.65, 0, 0.45, 1) 0.5s forwards;
}

@keyframes stroke {
  100% { stroke-dashoffset: 0; }
}

.success-content h3 {
  font-size: 20px;
  font-weight: 600;
  color: var(--c-primary);
}

.success-desc {
  font-size: 16px;
  color: var(--c-text-secondary);
}

.redirect-hint {
  font-size: 13px;
  color: var(--c-muted);
  margin-top: 4px;
}

/* ===== Error Step ===== */
.error-card {
  padding: 60px 40px;
  text-align: center;
}

.error-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
}

.error-icon-wrapper {
  margin-bottom: 8px;
}

.error-icon {
  width: 72px;
  height: 72px;
  animation: shake 0.5s ease-in-out;
}

.error-content h3 {
  font-size: 20px;
  font-weight: 600;
  color: var(--c-accent);
}

.error-desc {
  font-size: 14px;
  color: var(--c-text-secondary);
}

.error-actions {
  display: flex;
  gap: 12px;
  margin-top: 12px;
}
</style>
