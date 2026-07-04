<template>
  <div class="product-detail" v-if="product">
    <!-- Breadcrumb -->
    <div class="breadcrumb">
      <router-link to="/">首页</router-link>
      <span class="sep">/</span>
      <router-link to="/product/list">商品</router-link>
      <span class="sep">/</span>
      <span class="current">{{ product.title }}</span>
    </div>

    <div class="detail-layout">
      <!-- Left: Images -->
      <div class="detail-gallery">
        <div class="gallery-main">
          <img :src="currentImage || product.coverImage || getCategoryCover(product.category?.name, product.id)" :alt="product.title" class="main-img" />
        </div>
        <div class="gallery-thumbs" v-if="product.images?.length">
          <img
            v-for="img in product.images"
            :key="img.id"
            :src="img.url"
            :class="{ active: currentImage === img.url }"
            @click="currentImage = img.url"
          />
        </div>
      </div>

      <!-- Right: Info -->
      <div class="detail-info">
        <span class="product-condition" :class="conditionClass">{{ product.condition }}</span>
        <h1 class="product-title">{{ product.title }}</h1>

        <div class="product-price-box">
          <div class="price-main">
            <span class="price-symbol">¥</span>
            <span class="price-value">{{ product.price }}</span>
          </div>
          <div class="price-original" v-if="product.originalPrice">
            原价 ¥{{ product.originalPrice }}
          </div>
        </div>

        <div class="product-meta">
          <div class="meta-item">
            <span class="meta-label">分类</span>
            <span class="meta-value">{{ product.category?.parentName }} / {{ product.category?.name }}</span>
          </div>
          <div class="meta-item">
            <span class="meta-label">浏览</span>
            <span class="meta-value">{{ product.viewCount }} 次</span>
          </div>
          <div class="meta-item">
            <span class="meta-label">收藏</span>
            <span class="meta-value">{{ product.favoriteCount }} 次</span>
          </div>
          <div class="meta-item">
            <span class="meta-label">发布时间</span>
            <span class="meta-value">{{ product.createdAt }}</span>
          </div>
        </div>

        <div class="product-actions">
          <button class="btn-cart" @click="addToCart" :disabled="product.status !== '在售'">
            <el-icon><ShoppingCart /></el-icon>
            {{ product.status === '在售' ? '加入购物车' : '已售罄' }}
          </button>
          <button class="btn-buy" @click="buyNow" :disabled="product.status !== '在售'">
            <span class="btn-label">{{ product.status === '在售' ? '立即购买' : '已售罄' }}</span>
            <span class="btn-sub" v-if="product.status === '在售'">与卖家沟通后下单</span>
          </button>
          <button class="btn-fav" @click="toggleFav">
            <el-icon><Star v-if="!product.isFavorited" /><StarFilled v-else /></el-icon>
            {{ product.isFavorited ? '已收藏' : '收藏' }}
          </button>
        </div>

        <!-- Seller Card -->
        <div class="seller-card">
          <div class="seller-header">卖家信息</div>
          <div class="seller-body">
            <el-avatar :size="44" :src="product.seller?.avatar">
              {{ product.seller?.nickname?.[0] }}
            </el-avatar>
            <div class="seller-detail">
              <p class="seller-name">{{ product.seller?.nickname }}</p>
              <div class="seller-score">
                <span class="score-dot"></span>
                信誉分 {{ product.seller?.creditScore }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Description -->
    <section class="detail-section">
      <h2 class="section-title">商品描述</h2>
      <div class="description">{{ sanitizedDescription }}</div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Star, StarFilled, ShoppingCart } from '@element-plus/icons-vue'
import { productApi, orderApi, cartApi } from '@/api'
import { isLoggedIn } from '@/utils/auth'
import { getCategoryCover } from '@/utils/productImage'

const route = useRoute()
const router = useRouter()
const product = ref<any>(null)
const currentImage = ref('')

const sanitizedDescription = computed(() => {
  const desc = product.value?.description
  if (!desc) return '暂无描述'
  // 移除 <script> / <style> 标签
  let cleaned = desc.replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')
  cleaned = cleaned.replace(/<style\b[^<]*(?:(?!<\/style>)<[^<]*)*<\/style>/gi, '')
  // 剥离所有 HTML 标签
  cleaned = cleaned.replace(/<[^>]*>/g, '')
  // 解码 HTML 实体
  const textarea = document.createElement('textarea')
  textarea.innerHTML = cleaned
  return textarea.value || '暂无描述'
})

const conditionClass = computed(() => {
  const map: Record<string, string> = {
    '全新': 'cond-new',
    '几乎全新': 'cond-like-new',
    '轻微使用痕迹': 'cond-good',
    '明显使用痕迹': 'cond-fair'
  }
  return map[product.value?.condition] || ''
})

onMounted(async () => {
  const res: any = await productApi.getDetail(Number(route.params.id))
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

async function addToCart() {
  if (!isLoggedIn()) { router.push('/login'); return }
  try {
    await cartApi.add({ productId: product.value.id })
    ElMessage.success('已加入购物车')
  } catch (_) {}
}
</script>

<style scoped>
/* Breadcrumb */
.breadcrumb {
  font-size: 13px;
  color: var(--c-muted);
  margin-bottom: 24px;
}

.breadcrumb a {
  color: var(--c-text-secondary);
  transition: color 0.2s;
}

.breadcrumb a:hover {
  color: var(--c-primary);
}

.breadcrumb .sep {
  margin: 0 8px;
}

.breadcrumb .current {
  color: var(--c-text);
}

/* Layout */
.detail-layout {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 40px;
  margin-bottom: 40px;
}

/* Gallery */
.gallery-main {
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius-md);
  overflow: hidden;
  margin-bottom: 12px;
}

.main-img {
  width: 100%;
  height: 420px;
  object-fit: contain;
  display: block;
}

.gallery-thumbs {
  display: flex;
  gap: 8px;
}

.gallery-thumbs img {
  width: 64px;
  height: 64px;
  object-fit: cover;
  border-radius: var(--radius-sm);
  cursor: pointer;
  border: 2px solid transparent;
  transition: border-color 0.2s;
}

.gallery-thumbs img.active {
  border-color: var(--c-primary);
}

/* Info */
.detail-info {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.product-condition {
  display: inline-flex;
  align-items: center;
  padding: 4px 12px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
  width: fit-content;
}

.cond-new { background: #E8F5E9; color: #2E7D32; }
.cond-like-new { background: #E3F2FD; color: #1565C0; }
.cond-good { background: #FFF3E0; color: #E65100; }
.cond-fair { background: #F3E5F5; color: #7B1FA2; }

.product-title {
  font-size: 22px;
  font-weight: 700;
  color: var(--c-text);
  line-height: 1.4;
}

/* Price */
.product-price-box {
  background: #FFF8F0;
  border: 1px solid #FFE8CC;
  border-radius: var(--radius-md);
  padding: 16px 20px;
  display: flex;
  align-items: baseline;
  gap: 16px;
}

.price-main {
  display: flex;
  align-items: baseline;
  gap: 2px;
}

.price-symbol {
  font-size: 16px;
  font-weight: 700;
  color: var(--c-accent);
}

.price-value {
  font-size: 32px;
  font-weight: 900;
  color: var(--c-accent);
  letter-spacing: -1px;
}

.price-original {
  font-size: 14px;
  color: var(--c-muted);
  text-decoration: line-through;
}

/* Meta */
.product-meta {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
  padding: 16px 0;
  border-top: 1px solid var(--c-border-light);
  border-bottom: 1px solid var(--c-border-light);
}

.meta-item {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.meta-label {
  font-size: 12px;
  color: var(--c-muted);
}

.meta-value {
  font-size: 14px;
  color: var(--c-text);
}

/* Actions */
.product-actions {
  display: flex;
  gap: 12px;
}

.btn-cart {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 14px 20px;
  background: var(--c-primary-bg);
  color: var(--c-primary);
  border: 1px solid var(--c-primary);
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition: all 0.2s;
  font-family: inherit;
  font-size: 15px;
  font-weight: 600;
}

.btn-cart:hover:not(:disabled) {
  background: var(--c-primary);
  color: white;
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(45, 106, 79, 0.25);
}

.btn-cart:disabled {
  border-color: var(--c-muted);
  color: var(--c-muted);
  background: transparent;
  cursor: not-allowed;
}

.btn-buy {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 14px 24px;
  background: var(--c-accent);
  color: white;
  border: none;
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition: all 0.2s;
  font-family: inherit;
}

.btn-buy:hover:not(:disabled) {
  background: var(--c-accent-hover);
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(231, 111, 81, 0.3);
}

.btn-buy:disabled {
  background: var(--c-muted);
  cursor: not-allowed;
}

.btn-label {
  font-size: 16px;
  font-weight: 700;
}

.btn-sub {
  font-size: 11px;
  opacity: 0.85;
  margin-top: 2px;
}

.btn-fav {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 14px 20px;
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition: all 0.2s;
  font-size: 14px;
  color: var(--c-text-secondary);
  font-family: inherit;
}

.btn-fav:hover {
  border-color: var(--c-accent);
  color: var(--c-accent);
}

/* Seller */
.seller-card {
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius-md);
  overflow: hidden;
}

.seller-header {
  padding: 12px 16px;
  font-size: 13px;
  font-weight: 600;
  color: var(--c-text);
  border-bottom: 1px solid var(--c-border-light);
}

.seller-body {
  padding: 16px;
  display: flex;
  align-items: center;
  gap: 12px;
}

.seller-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--c-text);
}

.seller-score {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: var(--c-text-secondary);
  margin-top: 2px;
}

.score-dot {
  width: 6px;
  height: 6px;
  border-radius: 50%;
  background: var(--c-primary-light);
}

/* Description Section */
.detail-section {
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius-md);
  padding: 28px;
}

.section-title {
  font-size: 18px;
  font-weight: 700;
  margin-bottom: 16px;
  color: var(--c-text);
}

.description {
  line-height: 1.8;
  color: var(--c-text-secondary);
  font-size: 14px;
}

/* Responsive */
@media (max-width: 768px) {
  .detail-layout {
    grid-template-columns: 1fr;
    gap: 24px;
  }

  .main-img {
    height: 280px;
  }

  .product-meta {
    grid-template-columns: 1fr 1fr;
  }
}
</style>
