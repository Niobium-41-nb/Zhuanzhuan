<template>
  <div><h2>商品审核</h2>
    <el-table :data="list" border stripe>
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="title" label="商品名称" min-width="200" />
      <el-table-column prop="price" label="价格" width="100" />
      <el-table-column label="卖家" prop="userId" width="80" />
      <el-table-column prop="createdAt" label="发布时间" width="160" />
      <el-table-column label="操作" width="200">
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

onMounted(async () => { const res = await adminApi.getReviewList({}); list.value = res.data?.records || [] })

async function review(id: number, action: string) {
  await adminApi.reviewProduct(id, { action })
  ElMessage.success('审核完成'); list.value = list.value.filter(i => i.id !== id)
}
</script>
