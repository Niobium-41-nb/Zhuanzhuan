<template>
  <div class="home-page">
    <!-- ===== Hero Banner ===== -->
    <section class="hero">
      <div class="hero-bg">
        <div class="hero-shape hero-shape-1"></div>
        <div class="hero-shape hero-shape-2"></div>
        <div class="hero-shape hero-shape-3"></div>
      </div>
      <div class="hero-content">
        <span class="hero-badge">🌟 校园专属</span>
        <h1 class="hero-title">淘你所爱 &nbsp; 转你所闲</h1>
        <p class="hero-subtitle">安全 · 便捷 · 可靠 — 让每一件物品找到新主人</p>
        <div class="hero-stats">
          <div class="stat-item">
            <span class="stat-value">{{ stats.users }}</span>
            <span class="stat-label">注册用户</span>
          </div>
          <div class="stat-divider"></div>
          <div class="stat-item">
            <span class="stat-value">{{ stats.products }}</span>
            <span class="stat-label">在售商品</span>
          </div>
          <div class="stat-divider"></div>
          <div class="stat-item">
            <span class="stat-value">{{ stats.trades }}</span>
            <span class="stat-label">成交订单</span>
          </div>
        </div>
        <div class="hero-search">
          <div class="search-wrapper">
            <el-icon class="search-icon"><Search /></el-icon>
            <input
              v-model="keyword"
              placeholder="搜索你想买的..."
              class="search-input"
              @keyup.enter="doSearch"
            />
            <button class="search-btn" @click="doSearch">搜索</button>
          </div>
        </div>
      </div>
    </section>

    <!-- ===== Categories ===== -->
    <section class="section">
      <div class="section-header">
        <h2 class="section-title">商品分类</h2>
        <router-link to="/product/list" class="section-more">查看全部 &rarr;</router-link>
      </div>
      <div class="category-tabs">
        <button
          v-for="cat in displayCategories"
          :key="cat.id"
          :class="['cat-tab', { active: activeCategory === String(cat.id) }]"
          @click="switchCategory(cat.id)"
        >
          <span class="cat-emoji">{{ cat.emoji }}</span>
          <span class="cat-name">{{ cat.name }}</span>
        </button>
      </div>
    </section>

    <!-- ===== Products ===== -->
    <section class="section">
      <div class="section-header">
        <h2 class="section-title">最新商品</h2>
      </div>
      <div class="product-grid">
        <article
          v-for="item in products"
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
              <span class="meta-views">
                <el-icon><View /></el-icon>
                {{ item.viewCount }}
              </span>
              <span class="meta-time">{{ formatTime(item.createdAt) }}</span>
            </div>
          </div>
        </article>
      </div>
      <el-empty v-if="!products.length && loaded" description="暂无商品" />
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import { productApi, indexApi } from '@/api'

const router = useRouter()
const keyword = ref('')
const activeCategory = ref('0')
const categories = ref<any[]>([])
const products = ref<any[]>([])
const loaded = ref(false)

const stats = ref({ users: '--', products: '--', trades: '--' })

const categoryEmojis: Record<string, string> = {
  '电子产品': '📱', '书籍': '📚', '生活用品': '🏠',
  '服饰': '👕', '运动': '⚽', '学习': '📖',
  '数码': '💻', '其他': '📦'
}

const displayCategories = computed(() =>
  [{ id: '0', name: '全部', emoji: '✨' } as any, ...categories.value].slice(0, 8).map((c: any) => ({
    ...c,
    emoji: c.id === '0' ? '✨' : (categoryEmojis[c.name] || '📦')
  }))
)

onMounted(async () => {
  try {
    const catRes = await productApi.getCategories()
    categories.value = catRes.data || []
  } catch (_) {}
  try {
    const statRes: any = await indexApi.getStatistics()
    if (statRes.data) {
      stats.value = {
        users: statRes.data.userCount?.toLocaleString() || '--',
        products: statRes.data.productCount?.toLocaleString() || '--',
        trades: statRes.data.orderCount?.toLocaleString() || '--'
      }
    }
  } catch (_) {}
  await loadProducts()
})

async function loadProducts() {
  const params: any = { page: 1, size: 20 }
  if (activeCategory.value !== '0') params.categoryId = activeCategory.value
  try {
    const res: any = await productApi.getList(params)
    products.value = res.data || []
    loaded.value = true
  } catch (_) {}
}

function switchCategory(id: number | string) {
  activeCategory.value = String(id)
  loadProducts()
}

function doSearch() {
  router.push({ path: '/product/list', query: { keyword: keyword.value } })
}

function formatTime(t: string) {
  if (!t) return ''
  const d = new Date(t)
  const now = new Date()
  const diff = now.getTime() - d.getTime()
  if (diff < 3600000) return Math.floor(diff / 60000) + '分钟前'
  if (diff < 86400000) return Math.floor(diff / 3600000) + '小时前'
  return d.toLocaleDateString('zh-CN')
}
</script>

<style scoped>
/* ===== Hero Section ===== */
.hero {
  position: relative;
  padding: 80px 24px 100px;
  text-align: center;
  overflow: hidden;
  background: linear-gradient(135deg, #1B4332 0%, #2D6A4F 50%, #40916C 100%);
  border-radius: var(--radius-lg);
  margin-bottom: 40px;
}

.hero-bg {
  position: absolute;
  inset: 0;
  overflow: hidden;
  pointer-events: none;
}

.hero-shape {
  position: absolute;
  border-radius: 50%;
  opacity: 0.1;
}

.hero-shape-1 {
  width: 400px; height: 400px;
  background: var(--c-warm);
  top: -100px; right: -100px;
  animation: float 8s ease-in-out infinite;
}

.hero-shape-2 {
  width: 300px; height: 300px;
  background: var(--c-primary-light);
  bottom: -80px; left: -80px;
  animation: float 10s ease-in-out infinite reverse;
}

.hero-shape-3 {
  width: 200px; height: 200px;
  background: white;
  top: 50%; left: 20%;
  animation: float 12s ease-in-out infinite;
}

@keyframes float {
  0%, 100% { transform: translate(0, 0) scale(1); }
  50% { transform: translate(30px, -30px) scale(1.1); }
}

.hero-content {
  position: relative;
  z-index: 1;
  max-width: 700px;
  margin: 0 auto;
}

.hero-badge {
  display: inline-block;
  padding: 4px 16px;
  background: rgba(255,255,255,0.15);
  backdrop-filter: blur(8px);
  border-radius: 20px;
  font-size: 13px;
  color: rgba(255,255,255,0.9);
  margin-bottom: 24px;
}

.hero-title {
  font-family: 'ZCOOL QingKe HuangYou', sans-serif;
  font-size: 48px;
  color: white;
  line-height: 1.2;
  margin-bottom: 16px;
  letter-spacing: 4px;
}

.hero-subtitle {
  font-size: 16px;
  color: rgba(255,255,255,0.8);
  margin-bottom: 36px;
}

.hero-stats {
  display: flex;
  justify-content: center;
  gap: 24px;
  margin-bottom: 36px;
}

.stat-item {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.stat-value {
  font-size: 28px;
  font-weight: 900;
  color: white;
  line-height: 1;
}

.stat-label {
  font-size: 12px;
  color: rgba(255,255,255,0.7);
  margin-top: 4px;
}

.stat-divider {
  width: 1px;
  background: rgba(255,255,255,0.2);
}

/* Search */
.hero-search {
  display: flex;
  justify-content: center;
}

.search-wrapper {
  display: flex;
  align-items: center;
  background: white;
  border-radius: 50px;
  padding: 4px 4px 4px 20px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.15);
  width: 100%;
  max-width: 480px;
  transition: box-shadow 0.3s;
}

.search-wrapper:focus-within {
  box-shadow: 0 4px 30px rgba(0,0,0,0.25);
}

.search-icon {
  color: var(--c-muted);
  font-size: 18px;
  margin-right: 8px;
}

.search-input {
  flex: 1;
  border: none;
  outline: none;
  font-size: 15px;
  padding: 12px 0;
  background: transparent;
  font-family: inherit;
}

.search-input::placeholder {
  color: var(--c-muted);
}

.search-btn {
  padding: 10px 28px;
  background: var(--c-accent);
  color: white;
  border: none;
  border-radius: 50px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.2s;
  font-family: inherit;
}

.search-btn:hover {
  background: var(--c-accent-hover);
  transform: scale(1.02);
}

/* ===== Section ===== */
.section {
  margin-bottom: 40px;
}

.section-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
}

.section-title {
  font-size: 22px;
  font-weight: 700;
  color: var(--c-text);
  position: relative;
}

.section-title::after {
  content: '';
  position: absolute;
  bottom: -4px;
  left: 0;
  width: 32px;
  height: 3px;
  background: var(--c-primary);
  border-radius: 2px;
}

.section-more {
  font-size: 14px;
  color: var(--c-text-secondary);
  transition: color 0.2s;
}

.section-more:hover {
  color: var(--c-primary);
}

/* ===== Category Tabs ===== */
.category-tabs {
  display: flex;
  gap: 12px;
  overflow-x: auto;
  padding-bottom: 8px;
}

.cat-tab {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 6px;
  padding: 16px 24px;
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius-md);
  cursor: pointer;
  transition: all 0.2s;
  white-space: nowrap;
  font-family: inherit;
}

.cat-tab:hover {
  border-color: var(--c-primary-light);
  background: var(--c-primary-bg);
  transform: translateY(-2px);
}

.cat-tab.active {
  border-color: var(--c-primary);
  background: var(--c-primary);
  color: white;
  box-shadow: 0 4px 12px rgba(45, 106, 79, 0.3);
}

.cat-emoji {
  font-size: 24px;
}

.cat-name {
  font-size: 13px;
  font-weight: 500;
}

/* ===== Product Grid ===== */
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
  line-height: 1.4;
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

.meta-views {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
}

.meta-views .el-icon {
  font-size: 13px;
}

.meta-time {
  font-size: 12px;
}

/* ===== Responsive ===== */
@media (max-width: 768px) {
  .hero { padding: 60px 16px 80px; }
  .hero-title { font-size: 32px; }
  .hero-stats { gap: 16px; }
  .stat-value { font-size: 22px; }
  .product-grid {
    grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
    gap: 12px;
  }
  .category-tabs { gap: 8px; }
  .cat-tab { padding: 12px 16px; }
}
</style>
