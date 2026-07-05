# ============================================================
# Stage 1: Build - Node.js 编译前端
# ============================================================
FROM node:20-alpine AS builder

# 设置 locale 为 UTF-8
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

WORKDIR /build

COPY package.json package-lock.json ./
RUN npm ci --quiet

COPY . .
RUN npm run build

# ============================================================
# Stage 2: Serve - Nginx 托管静态文件
# ============================================================
FROM nginx:1.25-alpine

# 设置 locale 为 UTF-8
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# 复制构建产物
COPY --from=builder /build/dist /usr/share/nginx/html

# 复制 Nginx 配置
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
