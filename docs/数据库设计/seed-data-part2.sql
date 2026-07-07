-- ============================================================
-- 转转 - 种子数据 第二部分
-- 继续：考试资料、生活用品、服饰鞋包、运动户外等
-- ============================================================

USE `zhuanzhuan`;
SET @pwd = '$2a$10$jnb0EqRycqlWErewqY3CS.qIafyXZv./nii/J/AFyEtCItBs74KYK';

-- == 考试资料 (category_id=16) - 12个 ==
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(3, 16, '考研数学一 张宇36讲 全新未拆', '2025最新版考研数学一全套，买错了出掉。', 55.00, 108.00, '全新', 'https://picsum.photos/seed/exam1/640/480', 398, 54, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(8, 16, '考研英语 历年真题详解 2025版', '黄皮书英语一真题，2005-2024全套。', 35.00, 76.00, '轻微使用痕迹', 'https://picsum.photos/seed/exam2/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(4, 16, '考研政治 肖秀荣1000题+精讲精练', '2025肖秀荣全套，少量题目有铅笔痕迹。', 45.00, 98.00, '轻微使用痕迹', 'https://picsum.photos/seed/exam3/640/480', 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(9, 16, '计算机408考研 王道四本套装', '数据结构+组成原理+操作系统+计算机网络。考研408必备。', 60.00, 128.00, '轻微使用痕迹', 'https://picsum.photos/seed/exam4/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(6, 16, '英语六级 星火真题 2024新版', '含10套真题+听力音频。有些做题痕迹。', 12.00, 32.00, '轻微使用痕迹', 'https://picsum.photos/seed/exam5/640/480', 198, 25, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(12, 16, 'GRE词汇精选 红宝书 乱序版', '考G必备，背完这本词汇量暴增。书角有磨损。', 25.00, 58.00, '明显使用痕迹', 'https://picsum.photos/seed/exam6/640/480', 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(14, 16, '公务员考试 行测+申论 中公套装', '国考省考通用，题型全面。去年买的没怎么看...', 40.00, 96.00, '几乎全新', 'https://picsum.photos/seed/exam7/640/480', 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(3, 16, '托福 官方指南+TPO真题', '托福备考全套，含OG和TPO30-70。', 55.00, 118.00, '轻微使用痕迹', 'https://picsum.photos/seed/exam8/640/480', 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(10, 16, '法考 客观题资料包', '瑞达法考全套讲义+真题，法学专业必备。', 65.00, 138.00, '轻微使用痕迹', 'https://picsum.photos/seed/exam9/640/480', 112, 14, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(11, 16, '日语N2备考 红蓝宝书+真题', '标日N2语法+词汇+历年真题。学日语的来。', 35.00, 78.00, '轻微使用痕迹', 'https://picsum.photos/seed/exam10/640/480', 134, 16, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(16, 16, '教师资格证 综合素质+教育知识', '中公教育教材+真题，考教资必备。', 28.00, 68.00, '几乎全新', 'https://picsum.photos/seed/exam11/640/480', 156, 21, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(5, 16, '雅思 剑桥真题4-18全套', 'IELTS备考套装，含解析和音频。', 65.00, 138.00, '轻微使用痕迹', 'https://picsum.photos/seed/exam12/640/480', 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- == 宿舍用品 (category_id=17) - 14个 ==
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(16, 17, '宿舍迷你小冰箱 15L 冷暖两用', '夏天冰饮料冬天热牛奶，宿舍神器。功率低不跳闸。', 129.00, 299.00, '轻微使用痕迹', 'https://picsum.photos/seed/dorm1/640/480', 534, 75, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(14, 17, '可折叠收纳箱 66L 大号 3个装', '衣物杂物收纳神器，可折叠不占地方。', 35.00, 69.00, '轻微使用痕迹', 'https://picsum.photos/seed/dorm2/640/480', 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(5, 17, '寝室台灯 LED护眼 三档调光', '无频闪护眼台灯，长臂调节。有夹子和底座两种安装。', 49.00, 99.00, '几乎全新', 'https://picsum.photos/seed/dorm3/640/480', 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(12, 17, '电热水壶 1.7L 304不锈钢', '快速烧水，自动断电。宿舍必备泡面神器。', 25.00, 59.00, '轻微使用痕迹', 'https://picsum.photos/seed/dorm4/640/480', 278, 36, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(16, 17, '宿舍床帘 遮光+防蚊 三件套', '一体式床帘，私密空间必备。女生宿舍人手一个。', 45.00, 89.00, '轻微使用痕迹', 'https://picsum.photos/seed/dorm5/640/480', 389, 53, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(8, 17, '加湿器 超声波静音 2.5L', '冬天开空调必备，静音加湿不打扰睡眠。', 39.00, 79.00, '轻微使用痕迹', 'https://picsum.photos/seed/dorm6/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(14, 17, '床上懒人桌 可升降折叠', '笔记本桌+零食桌，冬天被窝办公神器。', 35.00, 68.00, '轻微使用痕迹', 'https://picsum.photos/seed/dorm7/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(15, 17, '桌面书架 多层置物架 白色', '木质桌面书架，承重力强。让桌面整洁有序。', 30.00, 59.00, '轻微使用痕迹', 'https://picsum.photos/seed/dorm8/640/480', 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(11, 17, '衣柜除湿挂袋 10个装', '宿舍衣柜防潮必备，南方必备神器。未拆封。', 8.00, 19.00, '全新', 'https://picsum.photos/seed/dorm9/640/480', 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(16, 17, '宿舍地毯 50x80cm 灰色', '脚垫地毯，冬天踩上去暖暖的。可水洗。', 18.00, 39.00, '轻微使用痕迹', 'https://picsum.photos/seed/dorm10/640/480', 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(9, 17, '插排 6位+3USB 防雷击', '独立开关+安全门，宿舍用电安全第一。', 22.00, 45.00, '轻微使用痕迹', 'https://picsum.photos/seed/dorm11/640/480', 267, 35, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(7, 17, '迷你投影仪 便携版 支持投屏', '周末宿舍看电影神器，白墙即可投影。', 169.00, 399.00, '轻微使用痕迹', 'https://picsum.photos/seed/dorm12/640/480', 456, 62, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY)),
(4, 17, '电蚊拍 充电式 三层网', '夏季灭蚊神器，充电一次用一周。', 15.00, 29.00, '几乎全新', 'https://picsum.photos/seed/dorm13/640/480', 178, 23, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY)),
(10, 17, '宿舍挂烫机 手持便携', '小巧不占地，除皱效果好。面试前熨一下衬衫。', 49.00, 99.00, '轻微使用痕迹', 'https://picsum.photos/seed/dorm14/640/480', 134, 16, '在售', DATE_SUB(NOW(), INTERVAL 15 DAY));

-- == 厨房电器 (category_id=18) - 8个 ==
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(12, 18, '美的电饭煲 3L 智能预约', '宿舍小厨房必备，智能预约煮饭煲汤。内胆完好不粘。', 89.00, 199.00, '轻微使用痕迹', 'https://picsum.photos/seed/kitchen1/640/480', 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(8, 18, '小熊空气炸锅 3.5L 可视化', '无油健康烹饪，炸鸡薯条样样行。可视窗口观察食物。', 129.00, 299.00, '轻微使用痕迹', 'https://picsum.photos/seed/kitchen2/640/480', 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(16, 18, '九阳豆浆机 600ml 预约款', '早起一杯热豆浆/米糊。免过滤设计清洗方便。', 79.00, 199.00, '轻微使用痕迹', 'https://picsum.photos/seed/kitchen3/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(14, 18, '小米电磁炉 青春版 2100W', 'OLED旋钮控温，精准火候。配平底锅一个。', 99.00, 229.00, '轻微使用痕迹', 'https://picsum.photos/seed/kitchen4/640/480', 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(12, 18, '便携榨汁杯 无线充电款', '30秒鲜榨果汁，无线充电。夏天必备。', 39.00, 89.00, '几乎全新', 'https://picsum.photos/seed/kitchen5/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(5, 18, '烤箱 12L 迷你电烤箱', '烤面包饼干蛋挞，烘焙入门神器。带烤盘烤架。', 69.00, 159.00, '轻微使用痕迹', 'https://picsum.photos/seed/kitchen6/640/480', 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(10, 18, '小熊酸奶机 1L 全自动', '自制酸奶健康无添加。送菌粉两包。', 25.00, 59.00, '几乎全新', 'https://picsum.photos/seed/kitchen7/640/480', 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(3, 18, '早餐机 三明治机+华夫饼盘', '五分钟搞定三明治早餐。两面烤盘可拆卸清洗。', 49.00, 119.00, '轻微使用痕迹', 'https://picsum.photos/seed/kitchen8/640/480', 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- == 美妆个护 (category_id=19) - 8个 ==
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(11, 19, 'SK-II 神仙水 230ml 全新未拆', '免税店购入，全新未拆封。日期到2027年。', 799.00, 1590.00, '全新', 'https://picsum.photos/seed/beauty1/640/480', 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(5, 19, '戴森 卷发棒 Airwrap 全套', '美发神器，卷发直发吹风三合一。用了不到五次。', 1999.00, 3699.00, '几乎全新', 'https://picsum.photos/seed/beauty2/640/480', 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(16, 19, '兰蔻 持妆粉底液 PO-01', '色号买错了只用过一次。适合白皮妹子。', 199.00, 450.00, '几乎全新', 'https://picsum.photos/seed/beauty3/640/480', 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(8, 19, '雅萌 ACE五代 射频美容仪', '提拉紧致抗初老，搭配凝胶使用。坚持用效果明显。', 1299.00, 2999.00, '轻微使用痕迹', 'https://picsum.photos/seed/beauty4/640/480', 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(14, 19, 'MAC 口红套装 3支热门色', 'Chili/Ruby Woo/Marrakesh三支。Chili试过一次。', 199.00, 510.00, '轻微使用痕迹', 'https://picsum.photos/seed/beauty5/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(5, 19, '松下 蒸脸器 纳米离子', '补水神器，蒸完脸滑滑的。冬天护肤必备。', 169.00, 399.00, '轻微使用痕迹', 'https://picsum.photos/seed/beauty6/640/480', 145, 19, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(11, 19, '香奈儿 蔚蓝男士香水 100ml', '经典的木质柑橘香调。用了不到10%的量。', 499.00, 890.00, '轻微使用痕迹', 'https://picsum.photos/seed/beauty7/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(16, 19, '无印良品 香薰机+精油套装', '超声波静音香薰，配薰衣草+甜橙精油各一瓶。', 129.00, 298.00, '轻微使用痕迹', 'https://picsum.photos/seed/beauty8/640/480', 178, 23, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- == 上衣 (category_id=20) - 12个 ==
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(11, 20, '优衣库 轻薄羽绒服 女款 米色 M码', '轻暖便携，可以收纳成小包。只穿了一季。', 149.00, 399.00, '轻微使用痕迹', 'https://picsum.photos/seed/cloth1/640/480', 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(5, 20, 'Nike 卫衣 学院风 灰色 S码', '加绒保暖，版型很好看。买小了穿不了。', 99.00, 299.00, '几乎全新', 'https://picsum.photos/seed/cloth2/640/480', 345, 47, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(8, 20, 'ZARA 西装外套 女 黑色 M码', '垂感面料有质感，面试通勤都可以。只穿过两次。', 169.00, 499.00, '几乎全新', 'https://picsum.photos/seed/cloth3/640/480', 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(16, 20, 'Adidas 三叶草 T恤 白色 L码', '经典三叶草logo，纯棉舒适。穿了几次发现风格不适合。', 59.00, 199.00, '轻微使用痕迹', 'https://picsum.photos/seed/cloth4/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(6, 20, 'Patagonia 抓绒衣 男 蓝色 L码', '环保面料保暖透气，户外活动必备。', 199.00, 599.00, '轻微使用痕迹', 'https://picsum.photos/seed/cloth5/640/480', 178, 24, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(11, 20, 'UR 针织开衫 杏色 M码', '软糯舒适，适合春秋穿搭。只穿过一次不喜欢了。', 89.00, 269.00, '几乎全新', 'https://picsum.photos/seed/cloth6/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(9, 20, 'Champion 卫衣 反转logo 黑色 L码', '美版宽松版型，加绒很厚实。洗过一次没缩水。', 79.00, 239.00, '轻微使用痕迹', 'https://picsum.photos/seed/cloth7/640/480', 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 8 DAY)),
(14, 20, 'H&M 长款风衣 卡其色 S码', '经典英伦风，春天穿超有气质。', 129.00, 399.00, '轻微使用痕迹', 'https://picsum.photos/seed/cloth8/640/480', 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(10, 20, '北面 冲锋衣 男 黑色 XL码', 'Gore-Tex防水透气，防风性能一流。户外登山必备。', 399.00, 1299.00, '轻微使用痕迹', 'https://picsum.photos/seed/cloth9/640/480', 289, 39, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(5, 20, 'Lee 牛仔外套 复古蓝 M码', '经典牛仔外套永不过时。穿了几次颜色更自然了。', 169.00, 499.00, '轻微使用痕迹', 'https://picsum.photos/seed/cloth10/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(12, 20, '优衣库 摇粒绒外套 男 深灰 L码', '优衣库经典款，轻暖舒适。已经洗过两次。', 49.00, 149.00, '轻微使用痕迹', 'https://picsum.photos/seed/cloth11/640/480', 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(7, 20, 'Arcteryx 始祖鸟 速干T恤 男 M码', '顶级户外品牌速干面料，夏天运动穿超爽。', 199.00, 599.00, '轻微使用痕迹', 'https://picsum.photos/seed/cloth12/640/480', 156, 20, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- == 裤装 (category_id=21) - 8个 ==
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(5, 21, 'Levi''s 501 经典直筒牛仔裤 28码', '经典501版型，中腰直筒显腿长。穿了几次洗过一水。', 299.00, 799.00, '轻微使用痕迹', 'https://picsum.photos/seed/pants1/640/480', 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(11, 21, 'ZARA 阔腿裤 女 黑色 S码', '垂感面料高级感十足，通勤必备。只穿过一次。', 99.00, 299.00, '几乎全新', 'https://picsum.photos/seed/pants2/640/480', 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(6, 21, 'Nike 运动长裤 Dri-FIT 男 灰色 L码', '速干面料运动穿着舒适。健身房常备。', 89.00, 249.00, '轻微使用痕迹', 'https://picsum.photos/seed/pants3/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(8, 21, '优衣库 弹力九分裤 女 藏青 M码', '弹力面料舒适不紧绷，上班上课都合适。', 69.00, 199.00, '轻微使用痕迹', 'https://picsum.photos/seed/pants4/640/480', 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(16, 21, 'HM 牛仔短裤 浅蓝色 27码', '夏天百搭牛仔短裤，高腰显腿长。', 39.00, 119.00, '轻微使用痕迹', 'https://picsum.photos/seed/pants5/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(4, 21, '迪卡侬 户外速干裤 男 卡其色 L码', '可拆卸裤腿变短裤，户外神器。', 69.00, 179.00, '轻微使用痕迹', 'https://picsum.photos/seed/pants6/640/480', 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(12, 21, 'GAP 休闲卡其裤 男 深卡其 32码', '经典卡其裤，配什么上衣都好看。', 79.00, 229.00, '轻微使用痕迹', 'https://picsum.photos/seed/pants7/640/480', 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(14, 21, '太平鸟 格子短裙 女 S码', '日系学院风百褶短裙，穿起来很元气。', 59.00, 169.00, '几乎全新', 'https://picsum.photos/seed/pants8/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- == 鞋类 (category_id=22) - 10个 ==
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(6, 22, 'Nike Air Force 1 小白鞋 42码', '经典AF1，百搭神器。穿了大半年有正常穿着痕迹。', 299.00, 799.00, '轻微使用痕迹', 'https://picsum.photos/seed/shoes1/640/480', 534, 72, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(11, 22, 'Adidas Samba OG 德训鞋 37码', '复古德训鞋，颜值在线。穿了不到十次。', 399.00, 799.00, '轻微使用痕迹', 'https://picsum.photos/seed/shoes2/640/480', 423, 58, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(10, 22, 'New Balance 2002R 元祖灰 41.5码', '老爹鞋天花板，脚感无敌。', 599.00, 1199.00, '几乎全新', 'https://picsum.photos/seed/shoes3/640/480', 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(5, 22, '匡威 Chuck 70 高帮 黑色 39码', '经典帆布鞋，怎么搭都好看。穿了半年鞋头有正常磨损。', 199.00, 569.00, '轻微使用痕迹', 'https://picsum.photos/seed/shoes4/640/480', 278, 37, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(14, 22, 'UGG 短筒雪地靴 栗色 38码', '冬天神器，超级保暖。只在去年穿了一季。', 299.00, 899.00, '轻微使用痕迹', 'https://picsum.photos/seed/shoes5/640/480', 198, 26, '在售', DATE_SUB(NOW(), INTERVAL 6 DAY)),
(6, 22, 'Nike 飞马 Pegasus 40 跑鞋 42码', '专业缓震跑鞋，跑了大概100公里左右。', 349.00, 899.00, '轻微使用痕迹', 'https://picsum.photos/seed/shoes6/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(11, 22, 'Dr. Martens 1460 八孔马丁靴 37码', '经典马丁靴，越穿越好看。已经穿软了不磨脚。', 499.00, 1399.00, '轻微使用痕迹', 'https://picsum.photos/seed/shoes7/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(4, 22, 'Crocs 洞洞鞋 经典款 43码', '夏天拖鞋神器，穿起来超舒服。', 89.00, 269.00, '轻微使用痕迹', 'https://picsum.photos/seed/shoes8/640/480', 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 10 DAY)),
(8, 22, 'Asics Gel-Kayano 29 稳定跑鞋 39码', '顶级稳定系跑鞋，适合扁平足/外翻脚型。', 499.00, 1299.00, '轻微使用痕迹', 'https://picsum.photos/seed/shoes9/640/480', 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 12 DAY)),
(16, 22, 'Vans Old Skool 棋盘格 38码', '经典滑板鞋，棋盘格百搭。后跟有一点磨损。', 169.00, 469.00, '明显使用痕迹', 'https://picsum.photos/seed/shoes10/640/480', 289, 38, '在售', DATE_SUB(NOW(), INTERVAL 14 DAY));

-- == 箱包 (category_id=23) - 8个 ==
INSERT INTO `product` (`user_id`, `category_id`, `title`, `description`, `price`, `original_price`, `condition`, `cover_image`, `view_count`, `favorite_count`, `status`, `created_at`) VALUES
(5, 23, '小米 20寸登机箱 商务款', '静音万向轮+TSA海关锁。短途出差旅行的好伙伴。', 199.00, 399.00, '轻微使用痕迹', 'https://picsum.photos/seed/bag1/640/480', 345, 48, '在售', DATE_SUB(NOW(), INTERVAL 2 DAY)),
(8, 23, 'Herschel 双肩包 经典款 黑色', '加拿大品牌，笔记本电脑隔层+多口袋。上学通勤都好看。', 199.00, 599.00, '轻微使用痕迹', 'https://picsum.photos/seed/bag2/640/480', 423, 56, '在售', DATE_SUB(NOW(), INTERVAL 3 DAY)),
(11, 23, 'Longchamp 饺子包 海军蓝 中号', '法国经典托特包，轻便能装。通勤上课两用。', 399.00, 1000.00, '轻微使用痕迹', 'https://picsum.photos/seed/bag3/640/480', 267, 36, '在售', DATE_SUB(NOW(), INTERVAL 4 DAY)),
(3, 23, 'Samsonite 新秀丽 双肩电脑包', '商务通勤包，减负背带+Tess合金拉链。15.6寸笔记本专区。', 299.00, 799.00, '轻微使用痕迹', 'https://picsum.photos/seed/bag4/640/480', 198, 27, '在售', DATE_SUB(NOW(), INTERVAL 5 DAY)),
(14, 23, 'UR 斜挎小方包 奶油白', '通勤约会万能搭配，大小刚好装手机钥匙。', 69.00, 199.00, '轻微使用痕迹', 'https://picsum.photos/seed/bag5/640/480', 312, 42, '在售', DATE_SUB(NOW(), INTERVAL 7 DAY)),
(10, 23, 'Osprey 登山包 38L 户外徒步包', '专业户外背包，背负系统舒适。', 299.00, 899.00, '轻微使用痕迹', 'https://picsum.photos/seed/bag6/640/480', 145, 18, '在售', DATE_SUB(NOW(), INTERVAL 9 DAY)),
(16, 23, 'COS 帆布托特包 黑色', '极简风大容量帆布包，北欧风格百搭。', 79.00, 199.00, '轻微使用痕迹', 'https://picsum.photos/seed/bag7/640/480', 234, 31, '在售', DATE_SUB(NOW(), INTERVAL 11 DAY)),
(6, 23, '迪卡侬 骑行背包 15L 反光条', '轻量骑行背包，内置水袋仓。夜间反光安全。', 59.00, 149.00, '轻微使用痕迹', 'https://picsum.photos/seed/bag8/640/480', 167, 22, '在售', DATE_SUB(NOW(), INTERVAL 13 DAY));

-- ============================================================
-- 继续更多商品...
-- ============================================================
