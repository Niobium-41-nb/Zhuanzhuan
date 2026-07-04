<template>
  <div class="my-products-page">
    <div class="page-header">
      <div class="header-left">
        <h2>我的商品</h2>
        <span class="header-count">共 {{ total }} 件</span>
      </div>
      <el-button type="primary" @click="$router.push('/product/publish')">
        <el-icon><Plus /></el-icon>发布商品
      </el-button>
    </div>

    <!-- 状态筛选标签 -->
    <el-tabs v-model="activeTab" @tab-change="handleTabChange" class="status-tabs">
      <el-tab-pane label="全部" name="" />
      <el-tab-pane label="在售" name="在售" />
      <el-tab-pane label="待审核" name="待审核" />
      <el-tab-pane label="已下架" name="已下架" />
      <el-tab-pane label="审核驳回" name="审核驳回" />
    </el-tabs>

    <!-- 商品列表 -->
    <template v-if="list.length">
      <div class="product-grid">
        <div v-for="item in list" :key="item.id" class="product-card">
          <div class="card-img-wrap" @click="$router.push(`/product/${item.id}`)">
            <img :src="getProductCover(item)" :alt="item.title" class="card-img" />
            <span class="status-badge" :class="statusClass(item.status)">{{ item.status }}</span>
          </div>
          <div class="card-body">
            <h4 class="card-title" @click="$router.push(`/product/${item.id}`)">{{ item.title }}</h4>
            <div class="card-price">¥{{ item.price }}</div>
            <div class="card-meta">
              <span>浏览 {{ item.viewCount || 0 }}</span>
              <span>收藏 {{ item.favoriteCount || 0 }}</span>
            </div>
            <div class="card-actions">
              <el-button size="small" @click="$router.push(`/product/${item.id}`)">查看</el-button>
              <el-button size="small" @click="handleEdit(item)">编辑</el-button>
              <el-button
                v-if="item.status === '在售'"
                size="small"
                @click="handleToggleStatus(item, '已下架')"
              >下架</el-button>
              <el-button
                v-if="item.status === '已下架' || item.status === '审核驳回'"
                size="small"
                type="primary"
                @click="handleToggleStatus(item, '在售')"
              >上架</el-button>
              <el-popconfirm title="确定删除该商品？" @confirm="handleDelete(item)">
                <template #reference>
                  <el-button size="small" type="danger" text>删除</el-button>
                </template>
              </el-popconfirm>
            </div>
          </div>
        </div>
      </div>

      <!-- 分页 -->
      <div class="pagination-wrap" v-if="total > size">
        <el-pagination
          v-model:current-page="page"
          :page-size="size"
          :total="total"
          layout="prev, pager, next"
          @current-change="fetchData"
        />
      </div>
    </template>

    <el-empty v-else description="还没有发布商品" />

    <!-- 编辑对话框 -->
    <el-dialog v-model="editVisible" title="编辑商品" width="640px" top="5vh">
      <el-form ref="editFormRef" :model="editForm" :rules="editRules" label-width="80px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="editForm.title" maxlength="50" show-word-limit />
        </el-form-item>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="分类" prop="categoryId">
              <el-cascader
                v-model="editForm.categoryId"
                :options="categories"
                :props="{ value:'id', label:'name', children:'children' }"
                placeholder="选择分类"
                class="full-width"
              />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="成色" prop="condition">
              <el-select v-model="editForm.condition" placeholder="选择成色" class="full-width">
                <el-option v-for="c in conditions" :key="c" :label="c" :value="c" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="价格" prop="price">
              <el-input-number v-model="editForm.price" :precision="2" :min="0" :step="10" class="full-width" controls-position="right" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="原价">
              <el-input-number v-model="editForm.originalPrice" :precision="2" :min="0" class="full-width" controls-position="right" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="描述">
          <el-input v-model="editForm.description" type="textarea" :rows="4" maxlength="2000" show-word-limit />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="editVisible = false">取消</el-button>
        <el-button type="primary" @click="submitEdit" :loading="editLoading">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { productApi } from '@/api'
import { getProductCover } from '@/utils/productImage'

const list = ref<any[]>([])
const total = ref(0)
const page = ref(1)
const size = ref(12)
const activeTab = ref('')
const conditions = ['全新', '几乎全新', '轻微使用痕迹', '明显使用痕迹', '老旧']
const categories = ref<any[]>([])

// 编辑对话框
const editVisible = ref(false)
const editLoading = ref(false)
const editFormRef = ref()
const editForm = reactive({ id: 0, title: '', categoryId: null, condition: '', price: 0, originalPrice: null, description: '' })
const editRules = {
  title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
  categoryId: [{ required: true, message: '请选择分类' }],
  condition: [{ required: true, message: '请选择成色' }],
  price: [{ required: true, message: '请输入价格' }]
}

function statusClass(status: string) {
  const map: Record<string, string> = {
    '在售': 'status-active',
    '待审核': 'status-pending',
    '已下架': 'status-offline',
    '审核驳回': 'status-rejected',
    '已售出': 'status-sold'
  }
  return map[status] || ''
}

onMounted(async () => {
  const res = await productApi.getCategories()
  categories.value = res.data || []
  fetchData()
})

function handleTabChange() {
  page.value = 1
  fetchData()
}

async function fetchData() {
  const params: any = { page: page.value, size: size.value }
  if (activeTab.value) {
    params.status = activeTab.value
  }
  const res: any = await productApi.getMyProducts(params)
  list.value = res.data || []
  total.value = res.total || 0
}

async function handleEdit(item: any) {
  // 获取完整商品详情
  const res = await productApi.getDetail(item.id)
  const p = res.data
  editForm.id = p.id
  editForm.title = p.title
  editForm.categoryId = p.category?.id ? (p.category?.parentId ? [p.category.parentId, p.category.id] : p.category.id) : null
  editForm.condition = p.condition
  editForm.price = p.price
  editForm.originalPrice = p.originalPrice || null
  editForm.description = p.description || ''
  editVisible.value = true
}

async function submitEdit() {
  const valid = await editFormRef.value.validate().catch(() => false)
  if (!valid) return
  editLoading.value = true
  try {
    const catId: unknown = editForm.categoryId
    const { id, ...payload } = {
      ...editForm,
      categoryId: Array.isArray(catId) ? catId[catId.length - 1] : catId
    }
    await productApi.update(editForm.id, payload)
    ElMessage.success('保存成功')
    editVisible.value = false
    fetchData()
  } catch (_) {} finally {
    editLoading.value = false
  }
}

async function handleToggleStatus(item: any, status: string) {
  try {
    await productApi.updateStatus(item.id, { status })
    ElMessage.success(status === '已下架' ? '已下架' : '已上架')
    fetchData()
  } catch (_) {}
}

async function handleDelete(item: any) {
  try {
    await productApi.delete(item.id)
    ElMessage.success('已删除')
    fetchData()
  } catch (_) {}
}
</script>

<style scoped>
.my-products-page {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: 24px;
}

.page-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
}

.header-left {
  display: flex;
  align-items: baseline;
  gap: 12px;
}

.header-left h2 {
  font-size: 22px;
  font-weight: 700;
  color: var(--c-text);
  margin: 0;
}

.header-count {
  font-size: 14px;
  color: var(--c-text-secondary);
}

.status-tabs {
  margin-bottom: 20px;
}

.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 20px;
}

.product-card {
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius-md);
  overflow: hidden;
  transition: box-shadow 0.2s;
}

.product-card:hover {
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
}

.card-img-wrap {
  position: relative;
  cursor: pointer;
  overflow: hidden;
}

.card-img {
  width: 100%;
  height: 200px;
  object-fit: cover;
  display: block;
  transition: transform 0.3s;
}

.card-img-wrap:hover .card-img {
  transform: scale(1.05);
}

.status-badge {
  position: absolute;
  top: 10px;
  left: 10px;
  padding: 3px 10px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
  color: #fff;
}

.status-active { background: #52c41a; }
.status-pending { background: #faad14; }
.status-offline { background: #999; }
.status-rejected { background: #f56c6c; }
.status-sold { background: #909399; }

.card-body {
  padding: 14px;
}

.card-title {
  margin: 0 0 6px;
  font-size: 15px;
  font-weight: 600;
  color: var(--c-text);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  cursor: pointer;
}

.card-title:hover {
  color: var(--c-primary);
}

.card-price {
  font-size: 18px;
  font-weight: 700;
  color: #f56c6c;
  margin-bottom: 6px;
}

.card-meta {
  display: flex;
  gap: 16px;
  font-size: 12px;
  color: var(--c-text-secondary);
  margin-bottom: 10px;
}

.card-actions {
  display: flex;
  gap: 6px;
  flex-wrap: wrap;
}

.pagination-wrap {
  display: flex;
  justify-content: center;
  margin-top: 32px;
}

.full-width {
  width: 100%;
}
</style>
