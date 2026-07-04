<template>
  <div><h2>订单管理</h2>
    <el-table :data="list" border stripe>
      <el-table-column prop="orderNo" label="订单号" width="180" />
      <el-table-column prop="buyerId" label="买家ID" width="80" />
      <el-table-column prop="sellerId" label="卖家ID" width="80" />
      <el-table-column prop="totalPrice" label="金额" width="100" />
      <el-table-column prop="status" label="状态" width="100">
        <template #default="{ row }"><el-tag :type="tagType(row.status)">{{ row.status }}</el-tag></template>
      </el-table-column>
      <el-table-column prop="createdAt" label="创建时间" width="160" />
    </el-table>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { adminApi } from '@/api'

const list = ref<any[]>([])

onMounted(async () => { const res = await adminApi.getOrders({}); list.value = res.data || [] })

function tagType(s: string) { const map: any = { '待付款': 'warning', '待发货': 'primary', '待收货': 'info', '已完成': 'success', '已取消': 'info' }; return map[s] || '' }
</script>
