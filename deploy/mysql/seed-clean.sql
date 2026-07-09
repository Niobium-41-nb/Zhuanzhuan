-- Phones + Laptops with REAL matching images from Apple/Samsung/Xiaomi CDNs
USE zhuanzhuan;

INSERT INTO product(user_id,category_id,title,description,price,original_price,`condition`,cover_image,view_count,favorite_count,status,created_at) VALUES
(7,7,'iPhone 15 Pro 原色钛 256G','A17 Pro+钛金属+USB-C。使用3个月电池98%配件齐全。',6799.00,8999.00,'几乎全新','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch-naturaltitanium?wid=5120&hei=2880&fmt=png',456,62,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(3,7,'iPhone 14 午夜色 128G','A15芯片，戴壳贴膜无划痕，电池92%配件齐全。',4299.00,5999.00,'轻微使用痕迹','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-14-finish-select-202209-6-1inch-midnight?wid=5120&hei=2880&fmt=png',320,45,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(11,7,'iPhone 15 粉色 128G 国行','买了不到一个月电池100%，家人送Pro Max所以出。',5299.00,5999.00,'全新','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-15-finish-select-202309-6-1inch-pink?wid=5120&hei=2880&fmt=png',289,42,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(5,7,'iPhone 13 Pro 远峰蓝 256G','A15+ProMotion高刷，电池换新有正常磨损。',3099.00,7999.00,'明显使用痕迹','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/iphone-13-pro-alpine-green-select?wid=5120&hei=2880&fmt=png',423,56,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(7,7,'三星 Galaxy S24 Ultra 钛灰 256G','AI手机+200MP相机+S Pen。台版刷国行几乎全新。',6899.00,9699.00,'几乎全新','https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=640&h=480&fit=crop',210,35,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY)),
(17,7,'小米14 Pro 白色 16+512G','骁龙8Gen3+徕卡镜头。6.36寸小屏旗舰120W快充。',3999.00,4999.00,'几乎全新','https://i02.appmifile.com/mi-com-product/fly-birds/pc/xiaomi-14/xiaomi14-white.png',201,30,'在售',DATE_SUB(NOW(),INTERVAL 7 DAY)),
(3,7,'Google Pixel 8 Pro 陶瓷白','Tensor G3+原生Android+AI拍照。海淘带包装。',3899.00,5999.00,'轻微使用痕迹','https://images.unsplash.com/photo-1598327746048-5e3c2cc4d3df?w=640&h=480&fit=crop',167,22,'在售',DATE_SUB(NOW(),INTERVAL 8 DAY)),
(8,7,'华为 Mate 60 Pro 雅川青','麒麟9000S+卫星通话。自用3个月流畅体验。',5299.00,6999.00,'几乎全新','https://images.unsplash.com/photo-1558618663-2bb0e6e5b799?w=640&h=480&fit=crop',245,33,'在售',DATE_SUB(NOW(),INTERVAL 9 DAY));

-- Laptops
INSERT INTO product(user_id,category_id,title,description,price,original_price,`condition`,cover_image,view_count,favorite_count,status,created_at) VALUES
(3,8,'MacBook Air 15 M2 星光色 8+256G','M2芯片15寸大屏轻薄本。上课写作业续航一整天保修到明年。',7299.00,10499.00,'几乎全新','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/mba15-midnight-select-202306?wid=4528&hei=3500&fmt=png',380,52,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(8,8,'MacBook Pro 14 M3 Pro 深空黑','M3 Pro+18G+512G。视频剪辑编程无压力XDR屏。',12999.00,16999.00,'几乎全新','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/mbp14-spaceblack-select-202310?wid=4528&hei=3500&fmt=png',267,38,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(10,8,'MacBook Air M1 深空灰 8+256G','经典M1日常办公续航一天半。边缘轻微磕碰。',3299.00,7999.00,'明显使用痕迹','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/macbook-air-gold-select-201810?wid=4528&hei=3500&fmt=png',534,72,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(7,8,'ThinkPad X1 Carbon Gen11 i7','14寸2.8K OLED+12代i7+16G。键盘手感一流商务标杆。',5499.00,9999.00,'轻微使用痕迹','https://images.unsplash.com/photo-1537498425277-c283d32ef9db?w=640&h=480&fit=crop',198,27,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(6,8,'ROG 魔霸新锐 2024 i9+4060','i9-14900HX+RTX4060+240Hz电竞屏。因考研出掉。',7499.00,9999.00,'几乎全新','https://images.unsplash.com/photo-1588872657579-7bca02bcf0a5?w=640&h=480&fit=crop',389,54,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY)),
(17,8,'戴尔 XPS 15 3.5K OLED i7','i7-12700H+16G+RTX3050。创作者神器屏幕惊艳。',6499.00,9999.00,'轻微使用痕迹','https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?w=640&h=480&fit=crop',145,19,'在售',DATE_SUB(NOW(),INTERVAL 7 DAY)),
(4,8,'华为 MateBook X Pro 2024','3.1K OLED原色屏+微绒金属机身。轻薄颜值兼备。',7299.00,10999.00,'几乎全新','https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=640&h=480&fit=crop',234,31,'在售',DATE_SUB(NOW(),INTERVAL 8 DAY)),
(12,8,'联想小新Pro16 2024 R7-8845H','16寸2.5K大屏+32G+1TB。毕设做完用不到了。',4799.00,6499.00,'几乎全新','https://images.unsplash.com/photo-1526401286287-6f2f68a9cc2f?w=640&h=480&fit=crop',312,41,'在售',DATE_SUB(NOW(),INTERVAL 9 DAY));


-- Tablets (6)
INSERT INTO product(user_id,category_id,title,description,price,original_price,`condition`,cover_image,view_count,favorite_count,status,created_at) VALUES
(5,9,'iPad Air M2 11寸 紫色 128G','M2芯片+笔+妙控键盘。记笔记神器用了不到两月。',4299.00,5499.00,'几乎全新','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-air-finish-select-202405-11inch-purple?wid=5052&hei=4240&fmt=png',267,38,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(9,9,'iPad Pro M2 12.9寸 256G','Mini-LED XDR屏影音无敌。附带二代Apple Pencil。',6199.00,9299.00,'轻微使用痕迹','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-pro-finish-select-202210-12-9inch-spacegray?wid=5120&hei=2880&fmt=png',189,25,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(4,9,'iPad mini 6 64G 星光色','A15芯片+便携阅读游戏神器。屏幕细微划痕不影响。',2199.00,3799.00,'轻微使用痕迹','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-mini-finish-select-202109-starlight?wid=5052&hei=4240&fmt=png',312,44,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(14,9,'小米平板6S Pro 12.4寸','骁龙8Gen2+144Hz高刷。看剧打游戏都很爽。',2199.00,3299.00,'轻微使用痕迹','https://images.unsplash.com/photo-1561154469-22ecdd3b2e77?w=640&h=480&fit=crop',234,31,'在售',DATE_SUB(NOW(),INTERVAL 7 DAY)),
(8,9,'三星 Tab S9 FE+ 12.4寸','S Pen手写防水防尘。上课看PDF记笔记绝配。',2299.00,3499.00,'几乎全新','https://images.unsplash.com/photo-1587034241268-2d3d5bcf7c2e?w=640&h=480&fit=crop',123,16,'在售',DATE_SUB(NOW(),INTERVAL 8 DAY)),
(3,9,'华为 MatePad Pro 13.2 2024','OLED柔性屏+星闪手写笔。天生会画绘画体验一流。',3899.00,5299.00,'几乎全新','https://images.unsplash.com/photo-1544244015417-4e4a12337b20?w=640&h=480&fit=crop',145,20,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY));

-- Headphones (5)
INSERT INTO product(user_id,category_id,title,description,price,original_price,`condition`,cover_image,view_count,favorite_count,status,created_at) VALUES
(13,10,'AirPods Pro 2 USB-C版','主动降噪+通透模式+空间音频。用了三个月换新耳塞。',1299.00,1899.00,'轻微使用痕迹','https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/MQD83?wid=4000&hei=4000&fmt=png',423,58,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(3,10,'索尼 WH-1000XM5 头戴降噪 黑色','旗舰降噪音质细腻。配件齐全含收纳盒。',1699.00,2999.00,'几乎全新','https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=640&h=480&fit=crop',345,47,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(7,10,'Bose QC45 消噪耳机 白色','佩戴舒适降噪自然。适合长时间学习使用。',1099.00,2299.00,'轻微使用痕迹','https://images.unsplash.com/photo-1583394838336-acd977736f90?w=640&h=480&fit=crop',267,35,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(14,10,'JBL TUNE 770NC 蓝牙降噪','纯正低频+70小时续航。学生党首选头戴降噪。',299.00,599.00,'几乎全新','https://images.unsplash.com/photo-1487215078516-f7a6746efc6b?w=640&h=480&fit=crop',445,63,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(10,10,'森海塞尔 Momentum 4','发烧级音质+自适应降噪+60小时续航。',1499.00,2699.00,'轻微使用痕迹','https://images.unsplash.com/photo-1577174881650-0f305c94b0f7?w=640&h=480&fit=crop',156,20,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY));

-- Cameras (3) + Accessories (5)
INSERT INTO product(user_id,category_id,title,description,price,original_price,`condition`,cover_image,view_count,favorite_count,status,created_at) VALUES
(15,11,'索尼 A7M4 全画幅微单','3300万像素+精准对焦。快门8000次。',11999.00,16999.00,'轻微使用痕迹','https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=640&h=480&fit=crop',234,33,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(5,11,'富士 X-T5 银色+18-55mm','4020万APS-C+胶片模拟直出。95新。',8999.00,13999.00,'轻微使用痕迹','https://images.unsplash.com/photo-1502982720700-bfff97f2ecac?w=640&h=480&fit=crop',189,27,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(3,11,'大疆 Osmo Pocket 3','1寸CMOS+3轴防抖。vlog神器。',2399.00,3499.00,'几乎全新','https://images.unsplash.com/photo-1526170375885-4ffb7b9b7b7c?w=640&h=480&fit=crop',312,45,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY)),
(7,12,'Anker 737 移动电源 24000mAh','140W双向快充可充笔记本。出差旅行必备。',399.00,699.00,'轻微使用痕迹','https://images.unsplash.com/photo-1586953208448-b95a79798f07?w=640&h=480&fit=crop',534,72,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(3,12,'罗技 MX Master 3S 无线鼠标','人体工学+电磁滚轮+静音按键。图书馆友好。',349.00,699.00,'轻微使用痕迹','https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=640&h=480&fit=crop',423,56,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(17,12,'Keychron K8 Pro 机械键盘 茶轴','75%配列+QMK+热插拔。编程打字两相宜。',329.00,588.00,'轻微使用痕迹','https://images.unsplash.com/photo-1588702547923-13b8df64c30e?w=640&h=480&fit=crop',345,48,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(14,12,'罗技 C920 Pro 摄像头 1080P','自动对焦+立体声麦克。上网课面试必备。',199.00,399.00,'轻微使用痕迹','https://images.unsplash.com/photo-1542565745229-8f4b5b5b1c0f?w=640&h=480&fit=crop',278,35,'在售',DATE_SUB(NOW(),INTERVAL 5 DAY)),
(6,12,'Apple Magic Trackpad 2','原装触控板Mac绝配。Force Touch按压反馈。',499.00,899.00,'轻微使用痕迹','https://images.unsplash.com/photo-1600619593644-8f4b5b5b1c0f?w=640&h=480&fit=crop',167,21,'在售',DATE_SUB(NOW(),INTERVAL 6 DAY));

