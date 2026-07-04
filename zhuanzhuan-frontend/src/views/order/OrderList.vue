<template>
  <div class="order-list">
    <h2>我的订单</h2>
    <el-tabs v-model="activeStatus" @tab-change="loadOrders">
      <el-tab-pane label="全部" name="" />
      <el-tab-pane label="待付款" name="待付款" />
      <el-tab-pane label="待发货" name="待发货" />
      <el-tab-pane label="待收货" name="待收货" />
      <el-tab-pane label="已完成" name="已完成" />
      <el-tab-pane label="已取消" name="已取消" />
    </el-tabs>
    <el-card v-for="item in list" :key="item.orderId" class="order-card" @click="$router.push(`/order/${item.orderId}`)">
      <div class="order-header">
        <span class="order-no">订单号：{{ item.orderNo }}</span>
        <el-tag :type="statusType(item.status)">{{ item.status }}</el-tag>
      </div>
      <div class="order-body">
        <img :src="item.productImage" class="order-img" />
        <div class="order-info"><p>{{ item.productTitle }}</p><p class="order-price">¥{{ item.totalPrice }}</p></div>
      </div>
      <div class="order-footer"><span>{{ item.createdAt }}</span></div>
    </el-card>
    <el-empty v-if="!list.length" description="暂无订单" />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { orderApi } from '@/api'

const list = ref<any[]>([])
const activeStatus = ref('')

onMounted(() => loadOrders())

async function loadOrders() {
  const params: any = { role: 'buyer' }
  if (activeStatus.value) params.status = activeStatus.value
  const res = await orderApi.getList(params)
  list.value = res.data?.records || []
}

function statusType(s: string) {
  const map: any = { '待付款': 'warning', '待发货': 'primary', '待收货': 'info', '已完成': 'success', '已取消': 'info' }
  return map[s] || ''
}
</script>

<style scoped>
.order-card { margin-bottom: 12px; cursor: pointer; }
.order-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
.order-no { color: #909399; font-size: 12px; }
.order-body { display: flex; gap: 16px; }
.order-img { width: 80px; height: 80px; object-fit: cover; border-radius: 4px; }
.order-info p { margin: 4px 0; }
.order-price { color: #f56c6c; font-weight: bold; }
.order-footer { margin-top: 12px; color: #909399; font-size: 12px; text-align: right; }
</style>
