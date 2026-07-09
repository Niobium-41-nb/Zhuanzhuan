USE zhuanzhuan;

INSERT INTO product (user_id,category_id,title,description,price,original_price,`condition`,cover_image,view_count,favorite_count,status,created_at) VALUES
-- Phones (8)
(7,7,'iPhone 15 Pro 原色钛 256G','A17 Pro+钛金属+USB-C。使用3个月，电池98%，配件齐全。',6799.00,8999.00,'几乎全新','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch-naturaltitanium?wid=5120&hei=2880&fmt=png',456,62,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(3,7,'iPhone 14 午夜色 128G','A15芯片，戴壳贴膜无划痕，电池92%，配件齐全。',4299.00,5999.00,'轻微使用痕迹','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-finish-select-202209-6-1inch-midnight?wid=5120&hei=2880&fmt=png',320,45,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(11,7,'iPhone 15 粉色 128G','买了不到一个月电池100%，家人送Pro Max所以出。',5299.00,5999.00,'全新','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-15-finish-select-202309-6-1inch-pink?wid=5120&hei=2880&fmt=png',289,42,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(5,7,'iPhone 13 Pro 远峰蓝 256G','A15+ProMotion高刷。电池换新有正常磨损。',3099.00,7999.00,'明显使用痕迹','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-pro-alpine-green-select?wid=5120&hei=2880&fmt=png',423,56,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(7,7,'三星 Galaxy S24 Ultra 钛灰','AI手机+200MP相机+S Pen。台版刷国行。',6899.00,9699.00,'几乎全新','https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=640&h=480&fit=crop',210,35,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY)),
(17,7,'小米14 Pro 白色 16+512G','骁龙8Gen3+徕卡镜头。6.36寸小屏旗舰。',3999.00,4999.00,'几乎全新','https://i02.appmifile.com/mi-com-product/fly-birds/pc/xiaomi-14/xiaomi14-white.png',201,30,'在售',DATE_SUB(NOW(),INTERVAL 7 DAY)),
(3,7,'Google Pixel 8 Pro 陶瓷白','Tensor G3+原生Android+AI拍照。海淘带包装。',3899.00,5999.00,'轻微使用痕迹','https://images.unsplash.com/photo-1598327746048-5e3c2cc4d3df?w=640&h=480&fit=crop',167,22,'在售',DATE_SUB(NOW(),INTERVAL 8 DAY)),
(8,7,'华为 Mate 60 Pro 雅川青','麒麟9000S+卫星通话。自用3个月流畅。',5299.00,6999.00,'几乎全新','https://images.unsplash.com/photo-1558618663-2bb0e6e5b799?w=640&h=480&fit=crop',245,33,'在售',DATE_SUB(NOW(),INTERVAL 9 DAY)),

-- Laptops (8)
(3,8,'MacBook Air 15 M2 星光色 8+256G','M2芯片15寸大屏轻薄本。续航一整天，保修到明年。',7299.00,10499.00,'几乎全新','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/mba15-midnight-select-202306?wid=4528&hei=3500&fmt=png',380,52,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(8,8,'MacBook Pro 14 M3 Pro 深空黑','M3 Pro+18G+512G。剪辑编程无压力XDR屏。',12999.00,16999.00,'几乎全新','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/mbp14-spaceblack-select-202310?wid=4528&hei=3500&fmt=png',267,38,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(10,8,'MacBook Air M1 深空灰 8+256G','经典M1日常办公续航一天半。边缘有磕碰。',3299.00,7999.00,'明显使用痕迹','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/macbook-air-gold-select-201810?wid=4528&hei=3500&fmt=png',534,72,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(7,8,'ThinkPad X1 Carbon Gen11','14寸2.8K OLED+12代i7+16G。键盘手感一流。',5499.00,9999.00,'轻微使用痕迹','https://images.unsplash.com/photo-1537498425277-c283d32ef9db?w=640&h=480&fit=crop',198,27,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(6,8,'ROG 魔霸新锐 2024','i9-14900HX+RTX4060+240Hz屏。因考研出掉。',7499.00,9999.00,'几乎全新','https://images.unsplash.com/photo-1588872657579-7bca02bcf0a5?w=640&h=480&fit=crop',389,54,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY)),
(17,8,'戴尔 XPS 15 OLED','i7-12700H+16G+RTX3050。屏幕惊艳。',6499.00,9999.00,'轻微使用痕迹','https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?w=640&h=480&fit=crop',145,19,'在售',DATE_SUB(NOW(),INTERVAL 7 DAY)),
(4,8,'华为 MateBook X Pro 2024','3.1K OLED原色屏+微绒金属机身。',7299.00,10999.00,'几乎全新','https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=640&h=480&fit=crop',234,31,'在售',DATE_SUB(NOW(),INTERVAL 8 DAY)),
(12,8,'联想小新Pro16 2024','16寸2.5K+32G+1TB。毕设做完用不到了。',4799.00,6499.00,'几乎全新','https://images.unsplash.com/photo-1526401286287-6f2f68a9cc2f?w=640&h=480&fit=crop',312,41,'在售',DATE_SUB(NOW(),INTERVAL 9 DAY)),

-- Tablets (6)
(5,9,'iPad Air M2 11寸 紫色 128G','M2芯片+笔+键盘。记笔记神器。',4299.00,5499.00,'几乎全新','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-202405-11inch-purple?wid=5052&hei=4240&fmt=png',267,38,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(9,9,'iPad Pro M2 12.9寸 256G','Mini-LED XDR屏影音无敌。带二代Pencil。',6199.00,9299.00,'轻微使用痕迹','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-pro-finish-select-202210-12-9inch-spacegray?wid=5120&hei=2880&fmt=png',189,25,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(4,9,'iPad mini 6 64G 星光色','A15+便携阅读游戏神器。屏幕细微划痕。',2199.00,3799.00,'轻微使用痕迹','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-mini-finish-select-202109-starlight?wid=5052&hei=4240&fmt=png',312,44,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(14,9,'小米平板6S Pro 12.4寸','骁龙8Gen2+144Hz高刷屏。看剧打游戏爽。',2199.00,3299.00,'轻微使用痕迹','https://images.unsplash.com/photo-1561154469-22ecdd3b2e77?w=640&h=480&fit=crop',234,31,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(8,9,'三星 Tab S9 FE+ 12.4寸','S Pen手写防水防尘。上课PDF笔记绝配。',2299.00,3499.00,'几乎全新','https://images.unsplash.com/photo-1587034241268-2d3d5bcf7c2e?w=640&h=480&fit=crop',123,16,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY)),
(3,9,'华为 MatePad Pro 13.2 2024','OLED柔性屏+星闪手写笔。天生会画。',3899.00,5299.00,'几乎全新','https://images.unsplash.com/photo-1544244015417-4e4a12337b20?w=640&h=480&fit=crop',145,20,'在售',DATE_SUB(NOW(),INTERVAL 7 DAY)),

-- Headphones (5)
(13,10,'AirPods Pro 2 USB-C版','主动降噪+通透+空间音频。换新耳塞。',1299.00,1899.00,'轻微使用痕迹','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MQD83?wid=4000&hei=4000&fmt=png',423,58,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(3,10,'索尼 WH-1000XM5 头戴降噪 黑色','旗舰降噪音质细腻。含收纳盒。',1699.00,2999.00,'几乎全新','https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=640&h=480&fit=crop',345,47,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(7,10,'Bose QC45 消噪耳机 白色','佩戴舒适降噪自然。适合学习使用。',1099.00,2299.00,'轻微使用痕迹','https://images.unsplash.com/photo-1583394838336-acd977736f90?w=640&h=480&fit=crop',267,35,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(14,10,'JBL TUNE 770NC 蓝牙降噪','纯正低频+70小时续航。学生党首选。',299.00,599.00,'几乎全新','https://images.unsplash.com/photo-1487215078516-f7a6746efc6b?w=640&h=480&fit=crop',445,63,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(10,10,'森海塞尔 Momentum 4','发烧级音质+自适应降噪+60小时续航。',1499.00,2699.00,'轻微使用痕迹','https://images.unsplash.com/photo-1577174881650-0f305c94b0f7?w=640&h=480&fit=crop',156,20,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY)),

-- Cameras (3)
(15,11,'索尼 A7M4 全画幅微单','3300万像素+精准对焦。快门8000次。',11999.00,16999.00,'轻微使用痕迹','https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=640&h=480&fit=crop',234,33,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(5,11,'富士 X-T5 银色+18-55mm','4020万APS-C+胶片模拟直出。95新。',8999.00,13999.00,'轻微使用痕迹','https://images.unsplash.com/photo-1502982720700-bfff97f2ecac?w=640&h=480&fit=crop',189,27,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(3,11,'大疆 Osmo Pocket 3 口袋云台','1寸CMOS+3轴防抖。vlog神器。',2399.00,3499.00,'几乎全新','https://images.unsplash.com/photo-1526170375885-4ffb7b9b7b7c?w=640&h=480&fit=crop',312,45,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),

-- Accessories (5)
(7,12,'Anker 737 移动电源 24000mAh','140W双向快充可充笔记本。出差旅行必备。',399.00,699.00,'轻微使用痕迹','https://images.unsplash.com/photo-1586953208448-b95a79798f07?w=640&h=480&fit=crop',534,72,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(3,12,'罗技 MX Master 3S 无线鼠标','人体工学+电磁滚轮+静音。图书馆友好。',349.00,699.00,'轻微使用痕迹','https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=640&h=480&fit=crop',423,56,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(17,12,'Keychron K8 Pro 机械键盘 茶轴','75%配列+QMK+热插拔。编程打字两相宜。',329.00,588.00,'轻微使用痕迹','https://images.unsplash.com/photo-1588702547923-13b8df64c30e?w=640&h=480&fit=crop',345,48,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(14,12,'罗技 C920 Pro 摄像头 1080P','自动对焦+立体声。上网课面试必备。',199.00,399.00,'轻微使用痕迹','https://images.unsplash.com/photo-1542565745229-8f4b5b5b1c0f?w=640&h=480&fit=crop',278,35,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(6,12,'Apple Magic Trackpad 2','原装触控板Mac绝配。Force Touch。',499.00,899.00,'轻微使用痕迹','https://images.unsplash.com/photo-1600619593644-8f4b5b5b1c0f?w=640&h=480&fit=crop',167,21,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY));

-- Books & Study
INSERT INTO product (user_id,category_id,title,description,price,original_price,`condition`,cover_image,view_count,favorite_count,status,created_at) VALUES
(4,13,'数据结构 C语言版 严蔚敏','计算机考研必备教材。全新塑封未拆。',25.00,39.00,'全新','https://images.unsplash.com/photo-1497633762265-9d179a990aa6?w=640&h=480&fit=crop',345,48,'在售',DATE_SUB(NOW(),INTERVAL 1 DAY)),
(9,13,'计算机网络 自顶向下 7版','经典教材。有标注不影响阅读。',45.00,89.00,'轻微使用痕迹','https://images.unsplash.com/photo-1532012197267-da84d127e765?w=640&h=480&fit=crop',267,36,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(4,14,'三体 全套三册 刘慈欣','科幻神作值得反复阅读。轻微磨损。',45.00,93.00,'轻微使用痕迹','https://images.unsplash.com/photo-1512820790803-83ca734da794?w=640&h=480&fit=crop',567,78,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(6,14,'挪威的森林 村上春树','村上春树代表作。青春爱情经典。',16.00,32.00,'轻微使用痕迹','https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=640&h=480&fit=crop',289,38,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(7,15,'时间简史 霍金 插图版','宇宙学科普必读。全彩插图版。',35.00,68.00,'轻微使用痕迹','https://images.unsplash.com/photo-1456513080510-7f3e9f3b5c1e?w=640&h=480&fit=crop',267,35,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(17,15,'代码整洁之道 Martin','程序员进阶必读。提升代码质量经典。',35.00,59.00,'轻微使用痕迹','https://images.unsplash.com/photo-1544716278-1c3c2ce7e6a0?w=640&h=480&fit=crop',198,27,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY)),
(3,16,'考研数学一 张宇36讲','2025最新版全套。买错了出掉。',55.00,108.00,'全新','https://images.unsplash.com/photo-1524995997946-a1c3c2ce7e6a0?w=640&h=480&fit=crop',398,54,'在售',DATE_SUB(NOW(),INTERVAL 7 DAY)),
(8,16,'考研英语真题详解 黄皮书','2005-2024全套含解析。',35.00,76.00,'轻微使用痕迹','https://images.unsplash.com/photo-1481627834876-8f4b5b5b1c0f?w=640&h=480&fit=crop',312,42,'在售',DATE_SUB(NOW(),INTERVAL 8 DAY));

-- Life & Fashion
INSERT INTO product (user_id,category_id,title,description,price,original_price,`condition`,cover_image,view_count,favorite_count,status,created_at) VALUES
(16,17,'宿舍迷你冰箱 15L','夏天冰饮料冬天热牛奶。功率低不跳闸。',129.00,299.00,'轻微使用痕迹','https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=640&h=480&fit=crop',534,75,'在售',DATE_SUB(NOW(),INTERVAL 1 DAY)),
(5,17,'LED护眼台灯 三档调光','无频闪+长臂调节。夹子底座两用。',49.00,99.00,'几乎全新','https://images.unsplash.com/photo-1503676260728-1bb6b3f6a83f?w=640&h=480&fit=crop',345,47,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(12,18,'美的电饭煲 3L 智能预约','宿舍小厨房必备。煮饭煲汤不粘。',89.00,199.00,'轻微使用痕迹','https://images.unsplash.com/photo-1586105251261-72a75640488e?w=640&h=480&fit=crop',345,47,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(8,18,'小熊空气炸锅 3.5L 可视化','无油健康烹饪。可视窗口看食物。',129.00,299.00,'轻微使用痕迹','https://images.unsplash.com/photo-1598928506311-2c3c2ce7e6a0?w=640&h=480&fit=crop',423,58,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(11,19,'SK-II 神仙水 230ml 全新','免税店购入未拆封。日期到2027年。',799.00,1590.00,'全新','https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=640&h=480&fit=crop',345,48,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(16,19,'MUJI 香薰机+精油套装','超声波静音。薰衣草+甜橙精油。',129.00,298.00,'轻微使用痕迹','https://images.unsplash.com/photo-1571781926291-2c3c2ce7e6a0?w=640&h=480&fit=crop',178,23,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY)),
(11,20,'优衣库 轻薄羽绒服 米色 M','轻暖便携可收纳。只穿了一季。',149.00,399.00,'轻微使用痕迹','https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=640&h=480&fit=crop',423,58,'在售',DATE_SUB(NOW(),INTERVAL 7 DAY)),
(6,20,'Nike 加绒卫衣 灰色 S码','加绒保暖版型好看。买小了穿不了。',99.00,299.00,'几乎全新','https://images.unsplash.com/photo-1521572163474-2c3c2ce7e6a0?w=640&h=480&fit=crop',345,47,'在售',DATE_SUB(NOW(),INTERVAL 8 DAY)),
(5,21,'Levis 501 直筒牛仔裤 28码','经典501中腰直筒。穿洗过几次。',299.00,799.00,'轻微使用痕迹','https://images.unsplash.com/photo-1475178626620-a4d074967452?w=640&h=480&fit=crop',345,48,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(6,22,'Nike Air Force 1 小白鞋 42码','经典AF1百搭神器。正常穿着痕迹。',299.00,799.00,'轻微使用痕迹','https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=640&h=480&fit=crop',534,72,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(11,22,'Adidas Samba OG 德训鞋 37码','复古德训鞋颜值在线。穿不到十次。',399.00,799.00,'轻微使用痕迹','https://images.unsplash.com/photo-1525966222134-2c3c2ce7e6a0?w=640&h=480&fit=crop',423,58,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(5,23,'小米 20寸登机箱 商务款','静音万向轮+TSA海关锁。短途出差好伙伴。',199.00,399.00,'轻微使用痕迹','https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=640&h=480&fit=crop',345,48,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),

-- Sports & Outdoor & Other
(6,24,'Keep 动感单车 C1 智能调阻','静音磁控+App自动调节。用了半年。',699.00,1799.00,'轻微使用痕迹','https://images.unsplash.com/photo-1571019614242-c5c5a6e2bed2?w=640&h=480&fit=crop',456,62,'在售',DATE_SUB(NOW(),INTERVAL 1 DAY)),
(10,24,'YONEX 天斧88D Pro 羽毛球拍','进攻型杀球暴力。打五六次送拍套。',699.00,1299.00,'轻微使用痕迹','https://images.unsplash.com/photo-1517836357463-2c3c2ce7e6a0?w=640&h=480&fit=crop',345,47,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(10,25,'牧高笛 双人帐篷 3季帐','防雨防风露营首选。用过三四次。',299.00,699.00,'轻微使用痕迹','https://images.unsplash.com/photo-1504280390367-361c97edc0a3?w=640&h=480&fit=crop',423,58,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(9,25,'膳魔师 保温杯 1.2L','24小时保温。冬天爬山一杯热水。',99.00,249.00,'轻微使用痕迹','https://images.unsplash.com/photo-1478131143085-2c3c2ce7e6a0?w=640&h=480&fit=crop',267,35,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(13,6,'雅马哈 F310 民谣吉他 41寸','入门吉他经典款。附教程书+调音器。',499.00,899.00,'几乎全新','https://images.unsplash.com/photo-1511671782779-2c3c2ce7e6a0?w=640&h=480&fit=crop',423,58,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(5,6,'富士 Instax Mini 12 拍立得 粉色','可爱拍立得出片有质感。含相纸8张。',299.00,499.00,'轻微使用痕迹','https://images.unsplash.com/photo-1598488036847-2c3c2ce7e6a0?w=640&h=480&fit=crop',345,48,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY)),
(4,6,'Kindle Paperwhite 5 8G','6.8寸纯平墨水屏。看过几本书。',599.00,1068.00,'轻微使用痕迹','https://images.unsplash.com/photo-1598488036847-2c3c2ce7e6a0?w=640&h=480&fit=crop',312,42,'在售',DATE_SUB(NOW(),INTERVAL 7 DAY)),

-- End
