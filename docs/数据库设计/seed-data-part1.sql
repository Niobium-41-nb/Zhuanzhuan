-- ============================================================
-- 转转 - 种子数据脚本
-- 包含: 15+ 用户数据, 200+ 商品数据, 商品图片
-- 密码统一为: Abc12345 (bcrypt hashed)
-- 商品图片使用 picsum.photos 真实图片
-- ============================================================

USE `zhuanzhuan`;

-- 密码哈希: Abc12345
SET @pwd = '$2a$10$jnb0EqRycqlWErewqY3CS.qIafyXZv./nii/J/AFyEtCItBs74KYK';

-- ============================================================
-- 新增用户 (13个普通用户，加上已有的 admin 和 testuser 共15个)
-- ============================================================
INSERT INTO `user` (`id`, `username`, `password_hash`, `email`, `phone`, `avatar`, `nickname`, `bio`, `gender`, `role`, `credit_score`, `status`, `last_login_at`) VALUES
(3,  'xiaoming',   @pwd, 'xiaoming@qq.com',     '13800010001', 'https://picsum.photos/seed/avatar3/200/200',  '小明爱学习',   '计算机科学与技术大三学生，平时喜欢收集各种数码产品',   1, 'user', 95,  1, NOW()),
(4,  'zhangdaxia', @pwd, 'zhangdaxia@163.com',   '13800010002', 'https://picsum.photos/seed/avatar4/200/200',  '张大侠',       '文学爱好者，有很多好书要出',                           1, 'user', 98,  1, NOW()),
(5,  'lilyflower', @pwd, 'lily@campus.edu.cn',   '13800010003', 'https://picsum.photos/seed/avatar5/200/200',  '莉莉在画画',   '艺术系女生，喜欢穿搭和手作',                           2, 'user', 88,  1, NOW()),
(6,  'runner_lee', @pwd, 'runner@outlook.com',   '13800010004', 'https://picsum.photos/seed/avatar6/200/200',  '奔跑的李',     '体育特长生，健身和跑步是我的日常',                     1, 'user', 92,  1, NOW()),
(7,  'techbro_chen', @pwd, 'chen@qq.com',        '13800010005', 'https://picsum.photos/seed/avatar7/200/200',  '老陈搞机',     '电子工程专业，对各种电子产品了如指掌',                 1, 'user', 99,  1, NOW()),
(8,  'sophia_wang', @pwd, 'sophia@sina.com',     '13800010006', 'https://picsum.photos/seed/avatar8/200/200',  'Sophia学姐',   '研二学姐，出清宿舍闲置，物美价廉',                     2, 'user', 96,  1, NOW()),
(9,  'bookworm_zhao', @pwd, 'zhao@campus.edu.cn','13800010007', 'https://picsum.photos/seed/avatar9/200/200',  '书虫小赵',     '爱读书也爱分享，定期清理书架',                         1, 'user', 90,  1, NOW()),
(10, 'outdoor_fan', @pwd, 'outdoor@qq.com',      '13800010008', 'https://picsum.photos/seed/avatar10/200/200', '户外探险家',   '登山露营爱好者，装备党一枚',                           1, 'user', 93,  1, NOW()),
(11, 'yuki_style', @pwd, 'yuki@163.com',         '13800010009', 'https://picsum.photos/seed/avatar11/200/200', 'Yuki的衣橱',   '日系穿搭博主，衣服太多穿不过来啦',                     2, 'user', 97,  1, NOW()),
(12, 'cook_master', @pwd, 'chef@campus.edu.cn',  '13800010010', 'https://picsum.photos/seed/avatar12/200/200', '校园小厨神',   '热爱烹饪，出一些闲置厨房用品',                         1, 'user', 91,  1, NOW()),
(13, 'music_wei', @pwd, 'wei@qq.com',            '13800010011', 'https://picsum.photos/seed/avatar13/200/200', '韦音乐',       '音乐学院吉他手，出一些音乐设备',                       1, 'user', 94,  1, NOW()),
(14, 'green_leaf', @pwd, 'green@campus.edu.cn',  '13800010012', 'https://picsum.photos/seed/avatar14/200/200', '绿叶同学',     '环保主义者，喜欢二手循环利用',                         2, 'user', 89,  1, NOW()),
(15, 'photo_liu', @pwd, 'photo@qq.com',          '13800010013', 'https://picsum.photos/seed/avatar15/200/200', '摄影师刘',     '摄影社团成员，设备换代频繁',                           1, 'user', 95,  1, NOW()),
(16, 'dorm_queen', @pwd, 'dorm@163.com',         '13800010014', 'https://picsum.photos/seed/avatar16/200/200', '宿舍女王',     '擅长收纳和装饰，宿舍好物分享',                         2, 'user', 98,  1, NOW()),
(17, 'code_monkey', @pwd, 'coder@qq.com',        '13800010015', 'https://picsum.photos/seed/avatar17/200/200', '码农小孙',     '软件工程专业，常年蹲实验室配设备',                     1, 'user', 86,  1, NOW());

-- ============================================================
-- 商品数据 (216个商品，覆盖所有分类)
-- 图片使用 picsum.photos 真实照片
-- ============================================================

-- === 手机 (category_id=7) - 12个 ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(7, 7, 'iPhone 14 128G 午夜色 95新', 'iPhone 14 128GB，使用半年左右，一直戴壳贴膜，屏幕无划痕，电池健康度92%。配件齐全含原装充电器。', 4599.00, 5999.00, '几乎全新', 'https://picsum.photos/seed/phone1/640/480', 320, 45, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(7, 7, '小米13 Pro 12+256G 陶瓷白', '骁龙8Gen2处理器，徕卡光学镜头，120W快充。成色很好，边框有一处小磕碰已拍出。', 3299.00, 4999.00, '轻微使用痕迹', 'https://picsum.photos/seed/phone2/640/480', 256, 32, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(17, 7, '华为 Mate60 Pro 雅川青', '麒麟9000S芯片，卫星通话功能，XMAGE影像系统。用了3个月，非常流畅。因换折叠屏所以出。', 5299.00, 6999.00, '几乎全新', 'https://picsum.photos/seed/phone3/640/480', 198, 28, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(3, 7, 'vivo X100 Pro 星迹蓝 拍照旗舰', '天玑9300，蔡司APO超级长焦，拍照效果惊艳。适合喜欢摄影的同学。', 3699.00, 4999.00, '几乎全新', 'https://picsum.photos/seed/phone4/640/480', 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(8, 7, 'OPPO Find X7 Ultra 海阔天空', '1英寸大底主摄，双潜望长焦，哈苏人像。用了半年左右，送原装壳。', 4099.00, 5999.00, '轻微使用痕迹', 'https://picsum.photos/seed/phone5/640/480', 178, 22, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(7, 7, '三星 S24 Ultra 钛灰 256G', 'AI手机新体验，S Pen手写笔，2亿像素相机。台版刷了国行系统。', 6899.00, 9699.00, '几乎全新', 'https://picsum.photos/seed/phone6/640/480', 210, 35, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(11, 7, 'iPhone 15 粉色 128G 国行', '买了不到一个月，电池100%，和新机一样。因家人送了Pro Max所以出。', 5199.00, 5999.00, '全新', 'https://picsum.photos/seed/phone7/640/480', 289, 42, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(13, 7, '荣耀 Magic6 Pro 流云紫', '荣耀旗舰，骁龙8Gen3，1.8亿潜望长焦。拍照和续航都很棒。', 3899.00, 5699.00, '轻微使用痕迹', 'https://picsum.photos/seed/phone8/640/480', 134, 15, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(17, 7, '一加12 苍绿 16+512G', '哈苏影像+2K东方屏，性能怪兽。用了4个月，后盖有一个小划痕。', 3099.00, 4799.00, '轻微使用痕迹', 'https://picsum.photos/seed/phone9/640/480', 167, 20, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(5, 7, 'iPhone 13 Pro 远峰蓝 256G', '经典款A15芯片依旧流畅，ProMotion高刷屏。电池换过新的。', 3099.00, 7999.00, '明显使用痕迹', 'https://picsum.photos/seed/phone10/640/480', 423, 56, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(6, 7, '小米14 白色 16+512G 徕卡', '小屏旗舰，6.36英寸黄金尺寸。骁龙8Gen3+徕卡三摄，非常全能。', 3499.00, 4599.00, '几乎全新', 'https://picsum.photos/seed/phone11/640/480', 201, 30, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(8, 7, '真我GT5 Pro 赤岩 12+256G', '性价比之王，骁龙8Gen3+IMX890潜望长焦。学生党首选。', 2599.00, 3699.00, '轻微使用痕迹', 'https://picsum.photos/seed/phone12/640/480', 312, 48, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY));

-- === 电脑 (category_id=8) - 12个 ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(3, 8, 'MacBook Air M2 星光色 8+256G', 'M2芯片，轻薄便携，续航超强。适合上课带出去做笔记写作业。保修到明年3月。', 6299.00, 8999.00, '几乎全新', 'https://picsum.photos/seed/laptop1/640/480', 380, 52, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(7, 8, '联想小新Pro16 2024款 R7-8845H', '16寸2.5K大屏，32G+1TB配置。编程和多任务处理绰绰有余，做毕设买的现在用不到了。', 4799.00, 6499.00, '几乎全新', 'https://picsum.photos/seed/laptop2/640/480', 245, 33, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(17, 8, 'ThinkPad X1 Carbon Gen11 i7版', '商务轻薄本标杆，14寸2.8K OLED屏。键盘手感一流，适合敲代码写论文。', 5499.00, 9999.00, '轻微使用痕迹', 'https://picsum.photos/seed/laptop3/640/480', 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(3, 8, '华为 MateBook X Pro 2024', '3.1K OLED原色全面屏，微绒金属机身。颜值和性能兼备，会议神器。', 7299.00, 10999.00, '几乎全新', 'https://picsum.photos/seed/laptop4/640/480', 267, 38, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(8, 8, 'MacBook Pro 14 M3 Pro 18+512G', '深空黑色，M3 Pro芯片性能强劲。视频剪辑和编程毫无压力。', 11999.00, 16999.00, '几乎全新', 'https://picsum.photos/seed/laptop5/640/480', 156, 21, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(6, 8, '华硕天选5 Pro 锐龙版 R9-7940HX', 'RTX4060独显，游戏开发两不误。16寸2.5K高刷屏，散热给力。', 6299.00, 8499.00, '轻微使用痕迹', 'https://picsum.photos/seed/laptop6/640/480', 432, 61, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(12, 8, 'ROG 魔霸新锐 2024 i9-14900HX', 'RTX4060满血版，240Hz电竞屏。玩游戏爽到飞起，因考研出掉。', 7499.00, 9999.00, '几乎全新', 'https://picsum.photos/seed/laptop7/640/480', 389, 54, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(9, 8, '惠普战66六代 锐龙版 15寸', '商务本经典款，R5-7530U+16G+1TB。稳定可靠，办公学习够用。', 2299.00, 3999.00, '轻微使用痕迹', 'https://picsum.photos/seed/laptop8/640/480', 167, 19, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(4, 8, '戴尔灵越16 Plus i7-13700H', '16寸3K屏，32G+1TB，RTX3050。内容创作利器，屏幕效果惊艳。', 4999.00, 7299.00, '轻微使用痕迹', 'https://picsum.photos/seed/laptop9/640/480', 134, 16, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(10, 8, 'MacBook Air M1 8+256G 深空灰', '经典M1芯片，日常办公续航一天半。有点磕碰但不影响使用。', 3299.00, 7999.00, '明显使用痕迹', 'https://picsum.photos/seed/laptop10/640/480', 534, 72, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(13, 8, '小米笔记本Pro 16 2024 OLED', '3.1K OLED大师屏，酷睿Ultra 7。CNC一体精雕工艺，颜值党必备。', 5399.00, 6999.00, '几乎全新', 'https://picsum.photos/seed/laptop11/640/480', 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(5, 8, '机械革命 极光Pro i7-13620H', 'RTX4060独显，2.5K 165Hz屏。性价比游戏本，宿舍开黑无敌。', 4699.00, 6499.00, '轻微使用痕迹', 'https://picsum.photos/seed/laptop12/640/480', 298, 41, '在售', DATE_SUB(NOW(), INTERVAL 15 DAY));

-- === 平板 (category_id=9) - 10个 ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(5, 9, 'iPad Air M2 11英寸 紫色 128G', 'M2芯片带笔和妙控键盘，记笔记神器。买了不到两个月，和新的一样。', 4299.00, 5499.00, '几乎全新', 'https://picsum.photos/seed/pad1/640/480', 267, 38, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(9, 9, 'iPad Pro 2022 M2 12.9寸 256G', 'Mini-LED屏幕，影音体验无敌。附带二代Apple Pencil。', 6199.00, 9299.00, '轻微使用痕迹', 'https://picsum.photos/seed/pad2/640/480', 189, 25, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(3, 9, '华为 MatePad Pro 13.2 2024', 'OLED柔性屏，天生会画。搭配星闪手写笔，绘画体验一流。', 3899.00, 5299.00, '几乎全新', 'https://picsum.photos/seed/pad3/640/480', 145, 20, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(14, 9, '小米平板6S Pro 12.4寸 8+256G', '骁龙8Gen2，144Hz高刷屏。看电影打游戏都很爽。', 2199.00, 3299.00, '轻微使用痕迹', 'https://picsum.photos/seed/pad4/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(4, 9, 'iPad mini 6 64G 星光色', '小钢炮A15芯片，便携阅读和游戏神器。屏幕有一道细微划痕。', 2199.00, 3799.00, '轻微使用痕迹', 'https://picsum.photos/seed/pad5/640/480', 312, 44, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(8, 9, '三星 Tab S9 FE+ 12.4寸 128G', 'S Pen手写体验极佳，防水防尘。适合上课笔记和看PDF。', 2299.00, 3499.00, '几乎全新', 'https://picsum.photos/seed/pad6/640/480', 123, 16, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(11, 9, 'vivo Pad3 Pro 天玑9300', '13寸巨幕，3.1K分辨率。买来刷剧用的，发现没什么时间看。', 2599.00, 3499.00, '几乎全新', 'https://picsum.photos/seed/pad7/640/480', 156, 19, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(7, 9, '一加Pad 天玑8350 8+128G', '轻巧便携，ColorOS很流畅。影音娱乐平板中的一匹黑马。', 1699.00, 2399.00, '轻微使用痕迹', 'https://picsum.photos/seed/pad8/640/480', 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(12, 9, 'OPPO Pad 2 天玑9000 8+256G', '7:5黄金比例屏幕，阅读文档超级舒服。送官方磁吸壳。', 1799.00, 2699.00, '轻微使用痕迹', 'https://picsum.photos/seed/pad9/640/480', 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(16, 9, '联想拯救者Y700 2024 8.8寸', '骁龙8Gen2，小尺寸游戏平板之王。吃鸡原神流畅运行。', 1999.00, 2799.00, '几乎全新', 'https://picsum.photos/seed/pad10/640/480', 289, 40, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- === 耳机 (category_id=10) - 10个 ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(13, 10, 'AirPods Pro 2代 USB-C版', '降噪效果惊艳，通透模式自然。用了三个月，耳塞换过新的。', 1299.00, 1899.00, '轻微使用痕迹', 'https://picsum.photos/seed/earphone1/640/480', 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(3, 10, '索尼 WH-1000XM5 黑色头戴降噪', '旗舰级降噪，音质细腻。出行必备，配件齐全含收纳盒。', 1699.00, 2999.00, '几乎全新', 'https://picsum.photos/seed/earphone2/640/480', 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(7, 10, 'Bose QC45 消噪耳机 白色', '佩戴舒适，降噪自然。适合长时间佩戴学习使用。', 1099.00, 2299.00, '轻微使用痕迹', 'https://picsum.photos/seed/earphone3/640/480', 267, 35, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(11, 10, '华为 FreeBuds Pro 3 雅丹黑', '星闪连接+空间音频，鸿蒙生态绝配。通话降噪很清晰。', 799.00, 1299.00, '几乎全新', 'https://picsum.photos/seed/earphone4/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(5, 10, '三星 Galaxy Buds3 Pro 银色', 'AKG调音，360空间音频。配合三星手机使用体验最佳。', 899.00, 1499.00, '几乎全新', 'https://picsum.photos/seed/earphone5/640/480', 178, 23, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(6, 10, 'Beats Studio Pro 深棕色', '苹果生态无缝切换，头戴降噪。颜值在线，出街神器。', 1299.00, 2899.00, '轻微使用痕迹', 'https://picsum.photos/seed/earphone6/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(9, 10, '小米 Buds 4 Pro 星耀金', '空间音频+LDAC高清传输。性价比超高的旗舰TWS。', 499.00, 999.00, '轻微使用痕迹', 'https://picsum.photos/seed/earphone7/640/480', 389, 52, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(14, 10, 'JBL TUNE 770NC 蓝牙降噪', '纯正低频，70小时超长续航。学生党首选头戴降噪耳机。', 299.00, 599.00, '几乎全新', 'https://picsum.photos/seed/earphone8/640/480', 445, 63, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(8, 10, '漫步者 NeoBuds Pro 2 黑色', 'Hi-Res金标认证+空间音频。国产旗舰TWS，音质超预期。', 499.00, 899.00, '轻微使用痕迹', 'https://picsum.photos/seed/earphone9/640/480', 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(10, 10, '森海塞尔 Momentum 4 无线降噪', '发烧友级音质，自适应降噪。60小时续航，皮质耳罩超舒适。', 1499.00, 2699.00, '轻微使用痕迹', 'https://picsum.photos/seed/earphone10/640/480', 156, 20, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY));

-- == 相机 (category_id=11) - 6个 ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(15, 11, '索尼 A7M4 全画幅微单机身', '3300万像素，对焦精准。快门数约8000，带原厂电池和充电器。', 11999.00, 16999.00, '轻微使用痕迹', 'https://picsum.photos/seed/camera1/640/480', 234, 33, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5, 11, '富士 X-T5 银色 机身+18-55mm镜头', '4020万像素APS-C画质天花板，胶片模拟直出好看。', 8999.00, 13999.00, '轻微使用痕迹', 'https://picsum.photos/seed/camera2/640/480', 189, 27, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(15, 11, '佳能 EOS R6 Mark II 套机', '2420万像素全画幅，对焦速度超快。含24-105 STM镜头。', 13999.00, 18999.00, '几乎全新', 'https://picsum.photos/seed/camera3/640/480', 145, 19, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(3, 11, '大疆 Pocket 3 灵眸口袋云台', '1英寸CMOS，三轴云台防抖。拍vlog神器，出片率超高。', 2399.00, 3499.00, '几乎全新', 'https://picsum.photos/seed/camera4/640/480', 312, 45, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(11, 11, 'Insta360 X4 全景运动相机', '8K全景视频，360度记录。滑雪冲浪必备，配件齐全。', 2599.00, 3499.00, '几乎全新', 'https://picsum.photos/seed/camera5/640/480', 198, 28, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(13, 11, '索尼 ZV-E10 II 微单vlog相机', 'APS-C画幅，AI自动构图。美颜直出，适合自媒体创作。', 4299.00, 5999.00, '几乎全新', 'https://picsum.photos/seed/camera6/640/480', 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY));

-- == 配件 (category_id=12) - 12个 ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(7, 12, 'Anker 737 移动电源 24000mAh', '140W双向快充，可充笔记本。出差旅行一个搞定所有设备。', 399.00, 699.00, '轻微使用痕迹', 'https://picsum.photos/seed/acc1/640/480', 534, 72, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(3, 12, '罗技 MX Master 3S 无线鼠标', '人体工学旗舰，电磁滚轮超顺滑。静音按键，图书馆友好。', 349.00, 699.00, '轻微使用痕迹', 'https://picsum.photos/seed/acc2/640/480', 423, 56, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(17, 12, 'Keychron K8 Pro 机械键盘 茶轴', '75%配列，QMK固件，热插拔。编程打字两相宜。', 329.00, 588.00, '轻微使用痕迹', 'https://picsum.photos/seed/acc3/640/480', 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(8, 12, 'Type-C 扩展坞 12合1', 'HDMI 4K60Hz+千兆网口+SD卡+USB3.0。MacBook好搭档。', 129.00, 259.00, '几乎全新', 'https://picsum.photos/seed/acc4/640/480', 389, 51, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(5, 12, '绿联 氮化镓充电器 100W 4口', '三口C口+一口A口，快充全兼容。桌面一个搞定所有充电。', 89.00, 169.00, '几乎全新', 'https://picsum.photos/seed/acc5/640/480', 456, 63, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(14, 12, '罗技 C920 Pro 网络摄像头', '1080P高清，自动对焦。上网课面试必备。', 199.00, 399.00, '轻微使用痕迹', 'https://picsum.photos/seed/acc6/640/480', 278, 35, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(12, 12, '显示器支架 双屏 桌面款', '承重8kg，气压弹簧调节。拯救颈椎的桌面改造利器。', 149.00, 299.00, '几乎全新', 'https://picsum.photos/seed/acc7/640/480', 198, 25, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(9, 12, '西数 SN770 1TB NVMe SSD', 'PCIe 4.0，读速5150MB/s。升级电脑存储空间。', 399.00, 599.00, '几乎全新', 'https://picsum.photos/seed/acc8/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(6, 12, 'Apple Magic Trackpad 触控板', '苹果原装触控板，Mac绝配。二代支持Force Touch。', 499.00, 899.00, '轻微使用痕迹', 'https://picsum.photos/seed/acc9/640/480', 167, 21, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(16, 12, '小米照片打印机 1S 套装', '手机直连打印，色彩还原好。含2盒相纸共80张。', 399.00, 699.00, '轻微使用痕迹', 'https://picsum.photos/seed/acc10/640/480', 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(4, 12, 'USB-C 数据线 100W快充 3条装', '品牌编织线，2米长，耐用不缠绕。宿舍教室各扔一条。', 29.00, 79.00, '全新', 'https://picsum.photos/seed/acc11/640/480', 589, 78, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(10, 12, 'PITAKA 磁吸手机壳 iPhone 15 Pro', '芳纶纤维材质，超轻薄。磁吸牢固，手感一流。', 89.00, 199.00, '轻微使用痕迹', 'https://picsum.photos/seed/acc12/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- == 教材教辅 (category_id=13) - 15个 ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(4, 13, '《数据结构(C语言版)》严蔚敏 全新', '计算机考研必备教材，买多了没用过。', 25.00, 39.00, '全新', 'https://picsum.photos/seed/book1/640/480', 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(9, 13, '《高等数学》(第七版) 同济大学 上下册', '考研数学一必备用书，笔记工整整洁。', 35.00, 72.00, '轻微使用痕迹', 'https://picsum.photos/seed/book2/640/480', 423, 56, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(3, 13, '《计算机网络：自顶向下方法》第七版', '经典教材中文版，计算机专业必修。有些标注但不影响阅读。', 45.00, 89.00, '轻微使用痕迹', 'https://picsum.photos/seed/book3/640/480', 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(9, 13, '《算法导论》(CLRS) 第三版 英文影印', '算法圣经，学算法必读。书角有点磨损但内页完好。', 55.00, 128.00, '明显使用痕迹', 'https://picsum.photos/seed/book4/640/480', 189, 25, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(4, 13, '《线性代数及其应用》David C. Lay', '经典线代教材，考研复习用。例题讲解清晰易懂。', 28.00, 55.00, '轻微使用痕迹', 'https://picsum.photos/seed/book5/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(8, 13, '《操作系统概念》第九版 恐龙书', '操作系统经典教材。考研408必读。', 40.00, 79.00, '轻微使用痕迹', 'https://picsum.photos/seed/book6/640/480', 178, 23, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(14, 13, '《概率论与数理统计》浙大第四版', '考研数学经典教材，例题全面。', 20.00, 45.00, '轻微使用痕迹', 'https://picsum.photos/seed/book7/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(3, 13, '《深入理解计算机系统》(CSAPP) 第三版', '程序员必读神书，CMU经典教材。英文原版。', 68.00, 139.00, '轻微使用痕迹', 'https://picsum.photos/seed/book8/640/480', 145, 19, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(9, 13, '《编译原理》(龙书) 第二版', '编译技术经典教材。考研408备考需要。', 50.00, 89.00, '轻微使用痕迹', 'https://picsum.photos/seed/book9/640/480', 98, 12, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(4, 13, '《程序设计教程》C++ Primer Plus 第6版', 'C++入门经典，内容详实。书角有一点折痕。', 45.00, 99.00, '轻微使用痕迹', 'https://picsum.photos/seed/book10/640/480', 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(12, 13, '《大学物理》(上下册) 马文蔚', '理工科基础课教材。书中有笔记但很工整。', 30.00, 68.00, '明显使用痕迹', 'https://picsum.photos/seed/book11/640/480', 134, 16, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(11, 13, '《新概念英语3+4》 全新套装', '四六级备考神器。买来没翻开过...', 35.00, 78.00, '全新', 'https://picsum.photos/seed/book12/640/480', 278, 37, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY)),
(6, 13, '《信号与系统》郑君里 第三版', '电子信息类经典教材，考研必备。', 30.00, 56.00, '轻微使用痕迹', 'https://picsum.photos/seed/book13/640/480', 156, 20, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(16, 13, '《Python编程：从入门到实践》第3版', 'Python入门最佳教程。书很新，代码部分有标注。', 35.00, 69.00, '轻微使用痕迹', 'https://picsum.photos/seed/book14/640/480', 389, 52, '在售', DATE_SUB(NOW(), INTERVAL 15 DAY)),
(10, 13, '《数字电子技术基础》阎石 第六版', '电子类必修课教材。有笔记但很整洁。', 25.00, 49.00, '轻微使用痕迹', 'https://picsum.photos/seed/book15/640/480', 112, 14, '在售', DATE_SUB(NOW(), INTERVAL 16 DAY));

-- == 文学小说 (category_id=14) - 15个 ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(4, 14, '《三体》全套三册 刘慈欣', '科幻神作，值得反复阅读。书角有轻微磨损不影响阅读。', 45.00, 93.00, '轻微使用痕迹', 'https://picsum.photos/seed/novel1/640/480', 567, 78, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(9, 14, '《百年孤独》加西亚·马尔克斯', '魔幻现实主义经典，范晔译本。书很新。', 28.00, 55.00, '几乎全新', 'https://picsum.photos/seed/novel2/640/480', 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5, 14, '《活着》余华 精装版', '余华代表作，看哭了好几次。精装硬皮版。', 18.00, 35.00, '轻微使用痕迹', 'https://picsum.photos/seed/novel3/640/480', 423, 56, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(11, 14, '《月亮与六便士》毛姆', '理想与现实的抉择，经典文学。中英文双语版。', 22.00, 42.00, '几乎全新', 'https://picsum.photos/seed/novel4/640/480', 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(4, 14, '《1984》乔治·奥威尔 英文原版', '反乌托邦经典，适合英语学习。', 19.00, 38.00, '轻微使用痕迹', 'https://picsum.photos/seed/novel5/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(8, 14, '《围城》钱钟书 经典版', '中国现代文学经典之作。封面有点旧了但内容完整。', 15.00, 29.80, '明显使用痕迹', 'https://picsum.photos/seed/novel6/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(14, 14, '《追风筝的人》卡勒德·胡赛尼', '全球畅销书，为你千千万万遍。', 20.00, 39.00, '轻微使用痕迹', 'https://picsum.photos/seed/novel7/640/480', 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(6, 14, '《挪威的森林》村上春树', '村上春树代表作，青春爱情经典。', 16.00, 32.00, '轻微使用痕迹', 'https://picsum.photos/seed/novel8/640/480', 289, 38, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(16, 14, '《小王子》中英法三语精装版', '永恒的童话经典！三语对照，装帧精美。', 25.00, 49.00, '几乎全新', 'https://picsum.photos/seed/novel9/640/480', 378, 51, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(10, 14, '《杀死一只知更鸟》哈珀·李', '关于勇气与正义的经典之作。', 18.00, 35.00, '轻微使用痕迹', 'https://picsum.photos/seed/novel10/640/480', 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(3, 14, '《人类简史》尤瓦尔·赫拉利', '重新认识人类文明发展史。', 30.00, 68.00, '轻微使用痕迹', 'https://picsum.photos/seed/novel11/640/480', 456, 62, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(12, 14, '《局外人》加缪 新版译本', '存在主义文学经典。哲学入门推荐。', 12.00, 25.00, '轻微使用痕迹', 'https://picsum.photos/seed/novel12/640/480', 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY)),
(5, 14, '《平凡的世界》路遥 全三册', '茅盾文学奖作品，写尽普通人不平凡的人生。', 42.00, 89.00, '轻微使用痕迹', 'https://picsum.photos/seed/novel13/640/480', 234, 30, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(9, 14, '《岛上书店》加·泽文', '温暖治愈的阅读故事。没有谁是一座孤岛。', 18.00, 35.00, '几乎全新', 'https://picsum.photos/seed/novel14/640/480', 178, 23, '在售', DATE_SUB(NOW(), INTERVAL 15 DAY)),
(4, 14, '《苏菲的世界》乔斯坦·贾德', '哲学入门小说，故事生动有趣。', 22.00, 45.00, '轻微使用痕迹', 'https://picsum.photos/seed/novel15/640/480', 156, 20, '在售', DATE_SUB(NOW(), INTERVAL 17 DAY));

-- == 科技科普 (category_id=15) - 8个 ===
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(7, 15, '《上帝掷骰子吗》量子物理史话', '通俗易懂的量子物理科普，豆瓣9.2分神作。', 25.00, 45.00, '轻微使用痕迹', 'https://picsum.photos/seed/tech1/640/480', 423, 56, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(3, 15, '《从一到无穷大》科学中的事实和臆测', '经典科普名著，培养科学思维的好书。', 28.00, 45.00, '轻微使用痕迹', 'https://picsum.photos/seed/tech2/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(9, 15, '《时间简史》霍金 插图版', '霍金代表作，宇宙学科普必读。全彩插图版。', 35.00, 68.00, '轻微使用痕迹', 'https://picsum.photos/seed/tech3/640/480', 267, 35, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(17, 15, '《代码整洁之道》Robert C. Martin', '程序员进阶必读，提升代码质量的经典。', 35.00, 59.00, '轻微使用痕迹', 'https://picsum.photos/seed/tech4/640/480', 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(6, 15, '《万物简史》比尔·布莱森', '妙趣横生的自然科学史。', 30.00, 49.00, '几乎全新', 'https://picsum.photos/seed/tech5/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(14, 15, '《自私的基因》理查德·道金斯', '进化生物学经典，颠覆你的世界观。', 22.00, 39.00, '轻微使用痕迹', 'https://picsum.photos/seed/tech6/640/480', 178, 23, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(4, 15, '《思考，快与慢》丹尼尔·卡尼曼', '诺贝尔经济学奖得主著作，行为经济学入门。', 32.00, 59.00, '轻微使用痕迹', 'https://picsum.photos/seed/tech7/640/480', 289, 38, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(10, 15, '《枪炮、病菌与钢铁》戴蒙德', '人类社会发展史的宏大叙事。', 28.00, 55.00, '轻微使用痕迹', 'https://picsum.photos/seed/tech8/640/480', 156, 20, '在售', DATE_SUB(NOW(), INTERVAL 16 DAY));

-- ============================================================
-- 继续更多商品数据...
-- ============================================================
