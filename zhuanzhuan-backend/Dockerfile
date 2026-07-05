# ============================================================
# Stage 1: 下载依赖（利用 Docker 缓存层）
# ============================================================
FROM maven:3.9-eclipse-temurin-17 AS deps

WORKDIR /build
COPY pom.xml .

RUN mvn dependency:go-offline -B -q

# ============================================================
# Stage 2: 编译源码
# ============================================================
FROM deps AS builder

COPY src ./src
RUN mvn clean package -DskipTests -q

# ============================================================
# Stage 3: 运行
# ============================================================
FROM eclipse-temurin:17-jre-jammy

RUN groupadd -r appuser && useradd -r -g appuser -d /app appuser

WORKDIR /app
RUN mkdir -p /data/zhuanzhuan/uploads && chown -R appuser:appuser /app

COPY --from=builder /build/target/*.jar app.jar

RUN chown -R appuser:appuser /app

# 设置容器 locale 为 UTF-8
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# 入口包装脚本：以 root 修正卷权限后降权运行
RUN printf '#!/bin/sh\nchmod 777 /data/zhuanzhuan/uploads 2>/dev/null\nexec su -s /bin/sh appuser -c "exec /opt/java/openjdk/bin/java -Dfile.encoding=UTF-8 -jar /app/app.jar --spring.profiles.active=prod"\n' > /entrypoint.sh && chmod +x /entrypoint.sh

EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
