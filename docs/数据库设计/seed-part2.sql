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
