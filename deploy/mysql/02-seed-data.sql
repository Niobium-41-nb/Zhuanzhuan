-- ============================================================
-- 转转 - 完整种子数据
-- 图片使用 LoremFlickr 关键词匹配真实图片
-- 密码: Abc12345 / 管理员: admin123
-- ============================================================
USE `zhuanzhuan`;

SET @pwd = '$2a$10$jnb0EqRycqlWErewqY3CS.qIafyXZv./nii/J/AFyEtCItBs74KYK';
SET @img = 'https://loremflickr.com/640/480';

-- ============================================================
-- 用户 (15人)
-- ============================================================
INSERT INTO `user` (`id`, `username`, `password_hash`, `email`, `phone`, `avatar`, `nickname`, `bio`, `gender`, `role`, `credit_score`, `status`, `last_login_at`) VALUES
(3,  'xiaoming',   @pwd, 'xiaoming@qq.com',     '13800010001', CONCAT('https://i.pravatar.cc/200?u=xiaoming'),   '小明爱学习',   '计算机科学与技术大三学生，收集各种数码产品',   1, 'user', 95,  1, NOW()),
(4,  'zhangdaxia', @pwd, 'zhangdaxia@163.com',   '13800010002', CONCAT('https://i.pravatar.cc/200?u=zhangdaxia'), '张大侠',       '文学爱好者，有很多好书要出',                   1, 'user', 98,  1, NOW()),
(5,  'lilyflower', @pwd, 'lily@campus.edu.cn',   '13800010003', CONCAT('https://i.pravatar.cc/200?u=lilyflower'), '莉莉在画画',   '艺术系女生，喜欢穿搭和手作',                   2, 'user', 88,  1, NOW()),
(6,  'runner_lee', @pwd, 'runner@outlook.com',   '13800010004', CONCAT('https://i.pravatar.cc/200?u=runner_lee'), '奔跑的李',     '体育特长生，健身跑步是我的日常',               1, 'user', 92,  1, NOW()),
(7,  'techbro_chen', @pwd, 'chen@qq.com',        '13800010005', CONCAT('https://i.pravatar.cc/200?u=techbro'),    '老陈搞机',     '电子工程专业，对各种电子产品了如指掌',         1, 'user', 99,  1, NOW()),
(8,  'sophia_wang', @pwd, 'sophia@sina.com',     '13800010006', CONCAT('https://i.pravatar.cc/200?u=sophia'),     'Sophia学姐',   '研二学姐，出清宿舍闲置物美价廉',               2, 'user', 96,  1, NOW()),
(9,  'bookworm_zhao', @pwd, 'zhao@campus.edu.cn','13800010007', CONCAT('https://i.pravatar.cc/200?u=bookworm'),   '书虫小赵',     '爱读书也爱分享，定期清理书架',                 1, 'user', 90,  1, NOW()),
(10, 'outdoor_fan', @pwd, 'outdoor@qq.com',      '13800010008', CONCAT('https://i.pravatar.cc/200?u=outdoor'),    '户外探险家',   '登山露营爱好者，装备党一枚',                   1, 'user', 93,  1, NOW()),
(11, 'yuki_style', @pwd, 'yuki@163.com',         '13800010009', CONCAT('https://i.pravatar.cc/200?u=yuki'),       'Yuki的衣橱',   '日系穿搭博主，衣服太多穿不过来啦',             2, 'user', 97,  1, NOW()),
(12, 'cook_master', @pwd, 'chef@campus.edu.cn',  '13800010010', CONCAT('https://i.pravatar.cc/200?u=cook'),       '校园小厨神',   '热爱烹饪，出一些闲置厨房用品',                 1, 'user', 91,  1, NOW()),
(13, 'music_wei', @pwd, 'wei@qq.com',            '13800010011', CONCAT('https://i.pravatar.cc/200?u=musicwei'),   '韦音乐',       '音乐学院吉他手，出一些音乐设备',               1, 'user', 94,  1, NOW()),
(14, 'green_leaf', @pwd, 'green@campus.edu.cn',  '13800010012', CONCAT('https://i.pravatar.cc/200?u=greenleaf'),  '绿叶同学',     '环保主义者，喜欢二手循环利用',                 2, 'user', 89,  1, NOW()),
(15, 'photo_liu', @pwd, 'photo@qq.com',          '13800010013', CONCAT('https://i.pravatar.cc/200?u=photoliu'),   '摄影师刘',     '摄影社团成员，设备换代频繁',                   1, 'user', 95,  1, NOW()),
(16, 'dorm_queen', @pwd, 'dorm@163.com',         '13800010014', CONCAT('https://i.pravatar.cc/200?u=dormqueen'),  '宿舍女王',     '擅长收纳和装饰，宿舍好物分享',                 2, 'user', 98,  1, NOW()),
(17, 'code_monkey', @pwd, 'coder@qq.com',        '13800010015', CONCAT('https://i.pravatar.cc/200?u=codemonkey'), '码农小孙',     '软件工程专业，常年蹲实验室配设备',             1, 'user', 86,  1, NOW());

-- ============================================================
-- 商品 (216个) - 图片全部关键词匹配
-- ============================================================

-- === 手机 (12) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(7,  7, 'iPhone 14 128G 午夜色 95新', '一直戴壳贴膜屏幕无划痕，电池健康度92%，配件齐全。', 4599.00, 5999.00, '几乎全新', CONCAT(@img,'/iphone,smartphone'), 320, 45, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(7,  7, '小米13 Pro 12+256G 陶瓷白', '骁龙8Gen2处理器，徕卡光学镜头，120W快充。边框有一处小磕碰。', 3299.00, 4999.00, '轻微使用痕迹', CONCAT(@img,'/xiaomi,phone'), 256, 32, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(17, 7, '华为 Mate60 Pro 雅川青', '麒麟9000S芯片，卫星通话功能，XMAGE影像系统。用了3个月。', 5299.00, 6999.00, '几乎全新', CONCAT(@img,'/huawei,smartphone'), 198, 28, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(3,  7, 'vivo X100 Pro 星迹蓝 拍照旗舰', '天玑9300，蔡司APO超级长焦，拍照效果惊艳。', 3699.00, 4999.00, '几乎全新', CONCAT(@img,'/vivo,phone,camera'), 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(8,  7, 'OPPO Find X7 Ultra 海阔天空', '1英寸大底主摄，双潜望长焦，哈苏人像。', 4099.00, 5999.00, '轻微使用痕迹', CONCAT(@img,'/oppo,smartphone'), 178, 22, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(7,  7, '三星 S24 Ultra 钛灰 256G', 'AI手机新体验，S Pen手写笔，2亿像素相机。', 6899.00, 9699.00, '几乎全新', CONCAT(@img,'/samsung,galaxy'), 210, 35, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(11, 7, 'iPhone 15 粉色 128G 国行', '买了不到一个月电池100%，家人送了Pro Max所以出。', 5199.00, 5999.00, '全新', CONCAT(@img,'/iphone,pink'), 289, 42, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(13, 7, '荣耀 Magic6 Pro 流云紫', '骁龙8Gen3，1.8亿潜望长焦，拍照续航都很棒。', 3899.00, 5699.00, '轻微使用痕迹', CONCAT(@img,'/honor,smartphone'), 134, 15, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(17, 7, '一加12 苍绿 16+512G', '哈苏影像+2K东方屏，性能怪兽。用了4个月。', 3099.00, 4799.00, '轻微使用痕迹', CONCAT(@img,'/oneplus,phone'), 167, 20, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(5,  7, 'iPhone 13 Pro 远峰蓝 256G', '经典A15芯片依旧流畅，ProMotion高刷屏。电池换过新的。', 3099.00, 7999.00, '明显使用痕迹', CONCAT(@img,'/iphone,apple'), 423, 56, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(6,  7, '小米14 白色 16+512G 徕卡', '小屏旗舰，6.36英寸黄金尺寸。骁龙8Gen3+徕卡三摄。', 3499.00, 4599.00, '几乎全新', CONCAT(@img,'/xiaomi,mi'), 201, 30, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(8,  7, '真我GT5 Pro 赤岩 12+256G', '性价比之王，骁龙8Gen3+IMX890潜望长焦。学生党首选。', 2599.00, 3699.00, '轻微使用痕迹', CONCAT(@img,'/realme,phone'), 312, 48, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY));

-- === 电脑 (12) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(3,  8, 'MacBook Air M2 星光色 8+256G', 'M2芯片轻薄便携续航超强。上课写作业的神器。保修到明年3月。', 6299.00, 8999.00, '几乎全新', CONCAT(@img,'/macbook,air,laptop'), 380, 52, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(7,  8, '联想小新Pro16 2024款 R7-8845H', '16寸2.5K大屏，32G+1TB。做毕设买的现在用不到了。', 4799.00, 6499.00, '几乎全新', CONCAT(@img,'/lenovo,laptop'), 245, 33, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(17, 8, 'ThinkPad X1 Carbon Gen11 i7版', '商务轻薄本标杆，14寸OLED屏。键盘手感一流。', 5499.00, 9999.00, '轻微使用痕迹', CONCAT(@img,'/thinkpad,laptop'), 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(3,  8, '华为 MateBook X Pro 2024', '3.1K OLED全面屏，微绒金属机身。颜值性能兼备。', 7299.00, 10999.00, '几乎全新', CONCAT(@img,'/matebook,huawei'), 267, 38, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(8,  8, 'MacBook Pro 14 M3 Pro 18+512G', '深空黑色，M3 Pro芯片性能强劲。视频剪辑编程无压力。', 11999.00, 16999.00, '几乎全新', CONCAT(@img,'/macbook,pro,apple'), 156, 21, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(6,  8, '华硕天选5 Pro 锐龙版 R9', 'RTX4060独显，16寸2.5K高刷屏。游戏开发两不误。', 6299.00, 8499.00, '轻微使用痕迹', CONCAT(@img,'/asus,gaming,laptop'), 432, 61, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(12, 8, 'ROG 魔霸新锐 2024 i9-14900HX', 'RTX4060满血版，240Hz电竞屏。因考研出掉。', 7499.00, 9999.00, '几乎全新', CONCAT(@img,'/rog,gaming,laptop'), 389, 54, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(9,  8, '惠普战66六代 锐龙版 15寸', 'R5-7530U+16G+1TB，稳定可靠的商务本。', 2299.00, 3999.00, '轻微使用痕迹', CONCAT(@img,'/hp,laptop'), 167, 19, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(4,  8, '戴尔灵越16 Plus i7-13700H', '16寸3K屏，32G+1TB，RTX3050。屏幕效果惊艳。', 4999.00, 7299.00, '轻微使用痕迹', CONCAT(@img,'/dell,laptop,computer'), 134, 16, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(10, 8, 'MacBook Air M1 8+256G 深空灰', '经典M1芯片，日常办公续航一天半。有点磕碰。', 3299.00, 7999.00, '明显使用痕迹', CONCAT(@img,'/macbook,computer'), 534, 72, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(13, 8, '小米笔记本Pro 16 2024 OLED', '3.1K OLED大师屏，CNC一体精雕工艺。颜值党必备。', 5399.00, 6999.00, '几乎全新', CONCAT(@img,'/xiaomi,laptop'), 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(5,  8, '机械革命 极光Pro i7-13620H', 'RTX4060独显，2.5K 165Hz屏。性价比游戏本。', 4699.00, 6499.00, '轻微使用痕迹', CONCAT(@img,'/gaming,laptop,computer'), 298, 41, '在售', DATE_SUB(NOW(), INTERVAL 15 DAY));

-- === 平板 (10) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(5,  9, 'iPad Air M2 11英寸 紫色 128G', 'M2芯片带笔和妙控键盘，记笔记神器。用了不到两个月。', 4299.00, 5499.00, '几乎全新', CONCAT(@img,'/ipad,air,tablet'), 267, 38, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(9,  9, 'iPad Pro 2022 M2 12.9寸 256G', 'Mini-LED屏幕影音体验无敌。附带二代Apple Pencil。', 6199.00, 9299.00, '轻微使用痕迹', CONCAT(@img,'/ipad,pro,apple'), 189, 25, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(3,  9, '华为 MatePad Pro 13.2 2024', 'OLED柔性屏，搭配星闪手写笔绘画体验一流。', 3899.00, 5299.00, '几乎全新', CONCAT(@img,'/matepad,huawei,tablet'), 145, 20, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(14, 9, '小米平板6S Pro 12.4寸 8+256G', '骁龙8Gen2，144Hz高刷屏。看电影打游戏都很爽。', 2199.00, 3299.00, '轻微使用痕迹', CONCAT(@img,'/xiaomi,pad,tablet'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(4,  9, 'iPad mini 6 64G 星光色', '小钢炮A15芯片，便携阅读和游戏神器。', 2199.00, 3799.00, '轻微使用痕迹', CONCAT(@img,'/ipad,mini'), 312, 44, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(8,  9, '三星 Tab S9 FE+ 12.4寸', 'S Pen手写体验极佳，防水防尘。适合上课看PDF。', 2299.00, 3499.00, '几乎全新', CONCAT(@img,'/samsung,galaxy,tab'), 123, 16, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(11, 9, 'vivo Pad3 Pro 天玑9300', '13寸巨幕3.1K分辨率。买来刷剧用的。', 2599.00, 3499.00, '几乎全新', CONCAT(@img,'/vivo,pad,tablet'), 156, 19, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(7,  9, '一加Pad 天玑8350 8+128G', '轻巧便携ColorOS流畅，影音娱乐平板黑马。', 1699.00, 2399.00, '轻微使用痕迹', CONCAT(@img,'/oneplus,tablet'), 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(12, 9, 'OPPO Pad 2 天玑9000 8+256G', '7:5黄金比例屏幕阅读文档超舒服。送官方磁吸壳。', 1799.00, 2699.00, '轻微使用痕迹', CONCAT(@img,'/oppo,tablet,pad'), 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(16, 9, '联想拯救者Y700 2024 8.8寸', '骁龙8Gen2小尺寸游戏平板之王。吃鸡原神流畅运行。', 1999.00, 2799.00, '几乎全新', CONCAT(@img,'/lenovo,gaming,tablet'), 289, 40, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- === 耳机 (10) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(13, 10, 'AirPods Pro 2代 USB-C版', '降噪效果惊艳，通透模式自然。用了三个月耳塞换过新的。', 1299.00, 1899.00, '轻微使用痕迹', CONCAT(@img,'/airpods,pro,earphone'), 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(3,  10, '索尼 WH-1000XM5 头戴降噪 黑色', '旗舰级降噪音质细腻。出行必备配件齐全含收纳盒。', 1699.00, 2999.00, '几乎全新', CONCAT(@img,'/sony,headphones,wh1000xm5'), 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(7,  10, 'Bose QC45 消噪耳机 白色', '佩戴舒适降噪自然。适合长时间佩戴学习使用。', 1099.00, 2299.00, '轻微使用痕迹', CONCAT(@img,'/bose,headphones,quietcomfort'), 267, 35, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(11, 10, '华为 FreeBuds Pro 3 雅丹黑', '星闪连接+空间音频。鸿蒙生态绝配，通话降噪清晰。', 799.00, 1299.00, '几乎全新', CONCAT(@img,'/huawei,freebuds,earbuds'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(5,  10, '三星 Galaxy Buds3 Pro 银色', 'AKG调音，360空间音频。配合三星手机体验最佳。', 899.00, 1499.00, '几乎全新', CONCAT(@img,'/samsung,galaxy,buds'), 178, 23, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(6,  10, 'Beats Studio Pro 深棕色', '苹果生态无缝切换，颜值在线出街神器。', 1299.00, 2899.00, '轻微使用痕迹', CONCAT(@img,'/beats,studio,headphones'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(9,  10, '小米 Buds 4 Pro 星耀金', '空间音频+LDAC高清传输。性价比超高的旗舰TWS。', 499.00, 999.00, '轻微使用痕迹', CONCAT(@img,'/xiaomi,buds,earbuds'), 389, 52, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(14, 10, 'JBL TUNE 770NC 蓝牙降噪', '纯正低频70小时超长续航。学生党首选头戴降噪耳机。', 299.00, 599.00, '几乎全新', CONCAT(@img,'/jbl,headphones,bluetooth'), 445, 63, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(8,  10, '漫步者 NeoBuds Pro 2 黑色', 'Hi-Res金标认证+空间音频。国产旗舰TWS音质超预期。', 499.00, 899.00, '轻微使用痕迹', CONCAT(@img,'/edifier,earbuds,bluetooth'), 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(10, 10, '森海塞尔 Momentum 4 无线降噪', '发烧友级音质自适应降噪。60小时续航皮质耳罩超舒适。', 1499.00, 2699.00, '轻微使用痕迹', CONCAT(@img,'/sennheiser,momentum,headphones'), 156, 20, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY));

-- === 相机 (6) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(15, 11, '索尼 A7M4 全画幅微单机身', '3300万像素对焦精准，快门数约8000。带原厂电池充电器。', 11999.00, 16999.00, '轻微使用痕迹', CONCAT(@img,'/sony,a7,alpha,camera'), 234, 33, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5,  11, '富士 X-T5 银色 18-55mm套机', '4020万像素APS-C画质天花板，胶片模拟直出好看。', 8999.00, 13999.00, '轻微使用痕迹', CONCAT(@img,'/fujifilm,xt5,camera'), 189, 27, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(15, 11, '佳能 EOS R6 Mark II 套机', '2420万像素全画幅，对焦速度超快。含24-105 STM镜头。', 13999.00, 18999.00, '几乎全新', CONCAT(@img,'/canon,eos,r6,camera'), 145, 19, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(3,  11, '大疆 Pocket 3 灵眸口袋云台', '1英寸CMOS三轴云台防抖。vlog神器出片率超高。', 2399.00, 3499.00, '几乎全新', CONCAT(@img,'/dji,pocket,camera,gimbal'), 312, 45, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(11, 11, 'Insta360 X4 全景运动相机', '8K全景视频360度记录。滑雪冲浪必备配件齐全。', 2599.00, 3499.00, '几乎全新', CONCAT(@img,'/insta360,action,camera'), 198, 28, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(13, 11, '索尼 ZV-E10 II 微单vlog相机', 'APS-C画幅AI自动构图。美颜直出适合自媒体创作。', 4299.00, 5999.00, '几乎全新', CONCAT(@img,'/sony,zve10,camera,vlog'), 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY));

-- === 配件 (12) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(7,  12, 'Anker 737 移动电源 24000mAh', '140W双向快充可充笔记本。出差旅行一个搞定所有设备。', 399.00, 699.00, '轻微使用痕迹', CONCAT(@img,'/anker,powerbank,charger'), 534, 72, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(3,  12, '罗技 MX Master 3S 无线鼠标', '人体工学旗舰电磁滚轮超顺滑。静音按键图书馆友好。', 349.00, 699.00, '轻微使用痕迹', CONCAT(@img,'/logitech,mx,master,mouse'), 423, 56, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(17, 12, 'Keychron K8 Pro 机械键盘 茶轴', '75%配列QMK固件热插拔。编程打字两相宜。', 329.00, 588.00, '轻微使用痕迹', CONCAT(@img,'/keychron,mechanical,keyboard'), 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(8,  12, 'Type-C 扩展坞 12合1', 'HDMI 4K60Hz+千兆网口+SD卡+USB3.0。MacBook好搭档。', 129.00, 259.00, '几乎全新', CONCAT(@img,'/usb,hub,dock,adapter'), 389, 51, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(5,  12, '绿联 氮化镓充电器 100W 4口', '三口C口+一口A口快充全兼容。桌面一个搞定所有充电。', 89.00, 169.00, '几乎全新', CONCAT(@img,'/gan,charger,adapter'), 456, 63, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(14, 12, '罗技 C920 Pro 网络摄像头', '1080P高清自动对焦。上网课面试必备。', 199.00, 399.00, '轻微使用痕迹', CONCAT(@img,'/logitech,webcam,camera'), 278, 35, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(12, 12, '显示器支架 双屏 桌面款', '承重8kg气压弹簧调节。拯救颈椎桌面改造利器。', 149.00, 299.00, '几乎全新', CONCAT(@img,'/monitor,arm,stand,desk'), 198, 25, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(9,  12, '西数 SN770 1TB NVMe SSD', 'PCIe 4.0读速5150MB/s。升级电脑存储空间。', 399.00, 599.00, '几乎全新', CONCAT(@img,'/ssd,nvme,storage'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(6,  12, 'Apple Magic Trackpad 触控板', '苹果原装触控板Mac绝配。二代支持Force Touch。', 499.00, 899.00, '轻微使用痕迹', CONCAT(@img,'/apple,magic,trackpad'), 167, 21, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(16, 12, '小米照片打印机 1S 套装', '手机直连打印色彩还原好。含2盒相纸共80张。', 399.00, 699.00, '轻微使用痕迹', CONCAT(@img,'/xiaomi,photo,printer'), 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(4,  12, 'USB-C 数据线 100W快充 3条装', '品牌编织线2米长，耐用不缠绕。宿舍教室各扔一条。', 29.00, 79.00, '全新', CONCAT(@img,'/usb,cable,charger'), 589, 78, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(10, 12, 'PITAKA 磁吸手机壳 iPhone 15 Pro', '芳纶纤维材质超轻薄。磁吸牢固手感一流。', 89.00, 199.00, '轻微使用痕迹', CONCAT(@img,'/iphone,case,magsafe'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- ============================================================
-- More products continued...
-- ============================================================
-- ============================================================
-- 转转种子数据 Part 2: 教材教辅、文学小说、科技科普、考试资料
-- ============================================================
USE `zhuanzhuan`;
SET @img = 'https://loremflickr.com/640/480';

-- === 教材教辅 (15) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(4, 13, '《数据结构(C语言版)》严蔚敏 全新', '计算机考研必备教材，买多了没用过，全新塑封未拆。', 25.00, 39.00, '全新', CONCAT(@img,'/textbook,computer,science'), 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(9, 13, '《高等数学》(第七版) 同济大学 上下册', '考研数学一必备用书，笔记工整整洁。', 35.00, 72.00, '轻微使用痕迹', CONCAT(@img,'/math,textbook,calculus'), 423, 56, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(3, 13, '《计算机网络：自顶向下》第七版', '经典教材中文版，计算机专业必修。有些标注不影响阅读。', 45.00, 89.00, '轻微使用痕迹', CONCAT(@img,'/network,computer,textbook'), 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(9, 13, '《算法导论》(CLRS) 第三版 英文影印', '算法圣经学算法必读。书角有磨损但内页完好。', 55.00, 128.00, '明显使用痕迹', CONCAT(@img,'/algorithm,textbook,computer'), 189, 25, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(4, 13, '《线性代数及其应用》David C. Lay', '经典线代教材考研复习用。例题讲解清晰易懂。', 28.00, 55.00, '轻微使用痕迹', CONCAT(@img,'/linear,algebra,math,textbook'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(8, 13, '《操作系统概念》第九版 恐龙书', '操作系统经典教材。考研408必读。', 40.00, 79.00, '轻微使用痕迹', CONCAT(@img,'/operating,system,textbook'), 178, 23, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(14, 13, '《概率论与数理统计》浙大第四版', '考研数学经典教材，例题全面覆盖考点。', 20.00, 45.00, '轻微使用痕迹', CONCAT(@img,'/probability,statistics,textbook'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(3, 13, '《深入理解计算机系统》(CSAPP) 第三版', '程序员必读神书CMU经典教材。英文原版。', 68.00, 139.00, '轻微使用痕迹', CONCAT(@img,'/csapp,computer,textbook'), 145, 19, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(9, 13, '《编译原理》(龙书) 第二版', '编译技术经典教材。考研408备考需要。', 50.00, 89.00, '轻微使用痕迹', CONCAT(@img,'/compiler,dragon,book'), 98, 12, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(4, 13, '《C++ Primer Plus》第6版 中文', 'C++入门经典内容详实。书角有一点折痕。', 45.00, 99.00, '轻微使用痕迹', CONCAT(@img,'/c++,programming,textbook'), 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(12, 13, '《大学物理》(上下册) 马文蔚', '理工科基础课教材。书中有笔记但很工整。', 30.00, 68.00, '明显使用痕迹', CONCAT(@img,'/physics,textbook,university'), 134, 16, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(11, 13, '《新概念英语3+4》 全新套装', '四六级备考神器。买来没翻开过...', 35.00, 78.00, '全新', CONCAT(@img,'/english,textbook,new,concept'), 278, 37, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY)),
(6, 13, '《信号与系统》郑君里 第三版', '电子信息类经典教材考研必备。', 30.00, 56.00, '轻微使用痕迹', CONCAT(@img,'/signal,system,engineering,textbook'), 156, 20, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(16, 13, '《Python编程：从入门到实践》第3版', 'Python入门最佳教程。书很新代码部分有标注。', 35.00, 69.00, '轻微使用痕迹', CONCAT(@img,'/python,programming,book'), 389, 52, '在售', DATE_SUB(NOW(), INTERVAL 15 DAY)),
(10, 13, '《数字电子技术基础》阎石 第六版', '电子类必修课教材。有笔记但整洁。', 25.00, 49.00, '轻微使用痕迹', CONCAT(@img,'/electronics,digital,textbook'), 112, 14, '在售', DATE_SUB(NOW(), INTERVAL 16 DAY));

-- === 文学小说 (15) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(4, 14, '《三体》全套三册 刘慈欣', '科幻神作值得反复阅读。书角有轻微磨损不影响阅读。', 45.00, 93.00, '轻微使用痕迹', CONCAT(@img,'/science,fiction,novel,book'), 567, 78, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(9, 14, '《百年孤独》加西亚·马尔克斯', '魔幻现实主义经典，范晔译本。书很新。', 28.00, 55.00, '几乎全新', CONCAT(@img,'/novel,literature,classic,book'), 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5, 14, '《活着》余华 精装版', '余华代表作看哭了好几次。精装硬皮版。', 18.00, 35.00, '轻微使用痕迹', CONCAT(@img,'/chinese,novel,living,book'), 423, 56, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(11, 14, '《月亮与六便士》毛姆', '理想与现实的抉择，中英文双语版。', 22.00, 42.00, '几乎全新', CONCAT(@img,'/maugham,moon,novel'), 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(4, 14, '《1984》乔治·奥威尔 英文原版', '反乌托邦经典适合英语学习。', 19.00, 38.00, '轻微使用痕迹', CONCAT(@img,'/1984,orwell,book,novel'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(8, 14, '《围城》钱钟书 经典版', '中国现代文学经典之作。封面有点旧但内容完整。', 15.00, 29.80, '明显使用痕迹', CONCAT(@img,'/fortress,besieged,chinese,novel'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(14, 14, '《追风筝的人》卡勒德·胡赛尼', '全球畅销书为你千千万万遍。', 20.00, 39.00, '轻微使用痕迹', CONCAT(@img,'/kite,runner,novel,afghanistan'), 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(6, 14, '《挪威的森林》村上春树', '村上春树代表作青春爱情经典。', 16.00, 32.00, '轻微使用痕迹', CONCAT(@img,'/murakami,norwegian,wood,novel'), 289, 38, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(16, 14, '《小王子》中英法三语精装版', '永恒的童话经典！三语对照装帧精美。', 25.00, 49.00, '几乎全新', CONCAT(@img,'/little,prince,book,french'), 378, 51, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(10, 14, '《杀死一只知更鸟》哈珀·李', '关于勇气与正义的经典之作。', 18.00, 35.00, '轻微使用痕迹', CONCAT(@img,'/mockingbird,novel,classic'), 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(3, 14, '《人类简史》尤瓦尔·赫拉利', '重新认识人类文明发展史。', 30.00, 68.00, '轻微使用痕迹', CONCAT(@img,'/sapiens,history,book,bestseller'), 456, 62, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(12, 14, '《局外人》加缪 新版译本', '存在主义文学经典哲学入门推荐。', 12.00, 25.00, '轻微使用痕迹', CONCAT(@img,'/camus,stranger,novel,french'), 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY)),
(5, 14, '《平凡的世界》路遥 全三册', '茅盾文学奖作品写尽普通人不平凡的人生。', 42.00, 89.00, '轻微使用痕迹', CONCAT(@img,'/chinese,novel,ordinary,world'), 234, 30, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(9, 14, '《岛上书店》加·泽文', '温暖治愈的阅读故事。没有谁是一座孤岛。', 18.00, 35.00, '几乎全新', CONCAT(@img,'/bookstore,novel,island'), 178, 23, '在售', DATE_SUB(NOW(), INTERVAL 15 DAY)),
(4, 14, '《苏菲的世界》乔斯坦·贾德', '哲学入门小说故事生动有趣。', 22.00, 45.00, '轻微使用痕迹', CONCAT(@img,'/sophie,world,philosophy,novel'), 156, 20, '在售', DATE_SUB(NOW(), INTERVAL 17 DAY));

-- === 科技科普 (8) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(7, 15, '《上帝掷骰子吗》量子物理史话', '通俗易懂的量子物理科普豆瓣9.2分神作。', 25.00, 45.00, '轻微使用痕迹', CONCAT(@img,'/quantum,physics,book,science'), 423, 56, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(3, 15, '《从一到无穷大》G.伽莫夫', '经典科普名著培养科学思维的好书。', 28.00, 45.00, '轻微使用痕迹', CONCAT(@img,'/science,mathematics,popular,book'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(9, 15, '《时间简史》霍金 插图版', '霍金代表作宇宙学科普必读。全彩插图版。', 35.00, 68.00, '轻微使用痕迹', CONCAT(@img,'/hawking,brief,history,time'), 267, 35, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(17, 15, '《代码整洁之道》Robert C. Martin', '程序员进阶必读提升代码质量的经典。', 35.00, 59.00, '轻微使用痕迹', CONCAT(@img,'/clean,code,programming,book'), 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(6, 15, '《万物简史》比尔·布莱森', '妙趣横生的自然科学百科全书。', 30.00, 49.00, '几乎全新', CONCAT(@img,'/science,history,everything,book'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(14, 15, '《自私的基因》理查德·道金斯', '进化生物学经典颠覆你的世界观。', 22.00, 39.00, '轻微使用痕迹', CONCAT(@img,'/selfish,gene,evolution,book'), 178, 23, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(4, 15, '《思考，快与慢》丹尼尔·卡尼曼', '诺贝尔经济学奖得主著作行为经济学入门。', 32.00, 59.00, '轻微使用痕迹', CONCAT(@img,'/thinking,fast,slow,psychology'), 289, 38, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(10, 15, '《枪炮、病菌与钢铁》戴蒙德', '人类社会发展史的宏大叙事。', 28.00, 55.00, '轻微使用痕迹', CONCAT(@img,'/guns,germs,steel,history'), 156, 20, '在售', DATE_SUB(NOW(), INTERVAL 16 DAY));

-- === 考试资料 (12) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(3, 16, '考研数学一 张宇36讲 全新未拆', '2025最新版考研数学一全套，买错了出掉。', 55.00, 108.00, '全新', CONCAT(@img,'/exam,math,study,book'), 398, 54, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(8, 16, '考研英语 历年真题详解 2025版', '黄皮书英语一真题2005-2024全套。', 35.00, 76.00, '轻微使用痕迹', CONCAT(@img,'/english,exam,test,book'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(4, 16, '考研政治 肖秀荣1000题+精讲精练', '2025肖秀荣全套少量题目有铅笔痕迹。', 45.00, 98.00, '轻微使用痕迹', CONCAT(@img,'/politics,exam,study,book'), 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(9, 16, '计算机408考研 王道四本套装', '数据结构+组成原理+操作系统+计算机网络。', 60.00, 128.00, '轻微使用痕迹', CONCAT(@img,'/computer,science,exam,study'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(6, 16, '英语六级 星火真题 2024新版', '含10套真题+听力音频。有些做题痕迹。', 12.00, 32.00, '轻微使用痕迹', CONCAT(@img,'/cet6,english,exam,test'), 198, 25, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(12, 16, 'GRE词汇精选 红宝书 乱序版', '考G必备背完这本词汇量暴增。', 25.00, 58.00, '明显使用痕迹', CONCAT(@img,'/gre,vocabulary,exam,book'), 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(14, 16, '公务员考试 行测+申论 中公套装', '国考省考通用题型全面。去年买的没怎么看...', 40.00, 96.00, '几乎全新', CONCAT(@img,'/civil,service,exam,book'), 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(3, 16, '托福 官方指南+TPO真题', '托福备考全套含OG和TPO30-70。', 55.00, 118.00, '轻微使用痕迹', CONCAT(@img,'/toefl,english,exam,preparation'), 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(10, 16, '法考 客观题资料包', '瑞达法考全套讲义+真题法学专业必备。', 65.00, 138.00, '轻微使用痕迹', CONCAT(@img,'/law,exam,bar,study'), 112, 14, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(11, 16, '日语N2备考 红蓝宝书+真题', '标日N2语法+词汇+历年真题。学日语的来。', 35.00, 78.00, '轻微使用痕迹', CONCAT(@img,'/japanese,jlpt,exam,study'), 134, 16, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(16, 16, '教师资格证 综合素质+教育知识', '中公教育教材+真题考教资必备。', 28.00, 68.00, '几乎全新', CONCAT(@img,'/teacher,certificate,exam,book'), 156, 21, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(5, 16, '雅思 剑桥真题4-18全套', 'IELTS备考套装含解析和音频。', 65.00, 138.00, '轻微使用痕迹', CONCAT(@img,'/ielts,english,exam,preparation'), 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));
-- ============================================================
-- 转转种子数据 Part 3: 生活用品、服饰鞋包、运动户外、其他
-- ============================================================
USE `zhuanzhuan`;
SET @img = 'https://loremflickr.com/640/480';

-- === 宿舍用品 (14) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(16, 17, '宿舍迷你小冰箱 15L 冷暖两用', '夏天冰饮料冬天热牛奶宿舍神器。功率低不跳闸。', 129.00, 299.00, '轻微使用痕迹', CONCAT(@img,'/mini,fridge,dorm,refrigerator'), 534, 75, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(14, 17, '可折叠收纳箱 66L 大号 3个装', '衣物杂物收纳神器可折叠不占地方。', 35.00, 69.00, '轻微使用痕迹', CONCAT(@img,'/storage,box,organizer,plastic'), 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5,  17, '寝室台灯 LED护眼 三档调光', '无频闪护眼台灯长臂调节。有夹子和底座两种安装。', 49.00, 99.00, '几乎全新', CONCAT(@img,'/desk,lamp,led,study'), 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(12, 17, '电热水壶 1.7L 304不锈钢', '快速烧水自动断电。宿舍必备泡面神器。', 25.00, 59.00, '轻微使用痕迹', CONCAT(@img,'/electric,kettle,kitchen'), 278, 36, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(16, 17, '宿舍床帘 遮光+防蚊 三件套', '一体式床帘私密空间必备。女生宿舍人手一个。', 45.00, 89.00, '轻微使用痕迹', CONCAT(@img,'/bed,curtain,dorm,privacy'), 389, 53, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(8,  17, '加湿器 超声波静音 2.5L', '冬天开空调必备静音加湿不打扰睡眠。', 39.00, 79.00, '轻微使用痕迹', CONCAT(@img,'/humidifier,ultrasonic,bedroom'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(14, 17, '床上懒人桌 可升降折叠', '笔记本桌+零食桌冬天被窝办公神器。', 35.00, 68.00, '轻微使用痕迹', CONCAT(@img,'/laptop,bed,table,foldable'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(15, 17, '桌面书架 多层置物架 白色', '木质桌面书架承重力强。让桌面整洁有序。', 30.00, 59.00, '轻微使用痕迹', CONCAT(@img,'/desk,shelf,organizer,wood'), 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(11, 17, '衣柜除湿挂袋 10个装', '宿舍衣柜防潮必备南方必备神器。未拆封。', 8.00, 19.00, '全新', CONCAT(@img,'/dehumidifier,closet,bag'), 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(16, 17, '宿舍地毯 50x80cm 灰色', '脚垫地毯冬天踩上去暖暖的。可水洗。', 18.00, 39.00, '轻微使用痕迹', CONCAT(@img,'/rug,carpet,dorm,room'), 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(9,  17, '插排 6位+3USB 防雷击', '独立开关+安全门宿舍用电安全第一。', 22.00, 45.00, '轻微使用痕迹', CONCAT(@img,'/power,strip,surge,protector'), 267, 35, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(7,  17, '迷你投影仪 便携版 支持投屏', '周末宿舍看电影神器白墙即可投影。', 169.00, 399.00, '轻微使用痕迹', CONCAT(@img,'/mini,projector,portable,movie'), 456, 62, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY)),
(4,  17, '电蚊拍 充电式 三层网', '夏季灭蚊神器充电一次用一周。', 15.00, 29.00, '几乎全新', CONCAT(@img,'/electric,fly,swatter,mosquito'), 178, 23, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(10, 17, '宿舍挂烫机 手持便携', '小巧不占地除皱效果好。面试前熨一下衬衫。', 49.00, 99.00, '轻微使用痕迹', CONCAT(@img,'/garment,steamer,handheld,portable'), 134, 16, '在售', DATE_SUB(NOW(), INTERVAL 15 DAY));

-- === 厨房电器 (8) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(12, 18, '美的电饭煲 3L 智能预约', '宿舍小厨房必备智能预约煮饭煲汤。内胆完好不粘。', 89.00, 199.00, '轻微使用痕迹', CONCAT(@img,'/rice,cooker,electric,kitchen'), 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(8,  18, '小熊空气炸锅 3.5L 可视化', '无油健康烹饪炸鸡薯条样样行。可视窗口观察食物。', 129.00, 299.00, '轻微使用痕迹', CONCAT(@img,'/air,fryer,kitchen,cooking'), 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(16, 18, '九阳豆浆机 600ml 预约款', '早起一杯热豆浆/米糊。免过滤设计清洗方便。', 79.00, 199.00, '轻微使用痕迹', CONCAT(@img,'/soy,milk,maker,kitchen'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(14, 18, '小米电磁炉 青春版 2100W', 'OLED旋钮控温精准火候。配平底锅一个。', 99.00, 229.00, '轻微使用痕迹', CONCAT(@img,'/induction,cooker,kitchen'), 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(12, 18, '便携榨汁杯 无线充电款', '30秒鲜榨果汁无线充电。夏天必备。', 39.00, 89.00, '几乎全新', CONCAT(@img,'/portable,blender,juicer'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(5,  18, '烤箱 12L 迷你电烤箱', '烤面包饼干蛋挞烘焙入门神器。带烤盘烤架。', 69.00, 159.00, '轻微使用痕迹', CONCAT(@img,'/mini,oven,baking,kitchen'), 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(10, 18, '小熊酸奶机 1L 全自动', '自制酸奶健康无添加。送菌粉两包。', 25.00, 59.00, '几乎全新', CONCAT(@img,'/yogurt,maker,kitchen,appliance'), 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(3,  18, '早餐机 三明治机+华夫饼盘', '五分钟搞定三明治早餐。两面烤盘可拆卸清洗。', 49.00, 119.00, '轻微使用痕迹', CONCAT(@img,'/sandwich,maker,breakfast,waffle'), 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- === 美妆个护 (8) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(11, 19, 'SK-II 神仙水 230ml 全新未拆', '免税店购入全新未拆封。日期到2027年。', 799.00, 1590.00, '全新', CONCAT(@img,'/skincare,toner,beauty,bottle'), 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(5,  19, '戴森 卷发棒 Airwrap 全套', '美发神器卷发直发吹风三合一。用了不到五次。', 1999.00, 3699.00, '几乎全新', CONCAT(@img,'/dyson,airwrap,hair,styler'), 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(16, 19, '兰蔻 持妆粉底液 PO-01', '色号买错了只用过一次。适合白皮妹子。', 199.00, 450.00, '几乎全新', CONCAT(@img,'/lancome,foundation,makeup,cosmetic'), 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(8,  19, '雅萌 ACE五代 射频美容仪', '提拉紧致抗初老搭配凝胶使用。坚持用效果明显。', 1299.00, 2999.00, '轻微使用痕迹', CONCAT(@img,'/beauty,device,radio,frequency,skin'), 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(14, 19, 'MAC 口红套装 3支热门色', 'Chili/Ruby Woo/Marrakesh三支。Chili试过一次。', 199.00, 510.00, '轻微使用痕迹', CONCAT(@img,'/mac,lipstick,makeup,cosmetic'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(5,  19, '松下 蒸脸器 纳米离子', '补水神器蒸完脸滑滑的。冬天护肤必备。', 169.00, 399.00, '轻微使用痕迹', CONCAT(@img,'/facial,steamer,skincare,beauty'), 145, 19, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(11, 19, '香奈儿 蔚蓝男士香水 100ml', '经典的木质柑橘香调。用了不到10%的量。', 499.00, 890.00, '轻微使用痕迹', CONCAT(@img,'/chanel,bleu,perfume,fragrance'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(16, 19, '无印良品 香薰机+精油套装', '超声波静音香薰配薰衣草+甜橙精油各一瓶。', 129.00, 298.00, '轻微使用痕迹', CONCAT(@img,'/aroma,diffuser,essential,oil'), 178, 23, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- === 上衣 (12) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(11, 20, '优衣库 轻薄羽绒服 女 米色 M码', '轻暖便携可以收纳成小包。只穿了一季。', 149.00, 399.00, '轻微使用痕迹', CONCAT(@img,'/uniqlo,down,jacket,women,beige'), 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(5,  20, 'Nike 卫衣 学院风 灰色 S码', '加绒保暖版型很好看。买小了穿不了。', 99.00, 299.00, '几乎全新', CONCAT(@img,'/nike,hoodie,sweatshirt,grey'), 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(8,  20, 'ZARA 西装外套 女 黑色 M码', '垂感面料有质感面试通勤都可以。只穿过两次。', 169.00, 499.00, '几乎全新', CONCAT(@img,'/zara,blazer,jacket,women,black'), 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(16, 20, 'Adidas 三叶草 T恤 白色 L码', '经典三叶草logo纯棉舒适。发现风格不适合。', 59.00, 199.00, '轻微使用痕迹', CONCAT(@img,'/adidas,originals,tshirt,white'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(6,  20, 'Patagonia 抓绒衣 男 蓝色 L码', '环保面料保暖透气户外活动必备。', 199.00, 599.00, '轻微使用痕迹', CONCAT(@img,'/patagonia,fleece,jacket,blue'), 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(11, 20, 'UR 针织开衫 杏色 M码', '软糯舒适适合春秋穿搭。只穿过一次不喜欢了。', 89.00, 269.00, '几乎全新', CONCAT(@img,'/knit,cardigan,women,beige'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(9,  20, 'Champion 卫衣 反转logo 黑色 L码', '美版宽松版型加绒很厚实。洗过一次没缩水。', 79.00, 239.00, '轻微使用痕迹', CONCAT(@img,'/champion,hoodie,sweatshirt,black'), 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(14, 20, 'H&M 长款风衣 卡其色 S码', '经典英伦风春天穿超有气质。', 129.00, 399.00, '轻微使用痕迹', CONCAT(@img,'/trench,coat,women,khaki'), 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(10, 20, '北面 冲锋衣 男 黑色 XL码', 'Gore-Tex防水透气防风性能一流。户外登山必备。', 399.00, 1299.00, '轻微使用痕迹', CONCAT(@img,'/northface,jacket,outdoor,black'), 289, 39, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(5,  20, 'Lee 牛仔外套 复古蓝 M码', '经典牛仔外套永不过时。颜色越穿越自然。', 169.00, 499.00, '轻微使用痕迹', CONCAT(@img,'/lee,denim,jacket,vintage,blue'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(12, 20, '优衣库 摇粒绒外套 男 深灰 L码', '优衣库经典款轻暖舒适。洗过两次。', 49.00, 149.00, '轻微使用痕迹', CONCAT(@img,'/uniqlo,fleece,jacket,grey'), 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(7,  20, 'Arcteryx 始祖鸟 速干T恤 男 M码', '顶级户外品牌速干面料夏天运动穿超爽。', 199.00, 599.00, '轻微使用痕迹', CONCAT(@img,'/arcteryx,shirt,quick,dry,outdoor'), 156, 20, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- === 裤装 (8) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(5,  21, 'Levi''s 501 经典直筒牛仔裤 28码', '经典501版型中腰直筒显腿长。穿了几次洗过一水。', 299.00, 799.00, '轻微使用痕迹', CONCAT(@img,'/levis,501,jeans,denim'), 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(11, 21, 'ZARA 阔腿裤 女 黑色 S码', '垂感面料高级感十足通勤必备。只穿过一次。', 99.00, 299.00, '几乎全新', CONCAT(@img,'/wide,leg,pants,women,black'), 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(6,  21, 'Nike 运动长裤 Dri-FIT 男 灰 L码', '速干面料运动穿着舒适。健身房常备。', 89.00, 249.00, '轻微使用痕迹', CONCAT(@img,'/nike,jogger,pants,sport,grey'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(8,  21, '优衣库 弹力九分裤 女 藏青 M码', '弹力面料舒适不紧绷上班上课都合适。', 69.00, 199.00, '轻微使用痕迹', CONCAT(@img,'/uniqlo,ankle,pants,women,navy'), 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(16, 21, 'HM 牛仔短裤 浅蓝色 27码', '夏天百搭牛仔短裤高腰显腿长。', 39.00, 119.00, '轻微使用痕迹', CONCAT(@img,'/denim,shorts,women,blue'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(4,  21, '迪卡侬 户外速干裤 男 卡其 L码', '可拆卸裤腿变短裤户外神器。', 69.00, 179.00, '轻微使用痕迹', CONCAT(@img,'/decathlon,hiking,pants,khaki'), 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(12, 21, 'GAP 休闲卡其裤 男 深卡其 32码', '经典卡其裤配什么上衣都好看。', 79.00, 229.00, '轻微使用痕迹', CONCAT(@img,'/gap,chino,pants,khaki'), 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(14, 21, '太平鸟 百褶短裙 女 S码', '日系学院风百褶短裙穿起来很元气。', 59.00, 169.00, '几乎全新', CONCAT(@img,'/pleated,skirt,women,school'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- === 鞋类 (10) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(6,  22, 'Nike Air Force 1 小白鞋 42码', '经典AF1百搭神器。有正常穿着痕迹。', 299.00, 799.00, '轻微使用痕迹', CONCAT(@img,'/nike,air,force,white,sneaker'), 534, 72, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(11, 22, 'Adidas Samba OG 德训鞋 37码', '复古德训鞋颜值在线。穿了不到十次。', 399.00, 799.00, '轻微使用痕迹', CONCAT(@img,'/adidas,samba,sneaker,retro'), 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(10, 22, 'New Balance 2002R 元祖灰 41.5码', '老爹鞋天花板脚感无敌。', 599.00, 1199.00, '几乎全新', CONCAT(@img,'/newbalance,2002r,sneaker,grey'), 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(5,  22, '匡威 Chuck 70 高帮 黑色 39码', '经典帆布鞋怎么搭都好看。鞋头有正常磨损。', 199.00, 569.00, '轻微使用痕迹', CONCAT(@img,'/converse,chuck,taylor,black,high'), 278, 37, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(14, 22, 'UGG 短筒雪地靴 栗色 38码', '冬天神器超级保暖。只在去年穿了一季。', 299.00, 899.00, '轻微使用痕迹', CONCAT(@img,'/ugg,boots,winter,chestnut'), 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(6,  22, 'Nike Pegasus 40 跑鞋 42码', '专业缓震跑鞋跑了大概100公里左右。', 349.00, 899.00, '轻微使用痕迹', CONCAT(@img,'/nike,pegasus,running,shoe'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(11, 22, 'Dr. Martens 1460 八孔马丁靴 37码', '经典马丁靴越穿越好看。已经穿软了不磨脚。', 499.00, 1399.00, '轻微使用痕迹', CONCAT(@img,'/doc,martens,boots,black,leather'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(4,  22, 'Crocs 洞洞鞋 经典款 43码', '夏天拖鞋神器穿起来超舒服。', 89.00, 269.00, '轻微使用痕迹', CONCAT(@img,'/crocs,clogs,sandal,summer'), 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(8,  22, 'Asics Gel-Kayano 29 稳定跑鞋 39码', '顶级稳定系跑鞋适合扁平足外翻脚型。', 499.00, 1299.00, '轻微使用痕迹', CONCAT(@img,'/asics,kayano,running,shoe'), 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(16, 22, 'Vans Old Skool 棋盘格 38码', '经典滑板鞋棋盘格百搭。后跟有一点磨损。', 169.00, 469.00, '明显使用痕迹', CONCAT(@img,'/vans,old,skool,checkerboard'), 289, 38, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- === 箱包 (8) ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(5,  23, '小米 20寸登机箱 商务款', '静音万向轮+TSA海关锁。短途出差旅行的好伙伴。', 199.00, 399.00, '轻微使用痕迹', CONCAT(@img,'/luggage,suitcase,carry,on,travel'), 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(8,  23, 'Herschel 双肩包 经典款 黑色', '加拿大品牌笔记本电脑隔层+多口袋。上学通勤都好看。', 199.00, 599.00, '轻微使用痕迹', CONCAT(@img,'/herschel,backpack,school,bags'), 423, 56, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(11, 23, 'Longchamp 饺子包 海军蓝 中号', '法国经典托特包轻便能装。通勤上课两用。', 399.00, 1000.00, '轻微使用痕迹', CONCAT(@img,'/longchamp,tote,bag,navy,blue'), 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(3,  23, 'Samsonite 新秀丽 双肩电脑包', '商务通勤包减负背带+Tess合金拉链。15.6寸笔记本专区。', 299.00, 799.00, '轻微使用痕迹', CONCAT(@img,'/samsonite,laptop,backpack,business'), 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(14, 23, 'UR 斜挎小方包 奶油白', '通勤约会万能搭配大小刚好装手机钥匙。', 69.00, 199.00, '轻微使用痕迹', CONCAT(@img,'/crossbody,bag,women,cream,white'), 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(10, 23, 'Osprey 登山包 38L 户外徒步包', '专业户外背包背负系统舒适。', 299.00, 899.00, '轻微使用痕迹', CONCAT(@img,'/osprey,backpack,hiking,outdoor'), 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(16, 23, 'COS 帆布托特包 黑色', '极简风大容量帆布包北欧风格百搭。', 79.00, 199.00, '轻微使用痕迹', CONCAT(@img,'/canvas,tote,bag,black,minimal'), 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(6,  23, '迪卡侬 骑行背包 15L 反光条', '轻量骑行背包内置水袋仓。夜间反光安全。', 59.00, 149.00, '轻微使用痕迹', CONCAT(@img,'/cycling,backpack,hydration,outdoor'), 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY));
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
