<template>
  <div class="address-page">
    <div class="page-header">
      <h2 class="page-title">收货地址</h2>
      <el-button type="primary" @click="openAdd" size="large">
        <el-icon><Plus /></el-icon>新增地址
      </el-button>
    </div>

    <!-- Address List -->
    <div v-if="list.length" class="address-list">
      <div v-for="item in list" :key="item.id" class="address-card">
        <div class="address-left">
          <div class="address-top">
            <span class="address-receiver">{{ item.receiver }}</span>
            <span class="address-phone">{{ item.phone }}</span>
            <el-tag v-if="item.isDefault" size="small" class="default-tag">默认</el-tag>
          </div>
          <p class="address-text">
            {{ item.province }}{{ item.city }}{{ item.district }}{{ item.detail }}
          </p>
        </div>
        <div class="address-right">
          <el-button text @click="edit(item)">编辑</el-button>
          <el-popconfirm title="确定删除该地址？" @confirm="remove(item.id)">
            <template #reference>
              <el-button text type="danger">删除</el-button>
            </template>
          </el-popconfirm>
          <el-button v-if="!item.isDefault" text @click="setDefault(item.id)">设为默认</el-button>
        </div>
      </div>
    </div>
    <el-empty v-else description="暂无收货地址，点击上方按钮添加" />

    <!-- Dialog -->
    <el-dialog v-model="showDialog" :title="editingId ? '编辑地址' : '新增地址'" width="520px" :close-on-click-modal="false">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="80px" class="address-form">
        <el-form-item label="收件人" prop="receiver">
          <el-input v-model="form.receiver" placeholder="收件人姓名" />
        </el-form-item>
        <el-form-item label="手机号" prop="phone">
          <el-input v-model="form.phone" placeholder="11位手机号" maxlength="11" />
        </el-form-item>
        <el-form-item label="省市区" prop="region">
          <el-cascader
            v-model="form.region"
            :options="regionData"
            :props="cascaderProps"
            placeholder="请选择省 / 市 / 区"
            class="region-cascader"
            clearable
          />
        </el-form-item>
        <el-form-item label="详细地址" prop="detail">
          <el-input v-model="form.detail" placeholder="街道、门牌号等" type="textarea" :rows="2" maxlength="200" show-word-limit />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="showDialog = false">取消</el-button>
        <el-button type="primary" @click="save" :loading="saving">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { Plus } from '@element-plus/icons-vue'
import { regionData, codeToText } from 'element-china-area-data'
import { userApi } from '@/api'

const list = ref<any[]>([])
const showDialog = ref(false)
const editingId = ref<number | null>(null)
const saving = ref(false)
const formRef = ref()

const form = reactive({
  receiver: '',
  phone: '',
  region: [] as string[],
  detail: ''
})

const rules = {
  receiver: [{ required: true, message: '请输入收件人', trigger: 'blur' }],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1\d{10}$/, message: '手机号格式不正确', trigger: 'blur' }
  ],
  region: [{ required: true, message: '请选择省市区', trigger: 'change' }],
  detail: [{ required: true, message: '请输入详细地址', trigger: 'blur' }]
}

const cascaderProps = {
  label: 'label',
  value: 'value',
  children: 'children'
}

onMounted(() => loadAddresses())

async function loadAddresses() {
  const res: any = await userApi.getAddresses()
  list.value = res.data || []
}

function openAdd() {
  editingId.value = null
  form.receiver = ''
  form.phone = ''
  form.region = []
  form.detail = ''
  showDialog.value = true
}

function edit(item: any) {
  editingId.value = item.id
  form.receiver = item.receiver
  form.phone = item.phone
  // Convert province/city/district to region codes
  form.region = findRegionCodes(item.province, item.city, item.district)
  form.detail = item.detail
  showDialog.value = true
}

function findRegionCodes(province: string, city: string, district: string): string[] {
  const codes: string[] = []
  for (const p of regionData) {
    if (p.label === province) {
      codes.push(p.value)
      if (p.children && city) {
        for (const c of p.children) {
          if (c.label === city) {
            codes.push(c.value)
            if (c.children && district) {
              for (const d of c.children) {
                if (d.label === district) {
                  codes.push(d.value)
                  break
                }
              }
            }
            break
          }
        }
      }
      break
    }
  }
  return codes
}

function getRegionLabels(codes: string[]): { province: string; city: string; district: string } {
  const result = { province: '', city: '', district: '' }
  if (codes.length >= 1) result.province = codeToText[codes[0]] || ''
  if (codes.length >= 2) result.city = codeToText[codes[1]] || ''
  if (codes.length >= 3) result.district = codeToText[codes[2]] || ''
  return result
}

async function save() {
  const valid = await formRef.value.validate().catch(() => false)
  if (!valid) return

  saving.value = true
  try {
    const region = getRegionLabels(form.region)
    const addressData = {
      receiver: form.receiver,
      phone: form.phone,
      province: region.province,
      city: region.city,
      district: region.district,
      detail: form.detail
    }

    if (editingId.value) {
      await userApi.updateAddress(editingId.value, addressData)
    } else {
      await userApi.addAddress(addressData)
    }
    ElMessage.success('保存成功')
    showDialog.value = false
    editingId.value = null
    await loadAddresses()
  } catch (_) {
    ElMessage.error('保存失败')
  } finally {
    saving.value = false
  }
}

async function remove(id: number) {
  await userApi.deleteAddress(id)
  ElMessage.success('已删除')
  await loadAddresses()
}

async function setDefault(id: number) {
  await userApi.setDefaultAddress(id)
  await loadAddresses()
}
</script>

<style scoped>
.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
}

.page-title {
  font-size: 22px;
  font-weight: 700;
  color: var(--c-text);
}

/* Address List */
.address-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.address-card {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius-md);
  padding: 20px;
  transition: box-shadow 0.2s;
}

.address-card:hover {
  box-shadow: var(--shadow-sm);
}

.address-top {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 8px;
}

.address-receiver {
  font-size: 16px;
  font-weight: 600;
  color: var(--c-text);
}

.address-phone {
  font-size: 14px;
  color: var(--c-text-secondary);
}

.default-tag {
  margin-left: 4px;
}

.address-text {
  font-size: 14px;
  color: var(--c-text-secondary);
  line-height: 1.5;
}

.address-right {
  display: flex;
  align-items: center;
  gap: 4px;
  flex-shrink: 0;
  margin-left: 16px;
}

/* Dialog Form */
.address-form {
  padding: 8px 0;
}

.region-cascader {
  width: 100%;
}
</style>
