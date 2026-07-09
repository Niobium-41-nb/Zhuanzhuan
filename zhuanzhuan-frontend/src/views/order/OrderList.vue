<template>
  <div class="order-list">
    <div class="order-top"><h2>我的订单</h2><el-radio-group v-model="role" size="default" @change="loadOrders"><el-radio-button value="buyer">我买的</el-radio-button><el-radio-button value="seller">我卖的</el-radio-button></el-radio-group></div>
    <el-alert v-if="role==='seller'" title="切换到「待发货」查看需要你发货的订单，点击订单进入详情→录入物流→发货" type="success" :closable="false" show-icon style="margin-bottom:10px"/>
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
        <span class="order-person">{{ role==='buyer'?'卖家':'买家' }}：{{ role==='buyer'?item.sellerName:item.buyerName }}</span>
        <el-tag :type="statusType(item.status)">{{ item.status }}</el-tag>
        <el-button v-if="role==='seller' && item.status==='待发货'" type="primary" size="small" @click.stop="$router.push(`/order/${item.orderId}`)">📦 去发货</el-button>
      </div>
      <div class="order-body">
        <img :src="getOrderProductImage(item.productImage, item.productTitle, item.productId)" class="order-img" />
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
import { getOrderProductImage } from '@/utils/productImage'

const list = ref<any[]>([])
const activeStatus = ref('')
const role = ref('buyer')

onMounted(() => loadOrders())

async function loadOrders() {
  const params: any = { role: role.value }
  if (activeStatus.value) params.status = activeStatus.value
  const res = await orderApi.getList(params)
  list.value = res.data || []
}

function statusType(s: string) {
  const map: any = { '待付款': 'warning', '待发货': 'primary', '待收货': 'info', '已完成': 'success', '已取消': 'info' }
  return map[s] || ''
}
</script>

<style scoped>
.order-top { display:flex; justify-content:space-between; align-items:center; margin-bottom:8px; }
.order-top h2 { margin:0; }
.order-card { margin-bottom: 12px; cursor: pointer; }
.order-card:hover { border-color:var(--c-primary); }
.order-person { color:var(--c-text-secondary); font-size:13px; flex:1; text-align:right; margin-right:12px; }
.order-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
.order-no { color: #909399; font-size: 12px; }
.order-body { display: flex; gap: 16px; }
.order-img { width: 80px; height: 80px; object-fit: cover; border-radius: 4px; }
.order-info p { margin: 4px 0; }
.order-price { color: #f56c6c; font-weight: bold; }
.order-footer { margin-top: 12px; color: #909399; font-size: 12px; text-align: right; }
</style>
