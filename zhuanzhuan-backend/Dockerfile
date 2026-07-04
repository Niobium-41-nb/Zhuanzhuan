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

WORKDIR /app
RUN mkdir -p /data/zhuanzhuan/uploads

COPY --from=builder /build/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=prod"]
