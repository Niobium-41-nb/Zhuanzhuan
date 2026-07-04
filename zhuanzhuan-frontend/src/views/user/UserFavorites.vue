<template>
  <div class="favorites-page">
    <h2>我的收藏</h2>
    <el-row :gutter="20">
      <el-col v-for="item in list" :key="item.id" :span="6" :xs="12" :sm="8">
        <el-card :body-style="{ padding: '0' }" shadow="hover" class="fav-card" @click="$router.push(`/product/${item.id}`)">
          <img :src="getProductCover(item)" class="fav-img" />
          <div class="fav-info">
            <h4>{{ item.title }}</h4>
            <div class="price">¥{{ item.price }}</div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <el-empty v-if="!list.length" description="还没有收藏商品" />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { productApi } from '@/api'
import { getProductCover } from '@/utils/productImage'

const list = ref<any[]>([])

onMounted(async () => {
  const res = await productApi.getFavoriteList({ page: 1, size: 20 })
  list.value = res.data || []
})
</script>

<style scoped>
.fav-card { cursor: pointer; margin-bottom: 20px; border-radius: 8px; overflow: hidden; }
.fav-img { width: 100%; height: 200px; object-fit: cover; }
.fav-info { padding: 12px; }
.fav-info h4 { margin: 0 0 8px; font-size: 14px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.price { color: #f56c6c; font-weight: bold; font-size: 16px; }
</style>
