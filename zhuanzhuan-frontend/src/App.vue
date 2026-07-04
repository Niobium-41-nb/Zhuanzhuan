<template>
  <router-view />
</template>

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

body {
  font-family: 'Noto Sans SC', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', sans-serif;
  background: var(--c-bg);
  color: var(--c-text);
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

a { text-decoration: none; color: inherit; }

/* ===== Element Plus Overrides ===== */
.el-button--primary {
  --el-button-bg-color: var(--c-primary);
  --el-button-border-color: var(--c-primary);
  --el-button-hover-bg-color: var(--c-primary-dark);
  --el-button-hover-border-color: var(--c-primary-dark);
  --el-button-active-bg-color: var(--c-primary-dark);
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

.el-card { border-radius: var(--radius-md); border: 1px solid var(--c-border); }
.el-input__wrapper.is-focus,
.el-select__wrapper.is-focus { box-shadow: 0 0 0 1px var(--c-primary) inset !important; }

.el-pagination.is-background .el-pager li.is-active {
  background-color: var(--c-primary) !important;
}

.el-badge__content.is-fixed { background-color: var(--c-accent) !important; }

/* ===== Scrollbar ===== */
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: var(--c-border); border-radius: 3px; }
::-webkit-scrollbar-thumb:hover { background: var(--c-muted); }
</style>
