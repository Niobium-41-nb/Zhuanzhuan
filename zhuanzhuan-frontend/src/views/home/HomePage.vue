<template>
  <div class="home-page">
    <div class="banner">
      <div class="banner-content">
        <h1>校园二手物品交易平台</h1>
        <p>安全 · 便捷 · 可靠</p>
        <div class="search-box">
          <el-input v-model="keyword" placeholder="搜索你想买的..." size="large" @keyup.enter="doSearch">
            <template #append><el-button @click="doSearch" type="primary">搜索</el-button></template>
          </el-input>
        </div>
      </div>
    </div>

    <div class="categories">
      <el-tabs v-model="activeCategory" @tab-change="loadProducts">
        <el-tab-pane label="全部" name="0" />
        <el-tab-pane v-for="cat in categories" :key="cat.id" :label="cat.name" :name="String(cat.id)" />
      </el-tabs>
    </div>

    <div class="product-grid">
      <el-row :gutter="20">
        <el-col v-for="item in products" :key="item.id" :span="6" :xs="12" :sm="8" :md="6">
          <el-card :body-style="{ padding: '0' }" shadow="hover" class="product-card" @click="$router.push(`/product/${item.id}`)">
            <img :src="item.coverImage || 'https://via.placeholder.com/300x200?text=暂无图片'" class="product-img" />
            <div class="product-info">
              <h4>{{ item.title }}</h4>
              <div class="price"><span class="current">¥{{ item.price }}</span></div>
              <div class="meta">
                <span>{{ item.categoryName }}</span>
                <span>{{ item.viewCount }}次浏览</span>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
      <el-empty v-if="!products.length && loaded" description="暂无商品" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { productApi, indexApi } from '@/api'

const router = useRouter()
const keyword = ref('')
const activeCategory = ref('0')
const categories = ref<any[]>([])
const products = ref<any[]>([])
const loaded = ref(false)

onMounted(async () => {
  try {
    const catRes = await productApi.getCategories()
    categories.value = catRes.data || []
  } catch (_) {}
  await loadProducts()
})

async function loadProducts() {
  const params: any = { page: 1, size: 20 }
  if (activeCategory.value !== '0') params.categoryId = activeCategory.value
  try {
    const res = await productApi.getList(params)
    products.value = res.data?.records || []
    loaded.value = true
  } catch (_) {}
}

function doSearch() {
  router.push({ path: '/product/list', query: { keyword: keyword.value } })
}
</script>

<style scoped>
.banner { background: linear-gradient(135deg, #409eff, #337ecc); color: #fff; padding: 60px 20px; text-align: center; }
.banner h1 { font-size: 36px; margin-bottom: 12px; }
.banner p { font-size: 18px; margin-bottom: 30px; opacity: 0.9; }
.search-box { max-width: 500px; margin: 0 auto; }
.categories { margin: 20px 0; }
.product-grid { margin-top: 20px; }
.product-card { cursor: pointer; margin-bottom: 20px; border-radius: 8px; overflow: hidden; }
.product-img { width: 100%; height: 200px; object-fit: cover; }
.product-info { padding: 12px; }
.product-info h4 { margin: 0 0 8px; font-size: 14px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.price .current { color: #f56c6c; font-size: 18px; font-weight: bold; }
.meta { display: flex; justify-content: space-between; color: #909399; font-size: 12px; margin-top: 8px; }
</style>
