<template>
  <div class="guide-page">
    <div class="page-banner">
      <h1>使用指南</h1>
      <p>快速上手转转，轻松完成校园二手交易</p>
    </div>

    <div class="guide-content">
      <div class="guide-section">
        <div class="step-number">1</div>
        <div class="step-body">
          <h2>注册与登录</h2>
          <p>点击右上角「注册」按钮，使用校园邮箱或手机号完成注册。注册成功后即可登录，开始你的转转之旅。</p>
        </div>
      </div>

      <div class="guide-section">
        <div class="step-number">2</div>
        <div class="step-body">
          <h2>浏览商品</h2>
          <p>在首页或商品列表页浏览各类二手物品，支持按分类筛选和关键词搜索，快速找到心仪商品。</p>
        </div>
      </div>

      <div class="guide-section">
        <div class="step-number">3</div>
        <div class="step-body">
          <h2>发布商品</h2>
          <p>登录后点击「发布」按钮，上传商品图片、填写标题、描述和价格，即可将闲置物品分享给其他同学。</p>
        </div>
      </div>

      <div class="guide-section">
        <div class="step-number">4</div>
        <div class="step-body">
          <h2>沟通与交易</h2>
          <p>通过站内信与卖家或买家沟通商议，确认交易细节。建议选择在校内当面交易，确保安全可靠。</p>
        </div>
      </div>

      <div class="guide-section">
        <div class="step-number">5</div>
        <div class="step-body">
          <h2>订单管理</h2>
          <p>在「我的订单」中查看交易状态，及时确认收货或处理退款请求。完成交易后可为对方评价。</p>
        </div>
      </div>

      <div class="guide-tips">
        <el-icon size="20"><WarningFilled /></el-icon>
        <div>
          <strong>安全提示：</strong>请尽量选择校内当面交易，核实物品状况后再付款。切勿向陌生人转账或泄露个人隐私信息。
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { WarningFilled } from '@element-plus/icons-vue'
</script>

<style scoped>
.guide-page {
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

.guide-content {
  max-width: 720px;
  margin: 0 auto;
}

.guide-section {
  display: flex;
  gap: 24px;
  padding: 28px 0;
  border-bottom: 1px solid var(--c-border);
}

.guide-section:last-of-type {
  border-bottom: none;
}

.step-number {
  flex-shrink: 0;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background: var(--c-primary-bg);
  color: var(--c-primary);
  font-size: 20px;
  font-weight: 700;
  display: flex;
  align-items: center;
  justify-content: center;
}

.step-body h2 {
  font-size: 18px;
  color: var(--c-text);
  margin-bottom: 8px;
}

.step-body p {
  font-size: 15px;
  color: var(--c-text-secondary);
  line-height: 1.7;
}

.guide-tips {
  margin-top: 32px;
  padding: 16px 20px;
  background: #fef3c7;
  border-radius: var(--radius-md);
  display: flex;
  gap: 12px;
  align-items: flex-start;
  font-size: 14px;
  color: #92400e;
  line-height: 1.6;
}

.guide-tips .el-icon {
  flex-shrink: 0;
  margin-top: 2px;
  color: #d97706;
}
</style>
