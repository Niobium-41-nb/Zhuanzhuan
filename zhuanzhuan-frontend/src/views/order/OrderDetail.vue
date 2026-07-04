<template>
  <div class="order-detail" v-if="order">
    <el-card>
      <template #header>
        <div class="detail-header">
          <span>订单详情</span>
          <el-tag :type="statusType(order.status)">{{ order.status }}</el-tag>
        </div>
      </template>
      <el-descriptions :column="2">
        <el-descriptions-item label="订单号">{{ order.orderNo }}</el-descriptions-item>
        <el-descriptions-item label="总价">¥{{ order.totalPrice }}</el-descriptions-item>
        <el-descriptions-item label="卖家">{{ order.sellerName }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ order.createdAt }}</el-descriptions-item>
        <el-descriptions-item label="收件人">{{ order.shippingName }}</el-descriptions-item>
        <el-descriptions-item label="联系电话">{{ order.shippingPhone }}</el-descriptions-item>
        <el-descriptions-item label="收货地址" :span="2">{{ order.shippingAddress }}</el-descriptions-item>
        <el-descriptions-item label="物流公司">{{ order.logisticsCompany || '-' }}</el-descriptions-item>
        <el-descriptions-item label="物流单号">{{ order.logisticsNo || '-' }}</el-descriptions-item>
      </el-descriptions>
      <div class="actions" v-if="order.status === '待付款'">
        <el-button type="primary" @click="pay">去支付</el-button>
        <el-button @click="cancel">取消订单</el-button>
      </div>
    </el-card>
    <el-card v-if="logs.length" style="margin-top:16px">
      <template #header>订单状态</template>
      <el-timeline>
        <el-timeline-item v-for="log in logs" :key="log.createdAt" :timestamp="log.createdAt">
          {{ log.remark }}（{{ log.fromStatus || '创建' }} → {{ log.toStatus }}）
        </el-timeline-item>
      </el-timeline>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { orderApi } from '@/api'

const route = useRoute()
const order = ref<any>(null)
const logs = ref<any[]>([])

onMounted(async () => {
  const res = await orderApi.getDetail(Number(route.params.id))
  order.value = res.data
  const logRes = await orderApi.getLogs(Number(route.params.id))
  logs.value = logRes.data || []
})

async function pay() { await orderApi.pay(order.value.orderId); ElMessage.success('支付成功'); location.reload() }
async function cancel() { await orderApi.cancel(order.value.orderId); ElMessage.success('已取消'); location.reload() }

function statusType(s: string) { const map: any = { '待付款': 'warning', '待发货': 'primary', '待收货': 'info', '已完成': 'success', '已取消': 'info' }; return map[s] || '' }
</script>

<style scoped>
.detail-header { display: flex; justify-content: space-between; align-items: center; }
.actions { margin-top: 20px; display: flex; gap: 12px; }
</style>
