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
