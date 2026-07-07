<template>
  <router-view v-slot="{ Component }">
    <transition name="fade" mode="out-in">
      <component :is="Component" :key="$route.path" />
    </transition>
  </router-view>
  <!-- Scroll to Top Button -->
  <button class="scroll-top-btn" :class="{ visible: showScrollTop }" @click="scrollToTop" aria-label="回到顶部">
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
      <polyline points="18 15 12 9 6 15"></polyline>
    </svg>
  </button>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'

const showScrollTop = ref(false)

function onScroll() {
  showScrollTop.value = window.scrollY > 400
}

function scrollToTop() {
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

onMounted(() => window.addEventListener('scroll', onScroll, { passive: true }))
onUnmounted(() => window.removeEventListener('scroll', onScroll))
</script>

<style>
/* ===== CSS Variables ===== */
:root {
  --c-primary: #2D6A4F;
  --c-primary-dark: #1B4332;
  --c-primary-light: #52B788;
  --c-primary-bg: #E8F5E9;
  --c-accent: #E76F51;
  --c-accent-hover: #D65A3E;
  --c-warm: #F4A261;
  --c-bg: #FDFBF7;
  --c-surface: #FFFFFF;
  --c-text: #1F2937;
  --c-text-secondary: #6B7280;
  --c-muted: #9CA3AF;
  --c-border: #E5E7EB;
  --c-border-light: #F3F4F6;
  --shadow-sm: 0 1px 2px rgba(0,0,0,0.05);
  --shadow-md: 0 4px 12px rgba(0,0,0,0.08);
  --shadow-lg: 0 8px 30px rgba(0,0,0,0.1);
  --radius-sm: 8px;
  --radius-md: 12px;
  --radius-lg: 16px;
  --max-width: 1200px;
  --header-height: 64px;
}

* { margin: 0; padding: 0; box-sizing: border-box; }
html, body, #app { height: 100%; }

html {
  scroll-behavior: smooth;
}

body {
  font-family: 'Noto Sans SC', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', sans-serif;
  background: var(--c-bg);
  color: var(--c-text);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

a { text-decoration: none; color: inherit; }

/* ===== Page Transition Animations ===== */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.25s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.slide-enter-active,
.slide-leave-active {
  transition: all 0.3s ease;
}

.slide-enter-from {
  opacity: 0;
  transform: translateY(16px);
}

.slide-leave-to {
  opacity: 0;
  transform: translateY(-8px);
}

/* ===== Scroll to Top Button ===== */
.scroll-top-btn {
  position: fixed;
  bottom: 32px;
  right: 32px;
  z-index: 999;
  width: 44px;
  height: 44px;
  border-radius: 50%;
  border: none;
  background: var(--c-primary);
  color: white;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 16px rgba(45, 106, 79, 0.35);
  opacity: 0;
  transform: translateY(12px) scale(0.9);
  pointer-events: none;
  transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
}

.scroll-top-btn.visible {
  opacity: 1;
  transform: translateY(0) scale(1);
  pointer-events: auto;
}

.scroll-top-btn:hover {
  background: var(--c-primary-dark);
  transform: translateY(-3px) scale(1.05);
  box-shadow: 0 6px 24px rgba(45, 106, 79, 0.45);
}

.scroll-top-btn:active {
  transform: translateY(0) scale(0.95);
}

/* ===== Element Plus Overrides ===== */
.el-button--primary {
  --el-button-bg-color: var(--c-primary);
  --el-button-border-color: var(--c-primary);
  --el-button-hover-bg-color: var(--c-primary-dark);
  --el-button-hover-border-color: var(--c-primary-dark);
  --el-button-active-bg-color: var(--c-primary-dark);
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1) !important;
}

.el-button--primary:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(45, 106, 79, 0.3);
}

.el-button--primary:active {
  transform: translateY(0);
}

.el-button--primary.is-plain {
  --el-button-plain-bg-color: var(--c-primary-bg);
  --el-button-plain-border-color: var(--c-primary-light);
  --el-button-plain-hover-bg-color: var(--c-primary);
  --el-button-plain-hover-border-color: var(--c-primary);
}

.el-tabs__item.is-active { color: var(--c-primary) !important; }
.el-tabs__active-bar { background-color: var(--c-primary) !important; }
.el-tabs__item:hover { color: var(--c-primary-light) !important; }

.el-card {
  border-radius: var(--radius-md);
  border: 1px solid var(--c-border);
  transition: box-shadow 0.3s ease, transform 0.2s ease;
}

.el-card:hover {
  box-shadow: var(--shadow-md);
}

.el-input__wrapper.is-focus,
.el-select__wrapper.is-focus { box-shadow: 0 0 0 1px var(--c-primary) inset !important; }

.el-pagination.is-background .el-pager li.is-active {
  background-color: var(--c-primary) !important;
}

.el-badge__content.is-fixed { background-color: var(--c-accent) !important; }

/* ===== Skeleton Loading Animation ===== */
@keyframes shimmer {
  0% { background-position: -200% 0; }
  100% { background-position: 200% 0; }
}

.skeleton {
  background: linear-gradient(90deg, var(--c-border-light) 25%, #E8ECF0 50%, var(--c-border-light) 75%);
  background-size: 200% 100%;
  animation: shimmer 1.5s ease-in-out infinite;
  border-radius: var(--radius-sm);
}

/* ===== Scrollbar ===== */
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: var(--c-border); border-radius: 3px; }
::-webkit-scrollbar-thumb:hover { background: var(--c-muted); }

/* ===== Pulse Animation for Live Indicators ===== */
@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}

/* ===== Shake Animation for Error States ===== */
@keyframes shake {
  0%, 100% { transform: translateX(0); }
  10%, 30%, 50%, 70%, 90% { transform: translateX(-3px); }
  20%, 40%, 60%, 80% { transform: translateX(3px); }
}

.shake {
  animation: shake 0.5s ease-in-out;
}

/* ===== Fade In Up ===== */
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.fade-in-up {
  animation: fadeInUp 0.5s ease-out forwards;
}

/* ===== Selection Color ===== */
::selection {
  background: var(--c-primary);
  color: white;
}

::-moz-selection {
  background: var(--c-primary);
  color: white;
}
</style>
