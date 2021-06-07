#coding: utf-8 
namespace :db do 
desc "添加货物分类数据" 
task :create_goods_cat_data => :environment do 
  GoodsCatFeeConfig.destroy_all 
  GoodsCat.destroy_all 
  root_goods_cat = GoodsCat.find_or_create_by_name('货物分类') 
  #分理处ids 
  branches = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 中转部 西马林 理赔部 龙湖 元（西环）] 
  branches = %w[郑州公司]

  #邯郸邢台11县
  handan_11 = %w[鑫港（邯郸） 鸡泽 肥乡 邱县 曲周 巨鹿 内丘 隆尧 广宗 平乡 任县 柏乡]
  handan_11 = %w[鸡泽]

  #河南ids
  henan_branches = %w[三门峡 洛阳 洛阳二部  驻马店 漯河 许昌 肉联厂 济源 鹤壁 焦作 关林 新乡 开封 长葛 港区（新郑）]
  henan_branches = %w[三门峡 洛阳 驻马店]
  #山西
  #sx_branches = %w[长治 太原 晋城]
  sx_branches = %w[晋城]

  #河北ids
  hb_branches = %w[邯郸 邢台 武安 峰峰 魏县 水冶 磁县 临漳 沙河 大名 石家庄 馆陶 广平 成安 侯马
 涉县 马头 宁晋 永年 威县 邯郸二部 清河 正定 北方汽配（石家庄） 南和县 黎城 武安二部
 邯郸铁西 北方（邯郸） 亚森（邯郸） 豫让桥(邢台) 张庄（磁县） 华北商贸（石家庄）]

  hb_branches = %w[邯郸 邢台]
  #到河南的运费数据
  hn_goods_cat_data = [
    %w[	板	50	]	,
    %w[	板（重）	125	]	,
    %w[	办公文件（箱）	88	]	,
    %w[	包装袋	250	]	,
    %w[	包装纸	250	]	,
    %w[	保健品	91	]	,
    %w[	保险杠	54	]	,
    %w[	鲍鱼果	100	]	,
    %w[	壁纸	333	]	,
    %w[	壁纸胶	400	]	,
    %w[	便池	150	]	,
    %w[	变速箱	263	]	,
    %w[	玻璃	250	]	,
    %w[	玻璃家具	83	]	,
    %w[	玻璃胶	400	]	,
    %w[	玻璃门	114	]	,
    %w[	玻璃纸	111	]	,
    %w[	薄膜	357	]	,
    %w[	布	119	]	,
      %w[	布卷	100	]	,
      %w[	布条	88	]	,
      %w[	菜板、筷子	86	]	,
      %w[	餐桌	59	]	,
      %w[	茶几	88	]	,
      %w[	茶几配件	71	]	,
      %w[	茶具	147	]	,
      %w[	差速箱	233	]	,
      %w[	车门	104	]	,
      %w[	车座套	300	]	,
      %w[	齿轮泵	12500	]	,
      %w[	齿轮油	75	]	,
      %w[	抽水箱	77	]	,
      %w[	厨具（锅）	29	]	,
      %w[	橱柜	300	]	,
      %w[	橱柜	143	]	,
      %w[	窗户	111	]	,
      %w[	窗帘杆	139	]	,
      %w[	窗帘配件（箱）	58	]	,
      %w[	床板	47	]	,
      %w[	床垫	35	]	,
      %w[	床盖	42	]	,
      %w[	床头	0	]	,
      %w[	床头柜	65	]	,
      %w[	瓷砖	333	]	,
      %w[	打印纸	200	]	,
      %w[	大灯（箱）	45	]	,
      %w[	大理石	526	]	,
      %w[	袋子	100	]	,
      %w[	蛋糕	75	]	,
      %w[	挡风玻璃（前）	1667	]	,
      %w[	倒车镜	75	]	,
      %w[	灯	36	]	,
      %w[	灯（小）	150	]	,
      %w[	灯带（箱）	500	]	,
      %w[	灯底座	182	]	,
      %w[	灯架	150	]	,
      %w[	灯具	114	]	,
      %w[	灯具（方）	67	]	,
      %w[	地板	172	]	,
      %w[	地板砖（箱）	770	]	,
      %w[	地产鞋	83	]	,
      %w[	地漏	50	]	,
      %w[	地毯（卷）	0	]	,
      %w[	电池	176	]	,
      %w[	电动车	45	]	,
      %w[	电动摩托车	36	]	,
      %w[	电饭锅	40	]	,
      %w[	电暖气	63	]	,
      %w[	电暖扇	30	]	,
      %w[	电瓶	438	]	,
      %w[	电瓶充电器	217	]	,
      %w[	电器（皮）	0	]	,
      %w[	电器配件	48	]	,
      %w[	电器配件（袋）	59	]	,
      %w[	电视	130	]	,
      %w[	电线	240	]	,
      %w[	电子称	56	]	,
      %w[	电子琴	0	]	,
      %w[	吊灯	62	]	,
      %w[	调料	857	]	,
      %w[	调料（桶）	50	]	,
      %w[	顶底	36	]	,
      %w[	冻品	155	]	,
      %w[	豆干	83	]	,
      %w[	蹲便池	101	]	,
      %w[	发动机	170	]	,
      %w[	发动机（摩托）	127	]	,
      %w[	阀门	800	]	,
      %w[	方向盘套	93	]	,
      %w[	防爆膜	268	]	,
      %w[	防冻液	100	]	,
      %w[	粉	200	]	,
      %w[	风板	45	]	,
      %w[	扶手	125	]	,
      %w[	扶手	200	]	,
      %w[	服装包	91	]	,
      %w[	干果	145	]	,
      %w[	钢板	333	]	,
      %w[	钢化杯	190	]	,
      %w[	钢架	0	]	,
      %w[	钢卷	150	]	,
      %w[	钢圈（小）	175	]	,
      %w[	钢丝	111	]	,
      %w[	工程胎	42	]	,
      %w[	工具箱	32	]	,
      %w[	工艺品	75	]	,
      %w[	枸杞	85	]	,
      %w[	瓜子（30斤）	104	]	,
      %w[	管材	128	]	,
      %w[	管件	143	]	,
      %w[	管件（袋）	75	]	,
      %w[	广告牌	500	]	,
      %w[	柜子	56	]	,
      %w[	锅	0	]	,
      %w[	果汁机	69	]	,
      %w[	海藻	93	]	,
      %w[	合页	577	]	,
      %w[	和田枣	97	]	,
      %w[	核桃（袋）	82	]	,
      %w[	红豆汉堡	54	]	,
      %w[	红外线灯（箱）	72	]	,
      %w[	后车轮	58	]	,
      %w[	后桥	186	]	,
      %w[	化工	200	]	,
      %w[	化工机油（大桶）	250	]	,
      %w[	化妆品（轻）	150	]	,
      %w[	换气扇	222	]	,
      %w[	黄油（袋）	357	]	,
      %w[	机器	200	]	,
      %w[	机油	75	]	,
      %w[	家具	167	]	,
      %w[	家具板	111	]	,
      %w[	架子	0	]	,
      %w[	减振器	242	]	,
      %w[	酱菜	250	]	,
      %w[	胶（桶）	125	]	,
      %w[	胶带	100	]	,
      %w[	胶管	164	]	,
      %w[	胶条	77	]	,
      %w[	角磨机	96	]	,
      %w[	脚垫	86	]	,
      %w[	洁具	88	]	,
      %w[	洁具（盆）	76	]	,
      %w[	酒	63	]	,
      %w[	卡片	421	]	,
      %w[	开关	89	]	,
      %w[	烤肠	133	]	,
      %w[	空心轴	5000	]	,
      %w[	扣板	115	]	,
      %w[	筷子	178	]	,
      %w[	宽粉	147	]	,
      %w[	框玻璃门	75	]	,
      %w[	腊肉	142	]	,
      %w[	乐器	190	]	,
      %w[	晾衣架	46	]	,
      %w[	炉子	167	]	,
      %w[	滤纸	35	]	,
      %w[	铝材	250	]	,
      %w[	铝塑板	208	]	,
      %w[	轮胎	76	]	,
      %w[	轮胎1200	28	]	,
      %w[	毛巾架	60	]	,
      %w[	煤气灶	111	]	,
      %w[	美容品	0	]	,
      %w[	门	89	]	,
      %w[	门板	91	]	,
      %w[	门锁（箱）	56	]	,
      %w[	门套	71	]	,
      %w[	门套（塑料包装）	500	]	,
      %w[	密封条	1111	]	,
      %w[	面包	60	]	,
      %w[	名片	285	]	,
      %w[	模特（工艺）	0	]	,
      %w[	膜	160	]	,
      %w[	摩托外胎	667	]	,
      %w[	木地板	129	]	,
      %w[	木柜	74	]	,
      %w[	木盆	58	]	,
      %w[	木梯	63	]	,
      %w[	木条	125	]	,
      %w[	奶粉	147	]	,
      %w[	奶瓶	45	]	,
      %w[	牛仔裤	0	]	,
      %w[	农药	0	]	,
      %w[	农药（箱）	175	]	,
      %w[	女式凉鞋	52	]	,
      %w[	排气筒	0	]	,
      %w[	配件	136	]	,
      %w[	配件(车锅)	269	]	,
      %w[	配件（车轮）	96	]	,
      %w[	配件（电子）	220	]	,
      %w[	配件（后备箱）	148	]	,
      %w[	配件（护膝）	47	]	,
      %w[	配件（滑轮）	625	]	,
      %w[	配件（化油器）	111	]	,
      %w[	配件（火花塞）	200	]	,
      %w[	配件（键盘）	83	]	,
      %w[	配件（摩车框）	39	]	,
      %w[	配件（汽）	79	]	,
      %w[	配件（轻）	80	]	,
      %w[	配件（头盔）	133	]	,
      %w[	配件（凸轮轴）	150	]	,
      %w[	配件（纸质）	120	]	,
      %w[	配件（重）	250	]	,
      %w[	盆	125	]	,
      %w[	膨化食品	38	]	,
      %w[	皮料	25	]	,
      %w[	扑克	167	]	,
      %w[	普通秤	55	]	,
      %w[	漆	190	]	,
      %w[	漆（桶）	167	]	,
      %w[	起动机	300	]	,
      %w[	气泵	0	]	,
      %w[	气瓶	112	]	,
      %w[	汽车座椅	75	]	,
      %w[	汽配（地胶）	200	]	,
      %w[	汽配（门）	37	]	,
      %w[	汽配（纸箱）	155	]	,
      %w[	汽油机	100	]	,
      %w[	器械	375	]	,
      %w[	前车头	105	]	,
      %w[	切割机	125	]	,
      %w[	燃气灶	141	]	,
      %w[	热水器	62	]	,
      %w[	人造石	444	]	,
      %w[	日化	200	]	,
      %w[	润滑油	114	]	,
      %w[	沙发	52	]	,
      %w[	沙发配件（袋）	30	]	,
      %w[	沙琪玛	95	]	,
      %w[	刹车锅	286	]	,
      %w[	刹车片	266	]	,
      %w[	砂轮	230	]	,
      %w[	砂纸	171	]	,
      %w[	晒衣架	61	]	,
      %w[	晒衣架配件	143	]	,
      %w[	晒衣架线条	71	]	,
      %w[	山楂片	105	]	,
      %w[	食化	100	]	,
      %w[	食品	86	]	,
      %w[	食品添加剂	110	]	,
      %w[	手机	0	]	,
      %w[	手机（配件）	0	]	,
      %w[	兽药	150	]	,
      %w[	双面胶卷（圆）	35	]	,
      %w[	水泵	250	]	,
      %w[	水槽	63	]	,
      %w[	水管	77	]	,
      %w[	水晶灯	40	]	,
      %w[	水晶球	100	]	,
      %w[	水龙头	83	]	,
      %w[	水箱	71	]	,
      %w[	饲料	167	]	,
      %w[	塑料膜	80	]	,
      %w[	塑料制品	60	]	,
      %w[	锁	89	]	,
      %w[	锁具	133	]	,
      %w[	探照灯	0	]	,
      %w[	糖	62	]	,
      %w[	糖果	70	]	,
      %w[	糖果箱	120	]	,
      %w[	陶瓷	208	]	,
      %w[	梯子	50	]	,
      %w[	铁架	0	]	,
      %w[	童鞋	100	]	,
      %w[	头盔	95	]	,
      %w[	涂料	166	]	,
      %w[	拖把	38	]	,
      %w[	拖布池	86	]	,
      %w[	玩具	23	]	,
      %w[	网	45	]	,
      %w[	卫生巾	74	]	,
      %w[	卫生用品	100	]	,
      %w[	卫生纸	43	]	,
      %w[	温州鞋	38	]	,
      %w[	文具	85	]	,
      %w[	文具盒	50	]	,
      %w[	无纺布	44	]	,
      %w[	无花果	87	]	,
      %w[	五金	278	]	,
      %w[	洗发水	200	]	,
      %w[	洗手粉	115	]	,
      %w[	洗手盆	10	]	,
      %w[	线	0	]	,
      %w[	线缆(袋）	188	]	,
      %w[	线绳	0	]	,
      %w[	线条	125	]	,
      %w[	线砖（箱）	357	]	,
      %w[	香肠	100	]	,
      %w[	橡胶配件	114	]	,
      %w[	消毒柜	50	]	,
      %w[	消音器	114	]	,
      %w[	小刀	200	]	,
      %w[	鞋	45	]	,
      %w[	新疆枣	91	]	,
      %w[	杏仁	107	]	,
      %w[	宣传彩页	200	]	,
      %w[	宣传品	200	]	,
      %w[	亚克力板	3.5	]	,
      %w[	颜料	0	]	,
      %w[	扬声器	0	]	,
      %w[	腰果	60	]	,
      %w[	药	119	]	,
      %w[	药品	133	]	,
      %w[	液压油	200	]	,
      %w[	衣架	250	]	,
      %w[	衣架箱	48	]	,
      %w[	椅子	40	]	,
      %w[	油缸	80	]	,
      %w[	油漆（桶）	156	]	,
      %w[	油箱	100	]	,
      %w[	油烟机	53	]	,
      %w[	浴缸	76	]	,
      %w[	浴柜	86	]	,
      %w[	浴镜	234	]	,
      %w[	浴盆	37	]	,
      %w[	浴室柜	117	]	,
      %w[	浴室镜	136	]	,
      %w[	原子灰	188	]	,
      %w[	运动鞋	67	]	,
      %w[	枣	132	]	,
      %w[	芝麻（袋）100	78	]	,
      %w[	纸板	147	]	,
      %w[	纸杯	49	]	,
      %w[	纸尿片	29	]	,
      %w[	纸筒（圆）	114	]	,
      %w[	轴头	263	]	,
      %w[	柱子	125	]	,
      %w[	装饰材料（天花）	83	]	,
      %w[	资料	4000	]	,
      %w[	坐便	63	]	,
      %w[	坐垫	83	]	,
      %w[	座桥	33	]	,
      %w[	座套	100	]	,
    ]
    #先生成货物分类数据 
    hn_goods_cat_data.each do |cat|
      goods_cat = GoodsCat.find_by_name(cat.first)
      GoodsCat.create!(:name => cat.first,:parent_id => root_goods_cat.id ) unless goods_cat
    end
    #分理处到河南各点的运费数据
    branches.each do |f_org_name|
      f_org = Branch.find_by_name(f_org_name)
      henan_branches.each do |t_org_name|
        t_org = Branch.find_by_name(t_org_name)
        gcfc = GoodsCatFeeConfig.create!(:from_org => f_org,:to_org => t_org)
        hn_goods_cat_data.each do |cat|
          goods_cat = GoodsCat.find_by_name(cat.first)
          gcfc.goods_cat_fee_config_lines.create(:goods_cat_id => goods_cat.id,:unit_price => cat.last.to_i)
        end
      end
    end

    #邯郸邢台11县价格
    handan_11_goods_cat_data = [
      %w[	板	50	]	,
      %w[	板（重）	125	]	,
      %w[	办公文件（箱）	100	]	,
      %w[	包装袋	300	]	,
      %w[	包装纸	250	]	,
      %w[	保健品	136	]	,
      %w[	保险杠	100	]	,
      %w[	鲍鱼果	150	]	,
      %w[	壁纸	333	]	,
      %w[	壁纸胶	750	]	,
      %w[	便池	150	]	,
      %w[	变速箱	316	]	,
      %w[	玻璃	500	]	,
      %w[	玻璃家具	125	]	,
      %w[	玻璃胶	400	]	,
      %w[	玻璃门	152	]	,
      %w[	玻璃纸	111	]	,
      %w[	薄膜	464	]	,
      %w[	布	149	]	,
      %w[	布卷	100	]	,
      %w[	布条	88	]	,
      %w[	菜板、筷子	171	]	,
      %w[	餐桌	96	]	,
      %w[	茶几	143	]	,
      %w[	茶几配件	143	]	,
      %w[	茶具	147	]	,
      %w[	差速箱	400	]	,
      %w[	车门	156	]	,
      %w[	车座套	500	]	,
      %w[	齿轮泵	12500	]	,
      %w[	齿轮油	100	]	,
      %w[	抽水箱	77	]	,
      %w[	厨具（锅）	29	]	,
      %w[	橱柜	650	]	,
      %w[	橱柜	143	]	,
      %w[	窗户	111	]	,
      %w[	窗帘杆	139	]	,
      %w[	窗帘配件（箱）	58	]	,
      %w[	床板	77	]	,
      %w[	床垫	52	]	,
      %w[	床盖	68	]	,
      %w[	床头		]	,
      %w[	床头柜	105	]	,
      %w[	瓷砖	333	]	,
      %w[	打印纸	200	]	,
      %w[	大灯（箱）	45	]	,
      %w[	大理石	700	]	,
      %w[	袋子	100	]	,
      %w[	蛋糕	100	]	,
      %w[	挡风玻璃（前）	1667	]	,
      %w[	倒车镜	75	]	,
      %w[	灯	68	]	,
      %w[	灯（小）	300	]	,
      %w[	灯带（箱）	500	]	,
      %w[	灯底座	182	]	,
      %w[	灯架	250	]	,
      %w[	灯具	228	]	,
      %w[	灯具（方）	117	]	,
      %w[	地板	172	]	,
      %w[	地板砖（箱）	770	]	,
      %w[	地产鞋	117	]	,
      %w[	地漏	50	]	,
      %w[	地毯（卷）	167	]	,
      %w[	电池	294	]	,
      %w[	电动车	45	]	,
      %w[	电动摩托车	36	]	,
      %w[	电饭锅	58	]	,
      %w[	电暖气	126	]	,
      %w[	电暖扇	38	]	,
      %w[	电瓶	438	]	,
      %w[	电瓶充电器	260	]	,
      %w[	电器（皮）	0	]	,
      %w[	电器配件	57	]	,
      %w[	电器配件（袋）	59	]	,
      %w[	电视	174	]	,
      %w[	电线	240	]	,
      %w[	电子称	56	]	,
      %w[	电子琴	0	]	,
      %w[	吊灯	92	]	,
      %w[	调料	857	]	,
      %w[	调料（桶）	50	]	,
      %w[	顶底	58	]	,
      %w[	冻品	155	]	,
      %w[	豆干	146	]	,
      %w[	蹲便池	116	]	,
      %w[	发动机	170	]	,
      %w[	发动机（摩托）	182	]	,
      %w[	阀门	1000	]	,
      %w[	方向盘套	116	]	,
      %w[	防爆膜	357	]	,
      %w[	防冻液	167	]	,
      %w[	粉	375	]	,
      %w[	风板	68	]	,
      %w[	扶手	125	]	,
      %w[	扶手	200	]	,
      %w[	服装包	130	]	,
      %w[	干果	145	]	,
      %w[	钢板	444	]	,
      %w[	钢化杯	190	]	,
      %w[	钢架	295	]	,
      %w[	钢卷	250	]	,
      %w[	钢圈（小）	175	]	,
      %w[	钢丝	111	]	,
      %w[	工程胎	70	]	,
      %w[	工具箱	60	]	,
      %w[	工艺品	72	]	,
      %w[	枸杞	85	]	,
      %w[	瓜子（30斤）	125	]	,
      %w[	管材	256	]	,
      %w[	管件	143	]	,
      %w[	管件（袋）	88	]	,
      %w[	广告牌	500	]	,
      %w[	柜子	67	]	,
      %w[	锅	40	]	,
      %w[	果汁机	98	]	,
      %w[	海藻	93	]	,
      %w[	合页	577	]	,
      %w[	和田枣	139	]	,
      %w[	核桃（袋）	103	]	,
      %w[	红豆汉堡	107	]	,
      %w[	红外线灯（箱）	72	]	,
      %w[	后车轮	58	]	,
      %w[	后桥	310	]	,
      %w[	化工	200	]	,
      %w[	化工机油（大桶）	590	]	,
      %w[	化妆品（轻）	300	]	,
      %w[	换气扇	222	]	,
      %w[	黄油（袋）	357	]	,
      %w[	机器	267	]	,
      %w[	机油	125	]	,
      %w[	家具	250	]	,
      %w[	家具板	111	]	,
      %w[	架子	0	]	,
      %w[	减振器	354	]	,
      %w[	酱菜	250	]	,
      %w[	胶（桶）	250	]	,
      %w[	胶带	100	]	,
      %w[	胶管	205	]	,
      %w[	胶条	77	]	,
      %w[	角磨机	96	]	,
      %w[	脚垫	115	]	,
      %w[	洁具	88	]	,
      %w[	洁具（盆）	115	]	,
      %w[	酒	112	]	,
      %w[	卡片	421	]	,
      %w[	开关	133	]	,
      %w[	烤肠	133	]	,
      %w[	空心轴	5000	]	,
      %w[	扣板	138	]	,
      %w[	筷子	178	]	,
      %w[	宽粉	147	]	,
      %w[	框玻璃门	75	]	,
      %w[	腊肉	142	]	,
      %w[	乐器	190	]	,
      %w[	晾衣架	46	]	,
      %w[	炉子	210	]	,
      %w[	滤纸	70	]	,
      %w[	铝材	250	]	,
      %w[	铝塑板	250	]	,
      %w[	轮胎	134	]	,
      %w[	轮胎1200	56	]	,
      %w[	毛巾架	79	]	,
      %w[	煤气灶	167	]	,
      %w[	美容品	0	]	,
      %w[	门	145	]	,
      %w[	门板	136	]	,
      %w[	门锁（箱）	56	]	,
      %w[	门套	171	]	,
      %w[	门套（塑料包装）	700	]	,
      %w[	密封条	1333	]	,
      %w[	面包	120	]	,
      %w[	名片	285	]	,
      %w[	模特（工艺）	0	]	,
      %w[	膜	300	]	,
      %w[	摩托外胎	667	]	,
      %w[	木地板	226	]	,
      %w[	木柜	88	]	,
      %w[	木盆	87	]	,
      %w[	木梯	63	]	,
      %w[	木条	163	]	,
      %w[	奶粉	235	]	,
      %w[	奶瓶	75	]	,
      %w[	牛仔裤	0	]	,
      %w[	农药	0	]	,
      %w[	农药（箱）	200	]	,
      %w[	女式凉鞋	78	]	,
      %w[	排气筒	0	]	,
      %w[	配件	227	]	,
      %w[	配件(车锅)	385	]	,
      %w[	配件（车轮）	120	]	,
      %w[	配件（电子）	220	]	,
      %w[	配件（后备箱）	197	]	,
      %w[	配件（护膝）	78	]	,
      %w[	配件（滑轮）	875	]	,
      %w[	配件（化油器）	111	]	,
      %w[	配件（火花塞）	0	]	,
      %w[	配件（键盘）	156	]	,
      %w[	配件（摩车框）	58	]	,
      %w[	配件（汽）	105	]	,
      %w[	配件（轻）	120	]	,
      %w[	配件（头盔）	177	]	,
      %w[	配件（凸轮轴）	150	]	,
      %w[	配件（纸质）	140	]	,
      %w[	配件（重）	300	]	,
      %w[	盆	125	]	,
      %w[	膨化食品	53	]	,
      %w[	皮料	63	]	,
      %w[	扑克	208	]	,
      %w[	普通秤	55	]	,
      %w[	漆	190	]	,
      %w[	漆（桶）	167	]	,
      %w[	起动机	300	]	,
      %w[	气泵		]	,
      %w[	气瓶	112	]	,
      %w[	汽车座椅	75	]	,
      %w[	汽配（地胶）		]	,
      %w[	汽配（门）		]	,
      %w[	汽配（纸箱）	222	]	,
      %w[	汽油机	120	]	,
      %w[	器械	375	]	,
      %w[	前车头	105	]	,
      %w[	切割机	125	]	,
      %w[	燃气灶	141	]	,
      %w[	热水器	77	]	,
      %w[	人造石	555	]	,
      %w[	日化	250	]	,
      %w[	润滑油	171	]	,
      %w[	沙发	60	]	,
      %w[	沙发配件（袋）	30	]	,
      %w[	沙琪玛	167	]	,
      %w[	刹车锅	428	]	,
      %w[	刹车片	333	]	,
      %w[	砂轮	230	]	,
      %w[	砂纸	214	]	,
      %w[	晒衣架	91	]	,
      %w[	晒衣架配件	214	]	,
      %w[	晒衣架线条	95	]	,
      %w[	山楂片	184	]	,
      %w[	食化	140	]	,
      %w[	食品	86	]	,
      %w[	食品添加剂	154	]	,
      %w[	手机	0	]	,
      %w[	手机（配件）	0	]	,
      %w[	兽药	300	]	,
      %w[	双面胶卷（圆）	35	]	,
      %w[	水泵	250	]	,
      %w[	水槽	79	]	,
      %w[	水管	77	]	,
      %w[	水晶灯	67	]	,
      %w[	水晶球	100	]	,
      %w[	水龙头	103	]	,
      %w[	水箱	94	]	,
      %w[	饲料	200	]	,
      %w[	塑料膜	80	]	,
      %w[	塑料制品	120	]	,
      %w[	锁	89	]	,
      %w[	锁具	133	]	,
      %w[	探照灯		]	,
      %w[	糖	62	]	,
      %w[	糖果	93	]	,
      %w[	糖果箱	200	]	,
      %w[	陶瓷	312	]	,
      %w[	梯子	50	]	,
      %w[	铁架	154	]	,
      %w[	童鞋	100	]	,
      %w[	头盔	95	]	,
      %w[	涂料	200	]	,
      %w[	拖把	38	]	,
      %w[	拖布池	92	]	,
      %w[	玩具	50	]	,
      %w[	网	56	]	,
      %w[	卫生巾	130	]	,
      %w[	卫生用品	125	]	,
      %w[	卫生纸	85	]	,
      %w[	温州鞋	58	]	,
      %w[	文具	106	]	,
      %w[	文具盒	100	]	,
      %w[	无纺布	55	]	,
      %w[	无花果	130	]	,
      %w[	五金	278	]	,
      %w[	洗发水	250	]	,
      %w[	洗手粉	115	]	,
      %w[	洗手盆	10	]	,
      %w[	线	0	]	,
      %w[	线缆(袋）	188	]	,
      %w[	线绳	0	]	,
      %w[	线条	167	]	,
      %w[	线砖（箱）	357	]	,
      %w[	香肠	167	]	,
      %w[	橡胶配件	114	]	,
      %w[	消毒柜	50	]	,
      %w[	消音器	190	]	,
      %w[	小刀	267	]	,
      %w[	鞋	83	]	,
      %w[	新疆枣	136	]	,
      %w[	杏仁	214	]	,
      %w[	宣传彩页	200	]	,
      %w[	宣传品	250	]	,
      %w[	亚克力板	5	]	,
      %w[	颜料	0	]	,
      %w[	扬声器	0	]	,
      %w[	腰果	60	]	,
      %w[	药	143	]	,
      %w[	药品	200	]	,
      %w[	液压油	300	]	,
      %w[	衣架	300	]	,
      %w[	衣架箱	48	]	,
      %w[	椅子	66	]	,
      %w[	油缸	80	]	,
      %w[	油漆（桶）	188	]	,
      %w[	油箱	100	]	,
      %w[	油烟机	80	]	,
      %w[	浴缸	76	]	,
      %w[	浴柜	114	]	,
      %w[	浴镜	273	]	,
      %w[	浴盆	61	]	,
      %w[	浴室柜	117	]	,
      %w[	浴室镜	136	]	,
      %w[	原子灰	188	]	,
      %w[	运动鞋	117	]	,
      %w[	枣	158	]	,
      %w[	芝麻（袋）100	133	]	,
      %w[	纸板	196	]	,
      %w[	纸杯	69	]	,
      %w[	纸尿片	57	]	,
      %w[	纸筒（圆）	171	]	,
      %w[	轴头	316	]	,
      %w[	柱子	125	]	,
      %w[	装饰材料（天花）	83	]	,
      %w[	资料	5000	]	,
      %w[	坐便	94	]	,
      %w[	坐垫	108	]	,
      %w[	座桥	50	]	,
      %w[	座套	100	]	
    ]
    #到邯郸邢台11县数据
    branches.each do |f_org_name|
      f_org = Branch.find_by_name(f_org_name)
      handan_11.each do |t_org_name|
        t_org = Branch.find_by_name(t_org_name)
        gcfc = GoodsCatFeeConfig.create(:from_org => f_org,:to_org => t_org)
        handan_11_goods_cat_data.each do |cat|
          goods_cat = GoodsCat.find_by_name(cat.first)
          gcfc.goods_cat_fee_config_lines.create(:goods_cat_id => goods_cat.id,:unit_price => cat.last.to_i)
        end
      end
    end
    #河北价格
    hb_goods_cat_data = [
      %w[	板	50	]	,
      %w[	板（重）	125	]	,
      %w[	办公文件（箱）	88	]	,
      %w[	包装袋	300	]	,
      %w[	包装纸	250	]	,
      %w[	保健品	91	]	,
      %w[	保险杠	68	]	,
      %w[	鲍鱼果	125	]	,
      %w[	壁纸	333	]	,
      %w[	壁纸胶	400	]	,
      %w[	便池	150	]	,
      %w[	变速箱	263	]	,
      %w[	玻璃	400	]	,
      %w[	玻璃家具	83	]	,
      %w[	玻璃胶	400	]	,
      %w[	玻璃门	114	]	,
      %w[	玻璃纸	111	]	,
      %w[	薄膜	357	]	,
      %w[	布	119	]	,
      %w[	布卷	100	]	,
      %w[	布条	88	]	,
      %w[	菜板、筷子	114	]	,
      %w[	餐桌	74	]	,
      %w[	茶几	110	]	,
      %w[	茶几配件	114	]	,
      %w[	茶具	147	]	,
      %w[	差速箱	267	]	,
      %w[	车门	104	]	,
      %w[	车座套	400	]	,
      %w[	齿轮泵	12500	]	,
      %w[	齿轮油	100	]	,
      %w[	抽水箱	77	]	,
      %w[	厨具（锅）	29	]	,
      %w[	橱柜	650	]	,
      %w[	橱柜	143	]	,
      %w[	窗户	111	]	,
      %w[	窗帘杆	139	]	,
      %w[	窗帘配件（箱）	58	]	,
      %w[	床板	59	]	,
      %w[	床垫	42	]	,
      %w[	床盖	53	]	,
      %w[	床头	0	]	,
      %w[	床头柜	81	]	,
      %w[	瓷砖	333	]	,
      %w[	打印纸	200	]	,
      %w[	大灯（箱）	45	]	,
      %w[	大理石	614	]	,
      %w[	袋子	100	]	,
      %w[	蛋糕	85	]	,
      %w[	挡风玻璃（前）	1667	]	,
      %w[	倒车镜	75	]	,
      %w[	灯	45	]	,
      %w[	灯（小）	200	]	,
      %w[	灯带（箱）	500	]	,
      %w[	灯底座	182	]	,
      %w[	灯架	150	]	,
      %w[	灯具	143	]	,
      %w[	灯具（方）	83	]	,
      %w[	地板	172	]	,
      %w[	地板砖（箱）	770	]	,
      %w[	地产鞋	100	]	,
      %w[	地漏	50	]	,
      %w[	地毯（卷）	125	]	,
      %w[	电池	176	]	,
      %w[	电动车	45	]	,
      %w[	电动摩托车	36	]	,
      %w[	电饭锅	46	]	,
      %w[	电暖气	76	]	,
      %w[	电暖扇	30	]	,
      %w[	电瓶	438	]	,
      %w[	电瓶充电器	217	]	,
      %w[	电器（皮）	149	]	,
      %w[	电器配件	48	]	,
      %w[	电器配件（袋）	59	]	,
      %w[	电视	130	]	,
      %w[	电线	185	]	,
      %w[	电子称	56	]	,
      %w[	电子琴	111	]	,
      %w[	吊灯	77	]	,
      %w[	调料	857	]	,
      %w[	调料（桶）	50	]	,
      %w[	顶底	44	]	,
      %w[	冻品	155	]	,
      %w[	豆干	83	]	,
      %w[	蹲便池	101	]	,
      %w[	发动机	170	]	,
      %w[	发动机（摩托）	127	]	,
      %w[	阀门	800	]	,
      %w[	方向盘套	93	]	,
      %w[	防爆膜	268	]	,
      %w[	防冻液	133	]	,
      %w[	粉	200	]	,
      %w[	风板	45	]	,
      %w[	扶手	125	]	,
      %w[	扶手	200	]	,
      %w[	服装包	117	]	,
      %w[	干果	145	]	,
      %w[	钢板	333	]	,
      %w[	钢化杯	190	]	,
      %w[	钢架	277	]	,
      %w[	钢卷	175	]	,
      %w[	钢圈（小）	175	]	,
      %w[	钢丝	111	]	,
      %w[	工程胎	59	]	,
      %w[	工具箱	40	]	,
      %w[	工艺品	73	]	,
      %w[	枸杞	85	]	,
      %w[	瓜子（30斤）	104	]	,
      %w[	管材	128	]	,
      %w[	管件	143	]	,
      %w[	管件（袋）	88	]	,
      %w[	广告牌	500	]	,
      %w[	柜子	56	]	,
      %w[	锅	0	]	,
      %w[	果汁机	78	]	,
      %w[	海藻	93	]	,
      %w[	合页	577	]	,
      %w[	和田枣	97	]	,
      %w[	核桃（袋）	82	]	,
      %w[	红豆汉堡	71	]	,
      %w[	红外线灯（箱）	72	]	,
      %w[	后车轮	58	]	,
      %w[	后桥	248	]	,
      %w[	化工	200	]	,
      %w[	化工机油（大桶）	370	]	,
      %w[	化妆品（轻）	150	]	,
      %w[	换气扇	222	]	,
      %w[	黄油（袋）	357	]	,
      %w[	机器	200	]	,
      %w[	机油	100	]	,
      %w[	家具	167	]	,
      %w[	家具板	111	]	,
      %w[	架子	0	]	,
      %w[	减振器	242	]	,
      %w[	酱菜	250	]	,
      %w[	胶（桶）	175	]	,
      %w[	胶带	100	]	,
      %w[	胶管	164	]	,
      %w[	胶条	77	]	,
      %w[	角磨机	96	]	,
      %w[	脚垫	86	]	,
      %w[	洁具	88	]	,
      %w[	洁具（盆）	96	]	,
      %w[	酒	75	]	,
      %w[	卡片	421	]	,
      %w[	开关	89	]	,
      %w[	烤肠	133	]	,
      %w[	空心轴	5000	]	,
      %w[	扣板	115	]	,
      %w[	筷子	178	]	,
      %w[	宽粉	147	]	,
      %w[	框玻璃门	75	]	,
      %w[	腊肉	142	]	,
      %w[	乐器	190	]	,
      %w[	晾衣架	46	]	,
      %w[	炉子	167	]	,
      %w[	滤纸	58	]	,
      %w[	铝材	250	]	,
      %w[	铝塑板	208	]	,
      %w[	轮胎	95	]	,
      %w[	轮胎1200	42	]	,
      %w[	毛巾架	60	]	,
      %w[	煤气灶	139	]	,
      %w[	美容品	99	]	,
      %w[	门	111	]	,
      %w[	门板	91	]	,
      %w[	门锁（箱）	56	]	,
      %w[	门套	143	]	,
      %w[	门套（塑料包装）	500	]	,
      %w[	密封条	1333	]	,
      %w[	面包	100	]	,
      %w[	名片	285	]	,
      %w[	模特（工艺）	172	]	,
      %w[	膜	160	]	,
      %w[	摩托外胎	667	]	,
      %w[	木地板	226	]	,
      %w[	木柜	74	]	,
      %w[	木盆	77	]	,
      %w[	木梯	63	]	,
      %w[	木条	125	]	,
      %w[	奶粉	176	]	,
      %w[	奶瓶	45	]	,
      %w[	牛仔裤	177	]	,
      %w[	农药	217	]	,
      %w[	农药（箱）	200	]	,
      %w[	女式凉鞋	65	]	,
      %w[	排气筒	132	]	,
      %w[	配件	159	]	,
      %w[	配件(车锅)	269	]	,
      %w[	配件（车轮）	96	]	,
      %w[	配件（电子）	220	]	,
      %w[	配件（后备箱）	172	]	,
      %w[	配件（护膝）	62	]	,
      %w[	配件（滑轮）	625	]	,
      %w[	配件（化油器）	111	]	,
      %w[	配件（火花塞）	0	]	,
      %w[	配件（键盘）	83	]	,
      %w[	配件（摩车框）	39	]	,
      %w[	配件（汽）	79	]	,
      %w[	配件（轻）	100	]	,
      %w[	配件（头盔）	168	]	,
      %w[	配件（凸轮轴）	150	]	,
      %w[	配件（纸质）	140	]	,
      %w[	配件（重）	250	]	,
      %w[	盆	125	]	,
      %w[	膨化食品	38	]	,
      %w[	皮料	50	]	,
      %w[	扑克	167	]	,
      %w[	普通秤	55	]	,
      %w[	漆	190	]	,
      %w[	漆（桶）	167	]	,
      %w[	起动机	300	]	,
      %w[	气泵	286	]	,
      %w[	气瓶	112	]	,
      %w[	汽车座椅	75	]	,
      %w[	汽配（地胶）	250	]	,
      %w[	汽配（门）	37	]	,
      %w[	汽配（纸箱）	178	]	,
      %w[	汽油机	100	]	,
      %w[	器械	375	]	,
      %w[	前车头	105	]	,
      %w[	切割机	125	]	,
      %w[	燃气灶	141	]	,
      %w[	热水器	77	]	,
      %w[	人造石	555	]	,
      %w[	日化	200	]	,
      %w[	润滑油	143	]	,
      %w[	沙发	52	]	,
      %w[	沙发配件（袋）	30	]	,
      %w[	沙琪玛	95	]	,
      %w[	刹车锅	286	]	,
      %w[	刹车片	266	]	,
      %w[	砂轮	230	]	,
      %w[	砂纸	171	]	,
      %w[	晒衣架	61	]	,
      %w[	晒衣架配件	143	]	,
      %w[	晒衣架线条	71	]	,
      %w[	山楂片	105	]	,
      %w[	食化	100	]	,
      %w[	食品	86	]	,
      %w[	食品添加剂	110	]	,
      %w[	手机	208	]	,
      %w[	手机（配件）	5000	]	,
      %w[	兽药	250	]	,
      %w[	双面胶卷（圆）	35	]	,
      %w[	水泵	250	]	,
      %w[	水槽	63	]	,
      %w[	水管	77	]	,
      %w[	水晶灯	53	]	,
      %w[	水晶球	100	]	,
      %w[	水龙头	83	]	,
      %w[	水箱	71	]	,
      %w[	饲料	167	]	,
      %w[	塑料膜	80	]	,
      %w[	塑料制品	60	]	,
      %w[	锁	89	]	,
      %w[	锁具	133	]	,
      %w[	探照灯	200	]	,
      %w[	糖	62	]	,
      %w[	糖果	70	]	,
      %w[	糖果箱	120	]	,
      %w[	陶瓷	250	]	,
      %w[	梯子	50	]	,
      %w[	铁架	0	]	,
      %w[	童鞋	100	]	,
      %w[	头盔	95	]	,
      %w[	涂料	166	]	,
      %w[	拖把	38	]	,
      %w[	拖布池	86	]	,
      %w[	玩具	33	]	,
      %w[	网	45	]	,
      %w[	卫生巾	74	]	,
      %w[	卫生用品	100	]	,
      %w[	卫生纸	60	]	,
      %w[	温州鞋	54	]	,
      %w[	文具	85	]	,
      %w[	文具盒	70	]	,
      %w[	无纺布	44	]	,
      %w[	无花果	108	]	,
      %w[	五金	278	]	,
      %w[	洗发水	200	]	,
      %w[	洗手粉	115	]	,
      %w[	洗手盆	10	]	,
      %w[	线	154	]	,
      %w[	线缆(袋）	188	]	,
      %w[	线绳	125	]	,
      %w[	线条	125	]	,
      %w[	线砖（箱）	357	]	,
      %w[	香肠	117	]	,
      %w[	橡胶配件	114	]	,
      %w[	消毒柜	50	]	,
      %w[	消音器	114	]	,
      %w[	小刀	200	]	,
      %w[	鞋	56	]	,
      %w[	新疆枣	91	]	,
      %w[	杏仁	143	]	,
      %w[	宣传彩页	200	]	,
      %w[	宣传品	200	]	,
      %w[	亚克力板	5	]	,
      %w[	颜料	208	]	,
      %w[	扬声器	91	]	,
      %w[	腰果	60	]	,
      %w[	药	143	]	,
      %w[	药品	167	]	,
      %w[	液压油	250	]	,
      %w[	衣架	250	]	,
      %w[	衣架箱	48	]	,
      %w[	椅子	53	]	,
      %w[	油缸	80	]	,
      %w[	油漆（桶）	156	]	,
      %w[	油箱	100	]	,
      %w[	油烟机	66	]	,
      %w[	浴缸	76	]	,
      %w[	浴柜	100	]	,
      %w[	浴镜	234	]	,
      %w[	浴盆	49	]	,
      %w[	浴室柜	117	]	,
      %w[	浴室镜	136	]	,
      %w[	原子灰	188	]	,
      %w[	运动鞋	100	]	,
      %w[	枣	132	]	,
      %w[	芝麻（袋）100	111	]	,
      %w[	纸板	147	]	,
      %w[	纸杯	49	]	,
      %w[	纸尿片	43	]	,
      %w[	纸筒（圆）	143	]	,
      %w[	轴头	263	]	,
      %w[	柱子	125	]	,
      %w[	装饰材料（天花）	83	]	,
      %w[	资料	4000	]	,
      %w[	坐便	94	]	,
      %w[	坐垫	83	]	,
      %w[	座桥	42	]	,
      %w[	座套	100 ]
    ]
    branches.each do |f_org_name|
      f_org = Branch.find_by_name(f_org_name)
      hb_branches.each do |t_org_name|
        t_org = Branch.find_by_name(t_org_name)
        gcfc = GoodsCatFeeConfig.create(:from_org => f_org,:to_org => t_org)
        hb_goods_cat_data.each do |cat|
          goods_cat = GoodsCat.find_by_name(cat.first)
          gcfc.goods_cat_fee_config_lines.create(:goods_cat_id => goods_cat.id,:unit_price => cat.last.to_i)
        end
      end
    end
    #山西数据
    sx_goods_cat_data = [
      %w[	板	50	]	,
%w[	板（重）	125	]	,
%w[	办公文件（箱）	88	]	,
%w[	包装袋	300	]	,
%w[	包装纸	250	]	,
%w[	保健品	91	]	,
%w[	保险杠	60	]	,
%w[	鲍鱼果	125	]	,
%w[	壁纸	333	]	,
%w[	壁纸胶	400	]	,
%w[	便池	150	]	,
%w[	变速箱	263	]	,
%w[	玻璃	400	]	,
%w[	玻璃家具	83	]	,
%w[	玻璃胶	400	]	,
%w[	玻璃门	114	]	,
%w[	玻璃纸	111	]	,
%w[	薄膜	357	]	,
%w[	布	119	]	,
%w[	布卷	100	]	,
%w[	布条	88	]	,
%w[	菜板、筷子	114	]	,
%w[	餐桌	74	]	,
%w[	茶几	88	]	,
%w[	茶几配件	114	]	,
%w[	茶具	147	]	,
%w[	差速箱	233	]	,
%w[	车门	104	]	,
%w[	车座套	400	]	,
%w[	齿轮泵	12500	]	,
%w[	齿轮油	100	]	,
%w[	抽水箱	77	]	,
%w[	厨具（锅）	29	]	,
%w[	橱柜	400	]	,
%w[	橱柜	143	]	,
%w[	窗户	111	]	,
%w[	窗帘杆	139	]	,
%w[	窗帘配件（箱）	58	]	,
%w[	床板	59	]	,
%w[	床垫	42	]	,
%w[	床盖	53	]	,
%w[	床头	0	]	,
%w[	床头柜	81	]	,
%w[	瓷砖	333	]	,
%w[	打印纸	200	]	,
%w[	大灯（箱）	45	]	,
%w[	大理石	614	]	,
%w[	袋子	100	]	,
%w[	蛋糕	85	]	,
%w[	挡风玻璃（前）	1667	]	,
%w[	倒车镜	75	]	,
%w[	灯	45	]	,
%w[	灯（小）	200	]	,
%w[	灯带（箱）	500	]	,
%w[	灯底座	182	]	,
%w[	灯架	150	]	,
%w[	灯具	143	]	,
%w[	灯具（方）	83	]	,
%w[	地板	172	]	,
%w[	地板砖（箱）	770	]	,
%w[	地产鞋	100	]	,
%w[	地漏	50	]	,
%w[	地毯（卷）	83	]	,
%w[	电池	176	]	,
%w[	电动车	45	]	,
%w[	电动摩托车	36	]	,
%w[	电饭锅	46	]	,
%w[	电暖气	76	]	,
%w[	电暖扇	30	]	,
%w[	电瓶	438	]	,
%w[	电瓶充电器	217	]	,
%w[	电器（皮）	0	]	,
%w[	电器配件	48	]	,
%w[	电器配件（袋）	59	]	,
%w[	电视	130	]	,
%w[	电线	240	]	,
%w[	电子称	56	]	,
%w[	电子琴	0	]	,
%w[	吊灯	77	]	,
%w[	调料	857	]	,
%w[	调料（桶）	50	]	,
%w[	顶底	44	]	,
%w[	冻品	155	]	,
%w[	豆干	83	]	,
%w[	蹲便池	101	]	,
%w[	发动机	170	]	,
%w[	发动机（摩托）	127	]	,
%w[	阀门	800	]	,
%w[	方向盘套	93	]	,
%w[	防爆膜	268	]	,
%w[	防冻液	133	]	,
%w[	粉	200	]	,
%w[	风板	45	]	,
%w[	扶手	125	]	,
%w[	扶手	200	]	,
%w[	服装包	0	]	,
%w[	干果	145	]	,
%w[	钢板	333	]	,
%w[	钢化杯	190	]	,
%w[	钢架	0	]	,
%w[	钢卷	175	]	,
%w[	钢圈（小）	175	]	,
%w[	钢丝	111	]	,
%w[	工程胎	42	]	,
%w[	工具箱	40	]	,
%w[	工艺品	74	]	,
%w[	枸杞	85	]	,
%w[	瓜子（30斤）	104	]	,
%w[	管材	128	]	,
%w[	管件	143	]	,
%w[	管件（袋）	88	]	,
%w[	广告牌	500	]	,
%w[	柜子	56	]	,
%w[	锅	0	]	,
%w[	果汁机	69	]	,
%w[	海藻	93	]	,
%w[	合页	577	]	,
%w[	和田枣	97	]	,
%w[	核桃（袋）	82	]	,
%w[	红豆汉堡	54	]	,
%w[	红外线灯（箱）	72	]	,
%w[	后车轮	58	]	,
%w[	后桥	248	]	,
%w[	化工	200	]	,
%w[	化工机油（大桶）	370	]	,
%w[	化妆品（轻）	150	]	,
%w[	换气扇	222	]	,
%w[	黄油（袋）	357	]	,
%w[	机器	200	]	,
%w[	机油	100	]	,
%w[	家具	167	]	,
%w[	家具板	111	]	,
%w[	架子	154	]	,
%w[	减振器	242	]	,
%w[	酱菜	250	]	,
%w[	胶（桶）	175	]	,
%w[	胶带	100	]	,
%w[	胶管	164	]	,
%w[	胶条	77	]	,
%w[	角磨机	96	]	,
%w[	脚垫	86	]	,
%w[	洁具	88	]	,
%w[	洁具（盆）	76	]	,
%w[	酒	75	]	,
%w[	卡片	421	]	,
%w[	开关	89	]	,
%w[	烤肠	133	]	,
%w[	空心轴	5000	]	,
%w[	扣板	115	]	,
%w[	筷子	178	]	,
%w[	宽粉	147	]	,
%w[	框玻璃门	75	]	,
%w[	腊肉	142	]	,
%w[	乐器	190	]	,
%w[	晾衣架	46	]	,
%w[	炉子	167	]	,
%w[	滤纸	58	]	,
%w[	铝材	250	]	,
%w[	铝塑板	208	]	,
%w[	轮胎	76	]	,
%w[	轮胎1200	28	]	,
%w[	毛巾架	60	]	,
%w[	煤气灶	139	]	,
%w[	美容品	0	]	,
%w[	门	111	]	,
%w[	门板	91	]	,
%w[	门锁（箱）	56	]	,
%w[	门套	143	]	,
%w[	门套（塑料包装）	500	]	,
%w[	密封条	1333	]	,
%w[	面包	80	]	,
%w[	名片	285	]	,
%w[	模特（工艺）	0	]	,
%w[	膜	160	]	,
%w[	摩托外胎	667	]	,
%w[	木地板	161	]	,
%w[	木柜	74	]	,
%w[	木盆	77	]	,
%w[	木梯	63	]	,
%w[	木条	125	]	,
%w[	奶粉	147	]	,
%w[	奶瓶	45	]	,
%w[	牛仔裤	0	]	,
%w[	农药	217	]	,
%w[	农药（箱）	200	]	,
%w[	女式凉鞋	65	]	,
%w[	排气筒	132	]	,
%w[	配件	136	]	,
%w[	配件(车锅)	269	]	,
%w[	配件（车轮）	96	]	,
%w[	配件（电子）	220	]	,
%w[	配件（后备箱）	172	]	,
%w[	配件（护膝）	62	]	,
%w[	配件（滑轮）	625	]	,
%w[	配件（化油器）	111	]	,
%w[	配件（火花塞）	0	]	,
%w[	配件（键盘）	83	]	,
%w[	配件（摩车框）	39	]	,
%w[	配件（汽）	79	]	,
%w[	配件（轻）	80	]	,
%w[	配件（头盔）	168	]	,
%w[	配件（凸轮轴）	150	]	,
%w[	配件（纸质）	140	]	,
%w[	配件（重）	250	]	,
%w[	盆	125	]	,
%w[	膨化食品	38	]	,
%w[	皮料	38	]	,
%w[	扑克	167	]	,
%w[	普通秤	55	]	,
%w[	漆	190	]	,
%w[	漆（桶）	167	]	,
%w[	起动机	300	]	,
%w[	气泵	0	]	,
%w[	气瓶	112	]	,
%w[	汽车座椅	75	]	,
%w[	汽配（地胶）	200	]	,
%w[	汽配（门）	37	]	,
%w[	汽配（纸箱）	133	]	,
%w[	汽油机	100	]	,
%w[	器械	375	]	,
%w[	前车头	105	]	,
%w[	切割机	125	]	,
%w[	燃气灶	141	]	,
%w[	热水器	77	]	,
%w[	人造石	444	]	,
%w[	日化	200	]	,
%w[	润滑油	143	]	,
%w[	沙发	52	]	,
%w[	沙发配件（袋）	30	]	,
%w[	沙琪玛	95	]	,
%w[	刹车锅	286	]	,
%w[	刹车片	266	]	,
%w[	砂轮	230	]	,
%w[	砂纸	171	]	,
%w[	晒衣架	61	]	,
%w[	晒衣架配件	143	]	,
%w[	晒衣架线条	71	]	,
%w[	山楂片	105	]	,
%w[	食化	100	]	,
%w[	食品	86	]	,
%w[	食品添加剂	110	]	,
%w[	手机	0	]	,
%w[	手机（配件）	0	]	,
%w[	兽药	250	]	,
%w[	双面胶卷（圆）	35	]	,
%w[	水泵	250	]	,
%w[	水槽	63	]	,
%w[	水管	77	]	,
%w[	水晶灯	53	]	,
%w[	水晶球	100	]	,
%w[	水龙头	83	]	,
%w[	水箱	71	]	,
%w[	饲料	167	]	,
%w[	塑料膜	80	]	,
%w[	塑料制品	60	]	,
%w[	锁	89	]	,
%w[	锁具	133	]	,
%w[	探照灯	0	]	,
%w[	糖	62	]	,
%w[	糖果	70	]	,
%w[	糖果箱	120	]	,
%w[	陶瓷	250	]	,
%w[	梯子	50	]	,
%w[	铁架	0	]	,
%w[	童鞋	100	]	,
%w[	头盔	95	]	,
%w[	涂料	166	]	,
%w[	拖把	38	]	,
%w[	拖布池	86	]	,
%w[	玩具	33	]	,
%w[	网	45	]	,
%w[	卫生巾	74	]	,
%w[	卫生用品	100	]	,
%w[	卫生纸	60	]	,
%w[	温州鞋	54	]	,
%w[	文具	85	]	,
%w[	文具盒	70	]	,
%w[	无纺布	44	]	,
%w[	无花果	87	]	,
%w[	五金	278	]	,
%w[	洗发水	200	]	,
%w[	洗手粉	115	]	,
%w[	洗手盆	10	]	,
%w[	线	0	]	,
%w[	线缆(袋）	188	]	,
%w[	线绳	0	]	,
%w[	线条	125	]	,
%w[	线砖（箱）	357	]	,
%w[	香肠	117	]	,
%w[	橡胶配件	114	]	,
%w[	消毒柜	50	]	,
%w[	消音器	114	]	,
%w[	小刀	200	]	,
%w[	鞋	56	]	,
%w[	新疆枣	91	]	,
%w[	杏仁	143	]	,
%w[	宣传彩页	200	]	,
%w[	宣传品	200	]	,
%w[	亚克力板	4	]	,
%w[	颜料	0	]	,
%w[	扬声器	0	]	,
%w[	腰果	60	]	,
%w[	药	119	]	,
%w[	药品	167	]	,
%w[	液压油	200	]	,
%w[	衣架	250	]	,
%w[	衣架箱	48	]	,
%w[	椅子	40	]	,
%w[	油缸	80	]	,
%w[	油漆（桶）	156	]	,
%w[	油箱	100	]	,
%w[	油烟机	66	]	,
%w[	浴缸	76	]	,
%w[	浴柜	100	]	,
%w[	浴镜	234	]	,
%w[	浴盆	49	]	,
%w[	浴室柜	117	]	,
%w[	浴室镜	136	]	,
%w[	原子灰	188	]	,
%w[	运动鞋	100	]	,
%w[	枣	132	]	,
%w[	芝麻（袋）100	111	]	,
%w[	纸板	147	]	,
%w[	纸杯	49	]	,
%w[	纸尿片	43	]	,
%w[	纸筒（圆）	143	]	,
%w[	轴头	263	]	,
%w[	柱子	125	]	,
%w[	装饰材料（天花）	83	]	,
%w[	资料	4000	]	,
%w[	坐便	94	]	,
%w[	坐垫	83	]	,
%w[	座桥	42	]	,
%w[	座套	100	]	,
    ]
    branches.each do |f_org_name|
      f_org = Branch.find_by_name(f_org_name)
      sx_branches.each do |t_org_name|
        t_org = Branch.find_by_name(t_org_name)
        gcfc = GoodsCatFeeConfig.create(:from_org => f_org,:to_org => t_org)
        sx_goods_cat_data.each do |cat|
          goods_cat = GoodsCat.find_by_name(cat.first)
          gcfc.goods_cat_fee_config_lines.create(:goods_cat_id => goods_cat.id,:unit_price => cat.last.to_i)
        end
      end
    end
  end
end