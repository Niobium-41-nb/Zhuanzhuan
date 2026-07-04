<template>
  <div>
    <div class="page-header">
      <h2>商品管理</h2>
      <div class="header-actions">
        <el-select v-model="filterStatus" placeholder="全部状态" clearable style="width:130px" @change="loadData">
          <el-option label="全部状态" value="" />
          <el-option label="待审核" value="待审核" />
          <el-option label="在售" value="在售" />
          <el-option label="审核驳回" value="审核驳回" />
          <el-option label="已下架" value="已下架" />
          <el-option label="已售出" value="已售出" />
        </el-select>
        <el-input v-model="keyword" placeholder="搜索商品名称..." clearable style="width:220px" @clear="loadData" @keyup.enter="loadData" />
        <el-button type="primary" @click="loadData">搜索</el-button>
      </div>
    </div>

    <el-table :data="list" border stripe v-loading="loading" empty-text="暂无商品数据" style="width:100%">
      <el-table-column prop="id" label="ID" width="60" />
      <el-table-column label="商品名称" min-width="200" show-overflow-tooltip>
        <template #default="{ row }">
          <div class="product-cell">
            <el-image :src="row.coverImage" style="width:40px;height:40px;border-radius:4px;flex-shrink:0" fit="cover">
              <template #error><div class="img-placeholder">📷</div></template>
            </el-image>
            <span class="product-title">{{ row.title }}</span>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="价格" width="100">
        <template #default="{ row }">¥{{ row.price }}</template>
      </el-table-column>
      <el-table-column prop="userId" label="卖家ID" width="80" />
      <el-table-column prop="viewCount" label="浏览" width="70" align="center" />
      <el-table-column prop="favoriteCount" label="收藏" width="70" align="center" />
      <el-table-column label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="statusType(row.status)" size="small">{{ row.status }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createdAt" label="发布时间" width="150" />
      <el-table-column label="操作" width="310" fixed="right">
        <template #default="{ row }">
          <el-button size="small" type="primary" @click="openEdit(row)">编辑</el-button>
          <el-button size="small" type="success" v-if="row.status === '待审核'" @click="review(row.id, 'approve')">通过</el-button>
          <el-button size="small" type="danger" v-if="row.status === '待审核'" @click="review(row.id, 'reject')">驳回</el-button>
          <el-button size="small" type="warning" v-if="row.status === '在售'" @click="offline(row.id)">下架</el-button>
          <el-popconfirm title="确定删除该商品？" @confirm="remove(row.id)">
            <template #reference>
              <el-button size="small" type="danger">删除</el-button>
            </template>
          </el-popconfirm>
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

    <!-- Edit Dialog -->
    <el-dialog v-model="editVisible" title="编辑商品" width="600px" destroy-on-close>
      <el-form :model="editForm" label-width="80px" size="small" v-if="editForm">
        <el-form-item label="商品名称">
          <el-input v-model="editForm.title" maxlength="50" />
        </el-form-item>
        <el-form-item label="价格">
          <el-input-number v-model="editForm.price" :precision="2" :min="0" :max="999999" style="width:200px" />
        </el-form-item>
        <el-form-item label="原价">
          <el-input-number v-model="editForm.originalPrice" :precision="2" :min="0" :max="999999" style="width:200px" />
        </el-form-item>
        <el-form-item label="成色">
          <el-select v-model="editForm.condition" style="width:200px">
            <el-option label="全新" value="全新" />
            <el-option label="几乎全新" value="几乎全新" />
            <el-option label="轻微使用痕迹" value="轻微使用痕迹" />
            <el-option label="明显使用痕迹" value="明显使用痕迹" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="editForm.status" style="width:200px">
            <el-option label="待审核" value="待审核" />
            <el-option label="在售" value="在售" />
            <el-option label="审核驳回" value="审核驳回" />
            <el-option label="已下架" value="已下架" />
            <el-option label="已售出" value="已售出" />
          </el-select>
        </el-form-item>
        <el-form-item label="封面图">
          <div class="cover-manage">
            <div class="cover-preview" v-if="editForm.coverImage">
              <el-image :src="editForm.coverImage" fit="contain" style="width:100%;height:100%">
                <template #error>
                  <div class="cover-error">图片加载失败</div>
                </template>
              </el-image>
              <el-button class="cover-remove" size="small" circle @click="editForm.coverImage = ''">
                <el-icon><Close /></el-icon>
              </el-button>
            </div>
            <div class="cover-empty" v-else @click="coverUploadRef?.$el.querySelector('input')?.click()">
              <el-icon><Plus /></el-icon>
              <span>点击上传封面</span>
            </div>
            <div class="cover-actions">
              <el-upload
                ref="coverUploadRef"
                action="#"
                :auto-upload="false"
                :show-file-list="false"
                :on-change="handleCoverUpload"
                accept="image/jpeg,image/png,image/gif,image/webp"
              >
                <el-button size="small" type="primary">
                  <el-icon><Upload /></el-icon> 上传图片
                </el-button>
              </el-upload>
              <el-button size="small" @click="showUrlInput = !showUrlInput">
                <el-icon><Link /></el-icon> {{ showUrlInput ? '收起' : '输入URL' }}
              </el-button>
            </div>
            <el-input v-if="showUrlInput" v-model="editForm.coverImage" placeholder="输入图片URL地址..." style="margin-top:8px" clearable />
          </div>
        </el-form-item>
        <el-form-item label="商品描述">
          <el-input v-model="editForm.description" type="textarea" :rows="4" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="editVisible = false">取消</el-button>
        <el-button type="primary" @click="saveEdit" :loading="saving">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { Close, Plus, Upload, Link } from '@element-plus/icons-vue'
import { adminApi, productApi } from '@/api'

const list = ref<any[]>([])
const loading = ref(false)
const page = ref(1)
const size = ref(10)
const total = ref(0)
const keyword = ref('')
const filterStatus = ref('')

// Edit dialog
const editVisible = ref(false)
const editForm = ref<any>(null)
const saving = ref(false)
const showUrlInput = ref(false)
const coverUploadRef = ref<any>(null)

/** 上传封面图 */
async function handleCoverUpload(uploadFile: any) {
  if (!uploadFile.raw) return
  const formData = new FormData()
  formData.append('file', uploadFile.raw)
  try {
    const res: any = await productApi.uploadImage(formData)
    editForm.value.coverImage = res.data.url
    ElMessage.success('封面上传成功')
  } catch (_) {
    ElMessage.error('封面上传失败')
  }
}

function statusType(s: string) {
  const map: Record<string, string> = { '待审核': 'warning', '在售': 'success', '审核驳回': 'danger', '已下架': 'info', '已售出': 'default' }
  return map[s] || 'info'
}

onMounted(() => loadData())

async function loadData() {
  loading.value = true
  try {
    const params: any = { page: page.value, size: size.value }
    if (keyword.value) params.keyword = keyword.value
    if (filterStatus.value) params.status = filterStatus.value
    const res: any = await adminApi.getProductList(params)
    list.value = res.data || []
    total.value = res.total || 0
  } catch (_) {
    ElMessage.error('加载失败')
  } finally {
    loading.value = false
  }
}

async function review(id: number, action: string) {
  try {
    await adminApi.reviewProduct(id, { action })
    ElMessage.success(action === 'approve' ? '已通过' : '已驳回')
    loadData()
  } catch (_) {
    ElMessage.error('操作失败')
  }
}

async function offline(id: number) {
  try {
    await adminApi.offlineProduct(id)
    ElMessage.success('已下架')
    loadData()
  } catch (_) {
    ElMessage.error('操作失败')
  }
}

async function remove(id: number) {
  try {
    await adminApi.adminDeleteProduct(id)
    ElMessage.success('已删除')
    loadData()
  } catch (_) {
    ElMessage.error('删除失败')
  }
}

function openEdit(row: any) {
  editForm.value = { ...row }
  showUrlInput.value = false
  editVisible.value = true
}

async function saveEdit() {
  saving.value = true
  try {
    await adminApi.adminUpdateProduct(editForm.value.id, editForm.value)
    ElMessage.success('保存成功')
    editVisible.value = false
    loadData()
  } catch (_) {
    ElMessage.error('保存失败')
  } finally {
    saving.value = false
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

.product-cell {
  display: flex;
  align-items: center;
  gap: 10px;
}

.product-title {
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.img-placeholder {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f5f7fa;
  border-radius: 4px;
  font-size: 18px;
}

/* Cover Image Management */
.cover-manage {
  width: 100%;
}

.cover-preview {
  position: relative;
  width: 200px;
  height: 150px;
  border: 1px solid #dcdfe6;
  border-radius: 6px;
  overflow: hidden;
  background: #fafafa;
  margin-bottom: 10px;
}

.cover-remove {
  position: absolute;
  top: 4px;
  right: 4px;
  width: 24px;
  height: 24px;
  background: rgba(0,0,0,0.5);
  color: #fff;
  border: none;
}

.cover-remove:hover {
  background: rgba(0,0,0,0.7);
  color: #fff;
}

.cover-empty {
  width: 200px;
  height: 150px;
  border: 2px dashed #dcdfe6;
  border-radius: 6px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 8px;
  color: #909399;
  cursor: pointer;
  transition: all 0.2s;
  margin-bottom: 10px;
}

.cover-empty:hover {
  border-color: #409eff;
  color: #409eff;
  background: #ecf5ff;
}

.cover-empty .el-icon {
  font-size: 28px;
}

.cover-error {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #909399;
  font-size: 13px;
}

.cover-actions {
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
