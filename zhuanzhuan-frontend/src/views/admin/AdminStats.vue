<template>
  <div>
    <h2>数据统计</h2>
    <el-row :gutter="20" style="margin-bottom:20px">
      <el-col :span="6" v-for="item in cards" :key="item.label">
        <el-card><div class="stat-card"><p class="stat-value">{{ item.value }}</p><p class="stat-label">{{ item.label }}</p></div></el-card>
      </el-col>
    </el-row>
    <el-row :gutter="20">
      <el-col :span="12"><el-card><template #header>分类分布</template><div ref="pieRef" style="height:300px" /></el-card></el-col>
      <el-col :span="12"><el-card><template #header>趋势</template><div ref="lineRef" style="height:300px" /></el-card></el-col>
    </el-row>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick } from 'vue'
import { adminApi } from '@/api'

const cards = ref<any[]>([])
const pieRef = ref()
const lineRef = ref()

onMounted(async () => {
  const res = await adminApi.getStatistics()
  cards.value = [
    { label: '用户总数', value: res.data.userCount },
    { label: '商品总数', value: res.data.productCount },
    { label: '订单总数', value: res.data.orderCount },
    { label: '今日注册', value: res.data.todayRegisterCount }
  ]

  nextTick(async () => {
    const echarts = await import('echarts')
    const detail = await adminApi.getStatisticsDetail({})

    if (pieRef.value) {
      const chart = echarts.init(pieRef.value)
      chart.setOption({
        tooltip: { trigger: 'item' },
        series: [{
          type: 'pie', radius: ['40%', '70%'],
          data: detail.data?.categoryDistribution || []
        }]
      })
    }

    if (lineRef.value) {
      const chart = echarts.init(lineRef.value)
      chart.setOption({
        xAxis: { type: 'category', data: detail.data?.labels || [] },
        yAxis: { type: 'value' },
        series: [{ type: 'line', data: detail.data?.values || [], smooth: true }]
      })
    }
  })
})
</script>

<style scoped>
.stat-card { text-align: center; }
.stat-value { font-size: 28px; font-weight: bold; color: #409eff; margin: 0; }
.stat-label { color: #909399; margin-top: 8px; }
</style>
