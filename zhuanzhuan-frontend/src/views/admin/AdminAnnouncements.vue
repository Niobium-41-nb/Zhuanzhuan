<template>
  <div><h2>公告管理</h2>
    <el-button type="primary" @click="openCreate" style="margin-bottom:16px">发布公告</el-button>
    <el-table :data="list" border stripe>
      <el-table-column prop="title" label="标题" min-width="200" />
      <el-table-column prop="status" label="状态" width="80">
        <template #default="{ row }"><el-tag :type="row.status === 1 ? 'success' : 'info'">{{ row.status === 1 ? '已发布' : '草稿' }}</el-tag></template>
      </el-table-column>
      <el-table-column prop="createdAt" label="发布时间" width="160" />
      <el-table-column label="操作" width="150">
        <template #default="{ row }">
          <el-button size="small" @click="edit(row)">编辑</el-button>
          <el-button size="small" type="danger" @click="remove(row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-dialog v-model="showDialog" :title="editingId ? '编辑公告' : '发布公告'" width="600px">
      <el-form :model="form" label-width="60px">
        <el-form-item label="标题"><el-input v-model="form.title" /></el-form-item>
        <el-form-item label="内容"><el-input v-model="form.content" type="textarea" :rows="6" /></el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showDialog = false">取消</el-button>
        <el-button type="primary" @click="save">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { adminApi } from '@/api'

const list = ref<any[]>([])
const showDialog = ref(false)
const editingId = ref<number | null>(null)
const saving = ref(false)
const form = reactive({ title: '', content: '' })

onMounted(async () => { await loadList() })
async function loadList() { const res = await adminApi.getAnnouncements(); list.value = res.data || [] }

function openCreate() { editingId.value = null; form.title = ''; form.content = ''; showDialog.value = true }
function edit(row: any) { editingId.value = row.id; form.title = row.title; form.content = row.content; showDialog.value = true }

async function save() {
  if (saving.value) return
  saving.value = true
  try {
    if (editingId.value) await adminApi.updateAnnouncement(editingId.value, form)
    else await adminApi.createAnnouncement(form)
    ElMessage.success('保存成功'); showDialog.value = false; editingId.value = null
    await loadList() // 刷新列表而非 reload 页面
  } catch (_) {} finally { saving.value = false }
}

async function remove(id: number) { await adminApi.deleteAnnouncement(id); ElMessage.success('已删除'); list.value = list.value.filter(i => i.id !== id) }
</script>
