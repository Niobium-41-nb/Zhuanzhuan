<template>
  <div class="contact-page">
    <div class="page-banner">
      <h1>联系我们</h1>
      <p>如有任何问题或建议，欢迎通过以下方式与我们取得联系</p>
    </div>

    <div class="contact-content">
      <div class="contact-grid">
        <div class="contact-card">
          <div class="card-icon">
            <el-icon size="32"><Message /></el-icon>
          </div>
          <h3>站内信</h3>
          <p>登录后可直接联系客服账号，我们会在 24 小时内回复。</p>
        </div>

        <div class="contact-card">
          <div class="card-icon">
            <el-icon size="32"><ChatDotSquare /></el-icon>
          </div>
          <h3>在线反馈</h3>
          <p>在「个人中心」-「意见反馈」中提交问题，我们将尽快处理。</p>
        </div>

        <div class="contact-card">
          <div class="card-icon">
            <el-icon size="32"><Iphone /></el-icon>
          </div>
          <h3>客服邮箱</h3>
          <p>
            <a href="mailto:support@zhuanzhuan.edu">support@zhuanzhuan.edu</a>
          </p>
        </div>

        <div class="contact-card">
          <div class="card-icon">
            <el-icon size="32"><Clock /></el-icon>
          </div>
          <h3>工作时间</h3>
          <p>周一至周五 9:00 - 18:00<br>周末及节假日在线留言</p>
        </div>
      </div>

      <div class="faq-section">
        <h2>常见问题</h2>
        <div class="faq-list">
          <div class="faq-item" v-for="(faq, index) in faqs" :key="index" @click="faq.open = !faq.open">
            <div class="faq-question">
              <span>{{ faq.q }}</span>
              <el-icon :class="{ rotated: faq.open }"><ArrowDown /></el-icon>
            </div>
            <div class="faq-answer" v-show="faq.open">
              <p>{{ faq.a }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { reactive } from 'vue'
import { Message, ChatDotSquare, Iphone, Clock, ArrowDown } from '@element-plus/icons-vue'

const faqs = reactive([
  { q: '如何联系卖家？', a: '登录后进入商品详情页，点击「联系卖家」按钮即可通过站内信与卖家沟通。', open: false },
  { q: '交易出现问题怎么办？', a: '请在「我的订单」中找到对应订单，点击「申请退款」或联系客服寻求帮助。', open: false },
  { q: '如何修改个人信息？', a: '登录后进入「个人中心」，即可修改头像、昵称、联系方式等个人信息。', open: false },
  { q: '商品发布后多久能审核通过？', a: '一般情况下，商品会在提交后的 1-2 小时内完成审核，请耐心等待。', open: false }
])
</script>

<style scoped>
.contact-page {
  max-width: var(--max-width);
  margin: 0 auto;
  padding: 0 24px 60px;
}

.page-banner {
  text-align: center;
  padding: 60px 0 48px;
}

.page-banner h1 {
  font-size: 32px;
  color: var(--c-text);
  margin-bottom: 12px;
}

.page-banner p {
  font-size: 16px;
  color: var(--c-text-secondary);
}

.contact-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 24px;
  margin-bottom: 60px;
}

.contact-card {
  background: var(--c-surface);
  border: 1px solid var(--c-border);
  border-radius: var(--radius-lg);
  padding: 32px;
  text-align: center;
  transition: all 0.3s ease;
}

.contact-card:hover {
  border-color: var(--c-primary);
  transform: translateY(-4px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.06);
}

.card-icon {
  width: 64px;
  height: 64px;
  border-radius: 50%;
  background: var(--c-primary-bg);
  color: var(--c-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 16px;
}

.contact-card h3 {
  font-size: 18px;
  color: var(--c-text);
  margin-bottom: 8px;
}

.contact-card p {
  font-size: 14px;
  color: var(--c-text-secondary);
  line-height: 1.7;
}

.contact-card a {
  color: var(--c-primary);
  text-decoration: none;
}

.contact-card a:hover {
  text-decoration: underline;
}

/* FAQ */
.faq-section h2 {
  font-size: 24px;
  text-align: center;
  margin-bottom: 24px;
  color: var(--c-text);
}

.faq-list {
  max-width: 720px;
  margin: 0 auto;
}

.faq-item {
  border: 1px solid var(--c-border);
  border-radius: var(--radius-md);
  margin-bottom: 12px;
  overflow: hidden;
  cursor: pointer;
  transition: border-color 0.2s;
}

.faq-item:hover {
  border-color: var(--c-primary);
}

.faq-question {
  padding: 16px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 15px;
  font-weight: 500;
  color: var(--c-text);
}

.faq-question .el-icon {
  transition: transform 0.3s;
  color: var(--c-text-secondary);
}

.faq-question .el-icon.rotated {
  transform: rotate(180deg);
}

.faq-answer {
  padding: 0 20px 16px;
  font-size: 14px;
  color: var(--c-text-secondary);
  line-height: 1.7;
}
</style>
