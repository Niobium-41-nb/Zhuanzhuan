<template>
  <div class="address-page">
    <div class="page-header"><h2>收货地址</h2><el-button type="primary" @click="showDialog = true">新增地址</el-button></div>
    <el-card v-for="item in list" :key="item.id" class="address-card">
      <div class="address-content">
        <div>
          <p><strong>{{ item.receiver }}</strong> {{ item.phone }}</p>
          <p>{{ item.province }}{{ item.city }}{{ item.district }}{{ item.detail }}</p>
        </div>
        <div class="address-actions">
          <el-tag v-if="item.isDefault" type="success" size="small">默认</el-tag>
          <el-button text @click="edit(item)">编辑</el-button>
          <el-button text type="danger" @click="remove(item.id)">删除</el-button>
          <el-button v-if="!item.isDefault" text @click="setDefault(item.id)">设为默认</el-button>
        </div>
      </div>
    </el-card>
    <el-empty v-if="!list.length" description="暂无地址" />
    <el-dialog v-model="showDialog" :title="editingId ? '编辑地址' : '新增地址'" width="500px">
      <el-form :model="form" label-width="80px">
        <el-form-item label="收件人"><el-input v-model="form.receiver" /></el-form-item>
        <el-form-item label="电话"><el-input v-model="form.phone" /></el-form-item>
        <el-row :gutter="10">
          <el-col :span="8"><el-form-item label="省"><el-input v-model="form.province" /></el-form-item></el-col>
          <el-col :span="8"><el-form-item label="市"><el-input v-model="form.city" /></el-form-item></el-col>
          <el-col :span="8"><el-form-item label="区"><el-input v-model="form.district" /></el-form-item></el-col>
        </el-row>
        <el-form-item label="详细地址"><el-input v-model="form.detail" /></el-form-item>
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
import { userApi } from '@/api'

const list = ref<any[]>([])
const showDialog = ref(false)
const editingId = ref<number | null>(null)
const form = reactive({ receiver: '', phone: '', province: '', city: '', district: '', detail: '' })

onMounted(() => loadAddresses())

async function loadAddresses() { const res = await userApi.getAddresses(); list.value = res.data || [] }

function edit(item: any) { editingId.value = item.id; Object.assign(form, item); showDialog.value = true }

async function save() {
  if (editingId.value) await userApi.updateAddress(editingId.value, form)
  else await userApi.addAddress(form)
  ElMessage.success('保存成功'); showDialog.value = false; editingId.value = null; loadAddresses()
}

async function remove(id: number) { await userApi.deleteAddress(id); ElMessage.success('已删除'); loadAddresses() }
async function setDefault(id: number) { await userApi.setDefaultAddress(id); loadAddresses() }
</script>

<style scoped>
.page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
.address-card { margin-bottom: 12px; }
.address-content { display: flex; justify-content: space-between; align-items: center; }
.address-actions { display: flex; align-items: center; gap: 8px; }
</style>
