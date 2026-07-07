<template>
  <div class="order-detail" v-if="order">
    <el-card>
      <template #header>
        <div class="detail-header">
          <span>订单详情</span>
          <el-tag :type="statusType(order.status)">{{ order.status }}</el-tag>
        </div>
      </template>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="订单号">{{ order.orderNo }}</el-descriptions-item>
        <el-descriptions-item label="商品">{{ order.productTitle }}</el-descriptions-item>
        <el-descriptions-item label="总价"><span class="price">¥{{ order.totalPrice }}</span></el-descriptions-item>
        <el-descriptions-item label="卖家">{{ order.sellerName }}</el-descriptions-item>
        <el-descriptions-item label="买家">{{ order.buyerName }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ order.createdAt }}</el-descriptions-item>
        <el-descriptions-item label="收件人">{{ order.shippingName || '-' }}</el-descriptions-item>
        <el-descriptions-item label="联系电话">{{ order.shippingPhone || '-' }}</el-descriptions-item>
        <el-descriptions-item label="收货地址" :span="2">{{ order.shippingAddress || '未填写' }}</el-descriptions-item>
        <el-descriptions-item label="物流公司">{{ order.logisticsCompany || '-' }}</el-descriptions-item>
        <el-descriptions-item label="物流单号">{{ order.logisticsNo || '-' }}</el-descriptions-item>
      </el-descriptions>

      <!-- Buyer: Pending Payment Actions -->
      <div class="actions" v-if="isBuyer && order.status === '待付款'">
        <el-button type="primary" size="large" @click="pay" :loading="loading">去支付</el-button>
        <el-button size="large" @click="cancel">取消订单</el-button>
      </div>

      <!-- Seller: Pending Ship Actions -->
      <div class="actions" v-if="isSeller && order.status === '待发货'">
        <el-button type="primary" size="large" @click="showShipDialog = true">录入物流发货</el-button>
      </div>

      <!-- Buyer: Pending Receive Actions -->
      <div class="actions" v-if="isBuyer && order.status === '待收货'">
        <el-button type="primary" size="large" @click="receive" :loading="loading">确认收货</el-button>
      </div>

      <!-- Buyer: Completed, can review -->
      <div class="actions" v-if="isBuyer && order.status === '已完成' && !reviewed">
        <el-button type="primary" size="large" @click="showReviewDialog = true">去评价</el-button>
      </div>
    </el-card>

    <!-- Order Timeline -->
    <el-card v-if="logs.length" style="margin-top:16px">
      <template #header>订单日志</template>
      <el-timeline>
        <el-timeline-item v-for="log in logs" :key="log.createdAt"
          :timestamp="log.createdAt" placement="top">
          {{ log.remark }}
          <span v-if="log.fromStatus">（{{ log.fromStatus }} → {{ log.toStatus }}）</span>
        </el-timeline-item>
      </el-timeline>
    </el-card>

    <!-- Ship Dialog -->
    <el-dialog v-model="showShipDialog" title="录入物流信息" width="400px">
      <el-form :model="shipForm" label-width="80px">
        <el-form-item label="物流公司">
          <el-select v-model="shipForm.logisticsCompany" placeholder="选择物流公司">
            <el-option label="顺丰速运" value="顺丰速运" />
            <el-option label="中通快递" value="中通快递" />
            <el-option label="圆通速递" value="圆通速递" />
            <el-option label="韵达快递" value="韵达快递" />
            <el-option label="申通快递" value="申通快递" />
            <el-option label="京东物流" value="京东物流" />
          </el-select>
        </el-form-item>
        <el-form-item label="物流单号">
          <el-input v-model="shipForm.logisticsNo" placeholder="请输入快递单号" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showShipDialog = false">取消</el-button>
        <el-button type="primary" @click="ship" :loading="loading" :disabled="!shipForm.logisticsCompany || !shipForm.logisticsNo">确认发货</el-button>
      </template>
    </el-dialog>

    <!-- Review Dialog -->
    <el-dialog v-model="showReviewDialog" title="评价交易" width="400px">
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
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { orderApi } from '@/api'
import { getUserInfo } from '@/utils/auth'

const route = useRoute()
const order = ref<any>(null)
const logs = ref<any[]>([])
const loading = ref(false)
const reviewed = ref(false)
const showShipDialog = ref(false)
const showReviewDialog = ref(false)

const currentUser = getUserInfo()
const isBuyer = computed(() => currentUser?.userId === order.value?.buyerId)
const isSeller = computed(() => currentUser?.userId === order.value?.sellerId && !isBuyer.value)

const shipForm = ref({ logisticsCompany: '', logisticsNo: '' })
const reviewForm = ref({ rating: 5, content: '' })

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
  } catch (_) {}
}

async function pay() {
  loading.value = true
  try {
    await orderApi.pay(order.value.orderId)
    ElMessage.success('支付成功！请等待卖家发货')
    await loadOrder()
  } catch (_) {} finally { loading.value = false }
}

async function cancel() {
  loading.value = true
  try {
    await orderApi.cancel(order.value.orderId)
    ElMessage.success('订单已取消')
    await loadOrder()
  } catch (_) {} finally { loading.value = false }
}

async function ship() {
  loading.value = true
  try {
    await orderApi.ship(order.value.orderId, shipForm.value)
    ElMessage.success('已发货')
    showShipDialog.value = false
    await loadOrder()
  } catch (_) {} finally { loading.value = false }
}

async function receive() {
  loading.value = true
  try {
    await orderApi.receive(order.value.orderId)
    ElMessage.success('已确认收货')
    await loadOrder()
  } catch (_) {} finally { loading.value = false }
}

async function submitReview() {
  loading.value = true
  try {
    await orderApi.review(order.value.orderId, reviewForm.value)
    ElMessage.success('评价成功')
    showReviewDialog.value = false
    reviewed.value = true
  } catch (_) {} finally { loading.value = false }
}

function statusType(s: string) {
  const map: Record<string, string> = {
    '待付款': 'warning', '待发货': 'primary', '待收货': '',
    '已完成': 'success', '已取消': 'info'
  }
  return map[s] || ''
}
</script>

<style scoped>
.detail-header { display: flex; justify-content: space-between; align-items: center; }
.price { font-size: 18px; font-weight: 700; color: var(--c-accent); }
.actions { margin-top: 24px; display: flex; gap: 12px; }
</style>
