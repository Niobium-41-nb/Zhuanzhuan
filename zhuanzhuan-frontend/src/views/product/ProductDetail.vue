<template>
  <div class="product-detail" v-if="product">
    <el-row :gutter="30">
      <el-col :span="12">
        <el-image :src="currentImage || product.coverImage" fit="contain" style="width:100%;height:400px;border-radius:8px" />
        <div class="thumbnails" v-if="product.images?.length">
          <img v-for="img in product.images" :key="img.id" :src="img.url" @click="currentImage = img.url" :class="{ active: currentImage === img.url }" />
        </div>
      </el-col>
      <el-col :span="12">
        <h1>{{ product.title }}</h1>
        <div class="price-area">
          <span class="price">¥{{ product.price }}</span>
          <span v-if="product.originalPrice" class="original">¥{{ product.originalPrice }}</span>
        </div>
        <div class="info">
          <p><label>成色：</label>{{ product.condition }}</p>
          <p><label>分类：</label>{{ product.category?.parentName }} / {{ product.category?.name }}</p>
          <p><label>浏览：</label>{{ product.viewCount }}次</p>
          <p><label>收藏：</label>{{ product.favoriteCount }}次</p>
        </div>
        <div class="actions">
          <el-button type="danger" size="large" @click="buyNow" :disabled="product.status !== '在售'">立即购买</el-button>
          <el-button size="large" @click="toggleFav">{{ product.isFavorited ? '取消收藏' : '收藏' }}</el-button>
        </div>
        <el-card class="seller-card">
          <template #header>卖家信息</template>
          <div class="seller-info">
            <el-avatar :size="48" :src="product.seller?.avatar" />
            <div>
              <p class="seller-name">{{ product.seller?.nickname }}</p>
              <p class="seller-score">信誉分：{{ product.seller?.creditScore }}</p>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
    <el-divider />
    <h3>商品描述</h3>
    <div class="description" v-html="product.description || '暂无描述'" />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { productApi, orderApi } from '@/api'
import { isLoggedIn } from '@/utils/auth'

const route = useRoute()
const router = useRouter()
const product = ref<any>(null)
const currentImage = ref('')

onMounted(async () => {
  const res = await productApi.getDetail(Number(route.params.id))
  product.value = res.data
  if (product.value.images?.length) currentImage.value = product.value.images[0].url
})

async function toggleFav() {
  if (!isLoggedIn()) { router.push('/login'); return }
  await productApi.toggleFavorite({ productId: product.value.id })
  product.value.isFavorited = !product.value.isFavorited
  ElMessage.success(product.value.isFavorited ? '已收藏' : '已取消收藏')
}

async function buyNow() {
  if (!isLoggedIn()) { router.push('/login'); return }
  try {
    const res = await orderApi.create({ productId: product.value.id })
    ElMessage.success('下单成功')
    router.push(`/order/${res.data.orderId}`)
  } catch (_) {}
}
</script>

<style scoped>
.thumbnails { display: flex; gap: 8px; margin-top: 12px; }
.thumbnails img { width: 60px; height: 60px; object-fit: cover; border-radius: 4px; cursor: pointer; border: 2px solid transparent; }
.thumbnails img.active { border-color: #409eff; }
.price-area { margin: 16px 0; }
.price { font-size: 28px; color: #f56c6c; font-weight: bold; }
.original { font-size: 16px; color: #909399; text-decoration: line-through; margin-left: 12px; }
.info p { margin: 8px 0; color: #606266; }
.info label { color: #909399; }
.actions { margin: 20px 0; display: flex; gap: 12px; }
.seller-card { margin-top: 20px; }
.seller-info { display: flex; align-items: center; gap: 12px; }
.seller-name { font-weight: bold; }
.seller-score { color: #909399; font-size: 12px; }
.description { line-height: 1.8; color: #606266; }
</style>
