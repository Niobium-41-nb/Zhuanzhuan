-- ============================================================
-- 转转 - 种子数据 第三部分
-- 继续：运动器材、户外装备、其他分类
-- ============================================================

USE `zhuanzhuan`;
SET @pwd = '$2a$10$jnb0EqRycqlWErewqY3CS.qIafyXZv./nii/J/AFyEtCItBs74KYK';

-- == 运动器材 (category_id=24) - 14个 ==
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(6, 24, 'Keep 动感单车 C1 智能调阻', '静音磁控，连接Keep App自动调节阻力。买了半年，没坚持下来...', 699.00, 1799.00, '轻微使用痕迹', 'https://picsum.photos/seed/sport1/640/480', 456, 62, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(10, 24, 'YONEX 羽毛球拍 天斧88D Pro', '进攻型球拍，杀球暴力。只打过五六次。送拍套。', 699.00, 1299.00, '轻微使用痕迹', 'https://picsum.photos/seed/sport2/640/480', 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(6, 24, '哑铃组合 20kg 可调节', '一对可调哑铃+连接杆变杠铃。宿舍健身够用了。', 99.00, 249.00, '轻微使用痕迹', 'https://picsum.photos/seed/sport3/640/480', 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(12, 24, '瑜伽垫 加厚10mm NBR材质+Tpe', '双面防滑加厚瑜伽垫，附收纳绑带。有轻微使用痕迹。', 35.00, 89.00, '轻微使用痕迹', 'https://picsum.photos/seed/sport4/640/480', 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(5, 24, 'Wilson 网球拍 Pro Staff 97', '费德勒同款系列，精准控球。95成新。', 599.00, 1499.00, '几乎全新', 'https://picsum.photos/seed/sport5/640/480', 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(14, 24, '跳绳 钢丝轴承竞速款', '专业竞速跳绳，计数+卡路里显示。减肥必备。', 19.00, 49.00, '轻微使用痕迹', 'https://picsum.photos/seed/sport6/640/480', 289, 38, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(8, 24, '乒乓球拍 蝴蝶Tenergy 05套胶', '专业级反胶套胶，弹性极佳。适合有一定基础的球友。', 169.00, 369.00, '轻微使用痕迹', 'https://picsum.photos/seed/sport7/640/480', 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(10, 24, '腹肌轮+弹力带+俯卧撑架 套装', '核心力量训练三件套。买来用了不到十次。', 29.00, 69.00, '轻微使用痕迹', 'https://picsum.photos/seed/sport8/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(6, 24, '篮球 Spalding 74-604Y 标准7号', 'NBA官方用球，PU材质手感好。打了一个多月。', 89.00, 199.00, '轻微使用痕迹', 'https://picsum.photos/seed/sport9/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(3, 24, '小米 筋膜枪 mini版', '运动后放松肌肉，三档力度+四款按摩头。', 149.00, 299.00, '轻微使用痕迹', 'https://picsum.photos/seed/sport10/640/480', 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(9, 24, '滑板 长板 舞板 枫木7层', '买来学舞板的，发现平衡感太差就放弃了。有一些使用痕迹。', 169.00, 399.00, '轻微使用痕迹', 'https://picsum.photos/seed/sport11/640/480', 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(16, 24, '泳镜Speedo+泳帽+鼻夹 套装', '专业游泳装备，只用了两次。送收纳盒。', 59.00, 139.00, '几乎全新', 'https://picsum.photos/seed/sport12/640/480', 134, 16, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY)),
(7, 24, '体感游戏机 Switch RingFit 健身环', 'Switch健身环大冒险全套。玩通关了出闲置。', 199.00, 499.00, '轻微使用痕迹', 'https://picsum.photos/seed/sport13/640/480', 389, 53, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(4, 24, '壁球拍一对+3个球 初学者套装', '壁球入门装备，轻量铝合金拍框。', 79.00, 189.00, '轻微使用痕迹', 'https://picsum.photos/seed/sport14/640/480', 123, 15, '在售', DATE_SUB(NOW(), INTERVAL 15 DAY));

-- == 户外装备 (category_id=25) - 9个 ==
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(10, 25, '牧高笛 帐篷 双人双层 3季帐', '户外露营首选，防雨防风。用过三四次，八成新。', 299.00, 699.00, '轻微使用痕迹', 'https://picsum.photos/seed/outdoor1/640/480', 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(6, 25, '探路者 登山杖 碳纤维 一对', '超轻碳纤维折叠杖，EVA握把。登山徒步必备。', 129.00, 339.00, '轻微使用痕迹', 'https://picsum.photos/seed/outdoor2/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(14, 25, '北面 羽绒睡袋 0°C舒适温标', '冬季露营保暖神器，650蓬鹅绒。', 249.00, 699.00, '轻微使用痕迹', 'https://picsum.photos/seed/outdoor3/640/480', 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(4, 25, '迪卡侬 防潮垫+充气枕头', '露营睡眠系统好搭档。R值2.5，三季够用。', 59.00, 139.00, '轻微使用痕迹', 'https://picsum.photos/seed/outdoor4/640/480', 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(10, 25, '户外折叠椅+折叠桌 便携套装', '月亮椅+蛋卷桌，露营喝茶神器。', 169.00, 399.00, '轻微使用痕迹', 'https://picsum.photos/seed/outdoor5/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(8, 25, '探路者 户外头灯 200流明', 'USB充电超亮头灯，夜晚徒步露营必备。', 29.00, 79.00, '几乎全新', 'https://picsum.photos/seed/outdoor6/640/480', 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(9, 25, 'THERMOS 膳魔师 保温杯 1.2L', '大容量24小时保温，冬天爬山一杯热水暖心。', 99.00, 249.00, '轻微使用痕迹', 'https://picsum.photos/seed/outdoor7/640/480', 267, 35, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(12, 25, '户外急救包 62件套装', '野外应急必备！买了带去露营一次都没用过。', 30.00, 69.00, '几乎全新', 'https://picsum.photos/seed/outdoor8/640/480', 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(7, 25, '大疆 OM 6 手机云台稳定器', '三轴防抖+智能跟随+内置自拍杆。拍vlog旅拍神器。', 399.00, 799.00, '轻微使用痕迹', 'https://picsum.photos/seed/outdoor9/640/480', 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY));

-- == 其他 (category_id=6) - 14个 ==
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(13, 6, '雅马哈 F310 民谣吉他 41寸', '入门吉他经典款，音色温暖。买来学了两周放弃了...附教程书+调音器。', 499.00, 899.00, '几乎全新', 'https://picsum.photos/seed/other1/640/480', 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(5, 6, '富士 Instax Mini 12 拍立得 粉色', '可爱拍立得，出片有质感。含一盒相纸（剩8张）。', 299.00, 499.00, '轻微使用痕迹', 'https://picsum.photos/seed/other2/640/480', 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(16, 6, '小米 智能音箱 Sound Pro', '哈曼调音+空间音频，音质超好。升级HomePod了所以出。', 499.00, 999.00, '轻微使用痕迹', 'https://picsum.photos/seed/other3/640/480', 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(8, 6, 'PS5 游戏手柄 DualSense 白色', '原装手柄，极少用。送手柄支架。', 299.00, 529.00, '几乎全新', 'https://picsum.photos/seed/other4/640/480', 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(4, 6, 'Kindle Paperwhite 5 8G 黑色', '6.8寸纯平墨水屏，泡面盖...看过几本书。', 599.00, 1068.00, '轻微使用痕迹', 'https://picsum.photos/seed/other5/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(14, 6, '乐高 花束 10280 拼砌套装', '乐高花卉系列，拼好当摆件超好看。已经拼好含说明书。', 199.00, 399.00, '轻微使用痕迹', 'https://picsum.photos/seed/other6/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(11, 6, 'Marshall Stanmore III 蓝牙音箱', '摇滚复古造型+澎湃低音。因为搬家所以出售。', 1599.00, 2999.00, '轻微使用痕迹', 'https://picsum.photos/seed/other7/640/480', 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(10, 6, 'Switch 游戏《塞尔达传说 王国之泪》', '神作玩通关了出。卡带完好。', 199.00, 379.00, '轻微使用痕迹', 'https://picsum.photos/seed/other8/640/480', 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(15, 6, '手绘板 Wacom CTL-672 数位板', '入门数位板之王，2048级压感。适合板绘新手。', 299.00, 599.00, '轻微使用痕迹', 'https://picsum.photos/seed/other9/640/480', 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(3, 6, '小米 台灯 Pro 读写版', '国AA级照度，Ra95高显色指数。没有频闪不伤眼。', 149.00, 299.00, '轻微使用痕迹', 'https://picsum.photos/seed/other10/640/480', 289, 38, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(9, 6, '故宫文创 日历 2025 全新未拆', '故宫博物馆出品，每天一幅文物图。送人自用都合适。', 35.00, 79.00, '全新', 'https://picsum.photos/seed/other11/640/480', 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(12, 6, '掌阅 iReader Light2 电子书阅读器', '6寸墨水屏，300PPI清晰护眼。比Kindle更轻更便携。', 399.00, 699.00, '轻微使用痕迹', 'https://picsum.photos/seed/other12/640/480', 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY)),
(16, 6, '桌面盆栽 多肉拼盘 陶瓷盆', '五棵多肉+手工陶瓷花盆。好养活不用经常浇水。', 19.00, 39.00, '轻微使用痕迹', 'https://picsum.photos/seed/other13/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(7, 6, '九号 电动滑板车 ES1L 36V', '校园通勤神器，续航20km。折叠可放宿舍。前后碟刹。', 699.00, 1499.00, '轻微使用痕迹', 'https://picsum.photos/seed/other14/640/480', 534, 72, '在售', DATE_SUB(NOW(), INTERVAL 15 DAY));

-- ============================================================
-- 商品图片关联数据 (每个商品 2-3 张图片)
-- ============================================================

-- 为部分热门商品添加多张图片
INSERT INTO `product_image` (`product_id`, `url`, `sort_order`) VALUES
-- iPhone 14 (product_id: 产品的第一个)
((SELECT id FROM product WHERE title LIKE 'iPhone 14 128G%' LIMIT 1), 'https://picsum.photos/seed/phone1a/640/480', 1),
((SELECT id FROM product WHERE title LIKE 'iPhone 14 128G%' LIMIT 1), 'https://picsum.photos/seed/phone1b/640/480', 2),
((SELECT id FROM product WHERE title LIKE 'iPhone 14 128G%' LIMIT 1), 'https://picsum.photos/seed/phone1c/640/480', 3),

-- MacBook Air
((SELECT id FROM product WHERE title LIKE 'MacBook Air M2%' LIMIT 1), 'https://picsum.photos/seed/laptop1a/640/480', 1),
((SELECT id FROM product WHERE title LIKE 'MacBook Air M2%' LIMIT 1), 'https://picsum.photos/seed/laptop1b/640/480', 2),

-- Kindle
((SELECT id FROM product WHERE title LIKE 'Kindle Paperwhite%' LIMIT 1), 'https://picsum.photos/seed/kindle1a/640/480', 1),
((SELECT id FROM product WHERE title LIKE 'Kindle Paperwhite%' LIMIT 1), 'https://picsum.photos/seed/kindle1b/640/480', 2),

-- 三体
((SELECT id FROM product WHERE title LIKE '%三体%' LIMIT 1), 'https://picsum.photos/seed/book3body1/640/480', 1),
((SELECT id FROM product WHERE title LIKE '%三体%' LIMIT 1), 'https://picsum.photos/seed/book3body2/640/480', 2),

-- AirPods Pro 2
((SELECT id FROM product WHERE title LIKE 'AirPods Pro 2%' LIMIT 1), 'https://picsum.photos/seed/pods1a/640/480', 1),
((SELECT id FROM product WHERE title LIKE 'AirPods Pro 2%' LIMIT 1), 'https://picsum.photos/seed/pods1b/640/480', 2),

-- Air Force 1
((SELECT id FROM product WHERE title LIKE '%Air Force 1%' LIMIT 1), 'https://picsum.photos/seed/shoes1a/640/480', 1),
((SELECT id FROM product WHERE title LIKE '%Air Force 1%' LIMIT 1), 'https://picsum.photos/seed/shoes1b/640/480', 2),

-- 动感单车
((SELECT id FROM product WHERE title LIKE '%动感单车%' LIMIT 1), 'https://picsum.photos/seed/bike1a/640/480', 1),
((SELECT id FROM product WHERE title LIKE '%动感单车%' LIMIT 1), 'https://picsum.photos/seed/bike1b/640/480', 2),

-- Marshall 音箱
((SELECT id FROM product WHERE title LIKE 'Marshall Stanmore%' LIMIT 1), 'https://picsum.photos/seed/marshall1a/640/480', 1),
((SELECT id FROM product WHERE title LIKE 'Marshall Stanmore%' LIMIT 1), 'https://picsum.photos/seed/marshall1b/640/480', 2);

-- ============================================================
-- 更新商品封面图（确保每个商品都有有效的封面图）
-- 对于没有明确设置 cover_image 的商品，通过其第一张 product_image 来更新
-- ============================================================
UPDATE product p
LEFT JOIN (
    SELECT product_id, MIN(url) AS first_image
    FROM product_image
    GROUP BY product_id
) pi ON p.id = pi.product_id
SET p.cover_image = pi.first_image
WHERE p.cover_image IS NULL AND pi.first_image IS NOT NULL;

-- ============================================================
-- 完成提示
-- ============================================================
SELECT '✅ 种子数据导入完成！' AS status;
