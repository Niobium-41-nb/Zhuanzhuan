-- ============================================================
-- 转转种子数据 Part 4: 运动器材、户外装备、其他
-- ============================================================
USE `zhuanzhuan`;
SET @img = 'https://loremflickr.com/640/480';

-- === 运动器材 (14) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(6,  24, 'Keep 动感单车 C1 智能调阻', '静音磁控连接Keep App自动调节阻力。买了半年没坚持下来...', 699.00, 1799.00, '轻微使用痕迹', CONCAT(@img,'/spinning,bike,exercise,indoor'), 456, 62, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(10, 24, 'YONEX 羽毛球拍 天斧88D Pro', '进攻型球拍杀球暴力。只打过五六次。送拍套。', 699.00, 1299.00, '轻微使用痕迹', CONCAT(@img,'/yonex,badminton,racket,sport'), 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(6,  24, '哑铃组合 20kg 可调节', '一对可调哑铃+连接杆变杠铃。宿舍健身够用了。', 99.00, 249.00, '轻微使用痕迹', CONCAT(@img,'/dumbbell,weight,adjustable,fitness'), 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(12, 24, '瑜伽垫 加厚10mm NBR+Tpe', '双面防滑加厚瑜伽垫附收纳绑带。有轻微使用痕迹。', 35.00, 89.00, '轻微使用痕迹', CONCAT(@img,'/yoga,mat,exercise,fitness,purple'), 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(5,  24, 'Wilson 网球拍 Pro Staff 97', '费德勒同款系列精准控球。95成新。', 599.00, 1499.00, '几乎全新', CONCAT(@img,'/wilson,tennis,racket,pro,staff'), 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(14, 24, '跳绳 钢丝轴承竞速款', '专业竞速跳绳计数+卡路里显示。减肥必备。', 19.00, 49.00, '轻微使用痕迹', CONCAT(@img,'/jump,rope,speed,fitness,exercise'), 289, 38, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(8,  24, '乒乓球拍 蝴蝶Tenergy 05套胶', '专业级反胶套胶弹性极佳。适合有一定基础的球友。', 169.00, 369.00, '轻微使用痕迹', CONCAT(@img,'/table,tennis,paddle,pingpong'), 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(10, 24, '腹肌轮+弹力带+俯卧撑架 套装', '核心力量训练三件套。买来用了不到十次。', 29.00, 69.00, '轻微使用痕迹', CONCAT(@img,'/ab,roller,resistance,band,fitness'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(6,  24, '篮球 Spalding 74-604Y 标准7号', 'NBA官方用球PU材质手感好。打了一个多月。', 89.00, 199.00, '轻微使用痕迹', CONCAT(@img,'/spalding,basketball,ball,nba'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(3,  24, '小米 筋膜枪 mini版', '运动后放松肌肉三档力度+四款按摩头。', 149.00, 299.00, '轻微使用痕迹', CONCAT(@img,'/massage,gun,fascia,muscle,recovery'), 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(9,  24, '滑板 长板 舞板 枫木7层', '买来学舞板的发现平衡感太差放弃了。有一些使用痕迹。', 169.00, 399.00, '轻微使用痕迹', CONCAT(@img,'/longboard,skateboard,maple,dancing'), 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(16, 24, '泳镜Speedo+泳帽+鼻夹 套装', '专业游泳装备只用了两次。送收纳盒。', 59.00, 139.00, '几乎全新', CONCAT(@img,'/speedo,goggles,swimming,cap'), 134, 16, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY)),
(7,  24, 'Switch RingFit 健身环大冒险', 'Switch健身环大冒险全套。玩通关了出闲置。', 199.00, 499.00, '轻微使用痕迹', CONCAT(@img,'/nintendo,switch,ring,fit,adventure'), 389, 53, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(4,  24, '壁球拍一对+3个球 初学者套装', '壁球入门装备轻量铝合金拍框。', 79.00, 189.00, '轻微使用痕迹', CONCAT(@img,'/squash,racket,beginner,sport'), 123, 15, '在售', DATE_SUB(NOW(), INTERVAL 15 DAY));

-- === 户外装备 (9) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(10, 25, '牧高笛 帐篷 双人双层 3季帐', '户外露营首选防雨防风。用过三四次八成新。', 299.00, 699.00, '轻微使用痕迹', CONCAT(@img,'/tent,camping,outdoor,backpacking'), 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(6,  25, '探路者 登山杖 碳纤维 一对', '超轻碳纤维折叠杖EVA握把。登山徒步必备。', 129.00, 339.00, '轻微使用痕迹', CONCAT(@img,'/trekking,pole,carbon,hiking'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(14, 25, '北面 羽绒睡袋 0°C舒适温标', '冬季露营保暖神器650蓬鹅绒。', 249.00, 699.00, '轻微使用痕迹', CONCAT(@img,'/sleeping,bag,down,camping,winter'), 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(4,  25, '迪卡侬 防潮垫+充气枕头', '露营睡眠系统好搭档。R值2.5三季够用。', 59.00, 139.00, '轻微使用痕迹', CONCAT(@img,'/sleeping,pad,camping,inflatable'), 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(10, 25, '户外折叠椅+折叠桌 便携套装', '月亮椅+蛋卷桌露营喝茶神器。', 169.00, 399.00, '轻微使用痕迹', CONCAT(@img,'/camping,chair,table,portable,outdoor'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(8,  25, '探路者 户外头灯 200流明', 'USB充电超亮头灯夜晚徒步露营必备。', 29.00, 79.00, '几乎全新', CONCAT(@img,'/headlamp,led,camping,outdoor'), 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(9,  25, 'THERMOS 膳魔师 保温杯 1.2L', '大容量24小时保温冬天爬山一杯热水暖心。', 99.00, 249.00, '轻微使用痕迹', CONCAT(@img,'/thermos,vacuum,flask,stainless'), 267, 35, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(12, 25, '户外急救包 62件套装', '野外应急必备！买了带去露营一次都没用过。', 30.00, 69.00, '几乎全新', CONCAT(@img,'/first,aid,kit,outdoor,emergency'), 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(7,  25, '大疆 OM 6 手机云台稳定器', '三轴防抖+智能跟随+内置自拍杆。vlog旅拍神器。', 399.00, 799.00, '轻微使用痕迹', CONCAT(@img,'/dji,osmo,mobile,gimbal,stabilizer'), 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY));

-- === 其他 (14) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(13, 6, '雅马哈 F310 民谣吉他 41寸', '入门吉他经典款音色温暖。附赠教程书+调音器。', 499.00, 899.00, '几乎全新', CONCAT(@img,'/yamaha,acoustic,guitar,f310'), 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(5,  6, '富士 Instax Mini 12 拍立得 粉色', '可爱拍立得出片有质感。含一盒相纸剩8张。', 299.00, 499.00, '轻微使用痕迹', CONCAT(@img,'/fujifilm,instax,mini,polaroid,camera'), 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(16, 6, '小米 智能音箱 Sound Pro', '哈曼调音+空间音频音质超好。升级HomePod了所以出。', 499.00, 999.00, '轻微使用痕迹', CONCAT(@img,'/xiaomi,sound,pro,speaker,smart'), 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(8,  6, 'PS5 DualSense 无线手柄 白色', '原装手柄极少用。送手柄支架。', 299.00, 529.00, '几乎全新', CONCAT(@img,'/ps5,dualsense,controller,gaming'), 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(4,  6, 'Kindle Paperwhite 5 8G 黑色', '6.8寸纯平墨水屏，泡面盖...看过几本书。', 599.00, 1068.00, '轻微使用痕迹', CONCAT(@img,'/kindle,paperwhite,ereader,ebook'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(14, 6, '乐高 花束 10280 拼砌套装', '乐高花卉系列拼好当摆件超好看。已拼好含说明书。', 199.00, 399.00, '轻微使用痕迹', CONCAT(@img,'/lego,flower,bouquet,botanical'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(11, 6, 'Marshall Stanmore III 蓝牙音箱', '摇滚复古造型+澎湃低音。因为搬家所以出售。', 1599.00, 2999.00, '轻微使用痕迹', CONCAT(@img,'/marshall,stanmore,speaker,bluetooth'), 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(10, 6, 'Switch《塞尔达传说 王国之泪》', '神作玩通关了出。卡带完好如新。', 199.00, 379.00, '轻微使用痕迹', CONCAT(@img,'/zelda,tears,kingdom,nintendo,switch'), 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(15, 6, '手绘板 Wacom CTL-672 数位板', '入门数位板之王2048级压感。适合板绘新手。', 299.00, 599.00, '轻微使用痕迹', CONCAT(@img,'/wacom,drawing,tablet,digital,art'), 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(3,  6, '小米 台灯 Pro 读写版', '国AA级照度Ra95高显色指数。无频闪不伤眼。', 149.00, 299.00, '轻微使用痕迹', CONCAT(@img,'/xiaomi,desk,lamp,pro,led'), 289, 38, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(9,  6, '故宫文创 日历 2025 全新未拆', '故宫博物馆出品每天一幅文物图。送人自用都合适。', 35.00, 79.00, '全新', CONCAT(@img,'/forbidden,city,calendar,chinese,art'), 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(12, 6, '掌阅 iReader Light2 电子书阅读器', '6寸墨水屏300PPI清晰护眼。比Kindle更轻便携。', 399.00, 699.00, '轻微使用痕迹', CONCAT(@img,'/ereader,ireader,ink,display'), 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY)),
(16, 6, '桌面盆栽 多肉拼盘 陶瓷盆', '五棵多肉+手工陶瓷花盆。好养活不用经常浇水。', 19.00, 39.00, '轻微使用痕迹', CONCAT(@img,'/succulent,plant,pot,ceramic,desk'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(7,  6, '九号 电动滑板车 ES1L 36V', '校园通勤神器续航20km。折叠可放宿舍。前后碟刹。', 699.00, 1499.00, '轻微使用痕迹', CONCAT(@img,'/electric,scooter,ninebot,commute'), 534, 72, '在售', DATE_SUB(NOW(), INTERVAL 15 DAY));

-- === 热门商品多图 ===
INSERT INTO `product_image` (`product_id`, `url`, `sort_order`) VALUES
((SELECT id FROM product WHERE title LIKE 'iPhone 14%' LIMIT 1), CONCAT(@img,'/iphone14,unboxing,apple'), 1),
((SELECT id FROM product WHERE title LIKE 'iPhone 14%' LIMIT 1), CONCAT(@img,'/iphone,back,camera'), 2),
((SELECT id FROM product WHERE title LIKE 'MacBook Air M2%' LIMIT 1), CONCAT(@img,'/macbook,air,desk,setup'), 1),
((SELECT id FROM product WHERE title LIKE 'MacBook Air M2%' LIMIT 1), CONCAT(@img,'/apple,laptop,keyboard'), 2),
((SELECT id FROM product WHERE title LIKE 'Kindle Paperwhite%' LIMIT 1), CONCAT(@img,'/kindle,reading,ebook,coffee'), 1),
((SELECT id FROM product WHERE title LIKE 'Kindle Paperwhite%' LIMIT 1), CONCAT(@img,'/kindle,paperwhite,ereader'), 2),
((SELECT id FROM product WHERE title LIKE '%三体%' LIMIT 1), CONCAT(@img,'/three,body,problem,liu,cixin'), 1),
((SELECT id FROM product WHERE title LIKE '%三体%' LIMIT 1), CONCAT(@img,'/science,fiction,book,chinese'), 2),
((SELECT id FROM product WHERE title LIKE 'AirPods Pro 2%' LIMIT 1), CONCAT(@img,'/airpods,pro,case,apple'), 1),
((SELECT id FROM product WHERE title LIKE 'AirPods Pro 2%' LIMIT 1), CONCAT(@img,'/airpods,earbuds,white'), 2),
((SELECT id FROM product WHERE title LIKE '%Air Force 1%' LIMIT 1), CONCAT(@img,'/nike,airforce,white,sneakers'), 1),
((SELECT id FROM product WHERE title LIKE '%Air Force 1%' LIMIT 1), CONCAT(@img,'/nike,sneakers,detail,shoe'), 2),
((SELECT id FROM product WHERE title LIKE '%动感单车%' LIMIT 1), CONCAT(@img,'/spinning,bike,fitness,home'), 1),
((SELECT id FROM product WHERE title LIKE '%动感单车%' LIMIT 1), CONCAT(@img,'/exercise,bike,indoor,cardio'), 2),
((SELECT id FROM product WHERE title LIKE 'Marshall Stanmore%' LIMIT 1), CONCAT(@img,'/marshall,stanmore,speaker,vintage'), 1),
((SELECT id FROM product WHERE title LIKE 'Marshall Stanmore%' LIMIT 1), CONCAT(@img,'/marshall,speaker,music,retro'), 2);

-- 确保所有商品都有封面图
UPDATE product p
LEFT JOIN (SELECT product_id, MIN(url) AS first_image FROM product_image GROUP BY product_id) pi ON p.id = pi.product_id
SET p.cover_image = pi.first_image
WHERE (p.cover_image IS NULL OR p.cover_image = '') AND pi.first_image IS NOT NULL;

SELECT '✅ 全部种子数据导入完成！' AS status;
