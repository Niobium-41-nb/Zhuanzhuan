-- ============================================================
-- 数据库索引优化迁移脚本
-- 适用版本: 转转 v1.0
-- 说明: 补充缺失的关键复合索引，提升查询性能
-- ============================================================

-- 1. 消息表: 会话查询 + 未读计数
--    查询模式: WHERE (from_user_id=X AND to_user_id=Y) OR (from_user_id=Y AND to_user_id=X)
--    未读计数: WHERE to_user_id=X AND is_read=0
ALTER TABLE `message`
    ADD INDEX `idx_from_to` (`from_user_id`, `to_user_id`),
    ADD INDEX `idx_to_read` (`to_user_id`, `is_read`);

-- 2. 通知表: 未读计数
--    查询模式: WHERE user_id=X AND is_read=0
ALTER TABLE `notification`
    ADD INDEX `idx_user_read` (`user_id`, `is_read`);

-- 3. 收藏表: 用户收藏列表
--    查询模式: WHERE user_id=X ORDER BY created_at DESC
ALTER TABLE `favorite`
    ADD INDEX `idx_user_created` (`user_id`, `created_at`);

-- 4. 商品表: 卖家商品列表
--    查询模式: WHERE user_id=X AND status=Y AND deleted_at IS NULL
ALTER TABLE `product`
    ADD INDEX `idx_user_status` (`user_id`, `status`);
