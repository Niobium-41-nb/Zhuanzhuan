<template>
  <div class="publish-page">
    <div class="page-header">
      <h1 class="page-title">发布商品</h1>
      <p class="page-desc">填写商品信息，让校园同学找到你的宝贝</p>
    </div>

    <div class="publish-card">
      <el-form ref="formRef" :model="form" :rules="rules" label-width="100px" label-position="top">
        <el-form-item label="商品标题" prop="title">
          <el-input v-model="form.title" placeholder="例如：全新高数课本，只用了一学期" maxlength="50" show-word-limit />
        </el-form-item>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="分类" prop="categoryId">
              <el-cascader v-model="form.categoryId" :options="categories" :props="{ value:'id', label:'name', children:'children' }" placeholder="选择分类" class="full-width" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="成色" prop="condition">
              <el-select v-model="form.condition" placeholder="选择成色" class="full-width">
                <el-option v-for="c in conditions" :key="c" :label="c" :value="c" />
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item label="价格（元）" prop="price">
              <el-input-number v-model="form.price" :precision="2" :min="0" :step="10" class="full-width" controls-position="right" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="原价（元，可选）">
              <el-input-number v-model="form.originalPrice" :precision="2" :min="0" class="full-width" controls-position="right" placeholder="选填" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="商品描述">
          <el-input v-model="form.description" type="textarea" :rows="5" placeholder="描述商品的使用情况、购买时间、为什么出售等..." maxlength="2000" show-word-limit />
        </el-form-item>

        <el-form-item label="上传图片">
          <el-upload action="#" list-type="picture-card" :auto-upload="false" :on-change="handleUpload" :file-list="fileList">
            <el-icon><Plus /></el-icon>
            <template #tip>
              <div style="font-size:12px;color:var(--c-muted);margin-top:4px">支持 JPG/PNG，建议上传清晰实物图</div>
            </template>
          </el-upload>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="submit" :loading="submitting" size="large" class="submit-btn">
            {{ submitting ? '发布中...' : '发布商品' }}
          </el-button>
          <el-button @click="$router.back()" size="large">取消</el-button>
        </el-form-item>
      </el-form>
    </div>
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
.publish-page {
  max-width: 720px;
  margin: 0 auto;
}

.page-header {
  margin-bottom: 28px;
}

.page-title {
  font-size: 24px;
  font-weight: 700;
  color: var(--c-text);
  margin-bottom: 6px;
}

.page-desc {
  font-size: 14px;
  color: var(--c-text-secondary);
}

.publish-card {
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius-md);
  padding: 32px;
}

.full-width {
  width: 100%;
}

.submit-btn {
  min-width: 160px;
}
</style>
