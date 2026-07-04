<template>
  <div class="publish-page">
    <h2>发布商品</h2>
    <el-form ref="formRef" :model="form" :rules="rules" label-width="100px">
      <el-form-item label="商品标题" prop="title">
        <el-input v-model="form.title" placeholder="5-50字" maxlength="50" show-word-limit />
      </el-form-item>
      <el-form-item label="分类" prop="categoryId">
        <el-cascader v-model="form.categoryId" :options="categories" :props="{ value:'id', label:'name', children:'children' }" placeholder="选择分类" />
      </el-form-item>
      <el-form-item label="价格" prop="price">
        <el-input-number v-model="form.price" :precision="2" :min="0" :step="10" />
      </el-form-item>
      <el-form-item label="原价">
        <el-input-number v-model="form.originalPrice" :precision="2" :min="0" />
      </el-form-item>
      <el-form-item label="成色" prop="condition">
        <el-select v-model="form.condition">
          <el-option v-for="c in conditions" :key="c" :label="c" :value="c" />
        </el-select>
      </el-form-item>
      <el-form-item label="描述">
        <el-input v-model="form.description" type="textarea" :rows="6" placeholder="描述你的商品..." />
      </el-form-item>
      <el-form-item label="图片">
        <el-upload action="#" list-type="picture-card" :auto-upload="false" :on-change="handleUpload" :file-list="fileList">
          <el-icon><Plus /></el-icon>
        </el-upload>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submit" :loading="submitting">发布商品</el-button>
        <el-button @click="$router.back()">取消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { productApi } from '@/api'

const router = useRouter()
const formRef = ref()
const submitting = ref(false)
const fileList = ref<any[]>([])
const conditions = ['全新', '几乎全新', '轻微使用痕迹', '明显使用痕迹', '老旧']
const categories = ref<any[]>([])
const form = reactive({ title: '', categoryId: null, price: 0, originalPrice: null, condition: '', description: '', imageIds: [] as number[] })
const rules = { title: [{ required: true, message: '请输入标题', trigger: 'blur' }], categoryId: [{ required: true, message: '请选择分类' }], price: [{ required: true, message: '请输入价格' }], condition: [{ required: true, message: '请选择成色' }] }

onMounted(async () => {
  const res = await productApi.getCategories()
  categories.value = res.data || []
})

async function handleUpload(uploadFile: any) {
  const formData = new FormData()
  formData.append('file', uploadFile.raw)
  const res = await productApi.uploadImage(formData)
  form.imageIds.push(res.data.imageId)
}

async function submit() {
  const valid = await formRef.value.validate().catch(() => false)
  if (!valid) return
  submitting.value = true
  try {
    await productApi.publish(form)
    ElMessage.success('发布成功，等待审核')
    router.push('/')
  } catch (_) {} finally { submitting.value = false }
}
</script>

<style scoped>
.publish-page { max-width: 700px; margin: 0 auto; }
.publish-page h2 { margin-bottom: 24px; }
</style>
