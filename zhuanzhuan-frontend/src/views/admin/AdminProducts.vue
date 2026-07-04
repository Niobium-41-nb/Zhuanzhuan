<template>
  <div>
    <div class="page-header">
      <h2>商品审核</h2>
      <el-tag type="warning">待审核 {{ list.length }} 件</el-tag>
    </div>

    <el-table :data="list" border stripe v-loading="loading" empty-text="暂无待审核商品">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="title" label="商品名称" min-width="200" show-overflow-tooltip />
      <el-table-column label="价格" width="100">
        <template #default="{ row }">¥{{ row.price }}</template>
      </el-table-column>
      <el-table-column label="卖家" width="120">
        <template #default="{ row }">
          <span>ID: {{ row.userId }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="status" label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="statusType(row.status)" size="small">{{ row.status }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createdAt" label="发布时间" width="160" />
      <el-table-column label="操作" width="200" fixed="right">
        <template #default="{ row }">
          <el-button size="small" type="success" @click="review(row.id, 'approve')">通过</el-button>
          <el-button size="small" type="danger" @click="review(row.id, 'reject')">驳回</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { adminApi } from '@/api'

const list = ref<any[]>([])
const loading = ref(false)

function statusType(status: string) {
  const map: Record<string, string> = { '待审核': 'warning', '在售': 'success', '审核驳回': 'danger', '已下架': 'info', '已售出': 'default' }
  return map[status] || 'info'
}

onMounted(async () => {
  loading.value = true
  try {
    const res = await adminApi.getReviewList({ status: '待审核' })
    list.value = res.data || []
  } catch (_) {
    ElMessage.error('加载失败')
  } finally {
    loading.value = false
  }
})

async function review(id: number, action: string) {
  try {
    await adminApi.reviewProduct(id, { action })
    ElMessage.success(action === 'approve' ? '审核通过' : '已驳回')
    list.value = list.value.filter(i => i.id !== id)
  } catch (_) {
    ElMessage.error('操作失败')
  }
}
</script>

<style scoped>
.page-header {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 20px;
}

.page-header h2 {
  font-size: 20px;
  font-weight: 600;
  margin: 0;
}
</style>
