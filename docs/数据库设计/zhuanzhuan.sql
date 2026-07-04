-- ============================================================
-- 校园二手物品交易平台 - 数据库初始化脚本
-- 数据库管理系统: MySQL 8.0+
-- 字符集: utf8mb4
-- 排序规则: utf8mb4_unicode_ci
-- 存储引擎: InnoDB
-- ============================================================

-- 删除已存在的数据库（生产环境请谨慎使用）
DROP DATABASE IF EXISTS `zhuanzhuan`;

-- 创建数据库
CREATE DATABASE IF NOT EXISTS `zhuanzhuan`
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;

-- 使用数据库
USE `zhuanzhuan`;

-- ============================================================
-- 1. 用户表 (user)
--    存储系统用户的注册信息与账户状态
-- ============================================================
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
    `id`            BIGINT(20)   NOT NULL   AUTO_INCREMENT  COMMENT '用户ID',
    `username`      VARCHAR(50)  NOT NULL                   COMMENT '用户名',
    `password_hash` VARCHAR(255) NOT NULL                   COMMENT '密码哈希值(BCrypt)',
    `email`         VARCHAR(100) DEFAULT NULL               COMMENT '邮箱',
    `phone`         VARCHAR(20)  DEFAULT NULL               COMMENT '手机号',
    `avatar`        VARCHAR(255) DEFAULT NULL               COMMENT '头像URL',
    `nickname`      VARCHAR(50)  DEFAULT NULL               COMMENT '昵称',
    `bio`           VARCHAR(200) DEFAULT NULL               COMMENT '个人简介',
    `gender`        TINYINT(4)   DEFAULT 0                  COMMENT '性别(0未知/1男/2女)',
    `role`          ENUM('user', 'admin') NOT NULL DEFAULT 'user' COMMENT '角色',
    `credit_score`  INT(11)      DEFAULT 100                COMMENT '信誉分',
    `status`        TINYINT(4)   NOT NULL DEFAULT 1         COMMENT '状态(0禁用/1启用)',
    `last_login_at` DATETIME     DEFAULT NULL               COMMENT '最后登录时间',
    `created_at`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted_at`    DATETIME     DEFAULT NULL               COMMENT '删除时间(软删除)',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`),
    UNIQUE KEY `uk_email` (`email`),
    UNIQUE KEY `uk_phone` (`phone`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户表';

-- ============================================================
-- 2. 商品分类表 (category)
--    存储商品的多级分类信息
-- ============================================================
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
    `id`         BIGINT(20)  NOT NULL  AUTO_INCREMENT  COMMENT '分类ID',
    `name`       VARCHAR(50) NOT NULL                  COMMENT '分类名称',
    `parent_id`  BIGINT(20)  DEFAULT 0                 COMMENT '父分类ID(0为顶级)',
    `level`      TINYINT(4)  NOT NULL DEFAULT 1        COMMENT '层级(1/2/3)',
    `icon`       VARCHAR(255) DEFAULT NULL             COMMENT '分类图标',
    `sort_order` INT(11)     DEFAULT 0                 COMMENT '排序序号',
    `status`     TINYINT(4)  NOT NULL DEFAULT 1        COMMENT '状态(0隐藏/1显示)',
    PRIMARY KEY (`id`),
    KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品分类表';

-- ============================================================
-- 3. 商品表 (product)
--    存储二手商品的详细信息
-- ============================================================
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
    `id`              BIGINT(20)   NOT NULL  AUTO_INCREMENT  COMMENT '商品ID',
    `user_id`         BIGINT(20)   NOT NULL                  COMMENT '卖家ID',
    `category_id`     BIGINT(20)   NOT NULL                  COMMENT '分类ID',
    `title`           VARCHAR(100) NOT NULL                  COMMENT '商品标题',
    `description`     TEXT                                   COMMENT '商品描述(富文本)',
    `price`           DECIMAL(10,2) NOT NULL                 COMMENT '价格(元)',
    `original_price`  DECIMAL(10,2) DEFAULT NULL             COMMENT '原价',
    `condition`       ENUM('全新','几乎全新','轻微使用痕迹','明显使用痕迹','老旧') NOT NULL COMMENT '成色',
    `cover_image`     VARCHAR(255) DEFAULT NULL              COMMENT '封面图URL',
    `view_count`      INT(11)      DEFAULT 0                 COMMENT '浏览量',
    `favorite_count`  INT(11)      DEFAULT 0                 COMMENT '收藏数',
    `status`          ENUM('待审核','在售','已下架','已售出','审核驳回') NOT NULL DEFAULT '待审核' COMMENT '商品状态',
    `created_at`      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
    `updated_at`      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted_at`      DATETIME     DEFAULT NULL              COMMENT '删除时间(软删除)',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_category_id` (`category_id`),
    KEY `idx_status` (`status`),
    KEY `idx_created_at` (`created_at`),
    KEY `idx_price` (`price`),
    FULLTEXT KEY `ft_title_desc` (`title`, `description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品表';

-- ============================================================
-- 4. 商品图片表 (product_image)
--    存储商品的多张图片信息
-- ============================================================
DROP TABLE IF EXISTS `product_image`;
CREATE TABLE `product_image` (
    `id`         BIGINT(20)  NOT NULL  AUTO_INCREMENT  COMMENT '图片ID',
    `product_id` BIGINT(20)  NOT NULL                  COMMENT '商品ID',
    `url`        VARCHAR(255) NOT NULL                 COMMENT '图片URL',
    `sort_order` INT(11)     DEFAULT 0                 COMMENT '排序序号',
    `created_at` DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
    PRIMARY KEY (`id`),
    KEY `idx_product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品图片表';

-- ============================================================
-- 5. 收货地址表 (address)
--    存储用户的收货地址信息
-- ============================================================
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
    `id`          BIGINT(20)  NOT NULL  AUTO_INCREMENT  COMMENT '地址ID',
    `user_id`     BIGINT(20)  NOT NULL                  COMMENT '用户ID',
    `receiver`    VARCHAR(50) NOT NULL                  COMMENT '收件人姓名',
    `phone`       VARCHAR(20) NOT NULL                  COMMENT '联系电话',
    `province`    VARCHAR(20) NOT NULL                  COMMENT '省份',
    `city`        VARCHAR(20) NOT NULL                  COMMENT '城市',
    `district`    VARCHAR(20) NOT NULL                  COMMENT '区县',
    `detail`      VARCHAR(200) NOT NULL                 COMMENT '详细地址',
    `is_default`  TINYINT(4)  NOT NULL DEFAULT 0        COMMENT '是否默认(0否/1是)',
    `created_at`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收货地址表';

-- ============================================================
-- 6. 订单表 (order)
--    存储交易订单信息
-- ============================================================
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
    `id`                BIGINT(20)   NOT NULL  AUTO_INCREMENT  COMMENT '订单ID',
    `order_no`          VARCHAR(32)  NOT NULL                  COMMENT '订单号(唯一)',
    `buyer_id`          BIGINT(20)   NOT NULL                  COMMENT '买家ID',
    `seller_id`         BIGINT(20)   NOT NULL                  COMMENT '卖家ID',
    `product_id`        BIGINT(20)   NOT NULL                  COMMENT '商品ID',
    `total_price`       DECIMAL(10,2) NOT NULL                 COMMENT '总价(元)',
    `shipping_name`     VARCHAR(50)  DEFAULT NULL              COMMENT '收件人姓名',
    `shipping_phone`    VARCHAR(20)  DEFAULT NULL              COMMENT '收件人电话',
    `shipping_address`  VARCHAR(255) DEFAULT NULL              COMMENT '收货地址',
    `logistics_company` VARCHAR(50)  DEFAULT NULL              COMMENT '物流公司',
    `logistics_no`      VARCHAR(50)  DEFAULT NULL              COMMENT '物流单号',
    `buyer_remark`      VARCHAR(200) DEFAULT NULL              COMMENT '买家备注',
    `status`            ENUM('待付款','待发货','待收货','已完成','已取消') NOT NULL DEFAULT '待付款' COMMENT '订单状态',
    `paid_at`           DATETIME     DEFAULT NULL              COMMENT '支付时间',
    `shipped_at`        DATETIME     DEFAULT NULL              COMMENT '发货时间',
    `received_at`       DATETIME     DEFAULT NULL              COMMENT '收货时间',
    `created_at`        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at`        DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_no` (`order_no`),
    KEY `idx_buyer_id` (`buyer_id`),
    KEY `idx_seller_id` (`seller_id`),
    KEY `idx_status` (`status`),
    KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单表';

-- ============================================================
-- 7. 订单日志表 (order_log)
--    记录订单状态的变更历史
-- ============================================================
DROP TABLE IF EXISTS `order_log`;
CREATE TABLE `order_log` (
    `id`          BIGINT(20)  NOT NULL  AUTO_INCREMENT  COMMENT '日志ID',
    `order_id`    BIGINT(20)  NOT NULL                  COMMENT '订单ID',
    `from_status` VARCHAR(20) DEFAULT NULL              COMMENT '原状态',
    `to_status`   VARCHAR(20) NOT NULL                  COMMENT '新状态',
    `operator`    VARCHAR(50) DEFAULT '系统'            COMMENT '操作人',
    `remark`      VARCHAR(200) DEFAULT NULL             COMMENT '备注',
    `created_at`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='订单日志表';

-- ============================================================
-- 8. 购物车表 (cart)
--    存储用户加入购物车的商品
-- ============================================================
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
    `id`          BIGINT(20)  NOT NULL  AUTO_INCREMENT  COMMENT '购物车项ID',
    `user_id`     BIGINT(20)  NOT NULL                  COMMENT '用户ID',
    `product_id`  BIGINT(20)  NOT NULL                  COMMENT '商品ID',
    `quantity`    INT(11)     NOT NULL DEFAULT 1        COMMENT '数量',
    `selected`    TINYINT(4)  NOT NULL DEFAULT 1        COMMENT '是否选中(0否/1是)',
    `created_at`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
    `updated_at`  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_product` (`user_id`, `product_id`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购物车表';

-- ============================================================
-- 9. 消息表 (message)
--    存储用户之间的站内信消息
-- ============================================================
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
    `id`           BIGINT(20)  NOT NULL  AUTO_INCREMENT  COMMENT '消息ID',
    `from_user_id` BIGINT(20)  NOT NULL                  COMMENT '发送方ID',
    `to_user_id`   BIGINT(20)  NOT NULL                  COMMENT '接收方ID',
    `content`      TEXT        NOT NULL                  COMMENT '消息内容',
    `type`         ENUM('text','image','system') NOT NULL DEFAULT 'text' COMMENT '消息类型',
    `is_read`      TINYINT(4)  NOT NULL DEFAULT 0        COMMENT '已读(0未读/1已读)',
    `created_at`   DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发送时间',
    PRIMARY KEY (`id`),
    KEY `idx_from_user_id` (`from_user_id`),
    KEY `idx_to_user_id` (`to_user_id`),
    KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息表';

-- ============================================================
-- 10. 通知表 (notification)
--     存储系统发送给用户的通知信息
-- ============================================================
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
    `id`         BIGINT(20)  NOT NULL  AUTO_INCREMENT  COMMENT '通知ID',
    `user_id`    BIGINT(20)  NOT NULL                  COMMENT '接收用户ID',
    `title`      VARCHAR(100) NOT NULL                 COMMENT '通知标题',
    `content`    TEXT        NOT NULL                  COMMENT '通知内容',
    `type`       ENUM('order','review','system') NOT NULL DEFAULT 'system' COMMENT '通知类型',
    `is_read`    TINYINT(4)  NOT NULL DEFAULT 0       COMMENT '已读(0未读/1已读)',
    `created_at` DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_is_read` (`is_read`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通知表';

-- ============================================================
-- 11. 收藏表 (favorite)
--     存储用户收藏的商品记录
-- ============================================================
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite` (
    `id`         BIGINT(20) NOT NULL  AUTO_INCREMENT  COMMENT '收藏ID',
    `user_id`    BIGINT(20) NOT NULL                  COMMENT '用户ID',
    `product_id` BIGINT(20) NOT NULL                  COMMENT '商品ID',
    `created_at` DATETIME   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_product` (`user_id`, `product_id`),
    KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='收藏表';

-- ============================================================
-- 12. 交易评价表 (review)
--     存储交易完成后买卖双方的评价信息
-- ============================================================
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
    `id`           BIGINT(20)  NOT NULL  AUTO_INCREMENT  COMMENT '评价ID',
    `order_id`     BIGINT(20)  NOT NULL                  COMMENT '订单ID',
    `from_user_id` BIGINT(20)  NOT NULL                  COMMENT '评价方ID',
    `to_user_id`   BIGINT(20)  NOT NULL                  COMMENT '被评价方ID',
    `rating`       TINYINT(4)  NOT NULL                  COMMENT '评分(1-5)',
    `content`      VARCHAR(500) DEFAULT NULL             COMMENT '评价内容',
    `created_at`   DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_from` (`order_id`, `from_user_id`),
    KEY `idx_order_id` (`order_id`),
    KEY `idx_to_user_id` (`to_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易评价表';

-- ============================================================
-- 13. 公告表 (announcement)
--     存储系统公告信息
-- ============================================================
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement` (
    `id`         BIGINT(20)  NOT NULL  AUTO_INCREMENT  COMMENT '公告ID',
    `admin_id`   BIGINT(20)  NOT NULL                  COMMENT '发布人ID',
    `title`      VARCHAR(100) NOT NULL                 COMMENT '公告标题',
    `content`    TEXT        NOT NULL                  COMMENT '公告内容',
    `status`     TINYINT(4)  NOT NULL DEFAULT 0        COMMENT '状态(0草稿/1发布)',
    `created_at` DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `updated_at` DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公告表';

-- ============================================================
-- 初始化数据
-- ============================================================

-- 插入默认管理员（密码: admin123，BCrypt哈希值）
-- 注意：实际生产环境请使用 BCryptPasswordEncoder 生成
INSERT INTO `user` (`id`, `username`, `password_hash`, `email`, `nickname`, `role`, `status`) VALUES
(1, 'admin', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'admin@zhuanzhuan.com', '系统管理员', 'admin', 1),
(2, 'testuser', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'test@zhuanzhuan.com', '测试用户', 'user', 1);

-- 插入商品分类
INSERT INTO `category` (`id`, `name`, `parent_id`, `level`, `sort_order`, `status`) VALUES
-- 一级分类
(1, '电子产品', 0, 1, 1, 1),
(2, '书籍教材', 0, 1, 2, 1),
(3, '生活用品', 0, 1, 3, 1),
(4, '服饰鞋包', 0, 1, 4, 1),
(5, '运动户外', 0, 1, 5, 1),
(6, '其他', 0, 1, 6, 1),
-- 二级分类：电子产品
(7, '手机', 1, 2, 1, 1),
(8, '电脑', 1, 2, 2, 1),
(9, '平板', 1, 2, 3, 1),
(10, '耳机', 1, 2, 4, 1),
(11, '相机', 1, 2, 5, 1),
(12, '配件', 1, 2, 6, 1),
-- 二级分类：书籍教材
(13, '教材教辅', 2, 2, 1, 1),
(14, '文学小说', 2, 2, 2, 1),
(15, '科技科普', 2, 2, 3, 1),
(16, '考试资料', 2, 2, 4, 1),
-- 二级分类：生活用品
(17, '宿舍用品', 3, 2, 1, 1),
(18, '厨房电器', 3, 2, 2, 1),
(19, '美妆个护', 3, 2, 3, 1),
-- 二级分类：服饰鞋包
(20, '上衣', 4, 2, 1, 1),
(21, '裤装', 4, 2, 2, 1),
(22, '鞋类', 4, 2, 3, 1),
(23, '箱包', 4, 2, 4, 1),
-- 二级分类：运动户外
(24, '运动器材', 5, 2, 1, 1),
(25, '户外装备', 5, 2, 2, 1);

-- ============================================================
-- 外键约束（可选启用，生产环境建议在应用层保证数据一致性）
-- ============================================================
-- ALTER TABLE `product` ADD CONSTRAINT `fk_product_user` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`);
-- ALTER TABLE `product` ADD CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category`(`id`);
-- ALTER TABLE `product_image` ADD CONSTRAINT `fk_product_image_product` FOREIGN KEY (`product_id`) REFERENCES `product`(`id`);
-- ALTER TABLE `order` ADD CONSTRAINT `fk_order_buyer` FOREIGN KEY (`buyer_id`) REFERENCES `user`(`id`);
-- ALTER TABLE `order` ADD CONSTRAINT `fk_order_seller` FOREIGN KEY (`seller_id`) REFERENCES `user`(`id`);
-- ALTER TABLE `order` ADD CONSTRAINT `fk_order_product` FOREIGN KEY (`product_id`) REFERENCES `product`(`id`);
-- ALTER TABLE `order_log` ADD CONSTRAINT `fk_order_log_order` FOREIGN KEY (`order_id`) REFERENCES `order`(`id`);
-- ALTER TABLE `message` ADD CONSTRAINT `fk_message_from_user` FOREIGN KEY (`from_user_id`) REFERENCES `user`(`id`);
-- ALTER TABLE `message` ADD CONSTRAINT `fk_message_to_user` FOREIGN KEY (`to_user_id`) REFERENCES `user`(`id`);
-- ALTER TABLE `notification` ADD CONSTRAINT `fk_notification_user` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`);
-- ALTER TABLE `favorite` ADD CONSTRAINT `fk_favorite_user` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`);
-- ALTER TABLE `favorite` ADD CONSTRAINT `fk_favorite_product` FOREIGN KEY (`product_id`) REFERENCES `product`(`id`);
-- ALTER TABLE `address` ADD CONSTRAINT `fk_address_user` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`);
-- ALTER TABLE `review` ADD CONSTRAINT `fk_review_order` FOREIGN KEY (`order_id`) REFERENCES `order`(`id`);
-- ALTER TABLE `announcement` ADD CONSTRAINT `fk_announcement_admin` FOREIGN KEY (`admin_id`) REFERENCES `user`(`id`);
