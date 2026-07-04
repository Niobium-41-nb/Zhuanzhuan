<template>
  <div class="cart-page">
    <h2>购物车</h2>
    <el-card v-for="item in list" :key="item.id" class="cart-item">
      <div class="cart-content">
        <el-checkbox v-model="item.selected" @change="updateItem(item)" />
        <img :src="item.coverImage" class="cart-img" />
        <div class="cart-info"><p>{{ item.title }}</p><p class="price">¥{{ item.price }}</p></div>
        <el-input-number v-model="item.quantity" :min="1" :max="99" size="small" @change="updateItem(item)" />
        <el-button text type="danger" @click="remove(item.id)">删除</el-button>
      </div>
    </el-card>
    <el-empty v-if="!list.length" description="购物车是空的" />
    <div class="cart-footer" v-if="list.length">
      <span>合计：¥{{ total }}</span>
      <el-button type="primary" @click="checkout">结算</el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { cartApi, orderApi } from '@/api'

const router = useRouter()
const list = ref<any[]>([])

const total = computed(() => list.value.filter(i => i.selected).reduce((s, i) => s + i.price * i.quantity, 0))

onMounted(async () => { const res = await cartApi.getList(); list.value = res.data || [] })

async function updateItem(item: any) { await cartApi.update(item.id, { quantity: item.quantity, selected: item.selected ? 1 : 0 }) }
async function remove(id: number) { await cartApi.delete(id); list.value = list.value.filter(i => i.id !== id); ElMessage.success('已删除') }

async function checkout() {
  const selected = list.value.filter(i => i.selected)
  for (const item of selected) {
    await orderApi.create({ productId: item.productId })
  }
  ElMessage.success('下单成功')
  router.push('/order/list')
}
</script>

<style scoped>
.cart-item { margin-bottom: 10px; }
.cart-content { display: flex; align-items: center; gap: 16px; }
.cart-img { width: 80px; height: 80px; object-fit: cover; border-radius: 4px; }
.cart-info { flex: 1; }
.price { color: #f56c6c; font-weight: bold; }
.cart-footer { text-align: right; margin-top: 20px; display: flex; justify-content: flex-end; align-items: center; gap: 16px; font-size: 18px; }
</style>
