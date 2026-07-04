<template>
  <div class="product-list-page">
    <div class="filters">
      <el-input v-model="keyword" placeholder="搜索商品..." clearable @clear="search" @keyup.enter="search" style="width:300px">
        <template #append><el-button @click="search">搜索</el-button></template>
      </el-input>
      <el-select v-model="categoryId" placeholder="分类" clearable @change="search" style="width:150px">
        <el-option v-for="c in categories" :key="c.id" :label="c.name" :value="c.id" />
      </el-select>
      <el-select v-model="sortField" placeholder="排序" @change="search" style="width:150px">
        <el-option label="最新发布" value="created_at" />
        <el-option label="价格 ↑" value="price_asc" />
        <el-option label="价格 ↓" value="price_desc" />
        <el-option label="最热" value="view_count" />
      </el-select>
    </div>
    <el-row :gutter="20">
      <el-col v-for="item in list" :key="item.id" :span="6" :xs="12" :sm="8" :md="6">
        <el-card :body-style="{ padding: '0' }" shadow="hover" class="product-card" @click="$router.push(`/product/${item.id}`)">
          <img :src="item.coverImage || 'https://via.placeholder.com/300x200?text=暂无图片'" class="product-img" />
          <div class="product-info">
            <h4>{{ item.title }}</h4>
            <div class="price">¥{{ item.price }}</div>
            <div class="meta"><span>{{ item.categoryName }}</span><span>{{ item.viewCount }}次浏览</span></div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <div class="pagination" v-if="total > 0">
      <el-pagination v-model:current-page="page" :total="total" :page-size="20" layout="prev, pager, next" @current-change="loadData" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { productApi } from '@/api'

const route = useRoute()
const list = ref<any[]>([])
const total = ref(0)
const page = ref(1)
const keyword = ref((route.query.keyword as string) || '')
const categoryId = ref<any>(null)
const sortField = ref('created_at')
const categories = ref<any[]>([])

onMounted(async () => {
  try {
    const catRes = await productApi.getCategories()
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
  const res = await productApi.getList(params)
  list.value = res.data?.records || []
  total.value = res.total || 0
}

function search() { page.value = 1; loadData() }
</script>

<style scoped>
.filters { display: flex; gap: 16px; margin-bottom: 20px; align-items: center; }
.product-card { cursor: pointer; margin-bottom: 20px; border-radius: 8px; overflow: hidden; }
.product-img { width: 100%; height: 200px; object-fit: cover; }
.product-info { padding: 12px; }
.product-info h4 { margin: 0 0 8px; font-size: 14px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.price { color: #f56c6c; font-size: 18px; font-weight: bold; }
.meta { display: flex; justify-content: space-between; color: #909399; font-size: 12px; margin-top: 8px; }
.pagination { text-align: center; margin: 20px 0; }
</style>
