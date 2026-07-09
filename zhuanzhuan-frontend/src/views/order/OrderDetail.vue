<template>
  <div class="order-detail" v-if="order">
    <!-- ===== Status Stepper ===== -->
    <div class="stepper-card" v-if="order.status !== '已取消'">
      <div class="stepper">
        <template v-for="(step, idx) in steps" :key="step.label">
          <!-- Connecting line (before each step except first) -->
          <div class="stepper-line" v-if="idx > 0"
            :class="{ active: idx <= currentStep, done: idx <= currentStep }">
          </div>

          <!-- Step circle + label -->
          <div class="stepper-node"
            :class="{
              active: idx === currentStep,
              done: idx < currentStep,
              pending: idx > currentStep
            }">
            <div class="stepper-circle">
              <!-- Completed: checkmark -->
              <svg v-if="idx < currentStep" class="check-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                <polyline points="20 6 9 17 4 12"></polyline>
              </svg>
              <!-- Active/pending: number -->
              <span v-else class="step-num">{{ idx + 1 }}</span>
            </div>
            <span class="step-label">{{ step.label }}</span>
          </div>
        </template>
      </div>

      <!-- Status hint text -->
      <div class="status-hint">
        <svg class="hint-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="12" y1="16" x2="12" y2="12"></line>
          <line x1="12" y1="8" x2="12.01" y2="8"></line>
        </svg>
        <span>{{ hintText }}</span>
      </div>
    </div>

    <!-- Cancelled status -->
    <div class="cancelled-card" v-else>
      <div class="cancelled-icon">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="15" y1="9" x2="9" y2="15"></line>
          <line x1="9" y1="9" x2="15" y2="15"></line>
        </svg>
      </div>
      <div class="cancelled-text">
        <strong>订单已取消</strong>
        <span>该订单已被取消，如有疑问请联系客服</span>
      </div>
    </div>

    <!-- ===== Order Info Card ===== -->
    <el-card class="info-card">
      <template #header>
        <div class="card-header">
          <div class="header-left">
            <span class="header-title">订单信息</span>
            <span class="order-no">#{{ order.orderNo }}</span>
          </div>
          <el-tag :type="statusType(order.status)" size="large" effect="plain">
            {{ order.status }}
          </el-tag>
        </div>
      </template>

      <!-- Product link -->
      <div class="product-link-row">
        <router-link :to="`/product/${order.productId}`" class="product-link">
          <div class="product-thumb" v-if="order.productImage">
            <img :src="order.productImage" :alt="order.productTitle" />
          </div>
          <div class="product-thumb-placeholder" v-else>
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
              <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
              <circle cx="8.5" cy="8.5" r="1.5"></circle>
              <polyline points="21 15 16 10 5 21"></polyline>
            </svg>
          </div>
          <div class="product-link-text">
            <span class="product-link-title">{{ order.productTitle }}</span>
            <span class="product-link-hint">查看商品详情 &rarr;</span>
          </div>
        </router-link>
      </div>

      <el-descriptions :column="2" border>
        <el-descriptions-item label="总价">
          <span class="price">¥{{ order.totalPrice }}</span>
        </el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ order.createdAt }}</el-descriptions-item>
        <el-descriptions-item label="卖家">{{ order.sellerName }}</el-descriptions-item>
        <el-descriptions-item label="买家">{{ order.buyerName }}</el-descriptions-item>
        <el-descriptions-item label="收件人">{{ order.shippingName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="联系电话">{{ order.shippingPhone || '-' }}</el-descriptions-item>
        <el-descriptions-item label="收货地址" :span="2">{{ order.shippingAddress || '未填写' }}</el-descriptions-item>
      </el-descriptions>

      <!-- Logistics info card (for 待收货 / 已完成) -->
      <div class="logistics-card" v-if="(order.status === '待收货' || order.status === '已完成') && order.logisticsCompany">
        <div class="logistics-header">
          <svg class="logistics-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
            <rect x="1" y="3" width="15" height="13"></rect>
            <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
            <circle cx="5.5" cy="18.5" r="2.5"></circle>
            <circle cx="18.5" cy="18.5" r="2.5"></circle>
          </svg>
          <span class="logistics-title">物流信息</span>
        </div>
        <div class="logistics-body">
          <div class="logistics-row">
            <span class="logistics-label">物流公司</span>
            <span class="logistics-value">{{ order.logisticsCompany }}</span>
          </div>
          <div class="logistics-row">
            <span class="logistics-label">快递单号</span>
            <span class="logistics-value tracking-no" @click="copyTrackingNo" :title="copyTip">
              {{ order.logisticsNo }}
              <svg class="copy-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect>
                <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path>
              </svg>
            </span>
          </div>
          <div class="logistics-row" v-if="order.shippedAt">
            <span class="logistics-label">发货时间</span>
            <span class="logistics-value">{{ order.shippedAt }}</span>
          </div>
          <div class="logistics-row" v-if="order.receivedAt">
            <span class="logistics-label">收货时间</span>
            <span class="logistics-value">{{ order.receivedAt }}</span>
          </div>
        </div>
      </div>

      <!-- Seller: waiting for buyer payment hint -->
      <div class="seller-waiting-hint" v-if="isSeller && order.status === '待付款'">
        <svg class="hint-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <polyline points="12 6 12 12 16 14"></polyline>
        </svg>
        <span>等待买家付款中，请耐心等待...</span>
      </div>

      <!-- ===== Action Buttons ===== -->
      <!-- Buyer: Pending Payment -->
      <div class="actions" v-if="isBuyer && order.status === '待付款'">
        <el-button type="primary" size="large" @click="goToPay">去支付</el-button>
        <el-button size="large" @click="cancel">取消订单</el-button>
      </div>

      <!-- Seller: Pending Ship -->
      <div class="actions" v-if="isSeller && order.status === '待发货'">
        <el-button type="primary" size="large" @click="showShipDialog = true">
          <svg class="btn-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="1" y="3" width="15" height="13"></rect>
            <polygon points="16 8 20 8 23 11 23 16 16 16 16 8"></polygon>
            <circle cx="5.5" cy="18.5" r="2.5"></circle>
            <circle cx="18.5" cy="18.5" r="2.5"></circle>
          </svg>
          录入物流发货
        </el-button>
      </div>

      <!-- Buyer: Pending Receive -->
      <div class="actions" v-if="isBuyer && order.status === '待收货'">
        <el-button type="primary" size="large" @click="receive" :loading="loading">确认收货</el-button>
      </div>

      <!-- Buyer: Completed, can review -->
      <div class="actions" v-if="isBuyer && order.status === '已完成' && !reviewed">
        <el-button type="primary" size="large" @click="showReviewDialog = true">去评价</el-button>
      </div>
    </el-card>

    <!-- ===== Order Timeline ===== -->
    <el-card v-if="logs.length" class="timeline-card">
      <template #header>
        <span class="header-title">订单日志</span>
      </template>
      <el-timeline>
        <el-timeline-item v-for="log in logs" :key="log.createdAt"
          :timestamp="log.createdAt" placement="top">
          {{ log.remark }}
          <span v-if="log.fromStatus" class="log-status-change">
            （{{ log.fromStatus }} &rarr; {{ log.toStatus }}）
          </span>
        </el-timeline-item>
      </el-timeline>
    </el-card>

    <!-- ===== Ship Dialog ===== -->
    <el-dialog v-model="showShipDialog" title="录入物流信息" width="480px" class="ship-dialog">
      <el-form :model="shipForm" label-width="80px">
        <el-form-item label="物流公司">
          <div class="company-grid">
            <div
              v-for="company in logisticsCompanies"
              :key="company.value"
              class="company-card"
              :class="{ selected: shipForm.logisticsCompany === company.value }"
              @click="shipForm.logisticsCompany = company.value">
              <div class="company-badge" :style="{ background: company.color }">
                <span class="company-initial">{{ company.initial }}</span>
              </div>
              <span class="company-name">{{ company.label }}</span>
              <svg v-if="shipForm.logisticsCompany === company.value" class="company-check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                <polyline points="20 6 9 17 4 12"></polyline>
              </svg>
            </div>
          </div>
        </el-form-item>
        <el-form-item label="物流单号">
          <el-input v-model="shipForm.logisticsNo" placeholder="请输入快递单号" size="large" clearable />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showShipDialog = false">取消</el-button>
        <el-button type="primary" @click="ship" :loading="loading" :disabled="!shipForm.logisticsCompany || !shipForm.logisticsNo">确认发货</el-button>
      </template>
    </el-dialog>

    <!-- ===== Review Dialog ===== -->
    <el-dialog v-model="showReviewDialog" title="评价交易" width="420px" class="review-dialog">
      <el-form :model="reviewForm" label-width="60px">
        <el-form-item label="评分">
          <el-rate v-model="reviewForm.rating" :max="5" show-score />
        </el-form-item>
        <el-form-item label="评价">
          <el-input v-model="reviewForm.content" type="textarea" rows="3" placeholder="说说这次交易体验吧" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showReviewDialog = false">跳过</el-button>
        <el-button type="primary" @click="submitReview" :loading="loading">提交评价</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { orderApi } from '@/api'
import { getUserInfo } from '@/utils/auth'

const router = useRouter()
const route = useRoute()
const order = ref<any>(null)
const logs = ref<any[]>([])
const loading = ref(false)
const reviewed = ref(false)
const showShipDialog = ref(false)
const showReviewDialog = ref(false)
const copyTip = ref('点击复制单号')

const currentUser = getUserInfo()
const isBuyer = computed(() => currentUser?.userId === order.value?.buyerId)
const isSeller = computed(() => currentUser?.userId === order.value?.sellerId && !isBuyer.value)

const shipForm = ref({ logisticsCompany: '', logisticsNo: '' })
const reviewForm = ref({ rating: 5, content: '' })

// Stepper configuration
const steps = [
  { label: '待付款', key: '待付款' },
  { label: '待发货', key: '待发货' },
  { label: '待收货', key: '待收货' },
  { label: '已完成', key: '已完成' }
]

const statusStepMap: Record<string, number> = {
  '待付款': 0,
  '待发货': 1,
  '待收货': 2,
  '已完成': 3
}

const currentStep = computed(() => {
  return statusStepMap[order.value?.status] ?? -1
})

const hintText = computed(() => {
  const map: Record<string, string> = {
    '待付款': '请尽快完成支付，超时订单将自动取消',
    '待发货': isSeller.value
      ? '买家已付款，请尽快发货'
      : '等待卖家发货中，卖家发货后将更新物流信息',
    '待收货': '商品运输中，收到商品后请确认收货',
    '已完成': '交易已完成，感谢使用转转'
  }
  return map[order.value?.status] || ''
})

// Logistics company options
const logisticsCompanies = [
  { label: '顺丰速运', value: '顺丰速运', initial: 'SF', color: '#E86624' },
  { label: '中通快递', value: '中通快递', initial: 'ZT', color: '#EC1C24' },
  { label: '圆通速递', value: '圆通速递', initial: 'YT', color: '#5B2D8E' },
  { label: '韵达快递', value: '韵达快递', initial: 'YD', color: '#FFCC00' },
  { label: '申通快递', value: '申通快递', initial: 'ST', color: '#FF6B00' },
  { label: '京东物流', value: '京东物流', initial: 'JD', color: '#E2231A' },
  { label: 'EMS', value: 'EMS', initial: 'EM', color: '#0066CC' },
  { label: '极兔速递', value: '极兔速递', initial: 'JT', color: '#F73150' }
]

onMounted(async () => {
  await loadOrder()
})

async function loadOrder() {
  try {
    const id = Number(route.params.id)
    const [orderRes, logRes] = await Promise.all([
      orderApi.getDetail(id),
      orderApi.getLogs(id)
    ])
    order.value = orderRes.data
    logs.value = logRes.data || []
  } catch (_) { ElMessage.error('操作失败，请重试') }
}

function goToPay() {
  router.push(`/order/${order.value.orderId}/pay`)
}

async function cancel() {
  loading.value = true
  try {
    await orderApi.cancel(order.value.orderId)
    ElMessage.success('订单已取消')
    await loadOrder()
  } catch (_) { ElMessage.error('操作失败，请重试') } finally { loading.value = false }
}

async function ship() {
  loading.value = true
  try {
    await orderApi.ship(order.value.orderId, shipForm.value)
    ElMessage.success('已发货')
    showShipDialog.value = false
    await loadOrder()
  } catch (_) { ElMessage.error('操作失败，请重试') } finally { loading.value = false }
}

async function receive() {
  loading.value = true
  try {
    await orderApi.receive(order.value.orderId)
    ElMessage.success('已确认收货')
    await loadOrder()
  } catch (_) { ElMessage.error('操作失败，请重试') } finally { loading.value = false }
}

async function submitReview() {
  loading.value = true
  try {
    await orderApi.review(order.value.orderId, reviewForm.value)
    ElMessage.success('评价成功')
    showReviewDialog.value = false
    reviewed.value = true
  } catch (_) { ElMessage.error('操作失败，请重试') } finally { loading.value = false }
}

async function copyTrackingNo() {
  if (!order.value?.logisticsNo) return
  try {
    await navigator.clipboard.writeText(order.value.logisticsNo)
    copyTip.value = '已复制！'
    ElMessage.success('快递单号已复制到剪贴板')
    setTimeout(() => { copyTip.value = '点击复制单号' }, 2000)
  } catch (_) {
    // Fallback for older browsers
    const input = document.createElement('input')
    input.value = order.value.logisticsNo
    document.body.appendChild(input)
    input.select()
    document.execCommand('copy')
    document.body.removeChild(input)
    copyTip.value = '已复制！'
    ElMessage.success('快递单号已复制到剪贴板')
    setTimeout(() => { copyTip.value = '点击复制单号' }, 2000)
  }
}

function statusType(s: string) {
  const map: Record<string, string> = {
    '待付款': 'warning', '待发货': 'primary', '待收货': '',
    '已完成': 'success', '已取消': 'danger'
  }
  return map[s] || ''
}
</script>

<style scoped>
/* ===== Layout ===== */
.order-detail {
  max-width: 780px;
  margin: 0 auto;
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

/* ===== Status Stepper Card ===== */
.stepper-card {
  background: var(--c-surface);
  border-radius: var(--radius-md);
  border: 1px solid var(--c-border);
  padding: 28px 32px 20px;
  box-shadow: var(--shadow-sm);
}

.stepper {
  display: flex;
  align-items: flex-start;
  justify-content: center;
  padding: 0 8px;
}

.stepper-line {
  flex: 1;
  height: 2px;
  background: var(--c-border);
  margin-top: 17px;
  max-width: 80px;
  min-width: 24px;
  border-radius: 1px;
  transition: background 0.5s ease;
}

.stepper-line.active,
.stepper-line.done {
  background: var(--c-primary);
}

.stepper-node {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  flex-shrink: 0;
}

.stepper-circle {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 700;
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
}

/* Pending step */
.stepper-node.pending .stepper-circle {
  border: 2px solid var(--c-border);
  color: var(--c-muted);
  background: var(--c-surface);
}

/* Active step */
.stepper-node.active .stepper-circle {
  background: var(--c-primary);
  color: #fff;
  border: 2px solid var(--c-primary);
  box-shadow: 0 0 0 6px rgba(45, 106, 79, 0.12);
  animation: stepPulse 2s ease-in-out infinite;
}

@keyframes stepPulse {
  0%, 100% { box-shadow: 0 0 0 4px rgba(45, 106, 79, 0.12); }
  50% { box-shadow: 0 0 0 10px rgba(45, 106, 79, 0.06); }
}

/* Done step */
.stepper-node.done .stepper-circle {
  background: var(--c-primary);
  border: 2px solid var(--c-primary);
  color: #fff;
}

.stepper-node.done .check-icon {
  width: 18px;
  height: 18px;
  color: #fff;
}

.step-label {
  font-size: 13px;
  font-weight: 500;
  color: var(--c-muted);
  white-space: nowrap;
  transition: color 0.3s ease;
}

.stepper-node.active .step-label {
  color: var(--c-primary);
  font-weight: 700;
}

.stepper-node.done .step-label {
  color: var(--c-primary);
}

/* Status hint */
.status-hint {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  margin-top: 20px;
  padding: 10px 16px;
  background: var(--c-primary-bg);
  border-radius: var(--radius-sm);
  font-size: 14px;
  color: var(--c-primary-dark);
  font-weight: 500;
}

.status-hint .hint-icon {
  width: 18px;
  height: 18px;
  flex-shrink: 0;
}

/* ===== Cancelled Card ===== */
.cancelled-card {
  background: var(--c-surface);
  border-radius: var(--radius-md);
  border: 1px solid #FECACA;
  padding: 32px;
  text-align: center;
  box-shadow: var(--shadow-sm);
}

.cancelled-icon {
  width: 56px;
  height: 56px;
  border-radius: 50%;
  background: #FEF2F2;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 16px;
}

.cancelled-icon svg {
  width: 28px;
  height: 28px;
  color: #EF4444;
}

.cancelled-text {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.cancelled-text strong {
  font-size: 16px;
  color: #991B1B;
}

.cancelled-text span {
  font-size: 13px;
  color: var(--c-text-secondary);
}

/* ===== Info Card ===== */
.info-card {
  border-radius: var(--radius-md);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 12px;
}

.header-title {
  font-size: 16px;
  font-weight: 700;
  color: var(--c-text);
}

.order-no {
  font-size: 13px;
  color: var(--c-muted);
  font-family: 'SF Mono', 'Cascadia Code', 'Consolas', monospace;
}

/* ===== Product Link ===== */
.product-link-row {
  margin-bottom: 20px;
}

.product-link {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 12px 16px;
  background: var(--c-bg);
  border-radius: var(--radius-sm);
  border: 1px solid var(--c-border-light);
  text-decoration: none;
  transition: all 0.25s ease;
}

.product-link:hover {
  background: var(--c-primary-bg);
  border-color: var(--c-primary-light);
  transform: translateY(-1px);
  box-shadow: var(--shadow-sm);
}

.product-thumb {
  width: 48px;
  height: 48px;
  border-radius: var(--radius-sm);
  overflow: hidden;
  flex-shrink: 0;
  background: var(--c-border-light);
}

.product-thumb img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.product-thumb-placeholder {
  width: 48px;
  height: 48px;
  border-radius: var(--radius-sm);
  flex-shrink: 0;
  background: var(--c-border-light);
  display: flex;
  align-items: center;
  justify-content: center;
}

.product-thumb-placeholder svg {
  width: 22px;
  height: 22px;
  color: var(--c-muted);
}

.product-link-text {
  display: flex;
  flex-direction: column;
  gap: 2px;
  flex: 1;
  min-width: 0;
}

.product-link-title {
  font-size: 14px;
  font-weight: 600;
  color: var(--c-text);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.product-link-hint {
  font-size: 12px;
  color: var(--c-primary);
  font-weight: 500;
}

/* ===== Price ===== */
.price {
  font-size: 18px;
  font-weight: 700;
  color: var(--c-accent);
}

/* ===== Logistics Info Card ===== */
.logistics-card {
  margin-top: 20px;
  border-radius: var(--radius-sm);
  border: 1px solid var(--c-primary-light);
  background: linear-gradient(135deg, #F0FDF4 0%, #FDFBF7 100%);
  overflow: hidden;
}

.logistics-header {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px 16px;
  background: rgba(45, 106, 79, 0.06);
  border-bottom: 1px solid rgba(45, 106, 79, 0.1);
}

.logistics-icon {
  width: 20px;
  height: 20px;
  color: var(--c-primary);
  flex-shrink: 0;
}

.logistics-title {
  font-size: 14px;
  font-weight: 700;
  color: var(--c-primary-dark);
}

.logistics-body {
  padding: 14px 16px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.logistics-row {
  display: flex;
  align-items: center;
  gap: 12px;
}

.logistics-label {
  font-size: 13px;
  color: var(--c-text-secondary);
  min-width: 60px;
  flex-shrink: 0;
}

.logistics-value {
  font-size: 14px;
  color: var(--c-text);
  font-weight: 500;
}

.tracking-no {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  cursor: pointer;
  color: var(--c-primary);
  font-family: 'SF Mono', 'Cascadia Code', 'Consolas', monospace;
  font-weight: 600;
  padding: 2px 8px;
  border-radius: 4px;
  background: rgba(45, 106, 79, 0.06);
  transition: all 0.2s ease;
  user-select: none;
}

.tracking-no:hover {
  background: rgba(45, 106, 79, 0.12);
}

.copy-icon {
  width: 14px;
  height: 14px;
  opacity: 0.6;
  flex-shrink: 0;
}

.tracking-no:hover .copy-icon {
  opacity: 1;
}

/* ===== Seller Waiting Hint ===== */
.seller-waiting-hint {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  margin-top: 20px;
  padding: 12px 16px;
  background: #FFFBEB;
  border: 1px solid #FDE68A;
  border-radius: var(--radius-sm);
  font-size: 14px;
  color: #92400E;
  font-weight: 500;
}

.seller-waiting-hint .hint-icon {
  width: 18px;
  height: 18px;
  flex-shrink: 0;
  color: #D97706;
}

/* ===== Actions ===== */
.actions {
  margin-top: 24px;
  display: flex;
  gap: 12px;
}

.btn-icon {
  width: 16px;
  height: 16px;
  margin-right: 2px;
  vertical-align: -2px;
}

/* ===== Timeline Card ===== */
.timeline-card {
  border-radius: var(--radius-md);
}

.log-status-change {
  font-size: 12px;
  color: var(--c-muted);
}

/* ===== Ship Dialog ===== */
.company-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 10px;
  width: 100%;
}

.company-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 14px 8px;
  border-radius: var(--radius-sm);
  border: 2px solid var(--c-border-light);
  cursor: pointer;
  transition: all 0.25s ease;
  position: relative;
}

.company-card:hover {
  border-color: var(--c-primary-light);
  background: var(--c-primary-bg);
  transform: translateY(-2px);
  box-shadow: var(--shadow-sm);
}

.company-card.selected {
  border-color: var(--c-primary);
  background: var(--c-primary-bg);
}

.company-badge {
  width: 42px;
  height: 42px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 13px;
  font-weight: 800;
  color: #fff;
  letter-spacing: 0.5px;
}

.company-name {
  font-size: 12px;
  color: var(--c-text);
  font-weight: 500;
  text-align: center;
  line-height: 1.3;
}

.company-check {
  position: absolute;
  top: -6px;
  right: -6px;
  width: 20px;
  height: 20px;
  color: var(--c-primary);
  background: #fff;
  border-radius: 50%;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1);
}

/* ===== Responsive ===== */
@media (max-width: 600px) {
  .order-detail {
    padding: 12px;
    gap: 12px;
  }

  .stepper-card {
    padding: 20px 12px 16px;
  }

  .stepper-line {
    max-width: 40px;
    min-width: 16px;
  }

  .stepper-circle {
    width: 30px;
    height: 30px;
    font-size: 12px;
  }

  .step-label {
    font-size: 11px;
  }

  .status-hint {
    font-size: 12px;
    padding: 8px 12px;
  }

  .company-grid {
    grid-template-columns: repeat(3, 1fr);
    gap: 8px;
  }

  .company-card {
    padding: 10px 6px;
  }

  .company-badge {
    width: 36px;
    height: 36px;
    font-size: 11px;
    border-radius: 8px;
  }

  .company-name {
    font-size: 11px;
  }
}
</style>
