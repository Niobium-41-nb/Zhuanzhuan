# ============================================================
# Stage 1: Build - Node.js 编译前端
# ============================================================
FROM node:20-alpine AS builder

WORKDIR /build

COPY package.json package-lock.json ./
RUN npm ci --quiet

COPY . .
RUN npm run build

# ============================================================
# Stage 2: Serve - Nginx 托管静态文件
# ============================================================
FROM nginx:1.25-alpine

# 复制构建产物
COPY --from=builder /build/dist /usr/share/nginx/html

# 复制 Nginx 配置
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
