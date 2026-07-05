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
├── docker-compose.yml              # Docker 编排（一键启动）
├── .env.example                    # 环境变量配置模板
├── deploy/                         # 服务配置
│   ├── mysql/my.cnf                #   MySQL 自定义配置
│   └── redis/redis.conf            #   Redis 配置
├── docs/                           # 项目文档
│   ├── 需求分析/
│   ├── 系统架构设计/
│   ├── 数据库设计/
│   └── 接口设计/
├── zhuanzhuan-backend/             # Spring Boot 后端
│   ├── Dockerfile
│   ├── pom.xml
│   └── src/main/java/com/zhuanzhuan/
│       ├── common/                 # 公共模块（配置/异常/统一返回）
│       ├── modules/                # 业务模块
│       │   ├── admin/              #   管理后台
│       │   ├── message/            #   站内信
│       │   ├── order/              #   订单
│       │   ├── product/            #   商品
│       │   ├── upload/             #   文件上传
│       │   └── user/               #   用户
│       └── security/               # JWT 安全认证
└── zhuanzhuan-frontend/            # Vue 3 前端
    ├── Dockerfile
    ├── nginx.conf                  # Nginx 反向代理配置
    └── src/
        ├── api/                    # API 接口封装
        ├── layouts/                # 布局组件
        ├── router/                 # 路由
        ├── stores/                 # Pinia 状态管理
        ├── utils/                  # 工具函数
        └── views/                  # 页面组件
```

## 🚀 快速启动（推荐 —— Docker 部署）

### 前置要求

| 工具 | 版本要求 | 用途 |
|------|----------|------|
| [Docker](https://docs.docker.com/get-docker/) | ≥ 24.x | 容器运行时 |
| [Docker Compose](https://docs.docker.com/compose/install/) | ≥ 2.x | 多容器编排 |
| [Git](https://git-scm.com/downloads) | 任意版本 | 代码克隆 |

### 第一步：克隆项目

```bash
git clone https://github.com/Niobium-41-nb/Zhuanzhuan.git
cd Zhuanzhuan
```

### 第二步：配置环境变量

将 `.env.example` 复制为 `.env`，并根据需要修改配置：

```bash
cp .env.example .env
```

> **生产环境必须修改以下敏感配置：**
>
> | 变量 | 说明 | 生成建议 |
> |------|------|----------|
> | `JWT_SECRET` | JWT 签名密钥 | `openssl rand -base64 32` |
> | `MYSQL_ROOT_PASSWORD` | MySQL root 密码 | 设置强密码 |
> | `REDIS_PASSWORD` | Redis 密码 | 设置强密码 |
>
> 邮件服务（`MAIL_*`）如需使用验证码功能才需配置，可暂不修改。

### 第三步：一键启动

```bash
# 构建并启动所有服务
docker-compose up -d --build

# 查看运行状态
docker-compose ps

# 首次启动等待约 30 秒，等待 MySQL 初始化完成
# 可通过以下命令查看初始化进度：
docker-compose logs --tail=50 mysql
docker-compose logs --tail=50 backend
```

### 第四步：访问服务

| 服务 | 地址 | 说明 |
|------|------|------|
| **前端页面** | http://localhost:3000 | 转转平台首页 |
| **后端 API** | http://localhost:3000/api/v1 | 通过 Nginx 反向代理 |

### 测试账号

| 用户名 | 密码 | 角色 | 说明 |
|--------|------|------|------|
| `admin` | `admin123` | 管理员 | 可访问管理后台 `/admin` |
| `testuser` | `admin123` | 普通用户 | 可发布/购买商品 |

---

## 🪟 Windows 本地演示指南

以下指南专为 **Windows 系统** 上的项目演示场景编写，提供两种方式任选其一。

### 方式一：Docker Desktop 一键演示（推荐）

这是最快捷的方式，只需安装 Docker 即可启动全部服务。

#### 1. 安装 Docker Desktop

1. 访问 [Docker Desktop for Windows](https://docs.docker.com/desktop/setup/install/windows-install/) 下载安装包
2. 运行安装程序，按提示完成安装（安装后需重启电脑）
3. 启动 Docker Desktop，等待右下角状态变为绿色 "Running"
4. 打开 **PowerShell** 或 **CMD**，验证安装成功：
   ```powershell
   docker --version
   docker compose version
   ```

> **⚠️ 注意：** Windows 上 Docker 命令为 `docker compose`（中间有空格），而非 `docker-compose`。以下 Windows 相关命令均使用 `docker compose` 格式。
>
> 如果遇到 "WSL 2 安装不完整" 的提示，请先安装 [WSL 2 内核更新包](https://learn.microsoft.com/zh-cn/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package)。

#### 2. 克隆项目并配置环境变量

```powershell
# 克隆项目
git clone https://github.com/Niobium-41-nb/Zhuanzhuan.git
cd Zhuanzhuan

# 复制 .env 配置文件（Windows 下用 copy 命令）
copy .env.example .env
```

#### 3. 一键启动所有服务

```powershell
# 构建并启动（首次启动需下载依赖，耗时约 2~5 分钟）
docker compose up -d --build

# 查看运行状态
docker compose ps

# 等待 MySQL 就绪后，后端会自动启动
# 可通过以下命令查看初始化进度：
docker compose logs --tail=50 mysql
docker compose logs --tail=50 backend
```

#### 4. 访问并演示

| 服务 | 地址 | 说明 |
|------|------|------|
| **前端页面** | http://localhost:3000 | 转转平台首页 |
| **管理后台** | http://localhost:3000/#/admin | 管理员面板 |

使用测试账号登录后，可演示以下功能：

- **浏览商品** — 首页查看推荐商品列表
- **搜索筛选** — 按分类、关键词搜索商品
- **注册登录** — 新用户注册或使用测试账号登录
- **发布商品** — 填写商品信息并上传图片
- **购物车** — 将商品加入购物车并下单
- **个人中心** — 查看/编辑个人信息、管理地址
- **管理后台** — 管理员审核商品、管理用户和订单

#### 5. 停止服务

```powershell
# 停止所有容器（数据保留）
docker compose down

# 下次重新启动（无需重新构建）
docker compose up -d

# 完全清除（⚠️ 会删除数据库数据）
docker compose down -v
```

---

### 方式二：本地手动启动（无需 Docker）

如果系统未安装 Docker Desktop，或需要展示源码编译过程，可使用此方式。

#### 1. 安装依赖软件

| 软件 | 下载地址 | 安装说明 |
|------|----------|----------|
| **JDK 17** | [Eclipse Temurin 17 MSI](https://adoptium.net/temurin/releases/?version=17) | 下载 `.msi` 安装包，一路默认安装 |
| **Maven** | [Maven 下载](https://maven.apache.org/download.cgi) | 下载 `Binary zip` 并解压，将 `bin` 目录添加到系统 PATH |
| **MySQL** | [MySQL Installer](https://dev.mysql.com/downloads/installer/) | 选择 "MySQL Server 8.0"，设置 root 密码为 `root123`（或自行修改配置） |
| **Redis** | [Redis for Windows](https://github.com/redis-windows/redis-windows/releases) | 下载最新 `.msi` 或 `.zip`，解压后运行 `redis-server.exe` |
| **Node.js** | [Node.js 下载](https://nodejs.org/) | 下载 LTS 版本的 `.msi` 安装包 |
| **Git** | [Git for Windows](https://git-scm.com/download/win) | 下载 `.exe` 安装包 |

> **💡 环境变量配置提示：**
> - JDK 安装后通常会自动配置 `JAVA_HOME`，可在 PowerShell 中用 `java -version` 验证
> - Maven 解压后需要手动添加：将 `D:\apache-maven-3.9.x\bin` 添加到系统 PATH
> - 安装完成后 **重启 PowerShell** 使环境变量生效

#### 2. 启动 MySQL 和 Redis

**MySQL：**
- 使用 MySQL Installer 安装后，MySQL 会作为 Windows 服务自动启动
- 在 PowerShell 中运行 `Get-Service MySQL80` 确认状态为 Running
- 如未自动启动：`net start MySQL80`

**Redis：**
- 进入 Redis 解压目录，运行：
  ```powershell
  .\redis-server.exe
  ```
- 保持该终端窗口打开，Redis 即在前台运行

#### 3. 初始化数据库

```powershell
# 导入数据库表结构和测试数据
mysql -u root -p zhuanzhuan < "docs/数据库设计/zhuanzhuan.sql"
# 输入密码（默认 root123）

# 如果提示数据库不存在，先创建
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS zhuanzhuan DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
```

#### 4. 启动后端服务

**使用 VS Code（推荐）：**

1. 用 VS Code 打开项目根目录 `E:\Zhuanzhuan`
2. 安装扩展：**Extension Pack for Java**（Microsoft 官方）
3. 打开 `zhuanzhuan-backend/src/main/java/com/zhuanzhuan/ZhuanzhuanApplication.java`
4. 点击文件右上角的 ▶ "Run" 按钮，或按 `F5` 启动调试

**使用命令行：**

```powershell
# 进入后端目录
cd zhuanzhuan-backend

# 编译并启动（首次编译下载依赖耗时约 1~3 分钟）
mvn spring-boot:run

# 或先打包再运行
mvn clean package -DskipTests
java -jar target\zhuanzhuan-backend-1.0.0.jar
```

> **注意：** 启动后控制台输出 `Started ZhuanzhuanApplication in X.XXX seconds` 即表示成功。
> 后端默认连接 `localhost:3306` 的 MySQL 和 `localhost:6379` 的 Redis。
> 如需修改密码，可在 `application-dev.yml` 中更改，或设置环境变量后启动：
> ```powershell
> $env:MYSQL_ROOT_PASSWORD="root123"; mvn spring-boot:run
> ```

验证后端启动成功：浏览器访问 http://localhost:8080 ，应返回 JSON 响应（可能为 404 但非连接失败错误）。

#### 5. 启动前端服务

```powershell
# 进入前端目录
cd zhuanzhuan-frontend

# 安装依赖（首次安装耗时约 1~2 分钟）
npm install

# 启动开发服务器
npm run dev
```

终端显示 `http://localhost:5173` 即表示启动成功，在浏览器中打开该地址即可访问。

> Vite 开发服务器已配置代理，会自动将 `/api` 请求转发到后端 `http://localhost:8080`。

#### 6. 演示操作流程

系统启动后，建议按以下顺序进行演示：

1. **访问首页** → http://localhost:5173 → 查看推荐商品列表
2. **注册新用户** → 点击"注册"，填写信息完成注册
3. **浏览商品** → 按分类筛选、关键词搜索
4. **发布商品** → 点击"发布"，填写商品信息并上传图片
5. **管理后台** → 使用 `admin / admin123` 登录 → 访问 `/admin` 审核商品
6. **下单流程** → 将商品加入购物车 → 提交订单 → 查看订单状态

---

## 💻 本地开发模式（不使用 Docker）

如果需要在本地 IDE 中开发和调试，可以分别启动后端和前端服务。

### 前置环境

| 工具 | 版本 | 用途 |
|------|------|------|
| JDK | ≥ 17（推荐 Eclipse Temurin 17） | 编译运行后端 |
| Maven | ≥ 3.9 | 后端依赖管理 |
| MySQL | ≥ 8.0 | 数据库 |
| Redis | ≥ 7.x | 缓存 |
| Node.js | ≥ 20.x | 前端开发服务器 |
| npm | ≥ 10.x | 前端依赖管理 |

### 1. 启动基础设施（MySQL + Redis）

#### 方式一：使用 Docker 单独启动

```bash
# 只启动 MySQL 和 Redis，不启动应用服务
docker-compose up -d mysql redis

# 等待 MySQL 就绪（约 30 秒，通过 SQL 脚本自动初始化数据库和测试数据）
docker-compose logs --tail=10 mysql
```

#### 方式二：使用本地安装的服务

确保本地 MySQL 和 Redis 已启动，然后手动导入数据库：

```bash
# 创建数据库
mysql -uroot -p -e "CREATE DATABASE IF NOT EXISTS zhuanzhuan DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# 导入表结构和测试数据
mysql -uroot -p zhuanzhuan < "docs/数据库设计/zhuanzhuan.sql"
```

### 2. 启动后端服务

**使用 IDE（推荐）：**

用 IntelliJ IDEA 或 VS Code 打开 `zhuanzhuan-backend/` 目录，直接运行 `com.zhuanzhuan.ZhuanzhuanApplication` 主类。

**使用命令行：**

```bash
cd zhuanzhuan-backend

# 编译并启动（默认使用 application-dev.yml 配置）
mvn spring-boot:run

# 或先打包再运行
mvn clean package -DskipTests
java -jar target/zhuanzhuan-backend-1.0.0.jar
```

> **注意：** 本地开发默认连接 `localhost:3306` 的 MySQL 和 `localhost:6379` 的 Redis。
> 可在 `application-dev.yml` 中修改数据库/Redis 连接信息，或通过环境变量覆盖：
> ```bash
> MYSQL_ROOT_PASSWORD=your_password REDIS_PASSWORD=your_password mvn spring-boot:run
> ```

启动成功后，后端 API 访问地址：http://localhost:8080

### 3. 启动前端服务

```bash
cd zhuanzhuan-frontend

# 安装依赖（首次启动或依赖有变更时）
npm install

# 启动开发服务器（默认端口 5173，支持热更新）
npm run dev
```

Vite 开发服务器已配置代理（`vite.config.ts`），会自动将 `/api` 和 `/uploads` 请求转发到后端 `http://localhost:8080`。

启动成功后，前端访问地址：http://localhost:5173

---

## 🔧 常用操作

### Docker 环境

```bash
# 全部重新构建
docker-compose up -d --build

# 仅构建并重启后端
docker-compose up -d --build backend

# 仅构建并重启前端
docker-compose up -d --build frontend

# 查看实时日志
docker-compose logs -f

# 查看指定服务日志（最近 100 行）
docker-compose logs --tail=100 backend

# 停止所有服务
docker-compose down

# 停止并删除所有数据卷（⚠️ 会清空数据库和上传文件）
docker-compose down -v
```

### 本地环境

```bash
# 后端 —— 重新编译
cd zhuanzhuan-backend && mvn clean compile

# 后端 —— 运行单元测试
cd zhuanzhuan-backend && mvn test

# 前端 —— 构建生产包
cd zhuanzhuan-frontend && npm run build

# 前端 —— 预览构建结果
cd zhuanzhuan-frontend && npm run preview
```

---

## 🧪 测试

### 后端测试

```bash
cd zhuanzhuan-backend
mvn test
```

### 前端测试

```bash
cd zhuanzhuan-frontend
npm test            # 单次运行
npm run test:watch  # 监听模式
```

### 测试覆盖

| 测试 | 数量 | 覆盖内容 |
|------|------|---------|
| 后端单元测试 | 14 | Result/JWT/UserService/应用上下文 |
| 前端单元测试 | 8 | 工具函数/组件渲染/API 格式 |

---

## 📊 测试数据

### 内置数据

项目包含预设的测试数据（20 件商品、3 个公告、3 条订单等），首次启动时通过 SQL 脚本自动初始化。如果使用 Docker Compose，MySQL 容器启动时即自动导入 `docs/数据库设计/zhuanzhuan.sql`。

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

---

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

---

## 🔐 安全设计

- JWT 双 Token 认证（Access + Refresh），自动续期
- 密码 BCrypt 加密存储
- 基于 Spring Security 的接口权限控制
- 统一异常处理与返回格式
- CORS 跨域支持（Nginx 层处理）
- 接口限流保护（Nginx 层，全局 30 r/s，登录 10 r/m）

---

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

Docker 部署时可通过 Knife4j 在线查看 API 文档（生产环境默认关闭）：
```
http://localhost:8080/doc.html
```

详细接口定义见 `docs/接口设计/接口设计说明书.md`。

---

## 📜 许可证

本项目仅用于学习交流，未经许可不得用于商业用途。
