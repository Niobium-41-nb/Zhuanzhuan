<template>
  <div class="product-list-page">
    <div class="page-header">
      <h1 class="page-title">商品列表</h1>
      <p class="page-desc">发现校园好物，淘到心仪宝贝</p>
    </div>

    <div class="filters">
      <div class="filter-search">
        <el-input
          v-model="keyword"
          placeholder="搜索商品..."
          clearable
          @clear="search"
          @keyup.enter="search"
          :prefix-icon="Search"
        />
      </div>
      <el-select v-model="categoryId" placeholder="全部分类" clearable @change="search" class="filter-select">
        <el-option v-for="c in categories" :key="c.id" :label="c.name" :value="c.id" />
      </el-select>
      <el-select v-model="sortField" placeholder="排序方式" @change="search" class="filter-select">
        <el-option label="最新发布" value="created_at" />
        <el-option label="价格 ↑" value="price_asc" />
        <el-option label="价格 ↓" value="price_desc" />
        <el-option label="最热" value="view_count" />
      </el-select>
    </div>

    <div class="product-grid">
      <article
        v-for="item in list"
        :key="item.id"
        class="product-card"
        @click="$router.push(`/product/${item.id}`)"
      >
        <div class="card-img-wrap">
          <img :src="item.coverImage || 'https://via.placeholder.com/300x200?text=暂无图片'" :alt="item.title" class="card-img" />
          <span class="card-category">{{ item.categoryName }}</span>
        </div>
        <div class="card-body">
          <h3 class="card-title">{{ item.title }}</h3>
          <div class="card-price">
            <span class="price-symbol">¥</span>
            <span class="price-value">{{ item.price }}</span>
          </div>
          <div class="card-meta">
            <span><el-icon><View /></el-icon> {{ item.viewCount }}</span>
            <span>{{ item.condition || '—' }}</span>
          </div>
        </div>
      </article>
    </div>

    <el-empty v-if="!list.length && loaded" description="没有找到相关商品" />

    <div class="pagination" v-if="total > 0">
      <el-pagination
        v-model:current-page="page"
        :total="total"
        :page-size="20"
        layout="prev, pager, next"
        background
        @current-change="loadData"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { Search, View } from '@element-plus/icons-vue'
import { productApi } from '@/api'

const route = useRoute()
const list = ref<any[]>([])
const total = ref(0)
const page = ref(1)
const loaded = ref(false)
const keyword = ref((route.query.keyword as string) || '')
const categoryId = ref<any>(null)
const sortField = ref('created_at')
const categories = ref<any[]>([])

onMounted(async () => {
  try {
    const catRes: any = await productApi.getCategories()
    categories.value = catRes.data || []
  } catch (_) {}
  await loadData()
})

async function loadData() {
  const params: any = { page: page.value, size: 20, sort: 'created_at', order: 'desc' }
  if (keyword.value) params.keyword = keyword.value
  if (categoryId.value) params.categoryId = categoryId.value
  if (sortField.value === 'price_asc') { params.sort = 'price'; params.order = 'asc' }
  else if (sortField.value === 'price_desc') { params.sort = 'price'; params.order = 'desc' }
  else if (sortField.value === 'view_count') { params.sort = 'view_count'; params.order = 'desc' }
  try {
    const res: any = await productApi.getList(params)
    list.value = res.data || []
    total.value = res.total || 0
    loaded.value = true
  } catch (_) {}
}

function search() { page.value = 1; loadData() }
</script>

<style scoped>
.page-header {
  margin-bottom: 28px;
}

.page-title {
  font-size: 24px;
  font-weight: 700;
  color: var(--c-text);
  margin-bottom: 6px;
}

.page-desc {
  font-size: 14px;
  color: var(--c-text-secondary);
}

/* Filters */
.filters {
  display: flex;
  gap: 12px;
  margin-bottom: 28px;
  flex-wrap: wrap;
}

.filter-search {
  flex: 1;
  min-width: 200px;
}

.filter-select {
  width: 150px;
}

/* Product Grid */
.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
  gap: 20px;
}

.product-card {
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius-md);
  overflow: hidden;
  cursor: pointer;
  transition: all 0.3s ease;
}

.product-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
  border-color: transparent;
}

.card-img-wrap {
  position: relative;
  width: 100%;
  padding-top: 66%;
  overflow: hidden;
  background: var(--c-border-light);
}

.card-img {
  position: absolute;
  inset: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.4s ease;
}

.product-card:hover .card-img {
  transform: scale(1.08);
}

.card-category {
  position: absolute;
  top: 8px;
  left: 8px;
  padding: 3px 10px;
  background: rgba(0,0,0,0.5);
  backdrop-filter: blur(4px);
  color: white;
  font-size: 11px;
  border-radius: 4px;
}

.card-body {
  padding: 14px;
}

.card-title {
  font-size: 14px;
  font-weight: 500;
  color: var(--c-text);
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  margin-bottom: 8px;
}

.card-price {
  display: flex;
  align-items: baseline;
  gap: 2px;
  margin-bottom: 8px;
}

.price-symbol {
  font-size: 13px;
  font-weight: 600;
  color: var(--c-accent);
}

.price-value {
  font-size: 20px;
  font-weight: 700;
  color: var(--c-accent);
  letter-spacing: -0.5px;
}

.card-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 12px;
  color: var(--c-muted);
}

.card-meta .el-icon {
  vertical-align: middle;
  font-size: 13px;
}

.pagination {
  text-align: center;
  margin: 40px 0 20px;
}

@media (max-width: 768px) {
  .product-grid {
    grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
    gap: 12px;
  }
}
</style>
