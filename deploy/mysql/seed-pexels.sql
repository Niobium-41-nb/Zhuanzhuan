USE zhuanzhuan;
DELETE FROM product;

INSERT INTO product(user_id,category_id,title,description,price,original_price,`condition`,cover_image,view_count,favorite_count,status,created_at) VALUES
(7,7,'iPhone 15 Pro 原色钛 256G','A17 Pro+钛金属+USB-C。使用3月电池98%。',6799.00,8999.00,'几乎全新','https://images.pexels.com/photos/788946/pexels-photo-788946.jpeg?w=640&h=480&fit=crop',456,62,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(3,7,'iPhone 14 午夜色 128G','A15戴壳贴膜无划痕电池92%配件全。',4299.00,5999.00,'轻微使用痕迹','https://images.pexels.com/photos/1294886/pexels-photo-1294886.jpeg?w=640&h=480&fit=crop',320,45,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(11,7,'iPhone 15 粉色 128G','不到一月电池100%家人送Pro Max所以出。',5299.00,5999.00,'全新','https://images.pexels.com/photos/699122/pexels-photo-699122.jpeg?w=640&h=480&fit=crop',289,42,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(3,8,'MacBook Air 15 M2 8+256G','M2芯片15寸轻薄本续航一天保修明年。',7299.00,10499.00,'几乎全新','https://images.pexels.com/photos/1779487/pexels-photo-1779487.jpeg?w=640&h=480&fit=crop',380,52,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(8,8,'MacBook Pro 14 M3 Pro 18+512G','M3 Pro剪辑编程无压力XDR屏。',12999.00,16999.00,'几乎全新','https://images.pexels.com/photos/2047905/pexels-photo-2047905.jpeg?w=640&h=480&fit=crop',267,38,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(10,8,'MacBook Air M1 深空灰 8+256G','经典M1续航一天半边缘磕碰。',3299.00,7999.00,'明显使用痕迹','https://images.pexels.com/photos/812264/pexels-photo-812264.jpeg?w=640&h=480&fit=crop',534,72,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(5,9,'iPad Air M2 紫色 128G','M2+笔+键盘记笔记神器不到两月。',4299.00,5499.00,'几乎全新','https://images.pexels.com/photos/1334597/pexels-photo-1334597.jpeg?w=640&h=480&fit=crop',267,38,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(9,9,'iPad Pro M2 12.9寸 256G','Mini-LED XDR屏带二代Pencil。',6199.00,9299.00,'轻微使用痕迹','https://images.pexels.com/photos/5082579/pexels-photo-5082579.jpeg?w=640&h=480&fit=crop',189,25,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(13,10,'AirPods Pro 2 USB-C版','主动降噪+通透+空间音频换新耳塞。',1299.00,1899.00,'轻微使用痕迹','https://images.pexels.com/photos/1649771/pexels-photo-1649771.jpeg?w=640&h=480&fit=crop',423,58,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(3,10,'索尼 WH-1000XM5 头戴降噪','旗舰降噪音质细腻含收纳盒。',1699.00,2999.00,'几乎全新','https://images.pexels.com/photos/3394650/pexels-photo-3394650.jpeg?w=640&h=480&fit=crop',345,47,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(7,10,'Bose QC45 消噪耳机 白色','佩戴舒适降噪自然办公室友好。',1099.00,2299.00,'轻微使用痕迹','https://images.pexels.com/photos/3945667/pexels-photo-3945667.jpeg?w=640&h=480&fit=crop',267,35,'在售',DATE_SUB(NOW(),INTERVAL 4 DAY)),
(15,11,'索尼 A7M4 全画幅微单','3300万像素+精准对焦快门8000次。',11999.00,16999.00,'轻微使用痕迹','https://images.pexels.com/photos/1029757/pexels-photo-1029757.jpeg?w=640&h=480&fit=crop',234,33,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(5,11,'富士 X-T5 银色+18-55mm','4020万APS-C+胶片模拟直出95新。',8999.00,13999.00,'轻微使用痕迹','https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg?w=640&h=480&fit=crop',189,27,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(7,12,'Anker 737移动电源 24000mAh','140W双向快充可充笔记本出差旅行必备。',399.00,699.00,'轻微使用痕迹','https://images.pexels.com/photos/577585/pexels-photo-577585.jpeg?w=640&h=480&fit=crop',534,72,'在售',DATE_SUB(NOW(),INTERVAL 2 DAY)),
(4,13,'数据结构 C语言版 严蔚敏','计算机考研必备教材全新塑封未拆。',25.00,39.00,'全新','https://images.pexels.com/photos/256450/pexels-photo-256450.jpeg?w=640&h=480&fit=crop',345,48,'在售',DATE_SUB(NOW(),INTERVAL 1 DAY)),
(4,14,'三体 全套三册 刘慈欣','科幻神作值得反复阅读书角轻微磨损。',45.00,93.00,'轻微使用痕迹','https://images.pexels.com/photos/256450/pexels-photo-256450.jpeg?w=640&h=480&fit=crop',567,78,'在售',DATE_SUB(NOW(),INTERVAL 3 DAY)),
(6,22,'Nike Air Force 1 小白鞋 42码','经典AF1百搭神器正常穿着痕迹。',299.00,799.00,'轻微使用痕迹','https://images.pexels.com/photos/1598505/pexels-photo-1598505.jpeg?w=640&h=480&fit=crop',534,72,'在售',DATE_SUB(NOW(),INTERVAL 1 DAY)),
(10,25,'牧高笛 双人帐篷 3季帐','防雨防风露营首选用过三四次八成新。',299.00,699.00,'轻微使用痕迹','https://images.pexels.com/photos/1687845/pexels-photo-1687845.jpeg?w=640&h=480&fit=crop',423,58,'在售',DATE_SUB(NOW(),INTERVAL 1 DAY)),
(6,24,'Keep 动感单车 C1','静音磁控+App自动调节用了半年。',699.00,1799.00,'轻微使用痕迹','https://images.pexels.com/photos/1954524/pexels-photo-1954524.jpeg?w=640&h=480&fit=crop',456,62,'在售',DATE_SUB(NOW(),INTERVAL 1 DAY)),
(13,6,'雅马哈 F310 民谣吉他 41寸','入门吉他经典附教程书+调音器。',499.00,899.00,'几乎全新','https://images.pexels.com/photos/3428498/pexels-photo-3428498.jpeg?w=640&h=480&fit=crop',423,58,'在售',DATE_SUB(NOW(),INTERVAL 1 DAY));
