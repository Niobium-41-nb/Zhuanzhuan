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
