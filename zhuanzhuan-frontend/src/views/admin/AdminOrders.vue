<template>
  <div>
    <div class="page-header">
      <h2>订单管理</h2>
      <div class="header-actions">
        <el-select v-model="filterStatus" placeholder="全部状态" clearable style="width:130px" @change="loadData">
          <el-option label="全部状态" value="" />
          <el-option label="待付款" value="待付款" />
          <el-option label="待发货" value="待发货" />
          <el-option label="待收货" value="待收货" />
          <el-option label="已完成" value="已完成" />
          <el-option label="已取消" value="已取消" />
        </el-select>
        <el-input v-model="orderNo" placeholder="搜索订单号..." clearable style="width:220px" @clear="loadData" @keyup.enter="loadData" />
        <el-button type="primary" @click="loadData">搜索</el-button>
      </div>
    </div>

    <el-table :data="list" border stripe v-loading="loading" empty-text="暂无订单数据" style="width:100%">
      <el-table-column prop="orderNo" label="订单号" width="180" />
      <el-table-column prop="buyerId" label="买家ID" width="80" />
      <el-table-column prop="sellerId" label="卖家ID" width="80" />
      <el-table-column prop="productId" label="商品ID" width="80" />
      <el-table-column label="金额" width="100">
        <template #default="{ row }">¥{{ row.totalPrice }}</template>
      </el-table-column>
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="tagType(row.status)">{{ row.status }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createdAt" label="创建时间" width="150" />
      <el-table-column label="操作" width="240" fixed="right">
        <template #default="{ row }">
          <el-button size="small" type="primary" @click="openDetail(row)">详情</el-button>
          <el-button size="small" type="success" v-if="row.status === '待付款'"
            @click="updateStatus(row.id, '已付款')">标记付款</el-button>
          <el-button size="small" type="primary" v-if="row.status === '待发货'"
            @click="updateStatus(row.id, '已发货')">标记发货</el-button>
          <el-button size="small" type="warning" v-if="row.status === '待收货'"
            @click="updateStatus(row.id, '已完成')">标记完成</el-button>
          <el-button size="small" type="danger" v-if="row.status === '待付款'"
            @click="updateStatus(row.id, '已取消')">取消</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div class="pagination-wrap" v-if="total > 0">
      <el-pagination
        v-model:current-page="page"
        :total="total"
        :page-size="size"
        layout="total, prev, pager, next"
        background
        @current-change="loadData"
      />
    </div>

    <!-- Order Detail Dialog -->
    <el-dialog v-model="detailVisible" title="订单详情" width="650px" destroy-on-close>
      <el-descriptions :column="2" border size="small" v-if="detail">
        <el-descriptions-item label="订单号" span="2">{{ detail.orderNo }}</el-descriptions-item>
        <el-descriptions-item label="买家ID">{{ detail.buyerId }}</el-descriptions-item>
        <el-descriptions-item label="卖家ID">{{ detail.sellerId }}</el-descriptions-item>
        <el-descriptions-item label="商品ID">{{ detail.productId }}</el-descriptions-item>
        <el-descriptions-item label="总金额">¥{{ detail.totalPrice }}</el-descriptions-item>
        <el-descriptions-item label="订单状态">
          <el-tag :type="tagType(detail.status)" size="small">{{ detail.status }}</el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="收货人">{{ detail.shippingName || '—' }}</el-descriptions-item>
        <el-descriptions-item label="联系电话">{{ detail.shippingPhone || '—' }}</el-descriptions-item>
        <el-descriptions-item label="收货地址" span="2">{{ detail.shippingAddress || '—' }}</el-descriptions-item>
        <el-descriptions-item label="物流公司">{{ detail.logisticsCompany || '—' }}</el-descriptions-item>
        <el-descriptions-item label="物流单号">{{ detail.logisticsNo || '—' }}</el-descriptions-item>
        <el-descriptions-item label="买家备注" span="2">{{ detail.buyerRemark || '—' }}</el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ detail.createdAt }}</el-descriptions-item>
        <el-descriptions-item label="付款时间">{{ detail.paidAt || '—' }}</el-descriptions-item>
        <el-descriptions-item label="发货时间">{{ detail.shippedAt || '—' }}</el-descriptions-item>
        <el-descriptions-item label="完成时间">{{ detail.receivedAt || '—' }}</el-descriptions-item>
      </el-descriptions>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { adminApi } from '@/api'

const list = ref<any[]>([])
const loading = ref(false)
const page = ref(1)
const size = ref(10)
const total = ref(0)
const filterStatus = ref('')
const orderNo = ref('')

// Detail dialog
const detailVisible = ref(false)
const detail = ref<any>(null)

function tagType(s: string) {
  const map: any = { '待付款': 'warning', '待发货': 'primary', '待收货': 'info', '已完成': 'success', '已取消': 'info' }
  return map[s] || ''
}

onMounted(() => loadData())

async function loadData() {
  loading.value = true
  try {
    const params: any = { page: page.value, size: size.value }
    if (filterStatus.value) params.status = filterStatus.value
    if (orderNo.value) params.orderNo = orderNo.value
    const res: any = await adminApi.getOrders(params)
    list.value = res.data || []
    total.value = res.total || 0
  } catch (_) {
    ElMessage.error('加载失败')
  } finally {
    loading.value = false
  }
}

async function updateStatus(id: number, status: string) {
  try {
    await adminApi.updateOrderStatus(id, { status })
    ElMessage.success('操作成功')
    loadData()
  } catch (_) {
    ElMessage.error('操作失败')
  }
}

async function openDetail(row: any) {
  try {
    const res: any = await adminApi.getOrderDetail(row.id)
    detail.value = res.data
    detailVisible.value = true
  } catch (_) {
    ElMessage.error('加载订单详情失败')
  }
}
</script>

<style scoped>
.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
  flex-wrap: wrap;
  gap: 12px;
}

.page-header h2 {
  font-size: 20px;
  font-weight: 600;
  margin: 0;
}

.header-actions {
  display: flex;
  gap: 8px;
  align-items: center;
}

.pagination-wrap {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}
</style>
