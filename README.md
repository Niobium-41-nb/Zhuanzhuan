# 转转 - 校园二手物品交易平台

<div align="center">

![转转](https://img.shields.io/badge/%E8%BD%AC%E8%BD%AC-Zhuanzhuan-2D6A4F?style=for-the-badge)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.0-6DB33F?logo=springboot)
![Vue 3](https://img.shields.io/badge/Vue-3.4-4FC08D?logo=vue.js)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?logo=mysql)
![Redis](https://img.shields.io/badge/Redis-7-DC382D?logo=redis)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker)

**安全 · 便捷 · 可靠 — 让每一件物品找到新主人**

</div>

## 📋 项目简介

转转是一个面向高校学生的二手物品交易平台，支持商品发布、浏览搜索、即时通讯、在线交易等完整功能。采用前后端分离架构，全容器化部署。

## 🏗️ 技术栈

| 层级 | 技术 | 版本 |
|------|------|------|
| **前端** | Vue 3 + TypeScript + Vite | 3.4 / 5.3 / 5.0 |
| **UI 框架** | Element Plus | 2.5 |
| **状态管理** | Pinia | 2.1 |
| **后端** | Spring Boot + Spring Security | 3.2.0 |
| **ORM** | MyBatis-Plus | 3.5.5 |
| **数据库** | MySQL + Redis | 8.0 / 7 |
| **容器化** | Docker Compose | 2.x |
| **构建** | Maven | 3.9 |

## 📁 项目结构

```
zhuanzhuan/
├── docker-compose.yml              # Docker 编排
├── deploy/                         # 服务配置
│   ├── mysql/my.cnf
│   └── redis/redis.conf
├── docs/                           # 项目文档
│   ├── 需求分析/
│   ├── 系统架构设计/
│   ├── 数据库设计/
│   └── 接口设计/
├── test-data/                      # 测试图片 (135张)
├── scripts/
│   └── scraper.py                  # 测试数据生成工具
├── zhuanzhuan-backend/             # Spring Boot 后端
│   ├── Dockerfile
│   ├── pom.xml
│   └── src/main/java/com/zhuanzhuan/
│       ├── common/                 # 公共模块
│       │   ├── config/             # 全局配置
│       │   ├── exception/          # 异常处理
│       │   └── result/             # 统一返回
│       ├── modules/
│       │   ├── admin/              # 管理后台
│       │   ├── message/            # 站内信
│       │   ├── order/              # 订单
│       │   ├── product/            # 商品
│       │   ├── upload/             # 文件上传
│       │   └── user/               # 用户
│       └── security/               # JWT 安全认证
└── zhuanzhuan-frontend/            # Vue 3 前端
    ├── Dockerfile
    ├── nginx.conf
    └── src/
        ├── api/                    # API 接口
        ├── layouts/                # 布局组件
        ├── router/                 # 路由
        ├── stores/                 # 状态管理
        ├── utils/                  # 工具函数
        └── views/                  # 页面组件
            ├── admin/              # 管理后台
            ├── home/               # 首页
            ├── message/            # 消息
            ├── order/              # 订单
            ├── product/            # 商品
            └── user/               # 用户
```

## 🚀 快速启动

### 前置要求

- Docker & Docker Compose
- Git

### 一键启动

```bash
git clone https://github.com/Niobium-41-nb/Zhuanzhuan.git
cd Zhuanzhuan

# 启动所有服务
docker-compose up -d --build

# 查看运行状态
docker-compose ps
```

服务启动后访问：

| 服务 | 地址 |
|------|------|
| **前端页面** | http://localhost:3000 |
| **phpMyAdmin** | http://localhost:3001 |
| **API 文档** | http://localhost:3000/api/v1/... |

### 测试账号

| 用户名 | 密码 | 角色 | 说明 |
|--------|------|------|------|
| `admin` | `admin123` | 管理员 | 可访问管理后台 |
| `testuser` | `admin123` | 普通用户 | 可发布/购买商品 |

## 🔧 常见操作

### 重新构建并重启

```bash
# 全部重新构建
docker-compose up -d --build

# 仅构建后端
docker-compose up -d --build backend

# 仅构建前端
docker-compose up -d --build frontend

# 仅重启（不构建）
docker-compose restart
```

### 查看日志

```bash
docker-compose logs --tail=100 backend
docker-compose logs --tail=100 frontend
```

## 🧪 测试

### 后端测试

```bash
cd zhuanzhuan-backend
mvn test
```

### 前端测试

```bash
cd zhuanzhuan-frontend
npm test          # 单次运行
npm run test:watch   # 监听模式
```

### 测试覆盖

| 测试 | 数量 | 覆盖内容 |
|------|------|---------|
| 后端单元测试 | 14 | Result/JWT/UserService/应用上下文 |
| 前端单元测试 | 8 | 工具函数/组件渲染/API 格式 |

## 📊 测试数据

### 内置数据

项目包含预设的测试数据（20 件商品、3 个公告、3 条订单等），首次启动 Docker 时通过 SQL 脚本自动初始化。

### 数据生成工具

`scripts/scraper.py` 可生成大量测试数据：

```bash
cd scripts

# 安装依赖
pip install requests beautifulsoup4 pymysql

# 生成 30 条带图片的商品并导入数据库
python3 scraper.py --count 30 --images-dir ../test-data -o /tmp/data.sql
docker exec -i zhuanzhuan-mysql mysql -uroot -proot123 zhuanzhuan < /tmp/data.sql

# 指定卖家用户 ID
python3 scraper.py --count 10 --user-id 2 --images-dir ../test-data -o data.sql

# 指定随机种子（可复现数据）
python3 scraper.py --seed 42 --images-dir ../test-data -o data.sql
```

## 🗄️ 数据库设计

### 分类限制

一级分类固定为 6 个，在数据库层面通过 CHECK 约束限制：

```
电子产品、书籍教材、生活用品、服饰鞋包、运动户外、其他
```

每个一级分类下有预设的二级分类（共 19 个），通过 `parent_id` 关联。

### 核心表

| 表名 | 说明 |
|------|------|
| `user` | 用户（含管理员） |
| `category` | 商品分类（二级） |
| `product` | 商品信息 |
| `order` | 订单 |
| `cart` | 购物车 |
| `favorite` | 收藏 |
| `message` | 站内信 |
| `announcement` | 系统公告 |

完整建表语句见 `docs/数据库设计/zhuanzhuan.sql`。

## 🔐 安全设计

- JWT 双 Token 认证（Access + Refresh）
- 密码 BCrypt 加密存储
- 基于 Spring Security 的接口权限控制
- 统一异常处理与返回格式
- CORS 跨域支持

## 📄 接口文档

API 前缀：`/api/v1`

| 模块 | 路径 | 说明 |
|------|------|------|
| 用户 | `/user/**` | 注册/登录/个人信息 |
| 商品 | `/product/**` | 列表/详情/发布/收藏 |
| 订单 | `/order/**` | 创建/列表/状态流转 |
| 消息 | `/message/**` | 私信/系统通知 |
| 管理 | `/admin/**` | 用户/商品/订单管理 |
| 首页 | `/index/**` | 推荐/统计 |

详细接口定义见 `docs/接口设计/接口设计说明书.md`。

## 📜 许可证

本项目仅用于学习交流，未经许可不得用于商业用途。

