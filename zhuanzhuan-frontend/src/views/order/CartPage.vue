<template>
  <div class="cart-page">
    <h2>购物车</h2>
    <el-card v-for="item in list" :key="item.id" class="cart-item">
      <div class="cart-content">
        <el-checkbox v-model="item.selected" @change="updateItem(item)" />
        <img :src="getProductCover(item)" class="cart-img" />
        <div class="cart-info"><p>{{ item.title }}</p><p class="price">¥{{ item.price }}</p></div>
        <el-input-number v-model="item.quantity" :min="1" :max="99" size="small" @change="updateItem(item)" />
        <el-button text type="danger" @click="remove(item.id)">删除</el-button>
      </div>
    </el-card>
    <el-empty v-if="!list.length" description="购物车是空的" />
    <div class="cart-footer" v-if="list.length">
      <span>合计：¥{{ total }}</span>
      <el-button type="primary" @click="openCheckout">结算</el-button>
    </div>

    <!-- Address selection dialog -->
    <el-dialog v-model="showAddrDialog" title="选择收货地址" width="480px">
      <div v-if="addresses.length" class="addr-list">
        <div v-for="a in addresses" :key="a.id" class="addr-item" :class="{sel: selAddr===a.id}" @click="selAddr=a.id">
          <div class="addr-rad"><span v-if="selAddr===a.id" class="addr-d"/></div>
          <div class="addr-txt"><b>{{a.receiver}}</b> {{a.phone}}<br/><span class="addr-detail">{{a.province}}{{a.city}}{{a.district}} {{a.detail}}</span></div>
          <el-tag v-if="a.isDefault" size="small" type="success">默认</el-tag>
        </div>
      </div>
      <el-empty v-else description="请先去个人中心添加地址"><el-button size="small" type="primary" @click="router.push('/user/address')">去添加</el-button></el-empty>
      <template #footer>
        <el-button @click="showAddrDialog=false">取消</el-button>
        <el-button type="primary" @click="doCheckout" :loading="checkoutLoading" :disabled="!selAddr">确认下单</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { cartApi, orderApi, userApi } from '@/api'
import { getProductCover } from '@/utils/productImage'

const router = useRouter()
const list = ref<any[]>([])
const showAddrDialog = ref(false)
const addresses = ref<any[]>([])
const selAddr = ref<number|null>(null)
const checkoutLoading = ref(false)

const total = computed(() => list.value.filter(i => i.selected).reduce((s, i) => s + i.price * i.quantity, 0))

onMounted(async () => { const res = await cartApi.getList(); list.value = res.data || [] })

async function updateItem(item: any) { await cartApi.update(item.id, { quantity: item.quantity, selected: item.selected ? 1 : 0 }) }
async function remove(id: number) { await cartApi.delete(id); list.value = list.value.filter(i => i.id !== id); ElMessage.success('已删除') }

async function openCheckout() {
  const selected = list.value.filter(i => i.selected)
  if (!selected.length) { ElMessage.warning('请选择商品'); return }
  try { const r = await userApi.getAddresses(); addresses.value = r.data || [] } catch(_) { addresses.value = [] }
  selAddr.value = addresses.value.find((a:any)=>a.isDefault)?.id || addresses.value[0]?.id || null
  showAddrDialog.value = true
}

async function doCheckout() {
  if (!selAddr.value) return
  checkoutLoading.value = true
  const selected = list.value.filter(i => i.selected)
  const orderIds: number[] = []
  try {
    for (const item of selected) {
      const res = await orderApi.create({ productId: item.productId, addressId: selAddr.value })
      if (res.data?.orderId) orderIds.push(res.data.orderId)
    }
    ElMessage.success('下单成功')
    showAddrDialog.value = false
    if (orderIds.length > 0) router.push(`/order/${orderIds[0]}/pay`)
    else router.push('/order/list')
  } catch(_) {} finally { checkoutLoading.value = false }
}
</script>

<style scoped>
.cart-item { margin-bottom: 10px; }
.cart-content { display: flex; align-items: center; gap: 16px; }
.cart-img { width: 80px; height: 80px; object-fit: cover; border-radius: 4px; }
.cart-info { flex: 1; }
.price { color: #f56c6c; font-weight: bold; }
.cart-footer { text-align: right; margin-top: 20px; display: flex; justify-content: flex-end; align-items: center; gap: 16px; font-size: 18px; }
.addr-list { max-height:300px; overflow-y:auto; }
.addr-item { display:flex; align-items:center; gap:10px; padding:12px; border:1px solid var(--c-border); border-radius:8px; margin-bottom:8px; cursor:pointer; }
.addr-item:hover { border-color:var(--c-primary); background:var(--c-primary-bg); }
.addr-item.sel { border-color:var(--c-primary); background:var(--c-primary-bg); border-width:2px; padding:11px; }
.addr-rad { width:18px;height:18px;border:2px solid var(--c-border);border-radius:50%;display:flex;align-items:center;justify-content:center;flex-shrink:0; }
.addr-item.sel .addr-rad { border-color:var(--c-primary); }
.addr-d { width:8px;height:8px;border-radius:50%;background:var(--c-primary); }
.addr-txt { flex:1;font-size:14px; }
.addr-detail { font-size:12px;color:var(--c-muted); }
</style>
