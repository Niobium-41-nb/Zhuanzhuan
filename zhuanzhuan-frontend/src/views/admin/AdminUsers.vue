<template>
  <div><h2>用户管理</h2>
    <el-table :data="list" border stripe>
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column prop="username" label="用户名" />
      <el-table-column prop="email" label="邮箱" />
      <el-table-column prop="phone" label="手机号" />
      <el-table-column prop="role" label="角色">
        <template #default="{ row }"><el-tag :type="row.role === 'admin' ? 'danger' : 'info'">{{ row.role }}</el-tag></template>
      </el-table-column>
      <el-table-column prop="creditScore" label="信誉分" width="80" />
      <el-table-column prop="status" label="状态" width="80">
        <template #default="{ row }"><el-tag :type="row.status === 1 ? 'success' : 'danger'">{{ row.status === 1 ? '启用' : '禁用' }}</el-tag></template>
      </el-table-column>
      <el-table-column label="操作" width="200">
        <template #default="{ row }">
          <el-button size="small" @click="toggleStatus(row)">{{ row.status === 1 ? '禁用' : '启用' }}</el-button>
          <el-button size="small" @click="toggleRole(row)">{{ row.role === 'admin' ? '设为普通用户' : '设为管理员' }}</el-button>
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

onMounted(async () => { const res = await adminApi.getUsers({}); list.value = res.data?.records || [] })

async function toggleStatus(row: any) {
  await adminApi.updateUserStatus(row.id, { status: row.status === 1 ? 0 : 1 })
  row.status = row.status === 1 ? 0 : 1; ElMessage.success('操作成功')
}

async function toggleRole(row: any) {
  await adminApi.updateUserRole(row.id, { role: row.role === 'admin' ? 'user' : 'admin' })
  row.role = row.role === 'admin' ? 'user' : 'admin'; ElMessage.success('操作成功')
}
</script>
