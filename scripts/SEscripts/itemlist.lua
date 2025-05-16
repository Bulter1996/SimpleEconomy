--seworldstatus里有计算材料价格之和的公式，如果物品在本列表中有价格，则以本列表的价格为优先

--[[
--太编辑：
--在这前7个列表里的物品将会增加到商店里面，本文件里所有表支持热更新(无需重启)，需要打开实时更新商品的开关，点击商店图标自动触发热更新。
--mod物品可放入这七个表里面，官方物品不能放到这7个表里，想增加官方物品请将物品放入这7个表之后的七个表内。
--格式参考其他表里的数据,一个标点符号都不能错(英文符号,注释选填),可以科技合成的物品的价格可以设置为nil,会根据原料来自动计算价格。
例子：	
{ name = "kabobs", price = 69 }, --肉串		不能合成
{ name = "armorwood", price = nil }, --木甲  能合成的
{ name = "ndnr_red_sporeseed", price = 100, tex = "spore_medium.tex" },	 调用官方贴图资源的
极端情况需要填入四个参数例如：
{ name = "ndnr_magma_milk",price = 300, tex = "ndnr_magma_milk_0.tex", atl = "images/ndnr_magma_milk_0.xml" }, --岩浆
tex和atl的用于显示贴图，这两个数据在物品信息里面获取，这里不展开说。
一般只需要这样：{ name = "kabobs", price = 69 }, --肉串
不能显示贴图时则需要填入tex或者填入atl
--]]
local itemlist = {}
itemlist.selist_food_mod = {

}
itemlist.selist_cloth_mod = {

}
itemlist.selist_smithing_mod = {

}
itemlist.selist_resource_mod = {

}
itemlist.selist_precious_mod = {

}
--只能放入特殊蓝图
itemlist.selist_blueprint_mod = {

}


itemlist.selist_food =
{
	{ name = "kabobs",                  price = 69 },                           --肉串
	{ name = "meatballs",               price = 82 },                           --肉丸
	{ name = "bonestew",                price = 118 },                          --肉汤
	{ name = "turkeydinner",            price = 115 },                          --火鸡正餐
	{ name = "baconeggs",               price = 91 },                           --鸡蛋火腿
	{ name = "perogies",                price = 92 },                           --饺子
	{ name = "hotchili",                price = 94 },                           --辣椒酱
	{ name = "guacamole",               price = 92 },                           --鳄梨酱
	{ name = "unagi",                   price = 107 },                          --鳗鱼寿司
	{ name = "frogglebunwich",          price = 63 },                           --青蛙三明治
	{ name = "fishtacos",               price = 145 },                          --玉米鱼饼
	{ name = "fishsticks",              price = 141 },                          --鱼条
	{ name = "honeynuggets",            price = 73 },                           --甜蜜金砖
	{ name = "honeyham",                price = 102 },                          --蜜汁火腿
	{ name = "monsterlasagna",          price = 99 },                           --怪兽千层饼
	{ name = "powcake",                 price = 65 },                           --芝士蛋糕
	{ name = "butterflymuffin",         price = 59 },                           --蝴蝶松饼
	{ name = "fruitmedley",             price = 94 },                           --水果圣代
	{ name = "ratatouille",             price = 67 },                           --蔬菜杂烩
	{ name = "jammypreserves",          price = 67 },                           --果酱
	{ name = "trailmix",                price = 61 },                           --什锦干果
	{ name = "flowersalad",             price = 92 },                           --花瓣沙拉
	{ name = "taffy",                   price = 61 },                           --太妃糖
	{ name = "icecream",                price = 155 },                          --冰淇淋
	{ name = "waffles",                 price = 173 },                          --华夫饼
	{ name = "pumpkincookie",           price = 86 },                           --南瓜饼
	{ name = "stuffedeggplant",         price = 77 },                           --香酥茄盒
	{ name = "watermelonicle",          price = 75 },                           --西瓜冰
	{ name = "dragonpie",               price = 118 },                          --火龙果派
	{ name = "pepperpopper",            price = 101 },                          --爆炒填馅辣椒
	{ name = "mashedpotatoes",          price = 120 },                          --奶油土豆泥
	{ name = "potatotornado",           price = 75 },                           --花式回旋块茎
	{ name = "salsa",                   price = 102 },                          --生鲜萨尔萨酱
	{ name = "vegstinger",              price = 82 },                           --蔬菜鸡尾酒
	{ name = "asparagussoup",           price = 79 },                           --芦笋汤
	{ name = "surfnturf",               price = 106 },                          --海鲜牛排
	{ name = "seafoodgumbo",            price = 175 },                          --海鲜浓汤
	{ name = "californiaroll",          price = 85 },                           --加州卷
	{ name = "ceviche",                 price = 111 },                          --酸橘汁腌鱼
	{ name = "lobsterdinner",           price = 217 },                          --龙虾正餐
	{ name = "lobsterbisque",           price = 127 },                          --龙虾汤
	{ name = "barnaclestuffedfishhead", price = 84 },                           --酿鱼头
	{ name = "barnaclinguine",          price = 77 },                           --藤壶中细面
	{ name = "barnaclepita",            price = 62 },                           --藤壶皮塔饼
	{ name = "barnaclesushi",           price = 73 },                           --藤壶握寿司
	{ name = "sweettea",                price = 63 },                           --舒缓茶
	{ name = "koalefig_trunk",          price = 176 },                          --无花果酿象鼻
	{ name = "figkabab",                price = 78 },                           --无花果烤串
	{ name = "figatoni",                price = 69 },                           --无花果意面
	{ name = "frognewton",              price = 65 },                           --无花果蛙腿
	{ name = "meatysalad",              price = 94 },                           --牛肉绿叶菜沙拉
	{ name = "leafymeatsouffle",        price = 111 },                          --果冻沙拉
	{ name = "leafymeatburger",         price = 113 },                          --素食堡
	{ name = "leafloaf",                price = 103 },                          --叶肉糕
	{ name = "bananapop",               price = 63 },                           --香蕉冻
	{ name = "bananajuice",             price = 69 },                           --香蕉奶昔
	{ name = "frozenbananadaiquiri",    price = 71 },                           --冰香蕉冻唇蜜
	{ name = "mandrakesoup",            price = 425 },                          --曼德拉草汤
	{ name = "bonesoup",                price = 153 },                          --骨头汤
	{ name = "freshfruitcrepes",        price = 221 },                          --鲜果可丽饼
	{ name = "moqueca",                 price = 157 },                          --海鲜杂烩
	{ name = "monstertartare",          price = 144 },                          --怪物达达
	{ name = "voltgoatjelly",           price = 500 },                          --伏特羊角冻
	{ name = "glowberrymousse",         price = 150 },                          --发光浆果慕斯
	{ name = "potatosouffle",           price = 154 },                          --蓬松土豆蛋奶酥
	{ name = "frogfishbowl",            price = 138 },                          --蓝带鱼排
	{ name = "gazpacho",                price = 126 },                          --芦笋冷汤
	{ name = "dragonchilisalad",        price = 190 },                          --辣龙椒沙拉
	{ name = "nightmarepie",            price = 195 },                          --恐怖国王饼
	{ name = "bunnystew",               price = 73 },                           --炖兔子
	{ name = "justeggs",                price = 85 },                           --普通煎蛋
	{ name = "veggieomlet",             price = 67 },                           --早餐锅
	{ name = "talleggs",                price = 179 },                          --苏格兰高鸟蛋
	{ name = "shroomcake",              price = 88 },                           --蘑菇蛋糕
	{ name = "beefalotreat",            price = 55 },                           --皮弗娄牛零食
	{ name = "beefalofeed",             price = 49 },                           --蒸树枝

	{ name = "dustmeringue",            price = 30 },                           --琥珀美食
	{ name = "yotr_food1",              price = 74 },                           --兔子卷
	{ name = "yotr_food2",              price = 114 },                          --月饼
	{ name = "yotr_food3",              price = 64 },                           --月冻
	{ name = "yotr_food4",              price = 76 },                           --泡芙串
	{ name = "yotp_food1",              price = 120 },                          --贡品烤肉
	{ name = "yotp_food3",              price = 90 },                           --鱼头串
	{ name = "shroombait",              price = 102 },                          --酿夜帽

	{ name = "meat",                    price = 30 },                           --大肉
	{ name = "meat_dried",              price = 60 },                           --肉干	
	{ name = "monstermeat",             price = 27 },                           --怪兽肉
	{ name = "monstermeat_dried",       price = 54 },                           --怪兽肉干
	{ name = "smallmeat",               price = 18 },                           --小肉	
	{ name = "smallmeat_dried",         price = 36 },                           --小肉干	
	{ name = "drumstick",               price = 18 },                           --鸡腿
	{ name = "bird_egg",                price = 18 },                           --鸡蛋
	{ name = "fishmeat_small",          price = 20 },                           --小鱼块
	{ name = "fishmeat",                price = 33 },                           --大鱼块
	{ name = "kelp",                    price = 10 },                           --海带
	{ name = "kelp_dried",              price = 20 },                           --海带干	
	{ name = "barnacle",                price = 14 },                           --藤壶
	{ name = "fig",                     price = 14 },                           --无花果
	{ name = "wobster_sheller_land",    price = 80 },                           --龙虾
	{ name = "eel",                     price = 60 },                           --鳗鱼
	{ name = "froglegs",                price = 14 },                           --青蛙腿
	{ name = "plantmeat",               price = 33 },                           --食人花肉
	{ name = "batwing",                 price = 32 },                           --蝙蝠翅膀
	{ name = "batnose",                 price = 33 },                           --裸露鼻孔
	{ name = "goatmilk",                price = 100 },                          --电羊奶
	{ name = "butter",                  price = 100 },                          --蝴蝶黄油
	{ name = "trunk_summer",            price = 125 },                          --红色象鼻
	{ name = "trunk_winter",            price = 200 },                          --蓝色象鼻
	{ name = "berries",                 price = 10 },                           --浆果
	{ name = "berries_juicy",           price = 10 },                           --蜜汁浆果
	{ name = "rock_avocado_fruit_ripe", price = 10 },                           --成熟石果
	{ name = "acorn_cooked",            price = 10 },                           --烤桦栗果	
	{ name = "cutlichen",               price = 10 },                           --苔藓
	{ name = "ice",                     price = 10 },                           --冰
	{ name = "milkywhites",             price = 30 },                           --乳白物	
	{ name = "red_cap",                 price = 11 },                           --红蘑菇
	{ name = "green_cap",               price = 12 },                           --绿蘑菇
	{ name = "blue_cap",                price = 16 },                           --蓝蘑菇
	{ name = "moon_cap",                price = 24 },                           --月亮蘑菇
	{ name = "cactus_meat",             price = 19 },                           --仙人掌
	{ name = "cactus_flower",           price = 30 },                           --仙人掌花
	{ name = "cave_banana",             price = 16 },                           --香蕉
	{ name = "butterflywings",          price = 10 },                           --蝴蝶翅膀
	{ name = "moonbutterflywings",      price = 20 },                           --月蛾翅膀
	{ name = "moon_tree_blossom",       price = 10 },                           --月树花
	{ name = "honey",                   price = 10 },                           --蜂蜜
	{ name = "petals",                  price = 6 },                            --花瓣
	{ name = "petals_evil",             price = 8 },                            --噩梦花瓣
	{ name = "carrot",                  price = 12 },                           --胡萝卜
	{ name = "corn",                    price = 18 },                           --玉米
	{ name = "durian",                  price = 24 },                           --榴莲
	{ name = "pomegranate",             price = 21 },                           --石榴
	{ name = "eggplant",                price = 28 },                           --茄子
	{ name = "pumpkin",                 price = 35 },                           --南瓜
	{ name = "watermelon",              price = 30 },                           --西瓜
	{ name = "dragonfruit",             price = 75 },                           --火龙果
	{ name = "asparagus",               price = 18 },                           --芦笋
	{ name = "onion",                   price = 33, tex = "quagmire_onion.tex" }, --洋葱
	{ name = "potato",                  price = 28 },                           --土豆
	{ name = "tomato",                  price = 24, tex = "quagmire_tomato.tex" }, --番茄
	{ name = "garlic",                  price = 21 },                           --大蒜
	{ name = "pepper",                  price = 25 },                           --辣椒
	{ name = "forgetmelots",            price = 8 },                            --必忘我
	{ name = "tillweed",                price = 8 },                            --犁地草
	{ name = "firenettles",             price = 8 },                            --火荨麻叶
}


itemlist.selist_cloth =
{

	{ name = "sewing_kit",             price = nil }, --缝补机
	{ name = "strawhat",               price = nil }, --草帽
	{ name = "flowerhat",              price = nil }, --花环
	{ name = "rabbithat",              price = nil }, --洞穴花环Warren Wreath（2024.09.13高深莫测）

	{ name = "grass_umbrella",         price = nil }, --花伞
	{ name = "umbrella",               price = nil }, --雨伞
	{ name = "minifan",                price = nil }, --风车
	{ name = "beefalohat",             price = nil }, --牛角帽
	{ name = "catcoonhat",             price = nil }, --猫帽
	{ name = "earmuffshat",            price = nil }, --兔毛耳罩
	{ name = "hawaiianshirt",          price = nil }, --花纹衬衫
	{ name = "icehat",                 price = nil }, --冰块
	{ name = "raincoat",               price = nil }, --雨衣
	{ name = "rainhat",                price = nil }, --雨帽
	{ name = "reflectivevest",         price = nil }, --夏季背心
	{ name = "trunkvest_summer",       price = nil }, --夏日背心
	{ name = "trunkvest_winter",       price = nil }, --寒冬背心
	{ name = "watermelonhat",          price = nil }, --西瓜帽
	{ name = "kelphat",                price = nil }, --海花冠
	{ name = "batnosehat",             price = 175 }, --牛奶帽
	{ name = "winterhat",              price = nil }, --冬帽
	{ name = "nightcaphat",            price = 30 }, --睡帽
	{ name = "torch",                  price = nil }, --火把
	{ name = "redlantern",             price = 124 }, --灯笼
	{ name = "lantern",                price = nil }, --提灯
	{ name = "minerhat",               price = nil }, --矿工帽
	{ name = "pumpkin_lantern",        price = nil }, --南瓜灯
	{ name = "molehat",                price = nil }, --地鼠帽
	{ name = "beehat",                 price = nil }, --养蜂帽
	{ name = "featherhat",             price = nil }, --羽毛帽
	{ name = "bushhat",                price = nil }, --浆果帽
	{ name = "tophat",                 price = nil }, --高礼帽
	{ name = "spiderhat",              price = 325 }, --女王帽
	{ name = "goggleshat",             price = nil }, --时尚眼镜
	{ name = "sweatervest",            price = nil }, --小巧背心
	{ name = "onemanband",             price = nil }, --独奏乐器
	{ name = "compass",                price = nil }, --指南针
	{ name = "waterballoon",           price = nil }, --水球
	{ name = "reviver",                price = 136 }, --告密的心
	{ name = "amulet",                 price = nil }, --红护符
	{ name = "blueamulet",             price = nil }, --蓝护符
	{ name = "purpleamulet",           price = nil }, --紫护符
	{ name = "heatrock",               price = nil }, --暖石
	{ name = "bedroll_straw",          price = nil }, --稻草卷
	{ name = "bedroll_furry",          price = nil }, --毛皮铺盖
	{ name = "portabletent_item",      price = nil }, --帐篷卷	
	{ name = "bernie_inactive",        price = nil }, --小熊
	{ name = "giftwrap",               price = nil }, --彩纸
	{ name = "bundlewrap",             price = nil }, --空包裹
	{ name = "featherpencil",          price = nil }, --羽毛笔
	{ name = "healingsalve",           price = nil }, --药膏
	{ name = "tillweedsalve",          price = nil }, --犁地草膏
	{ name = "bandage",                price = nil }, --蜂蜜药膏
	{ name = "healingsalve_acid",      price = nil }, --黏糊糊的药膏
	{ name = "lifeinjector",           price = nil }, --针筒
	{ name = "reskin_tool",            price = nil }, --清洁扫把
	{ name = "backpack",               price = nil }, --背包
	{ name = "piggyback",              price = nil }, --小猪包
	{ name = "seedpouch",              price = nil }, --种子袋
	{ name = "winter_ornament_light1", price = 150 }, --圣诞灯红
	{ name = "winter_ornament_light2", price = 150 }, --圣诞灯绿
	{ name = "winter_ornament_light3", price = 150 }, --圣诞灯蓝
	{ name = "winter_ornament_light4", price = 150 }, --圣诞灯白
}

itemlist.selist_smithing =
{
	{ name = "armorgrass",                      price = nil }, --草甲
	{ name = "armorwood",                       price = nil }, --木甲
	{ name = "spear",                           price = nil }, --长矛
	{ name = "spear_wathgrithr",                price = 124 }, --战斗长矛
	{ name = "wathgrithrhat",                   price = 132 }, --战斗头盔
	{ name = "hambat",                          price = nil }, --火腿棒
	{ name = "footballhat",                     price = nil }, --猪皮头盔
	{ name = "cookiecutterhat",                 price = nil }, --饼干切割机帽子
	{ name = "tentaclespike",                   price = 115 }, --触手棒
	{ name = "cutless",                         price = 70 }, --木头短剑
	{ name = "glasscutter",                     price = 600 }, --玻璃刀
	{ name = "batbat",                          price = nil }, --蝙蝠棒	
	{ name = "nightsword",                      price = nil }, --影刀
	{ name = "armor_sanity",                    price = nil }, --影甲
	{ name = "armormarble",                     price = nil }, --大理石甲
	{ name = "whip",                            price = nil }, --猫尾鞭
	{ name = "boomerang",                       price = nil }, --飞镖
	{ name = "blowdart_pipe",                   price = nil }, --吹箭
	{ name = "blowdart_fire",                   price = nil }, --燃烧吹箭
	{ name = "blowdart_sleep",                  price = nil }, --麻醉吹箭
	{ name = "blowdart_yellow",                 price = nil }, --电磁吹箭
	{ name = "firestaff",                       price = nil }, --红魔杖
	{ name = "icestaff",                        price = nil }, --蓝魔杖
	{ name = "telestaff",                       price = nil }, --紫魔杖
	{ name = "gunpowder",                       price = nil }, --炸药
	{ name = "trap_teeth",                      price = nil }, --狗牙陷阱
	{ name = "beemine",                         price = nil }, --蜜蜂地雷
	{ name = "waterplant_bomb",                 price = 29 }, --种壳
	{ name = "miniflare",                       price = nil }, --信号弹	
	{ name = "megaflare",                       price = nil }, --敌对信号弹
	{ name = "halloweenpotion_health_small",    price = 76 }, --小回复药水
	{ name = "halloweenpotion_health_large",    price = 100 }, --大回复药水
	{ name = "halloweenpotion_sanity_small",    price = 70 }, --小精神药水
	{ name = "halloweenpotion_sanity_large",    price = 90 }, --大精神药水
	{ name = "halloweenpotion_moon",            price = 100 }, --月亮精华液
	{ name = "halloweenpotion_embers",          price = 10 }, --石灰硫化晶体
	{ name = "halloweenpotion_sparks",          price = 10 }, --硝化硫酸晶体
	{ name = "firecrackers",                    price = 5 }, --鞭炮
	{ name = "bathbomb",                        price = 70 }, --沐浴球
	{ name = "rope_bridge_kit",                 price = nil }, --洞穴探险者的桥梁套件Spelunker's Bridge Kit（2024.09.13高深莫测）-
	{ name = "rabbitkinghorn",                  price = nil }, --挖洞兔号角Burrowing Horn（2024.09.13高深莫测）

	{ name = "axe",                             price = nil }, --斧头
	{ name = "shovel",                          price = nil }, --铲子
	{ name = "pickaxe",                         price = nil }, --矿锄
	{ name = "goldenaxe",                       price = nil }, --金斧头
	{ name = "goldenshovel",                    price = nil }, --金铲子
	{ name = "goldenpickaxe",                   price = nil }, --金矿锄
	{ name = "moonglassaxe",                    price = nil }, --玻璃斧头
	{ name = "hammer",                          price = nil }, --锤子
	{ name = "pitchfork",                       price = nil }, --草叉
	{ name = "razor",                           price = nil }, --剃须刀
	{ name = "bugnet",                          price = nil }, --捕虫网
	{ name = "birdtrap",                        price = nil }, --捕鸟器
	{ name = "beef_bell",                       price = nil }, --皮弗娄牛铃
	{ name = "saddle_basic",                    price = nil }, --鞍
	{ name = "brush",                           price = nil }, --刷子	
	{ name = "saddlehorn",                      price = nil }, --取鞍器
	{ name = "fishingrod",                      price = nil }, --鱼竿

	{ name = "farm_hoe",                        price = nil }, --园艺锄
	{ name = "golden_farm_hoe",                 price = nil }, --黄金园艺锄
	{ name = "wateringcan",                     price = nil }, --浇水壶
	{ name = "premiumwateringcan",              price = nil }, --鸟嘴壶	
	{ name = "farm_plow_item",                  price = nil }, --耕地机
	{ name = "compost",                         price = 10 }, --堆肥	
	{ name = "compostwrap",                     price = 70 }, --肥料包
	{ name = "fertilizer",                      price = 110 }, --便便桶
	{ name = "soil_amender",                    price = 80 }, --催长剂起子
	{ name = "plantregistryhat",                price = nil }, --耕作先驱帽
	{ name = "treegrowthsolution",              price = nil }, --树果酱

	{ name = "chum",                            price = 100 }, --鱼食
	{ name = "pocket_scale",                    price = nil }, --弹簧秤
	{ name = "oceanfishingrod",                 price = nil }, --海钓竿
	{ name = "tacklecontainer",                 price = 200 }, --钓具箱
	{ name = "supertacklecontainer",            price = 500 }, --超级钓具箱
	{ name = "oceanfishingbobber_ball",         price = nil }, --木球浮标
	{ name = "oceanfishingbobber_oval",         price = nil }, --硬物浮标
	{ name = "oceanfishingbobber_crow",         price = nil }, --黑羽浮标
	{ name = "oceanfishingbobber_robin",        price = nil }, --红羽浮标
	{ name = "oceanfishingbobber_robin_winter", price = nil }, --蔚蓝羽浮标
	{ name = "oceanfishingbobber_canary",       price = nil }, --黄羽浮标
	{ name = "oceanfishingbobber_goose",        price = 300 }, --鹅羽浮标
	{ name = "oceanfishingbobber_malbatross",   price = 400 }, --邪天翁羽浮标
	{ name = "trinket_6",                       price = 100 }, --烂电线
	{ name = "trinket_8",                       price = 100 }, --硬化橡胶塞
	{ name = "trinket_17",                       price = 100},  --弯曲的叉子
	{ name = "oceanfishinglure_spoon_red",      price = nil }, --日出匙型假饵
	{ name = "oceanfishinglure_spoon_green",    price = nil }, --黄昏匙型假饵
	{ name = "oceanfishinglure_spoon_blue",     price = nil }, --夜间匙型假饵
	{ name = "oceanfishinglure_spinner_red",    price = nil }, --日出旋转亮片
	{ name = "oceanfishinglure_spinner_green",  price = nil }, --黄昏旋转亮片
	{ name = "oceanfishinglure_spinner_blue",   price = nil }, --夜间旋转亮片
	{ name = "oceanfishinglure_hermit_drowsy",  price = 230 }, --麻醉鱼饵
	{ name = "oceanfishinglure_hermit_rain",    price = 200 }, --雨天鱼饵
	{ name = "oceanfishinglure_hermit_snow",    price = 200 }, --雪天鱼饵
	{ name = "oceanfishinglure_hermit_heavy",   price = 200 }, --重量级鱼饵

	{ name = "oar",                             price = nil }, --浆
	{ name = "oar_driftwood",                   price = nil }, --浮木浆
	{ name = "oar_monkey",                      price = 300 }, --战浆
	{ name = "boat_item",                       price = 200 }, --船套装
	{ name = "boat_ancient_item",               price = 500 }, --古董船套装
	{ name = "boatpatch",                       price = nil }, --船补丁
	{ name = "boat_grass_item",                 price = nil }, --草筏套装
	{ name = "boat_bumper_kelp_kit",            price = 120 }, --海带保险杠套装
	{ name = "boat_bumper_shell_kit",           price = 240 }, --贝壳保险杠套装
	{ name = "anchor_item",                     price = nil }, --锚套装
	{ name = "mast_item",                       price = 350 }, --桅杆套装
	{ name = "steeringwheel_item",              price = nil }, --方向舵套装
	{ name = "mastupgrade_lamp_item",           price = nil }, --甲板照明灯
	{ name = "mastupgrade_lightningrod_item",   price = nil }, --避雷导线
	{ name = "boat_rotator_kit",                price = 500 }, --转向舵套装
	{ name = "ocean_trawler_kit",               price = 346 }, --海洋拖网捕鱼器套装
	{ name = "boat_magnet_kit",                 price = nil }, --自动航行套装
	{ name = "boat_magnet_beacon",              price = nil }, --自动航行灯塔
	{ name = "boat_cannon_kit",                 price = nil }, --大炮套装
	{ name = "cannonball_rock_item",            price = nil }, --炮弹
	{ name = "dock_kit",                        price = nil }, --码头套装
	{ name = "dock_woodposts_item",             price = nil }, --码头桩


	--地皮
	{ name = "turf_grass",                      price = nil }, --长草地皮
	{ name = "turf_forest",                     price = nil }, --森林地皮
	{ name = "turf_savanna",                    price = nil }, --热带草原地皮
	{ name = "turf_deciduous",                  price = nil }, --落叶林地皮
	{ name = "turf_rocky",                      price = nil }, --岩石地皮
	{ name = "turf_desertdirt",                 price = nil }, --沙漠地皮
	{ name = "turf_marsh",                      price = nil }, --沼泽地皮
	{ name = "turf_fungus",                     price = nil }, --真菌地皮
	{ name = "turf_fungus_red",                 price = nil }, --真菌地皮
	{ name = "turf_fungus_green",               price = nil }, --真菌地皮
	{ name = "turf_fungus_moon",                price = nil }, --变异真菌地皮
	{ name = "turf_sinkhole",                   price = nil }, --黏滑地皮
	{ name = "turf_mud",                        price = nil }, --泥泞地皮
	{ name = "turf_underrock",                  price = nil }, --洞穴岩石地皮
	{ name = "turf_cave",                       price = nil }, --鸟粪地皮
	{ name = "turf_pebblebeach",                price = 40 }, --岩石海滩地皮
	{ name = "turf_shellbeach",                 price = nil }, --贝壳海滩地皮
	{ name = "turf_meteor",                     price = 87 }, --月球环形山地皮
	{ name = "turf_monkey_ground",              price = 20 }, --月亮码头海滩地皮
	{ name = "turf_archive",                    price = 114 }, --远古石刻
	{ name = "turf_ruinsbrick",                 price = nil }, --远古地面
	{ name = "turf_ruinsbrick_glow",            price = nil }, --仿远古地面
	{ name = "turf_ruinstrim",                  price = nil }, --远古砖雕
	{ name = "turf_ruinstrim_glow",             price = nil }, --仿远古砖雕
	{ name = "turf_ruinstiles",                 price = nil }, --远古瓷砖地皮
	{ name = "turf_ruinstiles_glow",            price = nil }, --仿远古瓷砖地皮


	--人工地皮
	{ name = "turf_woodfloor",                  price = nil }, --木质地板
	{ name = "turf_road",                       price = nil }, --卵石路
	{ name = "turf_cotl_brick",                 price = nil }, --砖地皮咩咩咩
	{ name = "turf_cotl_gold",                  price = nil }, --黄金地皮咩咩咩
	{ name = "turf_carpetfloor",                price = nil }, --地毯地板
	{ name = "turf_carpetfloor2",               price = nil }, --茂盛地板
	{ name = "turf_checkerfloor",               price = nil }, --方格地板
	{ name = "turf_beard_rug",                  price = nil }, --胡须地毯
	{ name = "turf_mosaic_blue",                price = nil }, --蓝色马赛克地
	{ name = "turf_mosaic_grey",                price = nil }, --灰色马赛克地面
	{ name = "turf_mosaic_red",                 price = nil }, --红色马赛克地面
	{ name = "turf_dragonfly",                  price = 180 }, --龙鳞地板

	{ name = "fence_rotator",                   price = nil }, --栅栏击剑
	{ name = "fence_item",                      price = nil }, --栅栏
	{ name = "fence_gate_item",                 price = nil }, --木门
	{ name = "wall_hay_item",                   price = nil }, --草墙
	{ name = "wall_wood_item",                  price = nil }, --木墙
	{ name = "wall_stone_item",                 price = nil }, --石墙
	{ name = "wall_moonrock_item",              price = nil }, --月石墙
	{ name = "wall_ruins_item",                 price = 60 }, --铥矿墙
	{ name = "wall_dreadstone_item",            price = 480 }, --绝望石墙
	{ name = "wall_scrap_item",                 price = 480 }, --废料墙

	


}

itemlist.selist_resource =
{
	{ name = "cutgrass",                             price = 4 },                                        --草
	{ name = "rope",                                 price = 16 },                                       --绳子
	{ name = "twigs",                                price = 4 },                                        --树枝
	{ name = "log",                                  price = 5 },                                       --木头
	{ name = "boards",                               price = 25 },                                       --木板
	{ name = "charcoal",                             price = 6 },                                        --木炭
	{ name = "ash",                                  price = 2 },                                        --灰烬	
	{ name = "driftwood_log",                        price = 10 },                                       --浮木桩
	{ name = "cutreeds",                             price = 8 },                                        --芦苇
	{ name = "papyrus",                              price = 37 },                                       --莎草纸
	{ name = "rocks",                                price = 5 },                                        --石头
	{ name = "cutstone",                             price = 18 },                                       --石砖
	{ name = "flint",                                price = 6 },                                        --燧石
	{ name = "nitre",                                price = 8 },                                       --硝石
	{ name = "goldnugget",                           price = 10 },                                       --金块
	{ name = "transistor",                           price = 45 },                                       --电子元件
	{ name = "gears",                                price = 100 },                                      --齿轮
	{ name = "saltrock",                             price = 15 },                                       --盐晶
	{ name = "rock_avocado_fruit",                   price = 12, tex = "rock_avocado_fruit_rockhard.tex" }, --石果
	{ name = "marble",                               price = 15 },                                       --大理石
	{ name = "marblebean",                           price = 15 },                                       --大理石豌豆
	{ name = "moonrocknugget",                       price = 15 },                                       --月岩
	{ name = "palmcone_scale",                       price = 20 },                                       --棕榈松果树鳞片	
	{ name = "dug_berrybush",                        price = 20 },                                       -- 浆果丛
	{ name = "dug_berrybush2",                       price = 25 },                                       -- 热带浆果丛
	{ name = "dug_berrybush_juicy",                  price = 30 },                                       -- 蜜汁浆果丛
	{ name = "dug_bananabush",                       price = 38 },                                       -- 香蕉丛
	{ name = "dug_grass",                            price = 15 },                                       -- 草丛
	{ name = "dug_sapling",                          price = 15 },                                       -- 树枝丛
	{ name = "dug_sapling_moon",                     price = 15 },                                       -- 月岛树枝丛
	{ name = "dug_marsh_bush",                       price = 15 },                                       -- 尖刺丛
	{ name = "dug_monkeytail",                       price = 30 },                                       -- 猴尾草
	{ name = "dug_rock_avocado_bush",                price = 30 },                                       -- 月岛石果丛
	{ name = "pinecone",                             price = 5 },                                        --常青树种子
	{ name = "acorn",                                price = 5 },                                        --桦树种子
	{ name = "twiggy_nut",                           price = 5 },                                        --多枝树种
	{ name = "palmcone_seed",                        price = 20 },                                       --棕榈松果树芽
	{ name = "lureplantbulb",                        price = 50 },                                       --食人花
	{ name = "livingtree_root",                      price = 50 },                                       --完全正常的树根
	{ name = "ancienttree_seed",                     price = 50 },                                       --惊喜种子
	{ name = "ancienttree_gem_sapling_item",         price = 50 },                                       -- 萌芽石苗
	{ name = "ancienttree_nightvision_sapling_item", price = 50 },                                       --阴郁之棘苗
	{ name = "rock_avocado_fruit_sprout",            price = 50 },                                       --发芽的石果
	{ name = "bullkelp_root",                        price = 30 },                                       --公牛海带茎
	{ name = "waterplant_planter",                   price = 30 },                                       --海芽插穗
	{ name = "dug_trap_starfish",                    price = 60 },                                       --海星陷阱
	{ name = "seeds",                                price = 6 },                                        --种子
	{ name = "carrot_seeds",                         price = 50 },                                       --胡萝卜种子
	{ name = "corn_seeds",                           price = 50 },                                       --玉米种子
	{ name = "potato_seeds",                         price = 50 },                                       --土豆种子
	{ name = "tomato_seeds",                         price = 50 },                                       --番茄种子
	{ name = "asparagus_seeds",                      price = 50 },                                       --芦笋种子
	{ name = "eggplant_seeds",                       price = 50 },                                       --茄子种子
	{ name = "pumpkin_seeds",                        price = 50 },                                       --南瓜种子
	{ name = "watermelon_seeds",                     price = 50 },                                       --西瓜种子
	{ name = "dragonfruit_seeds",                    price = 50 },                                       --火龙果种子
	{ name = "durian_seeds",                         price = 50 },                                       --榴莲种子
	{ name = "garlic_seeds",                         price = 50 },                                       --大蒜种子
	{ name = "onion_seeds",                          price = 50 },                                       --洋葱种子
	{ name = "pepper_seeds",                         price = 50 },                                       --辣椒种子
	{ name = "pomegranate_seeds",                    price = 50 },                                       --石榴种子

	{ name = "foliage",                              price = 6 },                                         --蕨叶
	{ name = "succulent_picked",                     price = 8 },                                        --肉质植物
	{ name = "lightbulb",                            price = 10 },                                       --荧光果
	{ name = "wormlight_lesser",                     price = 16 },                                       --小发光浆果
	{ name = "wormlight",                            price = 32 },                                       --发光浆果
	{ name = "ancientfruit_nightvision",             price = 60 },                                       --夜莓
	{ name = "fireflies",                            price = 30 },                                       --萤火虫
	{ name = "lightflier",                           price = 100 },                                      --球状光虫
	{ name = "ancientfruit_gem",                     price = 500 },                                      --晶洞果
	{ name = "redgem",                               price = 100 },                                      --红宝石
	{ name = "bluegem",                              price = 100 },                                      --蓝宝石
	{ name = "purplegem",                            price = 200 },                                      --紫宝石
	{ name = "moonglass",                            price = 100 },                                      --月亮碎片
	{ name = "livinglog",                            price = 40 },                                       --活木
	{ name = "nightmarefuel",                        price = 32 },                                       --噩梦燃料
	{ name = "spidergland",                          price = 16 },                                       --蜘蛛腺体
	{ name = "silk",                                 price = 20 },                                       --蜘蛛网
	{ name = "spidereggsack",                        price = 140 },                                      --蜘蛛巢
	{ name = "honeycomb",                            price = 120 },                                      --蜂巢
	{ name = "beeswax",                              price = 130 },                                      --蜂蜡
	{ name = "waxpaper",                             price = 180 },                                      --蜡纸
	{ name = "coontail",                             price = 100 },                                      --猫尾
	{ name = "furtuft",                              price = 62 },                                       --毛簇
	{ name = "boneshard",                            price = 20 },                                       --骨片
	{ name = "houndstooth",                          price = 38 },                                       --狗牙
	{ name = "stinger",                              price = 18 },                                       --蜂刺
	{ name = "cookiecuttershell",                    price = 52 },                                       --饼干切割机壳
	{ name = "messagebottleempty",                   price = 38 },                                       --空瓶子
	{ name = "gelblob_bottle",                       price = 60 },                                       --恶液
	{ name = "horn",                                 price = 180 },                                      --牛角
	{ name = "beefalowool",                          price = 21 },                                       --牛毛
	{ name = "pigskin",                              price = 48 },                                       --猪皮
	{ name = "manrabbit_tail",                       price = 53 },                                       --兔毛
	{ name = "feather_crow",                         price = 16 },                                       --黑鸟毛
	{ name = "feather_robin",                        price = 18 },                                       --红鸟毛
	{ name = "feather_robin_winter",                 price = 22 },                                       --蓝鸟毛
	{ name = "feather_canary",                       price = 36 },                                       --金鸟毛
	{ name = "beardhair",                            price = 20 },                                       --胡须
	{ name = "tentaclespots",                        price = 74 },                                       --触手皮
	{ name = "mosquitosack",                         price = 32 },                                       --血袋
	{ name = "rottenegg",                            price = 10 },                                       --臭鸡蛋
	{ name = "spoiled_food",                         price = 6 },                                        --腐烂食物
	{ name = "poop",                                 price = 12 },                                       --屎
	{ name = "guano",                                price = 7 },                                        --鸟屎
	{ name = "spoiled_fish_small",                   price = 7 },                                        --坏掉的小鱼
	{ name = "spoiled_fish",                         price = 8 },                                        --坏掉的鱼
	{ name = "phlegm",                               price = 30 },                                       --鼻涕
	{ name = "glommerfuel",                          price = 38 },                                       --格罗姆粘液
	{ name = "slurtleslime",                         price = 30 },                                       --含糊虫粘液
	{ name = "slurtle_shellpieces",                  price = 30 },                                       --壳碎片
	{ name = "spore_medium",                         price = 55 },                                       --红色孢子
	{ name = "spore_small",                          price = 55 },                                       --绿色孢子
	{ name = "spore_tall",                           price = 55 },                                       --蓝色孢子
	{ name = "tallbirdegg",                          price = 130 },                                      --高鸟蛋
	{ name = "ghostflower",                          price = 100 },                                      --哀悼荣耀
	--小动物
	{ name = "butterfly",                            price = 16 },                                       --蝴蝶
	{ name = "moonbutterfly",                        price = 50 },                                       --月蛾
	{ name = "bee",                                  price = 22 },                                       --蜜蜂
	{ name = "killerbee",                            price = 22 },                                       --杀人蜂
	{ name = "mosquito",                             price = 25 },                                       --蚊子
	{ name = "rabbit",                               price = 24 },                                       --兔子
	{ name = "mole",                                 price = 36 },                                       --地鼠
	{ name = "carrat",                               price = 42 },                                       --胡萝卜鼠
	{ name = "lightcrab",                            price = 136 },                                      --发光蟹
	{ name = "wobster_moonglass_land",               price = 120 },                                      --月光龙虾
	--蜘蛛
	{ name = "spider",                               price = 100 },                                      --蜘蛛
	{ name = "spider_warrior",                       price = 150 },                                      --蜘蛛战士
	{ name = "spider_water",                         price = 150 },                                      --海黾
	{ name = "spider_hider",                         price = 150 },                                      --洞穴蜘蛛
	{ name = "spider_spitter",                       price = 300 },                                      --喷吐蜘蛛
	{ name = "spider_dropper",                       price = 220 },                                      --穴居悬蛛
	{ name = "spider_moon",                          price = 230 },                                      --破碎蜘蛛
	{ name = "spider_healer",                        price = 520 },                                      --护士蜘蛛
	--鸟类
	{ name = "crow",                                 price = 22 },                                       --黑鸟
	{ name = "robin",                                price = 33 },                                       --红鸟
	{ name = "robin_winter",                         price = 44 },                                       --蓝鸟
	{ name = "puffin",                               price = 48 },                                       --海鹦鹉
	{ name = "canary",                               price = 55 },                                       --金丝雀
	{ name = "canary_poisoned",                      price = 125 },                                      --中毒金丝雀
	{ name = "bird_mutant",                          price = 78 },                                       --月茫乌鸦
	{ name = "bird_mutant_spitter",                  price = 78 },                                       --奇形鸟
	--鱼类
	{ name = "pondfish",                             price = 90 },                                       --淡水鱼
	{ name = "pondeel",                              price = 90 },                                       --活鳗鱼
	{ name = "oceanfish_medium_1_inv",               price = 136 },                                      --泥鱼
	{ name = "oceanfish_medium_2_inv",               price = 136 },                                      --斑鱼
	{ name = "oceanfish_medium_3_inv",               price = 136 },                                      --浮夸狮子鱼
	{ name = "oceanfish_medium_4_inv",               price = 136 },                                      --黑鲶鱼
	{ name = "oceanfish_medium_5_inv",               price = 150 },                                      --玉米鳕鱼
	{ name = "oceanfish_medium_6_inv",               price = 136 },                                      --花锦鲤
	{ name = "oceanfish_medium_7_inv",               price = 150 },                                      --金锦鲤
	{ name = "oceanfish_medium_8_inv",               price = 350 },                                      --冰鲷鱼
	{ name = "oceanfish_medium_9_inv",               price = 150 },                                      --甜味鱼
	{ name = "oceanfish_small_1_inv",                price = 90 },                                       --小孔雀鱼
	{ name = "oceanfish_small_2_inv",                price = 90 },                                       --针鼻喷墨鱼
	{ name = "oceanfish_small_3_inv",                price = 90 },                                       --小饵鱼
	{ name = "oceanfish_small_4_inv",                price = 90 },                                       --三文鱼苗
	{ name = "oceanfish_small_5_inv",                price = 90 },                                       --爆米花鱼
	{ name = "oceanfish_small_6_inv",                price = 350 },                                      --落叶比目鱼(秋)
	{ name = "oceanfish_small_7_inv",                price = 350 },                                      --花朵金枪鱼(春)
	{ name = "oceanfish_small_8_inv",                price = 350 },                                      --炽热太阳鱼
	{ name = "oceanfish_small_9_inv",                price = 350 },                                      --口水鱼

}

itemlist.selist_precious =
{
	{ name = "blueprint",                       price = 200 }, --蓝图
	{ name = "mandrake",                        price = 2500 }, --曼德拉草
	--草图相关
	{ name = "chesspiece_rook_sketch", tex = "sketch.tex", price = 200 }, --战车草图
	{ name = "chesspiece_bishop_sketch", tex = "sketch.tex", price = 200 }, --主教草图
	{ name = "chesspiece_knight_sketch", tex = "sketch.tex", price = 200 }, --骑士草图
	--巨鹿相关
	{ name = "deerclops_eyeball",               price = 1600 }, --眼球
	{ name = "eyebrellahat",                    price = nil }, --眼球伞
	--克劳斯相关
	{ name = "deer_antler3",                    price = 250 }, --鹿角
	{ name = "klaussackkey",                    price = 1800 }, --麋鹿茸
	--麋鹿鹅相关
	{ name = "goose_feather",                   price = 150 }, --鹅毛
	--熊大相关
	{ name = "bearger_fur",                     price = 1800 }, --熊皮
	{ name = "icepack",                         price = nil }, --保鲜背包
	{ name = "beargervest",                     price = nil }, --熊皮大衣
	--龙蝇相关
	{ name = "dragon_scales",                   price = 1600 }, --龙鳞
	{ name = "lavae_egg",                       price = 600 }, --熔岩虫卵
	{ name = "armordragonfly",                  price = nil }, --龙鳞衣
	--蜂后相关
	{ name = "hivehat",                         price = 2000 }, --蜂王冠
	{ name = "royal_jelly",                     price = 1100 }, --蜂王浆
	{ name = "jellybean",                       price = 400 }, --糖豆
	--蚁狮
	{ name = "antlionhat",                      price = nil }, --刮地皮头盔
	{ name = "townportaltalisman",              price = 200 }, --沙之石	
	--影织者
	{ name = "fossil_piece",                    price = 600 }, --化石碎片
	{ name = "armorskeleton",                   price = 5000 }, --骨甲
	{ name = "skeletonhat",                     price = 3200 }, --骨盔
	{ name = "thurible",                        price = 2400 }, --暗影香炉	
	{ name = "shadowheart",                     price = 3000 }, --暗影之心
	--毒菌蟾蜍相关
	{ name = "sleepbomb",                       price = 800 }, --催眠袋
	{ name = "red_mushroomhat",                 price = 320 }, --红菇帽
	{ name = "green_mushroomhat",               price = 320 }, --绿菇帽
	{ name = "blue_mushroomhat",                price = 320 }, --蓝菇帽
	{ name = "shroom_skin",                     price = 1600 }, --蛤蟆皮
	{ name = "moon_mushroomhat",                price = nil }, --月亮蘑菇帽
	--三基佬相关
	{ name = "trinket_15",                      price = 270 }, --白主教
	{ name = "trinket_16",                      price = 270 }, --黑主教
	{ name = "trinket_28",                      price = 270 }, --白战车
	{ name = "trinket_29",                      price = 270 }, --黑战车
	{ name = "trinket_30",                      price = 270 }, --白骑士
	{ name = "trinket_31",                      price = 270 }, --黑骑士
	--天体相关
	{ name = "moonstorm_spark",                 price = 200 }, --月熠
	{ name = "moonglass_charged",               price = 220 }, --灌注月亮碎片
	{ name = "moonstorm_static_item",           price = 2000 }, --约束静电
	{ name = "alterguardianhat",                price = 30000 }, --启迪之冠
	{ name = "alterguardianhatshard",           price = 1000 }, --启迪之冠碎片
	{ name = "chestupgrade_stacksize",          price = nil }, --弹性空间制造器
	--远古相关
	{ name = "greengem",                        price = 1400 }, --绿宝石
	{ name = "orangegem",                       price = 1100 }, --橙宝石
	{ name = "yellowgem",                       price = 1100 }, --黄宝石
	{ name = "opalpreciousgem",                 price = 4500 }, --彩虹宝石	
	{ name = "eyeturret_item",                  price = nil }, --眼球塔
	{ name = "greenstaff",                      price = nil }, --绿法杖
	{ name = "orangestaff",                     price = nil }, --橙法杖
	{ name = "yellowstaff",                     price = nil }, --黄法杖
	{ name = "multitool_axe_pickaxe",           price = nil }, --多用斧镐	
	{ name = "nutrientsgoggleshat",             price = nil }, --高级耕作先驱帽
	{ name = "minotaurhorn",                    price = 2500 }, --犀牛角
	{ name = "thulecite",                       price = 150 }, --铥矿
	{ name = "thulecite_pieces",                price = 20 }, --铥矿碎片
	{ name = "armorruins",                      price = nil }, --铥矿甲
	{ name = "ruins_bat",                       price = nil }, --铥矿棒
	{ name = "ruinshat",                        price = nil }, --铥矿头盔
	{ name = "nightmare_timepiece",             price = nil }, --铥矿徽章	
	{ name = "greenamulet",                     price = nil }, --建造护符
	{ name = "orangeamulet",                    price = nil }, --懒人护符
	{ name = "yellowamulet",                    price = nil }, --魔光护符
	{ name = "shadow_forge_kit",                price = nil }, --暗影术基座套装	
	{ name = "voidcloth",                       price = 200 }, --暗影碎布
	{ name = "voidcloth_scythe",                price = nil }, --暗影收割者
	{ name = "voidcloth_umbrella",              price = nil }, --暗影伞
	{ name = "voidclothhat",                    price = nil }, --虚空风帽
	{ name = "armor_voidcloth",                 price = nil }, --虚空长袍
	{ name = "voidcloth_kit",                   price = nil }, --虚空修补套件
	{ name = "purebrilliance",                  price = 200 }, --纯粹辉煌
	{ name = "lunarplant_husk",                 price = 200 }, --亮茄外壳
	{ name = "bomb_lunarplant",                 price = nil }, --亮茄炸弹
	{ name = "staff_lunarplant",                price = nil }, --亮茄魔杖
	{ name = "sword_lunarplant",                price = nil }, --亮茄剑
	{ name = "armor_lunarplant",                price = nil }, --亮茄盔甲
	{ name = "lunarplanthat",                   price = nil }, --亮茄头盔
	{ name = "pickaxe_lunarplant",              price = nil }, --亮茄粉碎者
	{ name = "shovel_lunarplant",               price = nil }, --亮茄铲子
	{ name = "lunarplant_kit",                  price = nil }, --亮茄修补套件
	{ name = "lunar_forge_kit",                 price = nil }, --辉煌铁匠铺套装
	{ name = "monkey_mediumhat",                price = 1000 }, --船长的三角帽
	{ name = "polly_rogershat",                 price = nil }, --波莉·罗杰的帽子
	{ name = "malbatross_feather",              price = 200 }, --邪天翁羽毛
	{ name = "malbatross_beak",                 price = 500 }, --邪天翁喙
	{ name = "gnarwail_horn",                   price = 400 }, --一角鲸的角
	{ name = "messagebottle",                   price = 250 }, --瓶中信
	{ name = "trident",                         price = 2000 }, --刺耳三叉戟
	{ name = "horrorfuel",                      price = 200, }, --纯粹恐惧
	{ name = "dreadstone",                      price = 200 }, --绝望石
	{ name = "armordreadstone",                 price = nil }, --绝望石甲
	{ name = "dreadstonehat",                   price = nil }, --绝望石盔
	{ name = "beeswax_spray",                   price = nil }, --防腐喷雾
	{ name = "eyemaskhat",                      price = 450, }, --眼面具
	{ name = "shieldofterror",                  price = 3000 }, --恐怖盾牌
	{ name = "oceantreenut",                    price = 3000 }, --疙瘩树果
	{ name = "krampus_sack",                    price = 10000 }, --小偷包
	{ name = "steelwool",                       price = 200 }, --刚羊毛
	{ name = "walrus_tusk",                     price = 500 }, --海象牙
	{ name = "walrushat",                       price = 600 }, --海象帽
	{ name = "nightstick",                      price = nil }, --晨星
	{ name = "panflute",                        price = nil }, --排箫	
	{ name = "staff_tornado",                   price = nil }, --旋风
	{ name = "lightninggoathorn",               price = 300 }, --电羊角
	{ name = "slurper_pelt",                    price = 100 }, --辍食者皮
	{ name = "slurtlehat",                      price = 300 }, --蜗牛头盔
	{ name = "armorsnurtleshell",               price = 400 }, --蜗牛壳
	{ name = "armorslurper",                    price = nil }, --饥饿腰带
	{ name = "cane",                            price = nil }, --步行手杖
	{ name = "featherfan",                      price = nil }, --鹅毛扇
	{ name = "opalstaff",                       price = 3000 }, --唤月法杖
	{ name = "saddle_race",                     price = nil }, --蝴蝶鞍
	{ name = "saddle_war",                      price = nil }, --战争鞍具
	{ name = "deserthat",                       price = nil }, --沙漠护目镜
	{ name = "moonstorm_goggleshat",            price = nil }, --星象护目镜
	--恐惧宿主
	{ name = "wagpunk_bits",                    price = 200 }, --废铁
	{ name = "wagpunkhat",                      price = nil }, --齿轮头盔
	{ name = "armorwagpunk",                    price = nil }, --齿轮甲
	{ name = "wagpunkbits_kit",                 price = nil }, --修理套件
	{ name = "security_pulse_cage",             price = 3300 }, --火花方舟
	{ name = "security_pulse_cage_full",        price = 5000 }, --火花方舟满
	{ name = "beargerfur_sack",                 price = nil }, --极地熊灌桶
	{ name = "deerclopseyeball_sentryward_kit", price = nil }, --冰晶生成器套装
	{ name = "houndstooth_blowpipe",            price = nil }, --榴弹炮

	{ name = "scraphat",                        price = 500 }, --拾荒尖帽
	{ name = "scrap_monoclehat",                price = nil }, --视界扩展器
	{ name = "boat_bumper_crabking_kit",        price = 600 }, --帝王蟹保险杠
	{ name = "gelblob_storage_kit",             price = nil }, --恶液储存箱套件Icker Preserve Kit（2024.09.13高深莫测）
	{ name = "carpentry_blade_moonglass",       price = nil }, --月光玻璃锯片Moon Glass Saw Blade（2024.09.13高深莫测）

	{ name = "shadowheart_infused",             price = 2000 }, --附身暗影心房Possessed Shadow Atrium（2024.09.13高深莫测）
	{ name = "shadow_beef_bell",                price = nil }, --阴郁皮弗娄牛铃铛Beefalo Gloom Bell（2024.09.13高深莫测）
	{ name = "saddle_shadow",                   price = nil }, --梦魇鞍具Nightmare saddle_baggage（2024.09.13高深莫测）
	{ name = "shadow_battleaxe",                price = nil }, --暗影槌Shadow Maul（2024.09.13高深莫测）
	{ name = "voidcloth_boomerang",             price = nil }, --阴郁回旋镖Gloomerang（2024.09.13高深莫测）
	{ name = "rabbitkingspear",                 price = 400 }, --兔王棍Rabbit King Cudgel（2024.09.13高深莫测）
}

itemlist.selist_precioustwo =
{
	{ name = "atrium_key",   price = 1500 }, --远古钥匙
	{ name = "hermit_pearl", price = 2000 }, --珍珠
	{ name = "terrarium",    price = 2000 }, --盒中泰拉
	{ name = "moonrockseed", price = 2000 }, --天体宝球

}


itemlist.selist_special =
{
	{ name = "luckamulet", price = 1000 }, --幸运项链
	{ name = "goldstaff",  price = 1000 }, --点金法杖
	{ name = "stealer",    price = 3000 }, --勤奋的探索者
	{ name = "vipcard",    price = 5000 }, --vip贵宾卡
}

--特殊蓝图
itemlist.selist_blueprint =
{
	{ name = "mushroom_light_blueprint",                     price = 2000 }, --萤菇灯
	{ name = "mushroom_light2_blueprint",                    price = 2000 }, --炽菇灯
	{ name = "red_mushroomhat_blueprint",                    price = 2000 }, --红菇帽
	{ name = "green_mushroomhat_blueprint",                  price = 2000 }, --绿菇帽
	{ name = "blue_mushroomhat_blueprint",                   price = 2000 }, --蓝菇帽
	{ name = "sleepbomb_blueprint",                          price = 2000 }, --睡袋
	{ name = "bundlewrap_blueprint",                         price = 2000 }, --捆绑包装
	{ name = "endtable_blueprint",                           price = 2000 }, --茶几
	{ name = "dragonflyfurnace_blueprint",                   price = 2000 }, --龙鳞火炉
	{ name = "townportal_blueprint",                         price = 2000 }, --懒人传送阵
	{ name = "antlionhat_blueprint",                         price = 2000 }, --刮地皮头盔
	{ name = "deserthat_blueprint",                          price = 2000 }, ----沙漠护目镜
	{ name = "moonstorm_goggleshat_blueprint",               price = 2000 }, --星象护目镜
	{ name = "moon_device_construction1_blueprint",          price = 2000 }, --未完成的实验
	{ name = "archive_resonator_item_blueprint",             price = 2000 }, --星象探测器
	{ name = "turfcraftingstation_blueprint",                price = 2000 }, --土地夯实器
	{ name = "refined_dust_blueprint",                       price = 2000 }, --尘土块
	{ name = "trident_blueprint",                            price = 2000 }, --三叉戟
	{ name = "winch_blueprint",                              price = 2000 }, --夹夹绞盘
	{ name = "pirate_flag_pole_blueprint",                   price = 2000 }, --海盗旗
	{ name = "boat_cannon_kit_blueprint",                    price = 2000 }, --大炮套装
	{ name = "cannonball_rock_item_blueprint",               price = 2000 }, --炮弹
	{ name = "dock_kit_blueprint",                           price = 2000 }, --码头套装
	{ name = "dock_woodposts_item_blueprint",                price = 2000 }, --码头桩
	{ name = "turf_monkey_ground_blueprint",                 price = 2000 }, --月亮码头海滩地皮
	{ name = "turf_shellbeach_blueprint",                    price = 2000 }, --沙滩地皮	
	{ name = "turf_archive_blueprint",                       price = 2000 }, --远古石刻
	{ name = "turf_ruinsbrick_blueprint",                    price = 2000 }, --远古地面
	{ name = "turf_ruinsbrick_glow_blueprint",               price = 2000 }, --仿远古地面
	{ name = "turf_ruinstrim_blueprint",                     price = 2000 }, --远古砖雕
	{ name = "turf_ruinstrim_glow_blueprint",                price = 2000 }, --仿远古砖雕
	{ name = "turf_ruinstiles_blueprint",                    price = 2000 }, --远古瓷砖地皮
	{ name = "turf_ruinstiles_glow_blueprint",               price = 2000 }, --仿远古瓷砖地皮
	{ name = "armordreadstone_blueprint",                    price = 2000 }, --绝望石盔甲
	{ name = "dreadstonehat_blueprint",                      price = 2000 }, --绝望石头盔
	{ name = "wall_dreadstone_item_blueprint",               price = 2000 }, --绝望石墙
	{ name = "support_pillar_dreadstone_scaffold_blueprint", price = 2000 }, --绝望石柱子	
	{ name = "support_pillar_scaffold_blueprint",            price = 2000 }, --柱子	

	--遗物复制品蓝图
	{ name = "ruinsrelic_table_blueprint",                   price = 2000 },
	{ name = "ruinsrelic_chair_blueprint",                   price = 2000 },
	{ name = "ruinsrelic_vase_blueprint",                    price = 2000 },
	{ name = "ruinsrelic_chipbowl_blueprint",                price = 2000 },
	{ name = "ruinsrelic_bowl_blueprint",                    price = 2000 },
	{ name = "ruinsrelic_plate_blueprint",                   price = 2000 },
	--恐惧宿主
	{ name = "carpentry_station_blueprint",                  price = 2000 }, --锯马
	{ name = "wagpunkhat_blueprint",                         price = 2000 }, --齿轮头盔
	{ name = "armorwagpunk_blueprint",                       price = 2000 }, --齿轮甲
	{ name = "wagpunkbits_kit_blueprint",                    price = 2000 }, --齿轮修理套件
	--咩~
	{ name = 'cotl_tabernacle_level1_blueprint',             price = 2000 },
	{ name = 'turf_cotl_brick_blueprint',                    price = 2000 },
	{ name = 'turf_cotl_gold_blueprint',                     price = 2000 },

	{ name = 'chestupgrade_stacksize_blueprint',             price = 2000 }, --箱子升级套件

}

--不能分解这个表里的物品
ForbiddenItems = {
	"moon_altar_icon",
	"moon_altar_ward",
	"moon_altar_glass",
	"moon_altar_seed",
	"moon_altar_idol",
	"moon_altar_crown",
	"chester_eyebone",
	"hutch_fishbowl",
	"fruitflyfruit",
	"glommerflower",
	"packim_fishbone",
	"rawling",
	"sunken_boat_trinket_4"
}
--不受cd影响的物品
allowone = {
	"sweet_potato_oversized",
	"carrot_oversized",
	"corn_oversized",
	"durian_oversized",
	"pomegranate_oversized",
	"eggplant_oversized",
	"pumpkin_oversized",
	"watermelon_oversized",
	"dragonfruit_oversized",
	"asparagus_oversized",
	"onion_oversized",
	"potato_oversized",
	"tomato_oversized",
	"garlic_oversized",
	"pepper_oversized"
}

--不开启分解功能也能分解这表里的物品
allowtwo = {
	"vipcard",
	"luckamulet"
}

--这个表是巨大作物回收的价格(会因倍率而变化)，给种田玩家的赚钱用的，只用于回收。
itemlist.price_basa =
{
	{ name = "sweet_potato_oversized", price = 333 }, --海难甜薯巨大作物
	{ name = "carrot_oversized",       price = 333 }, --胡萝卜巨大作物
	{ name = "corn_oversized",         price = 333 }, --玉米巨大作物
	{ name = "durian_oversized",       price = 333 }, --榴莲巨大作物
	{ name = "pomegranate_oversized",  price = 333 }, --石榴巨大作物
	{ name = "eggplant_oversized",     price = 356 }, --茄子巨大作物
	{ name = "pumpkin_oversized",      price = 408 }, --南瓜巨大作物
	{ name = "watermelon_oversized",   price = 408 }, --西瓜巨大作物
	{ name = "dragonfruit_oversized",  price = 458 }, --火龙果巨大作物
	{ name = "asparagus_oversized",    price = 333 }, --芦笋巨大作物
	{ name = "onion_oversized",        price = 418 }, --洋葱巨大作物
	{ name = "potato_oversized",       price = 356 }, --土豆巨大作物
	{ name = "tomato_oversized",       price = 333 }, --番茄巨大作物
	{ name = "garlic_oversized",       price = 333 }, --大蒜巨大作物
	{ name = "pepper_oversized",       price = 333 }, --辣椒巨大作物

}


itemlist.selist_foodum =
{
	{ name = "fishmeat_dried",         price = 70 },                                                   --鱼干
	{ name = "smallfishmeat_dried",    price = 40 },                                                   --小鱼干
	{ name = "monstersmallmeat",       price = 15 },                                                   --小怪物肉
	{ name = "scorpioncarapace",       price = 18, atl = "images/inventoryimages/scorpioncarapace.xml" }, --蝎子壳
	{ name = "um_monsteregg",          price = 17 },                                                   --怪物蛋
	{ name = "rice",                   price = 15 },                                                   --稻米
	{ name = "giant_blueberry",        price = 20 },                                                   --多汁蓝莓
	{ name = "viperfruit",             price = 36 },                                                   --毒莓
	{ name = "zaspberry",              price = 36 },                                                   --电莓
	{ name = "greenfoliage",           price = 8 },                                                    --连帽撅叶
	{ name = "beefalowings",           price = 160 },                                                  --牛角派
	{ name = "blueberrypancakes",      price = 100 },                                                  --蓝莓饼
	{ name = "californiaking",         price = 120 },                                                  --加州辣汤
	{ name = "um_deviled_eggs",        price = 70 },                                                   --魔鬼蛋
	{ name = "devilsfruitcake",        price = 100 },                                                  --恶魔水果蛋糕
	{ name = "viperjam",               price = 120 },                                                  --毒莓果酱
	{ name = "hardshelltacos",         price = 100 },                                                  --硬壳炸玉米饼
	{ name = "liceloaf",               price = 70 },                                                   --米花糖
	{ name = "seafoodpaella",          price = 150 },                                                  --海鲜饭
	{ name = "simpsalad",              price = 20 },                                                   --简单沙拉
	{ name = "snotroast",              price = 180 },                                                  --象鼻大餐
	{ name = "snowcone",               price = 20 },                                                   --雪糕
	{ name = "purplesteamedhams",      price = 90 },                                                   --汉堡
	{ name = "theatercorn",            price = 80 },                                                   --爆米花
	{ name = "stuffed_peeper_poppers", price = 150 },                                                  --酿辣椒爆米花
	{ name = "zaspberryparfait",       price = 150 },                                                  --电莓冻
	{ name = "honey_log",              price = 120 },                                                  --蜂蜜原木卷
}
itemlist.selist_clothum =
{
	--穿戴
	{ name = "snowgoggles",    price = 1100 }, --猫眼护目镜
	{ name = "gasmask",        price = 2400 }, --鹅毛面具
	{ name = "plaguemask",     price = 3000 }, --瘟疫面具
	{ name = "hat_ratmask",    price = 564 }, --鼠鼠面具
	{ name = "brine_balm",     price = 80 }, --盐晶药膏
	{ name = "sludge_sack",    price = 816 }, --海泥包
	{ name = "sporepack",      price = 1968 }, --孢子包
	{ name = "floral_bandage", price = 90 }, --仙人掌药膏
}

itemlist.selist_smithingum =
{

	--锻造

	{ name = "rat_whip",                      price = 117 }, --鼠尾鞭	
	{ name = "bugzapper",                     price = 190 }, --灭蚊拍
	{ name = "um_bear_trap_equippable_tooth", price = 139 }, --白捕兽夹
	{ name = "um_bear_trap_equippable_gold",  price = 150 }, --黄捕兽夹
	{ name = "um_magnerang",                  price = 1600 }, --磁力回旋镖
	{ name = "iceboomerang",                  price = 150 }, --冰冻回旋镖		
	{ name = "um_blowdart_pyre",              price = 80 }, --荨麻飞镖
	{ name = "pied_piper_flute",              price = 100 }, --鼠笛
	{ name = "uncompromising_blowgun",        price = 500 }, --暗器
	{ name = "blowgunammo_tooth",             price = 102 }, --镖
	{ name = "blowgunammo_fire",              price = 67 }, --火镖
	{ name = "blowgunammo_electric",          price = 75 }, --电镖
	{ name = "um_armor_pyre_nettles",         price = 72 }, --荨麻甲
	{ name = "armor_reed_um",                 price = 98 }, --芦苇甲
	{ name = "armor_sharksuit_um",            price = 648 }, --鲨鱼皮甲	
	{ name = "watermelon_lantern",            price = 136 }, --西瓜灯
	{ name = "saltpack",                      price = 732 }, --盐瓶 3000
	{ name = "uncompromising_fishingnet",     price = 80 }, --渔网	
	{ name = "driftwoodfishingrod",           price = 242 }, --浮木钓竿
	{ name = "sludge_oil",                    price = 190 }, --海泥提取物
	{ name = "boat_bumper_sludge_kit",        price = 136 }, --海泥保险杠
	{ name = "cannonball_sludge_item",        price = 30 }, --粗炮弹	
	{ name = "boatpatch_sludge",              price = 225 }, --海泥修理补丁
	{ name = "mastupgrade_windturbine_item",  price = 232 }, --风力发电机	
	{ name = "portableboat_item",             price = 124 }, --气垫船	
	{ name = "diseasecurebomb",               price = 211 }, --月油
	{ name = "ratpoisonbottle",               price = 124 }, --毒果酱
	{ name = "turf_ancienthoodedturf",        price = 36 }, --远古森林连帽地皮
	{ name = "turf_hoodedmoss",               price = 36 }, --连帽森林地皮
}



itemlist.selist_resourceum =
{
	--资源
	{ name = "rat_tail",         price = 20 }, --老鼠尾巴
	{ name = "sludge",           price = 40 }, --海泥
	{ name = "aphid",            price = 35 }, --蚜虫
	{ name = "um_smolder_spore", price = 70 }, --爆炸孢子
	{ name = "rockjawleather",   price = 200 }, --鲨鱼皮
	{ name = "woodpecker",       price = 36 }, --啄木鸟
	{ name = "sludge_cork",      price = 93 }, --海泥塞
	{ name = "whisperpod",       price = 100 }, --底语之荚
	{ name = "spider_trapdoor",  price = 210 }, --地板蜘蛛
	{ name = "skeletonmeat",     price = 100 }, --长猪肉
	{ name = "moon_tear",        price = 300 }, --月泪
}

itemlist.selist_preciousum =
{
	--珍贵
	{ name = "rne_goodiebag",            price = 500 },                                                  --零食袋
	{ name = "ancient_amulet_red",       price = nil },                                                  --幻灵护符
	{ name = "armor_glassmail",          price = nil },                                                  --月鳞甲
	{ name = "the_real_charles_t_horse", price = 3600 },                                                 --滑行手杖
	{ name = "shadow_crown",             price = 1000 },                                                 --暗影皇冠
	{ name = "skullflask",               price = 1000 },                                                 --头骨酒瓶
	{ name = "widowsgrasp",              price = 1000 },                                                 --寡妇爪子
	{ name = "widowshead",               price = 1000 },                                                 --寡妇头
	{ name = "shroom_skin_fragment",     price = 330 },                                                  --破碎蟾蜍皮
	{ name = "glass_scales",             price = 2000 },                                                 --启迪鳞片
	{ name = "moonglass_geode",          price = 1500 },                                                 --注能玻璃
	{ name = "sunglasses",               price = 500 },                                                  --墨镜
	{ name = "klaus_amulet",             price = 700 },                                                  --无锁
	{ name = "beargerclaw",              price = 700 },                                                  --诅咒熊爪
	{ name = "gore_horn_hat",            price = 600 },                                                  --犀牛帽
	{ name = "um_beegun",                price = 700 },                                                  --手持蜂巢
	{ name = "feather_frock",            price = 500 },                                                  --羽毛长袍
	{ name = "crabclaw",                 price = 1000 },                                                 --蟹钳
	{ name = "slobberlobber",            price = 1000 },                                                 --龙樱口哨
	{ name = "cursed_antler",            price = 1000 },                                                 --诅咒鹿角
	{ name = "staff_starfall",           price = 2000, atl = "images/inventoryimages/staff_starfall.xml" }, --星陨法杖
	{ name = "rain_horn",                price = 2000 },                                                 --雨螺
	{ name = "dormant_rain_horn",        price = 500 },                                                  --休眠海螺

}

itemlist.selist_blueprintum =
{

	{ name = "alterguardianhatshard_blueprint", price = 2000 }, --启迪碎片
	{ name = "moonstorm_static_item_blueprint", price = 2000 }, --约束静电
	{ name = "skullchest_child_blueprint",      price = 2000 }, --骷髅宝箱

}




itemlist.selist_smithing_xz =
{
	{ name = "spice_jelly",                   price = 81 }, -- 果冻粉
	{ name = "spice_voltjelly",               price = 202 }, -- 带电果冻粉
	{ name = "spice_phosphor",                price = 100 }, -- 荧光粉
	{ name = "spice_moontree_blossom",        price = 88 }, -- 月树花粉
	{ name = "spice_cactus_flower",           price = 86 }, -- 仙人掌花粉
	{ name = "spice_blood_sugar",             price = 110 }, -- 血糖
	{ name = "spice_rage_blood_sugar",        price = 252 }, -- 黑暗血糖
	{ name = "spice_soul",                    price = 82 }, -- 灵魂佐料
	{ name = "spice_potato_starch",           price = 102 }, -- 土豆淀粉
	{ name = "spice_poop",                    price = 85 }, -- 秘制酱料
	{ name = "spice_plantmeat",               price = 102 }, -- 叶肉酱
	{ name = "spice_mandrake_jam",            price = 352 }, -- 曼德拉果酱
	{ name = "spice_pomegranate",             price = 127 }, -- 山力叶酱
	{ name = "spices_box",                    price = 612 }, -- 调料盒
	{ name = "closed_book",                   price = 88 }, -- 无字天书
	{ name = "xinhua_dictionary",             price = 1320 }, -- 新华字典
	{ name = "trapreset_book",                price = 280 }, -- 陷阱重置册
	{ name = "marbleaxe",                     price = 170 }, -- 大理石斧头
	{ name = "marblepickaxe",                 price = 170 }, -- 大理石镐
	{ name = "medal_farm_plow_item",          price = 480 }, -- 高效耕地机
	{ name = "medal_waterpump_item",          price = 2200 }, -- 深井泵套件
	{ name = "medal_rain_bomb",               price = 128 }, -- 催雨弹
	{ name = "medal_clear_up_bomb",           price = 105 }, -- 放晴弹
	{ name = "medal_moonglass_shovel",        price = 432 }, -- 月光玻璃铲
	{ name = "medal_moonglass_hammer",        price = 432 }, -- 月光玻璃锤
	{ name = "medal_moonglass_bugnet",        price = 600 }, -- 月光玻璃网
	{ name = "medal_moonglass_potion",        price = 204 }, -- 月光药水
	{ name = "bottled_moonlight",             price = 200 }, -- 瓶装月光
	{ name = "medal_naughtybell",             price = 746 }, -- 淘气铃铛
	{ name = "autotrap_book",                 price = 800 }, -- 智能陷阱制作手册
	{ name = "medal_tentaclespike",           price = 500 }, -- 活性触手尖刺
	{ name = "trap_bat",                      price = 79 }, -- 蝙蝠陷阱
	{ name = "armor_medal_obsidian",          price = 408 }, -- 红晶甲
	{ name = "armor_blue_crystal",            price = 444 }, -- 蓝晶甲
	{ name = "bottled_soul",                  price = 55 }, -- 瓶装灵魂
	{ name = "medal_fishingrod",              price = 864 }, -- 玻璃钓竿
	{ name = "medal_resonator_item",          price = 600 }, -- 宝藏探测仪
	{ name = "lureplant_rod",                 price = 504 }, -- 食人花手杖
	{ name = "medal_skin_staff",              price = 800 }, -- 风花雪月
	{ name = "medal_chum",                    price = 120 }, -- 特制鱼食
	{ name = "medal_ammo_box",                price = 628 }, -- 弹药盒
	{ name = "medalslingshotammo_sanityrock", price = 84 }, -- 方尖弹
	{ name = "medalslingshotammo_sandspike",  price = 96 }, -- 沙刺弹
	{ name = "medalslingshotammo_water",      price = 20 }, -- 落水弹
	{ name = "medalslingshotammo_devoursoul", price = 50 }, -- 噬魂弹
	{ name = "medalslingshotammo_taunt",      price = 12 }, -- 痰蛋弹
	{ name = "medalslingshotammo_spines",     price = 25 }, -- 尖刺弹
	--	{ name = "medal_spacetime_snacks_packet", price = 200 }, -- 零食包装袋???
	{ name = "friendly_certificate",          price = 800 }, -- 友善勋章
	{ name = "arrest_certificate",            price = 528 }, -- 逮捕勋章
	{ name = "smallminer_certificate",        price = 153 }, -- 初级矿工勋章
	{ name = "cook_certificate",              price = 862 }, -- 烹饪勋章
	{ name = "smallchop_certificate",         price = 240 }, -- 初级伐木勋章
	{ name = "handy_test_certificate",        price = 792 }, -- 巧手考验勋章
	{ name = "wisdom_test_certificate",       price = 528 }, -- 蒙昧勋章
	{ name = "plant_certificate",             price = 1700 }, -- 虫木勋章
	{ name = "smallfishing_certificate",      price = 528 }, -- 钓鱼勋章
	{ name = "medal_box",                     price = 423 }, -- 勋章盒
}

itemlist.selist_resource_xz =
{
	--资源
	{ name = "toil_money",                price = 100 }, -- 血汗钱
	{ name = "medal_fishbones",           price = 15 }, -- 鱼骨
	{ name = "mandrakeberry",             price = 100 }, -- 曼德拉果
	{ name = "medal_weed_seeds",          price = 50 }, -- 杂草种子
	{name = "immortal_fruit_seed", price = 150}, -- 不朽种子
	{ name = "medal_gift_fruit_seed", price = 100 }, -- 包果种子
	{name = "medal_bee_larva", price = 110}, -- 育王蜂种
	{name = "medal_bee", price = 100}, -- 育王蜂
	{ name = "medal_ivy",                 price = 60 }, -- 旋花藤
	{ name = "lavaeel",                   price = 110 }, -- 熔岩鳗鱼
	{ name = "medal_obsidian",            price = 100 }, -- 红晶
	{ name = "medal_blue_obsidian",       price = 110 }, -- 蓝晶
	{ name = "sanityrock_fragment",       price = 100 }, -- 方尖碑碎片
	{ name = "medaldug_fruit_tree_stump", price = 100 }, -- 砧木桩
	{ name = "medaldug_livingtree_root",  price = 100 }, -- 活木树苗
	{name = "immortal_book", price = 884}, -- 不朽之谜
	{name = "immortal_essence", price = 252}, -- 不朽精华
	{ name = "medal_monster_essence",     price = 260 }, -- 怪物精华
	{ name = "medal_glommer_essence",     price = 182 }, -- 格罗姆精华
	{ name = "medal_dustmothden_base",    price = 300 }, -- 尘蛾巢台
	{ name = "medal_skin_coupon", price = 50 }, -- 皮肤券
	{ name = "medal_diligence_token", price = 50 }, -- 酬勤令
	{name = "medal_treasure_map_scraps1", price = 50}, -- 藏宝图碎片·日出
	{name = "medal_treasure_map_scraps2", price = 50}, -- 藏宝图碎片·黄昏
	{name = "medal_treasure_map_scraps3", price = 50}, -- 藏宝图碎片·夜晚
	{name = "medal_treasure_map", price = 50}, -- 藏宝图
	{ name = "medal_tribute_symbol", price = 50 }, -- 奉纳符
	{ name = "medal_loss_treasure_map", price = 50 }, -- 遗失藏宝图
	{ name = "medal_monster_symbol", price = 50 }, -- 暗影挑战符
	{ name = "medal_inherit_page", price = 100 }, -- 传承书页
}
--珍贵
itemlist.selist_precious_xz =
{
	{ name = "down_filled_coat",            price = 5400 }, -- 羽绒服
	{ name = "hat_blue_crystal",            price = 1872 }, -- 蓝晶帽
	-- {name = "medal_plant_book", price = 800}, -- 植物图鉴
	-- {name = "monster_book", price = 800}, -- 怪物图鉴
	-- {name = "unsolved_book", price = 800}, -- 未解之谜
	{ name = "medal_spacetime_bomb",        price = 5500 },                    -- 时空弹
	{ name = "mandrake_seeds",              price = 1500 },                    -- 曼德拉种子
	{ name = "medal_goathat",               price = 3500 },                    -- 羊角帽
	{ name = "immortal_fruit",              price = 600 },                     -- 不朽果实
	{ name = "immortal_fruit_oversized",    price = 2900 },                    -- 巨型不朽果实
	{ name = "immortal_gem",                price = 10000 },                   -- 不朽宝石
	{ name = "immortal_staff",              price = 16000 },                   -- 不朽法杖
	{ name = "sanityrock_mace",             price = 2800 },                    -- 方尖锏
	{ name = "meteor_staff",                price = 2800 },                    -- 流星法杖
	{ name = "medal_losswetpouch1",          price = 300,  tex = "wetpouch.tex" }, -- 遗失塑料袋·池塘	
	{ name = "medal_losswetpouch2",          price = 300,  tex = "wetpouch.tex" }, -- 遗失塑料袋·沼泽	
	{ name = "medal_losswetpouch3",          price = 300,  tex = "wetpouch.tex" }, -- 遗失塑料袋·洞穴	
	{ name = "medal_losswetpouch4",          price = 300,  tex = "wetpouch.tex" }, -- 遗失塑料袋·海洋	
	{ name = "medal_losswetpouch5",          price = 300,  tex = "wetpouch.tex" }, -- 遗失塑料袋·岩浆	
	{ name = "medal_losswetpouch6",          price = 300,  tex = "wetpouch.tex" }, -- 遗失塑料袋·湖泊	
	{ name = "medal_losswetpouch7",          price = 300,  tex = "wetpouch.tex" }, -- 遗失塑料袋·空间	
	{ name = "medal_spacetime_lingshi",     price = 1000 },                    -- 时空灵石
	{ name = "medal_withered_heart",        price = 8000 },                    -- 凋零之心
	{ name = "medal_withered_royaljelly",   price = 1350 },                    -- 凋零蜂王浆
	{ name = "spice_withered_royal_jelly",  price = 3700 },                    -- 凋零蜂王浆酱
	{ name = "medal_spacetime_snacks",      price = 4500 },                    -- 时空零食
	{ name = "medal_glassblock", price = 5000 }, -- 不朽晶柱
	{ name = "medal_spacetime_crystalball", price = 22000 },                   -- 预言水晶球
	{ name = "medal_spacetime_potion",      price = 648 },                     -- 改命药水
	{ name = "medal_spacetime_runes",       price = 1500 },                    -- 时空符文
	{ name = "medal_time_slider",           price = 500 },                     -- 时空碎片
	{ name = "medal_space_gem",             price = 15000 },                   -- 时空宝石
	{ name = "devour_staff",                price = 5000 },                    -- 吞噬法杖
	{ name = "medal_space_staff",           price = 22000 },                   -- 时空法杖
	{ name = "medal_dustmeringue",          price = 2100 },                    -- 琥珀灵石
	{ name = "medal_gift_fruit",            price = 300 },                     -- 包果
	{ name = "medal_gift_fruit_oversized",  price = 900 },                    -- 巨型包果
	{ name = "medal_shadow_tool",  			price = 1000 },		           	   -- 暗影魔法工具

}

itemlist.selist_precious_xzxz =
{
	{name = "blank_certificate",			   price = 1000}, -- 空白勋章	
	{ name = "speed_certificate",              price = 5000 }, -- 速度勋章
	{ name = "space_certificate",              price = 18000 }, -- 空间勋章
	{ name = "space_time_certificate",         price = 35000 }, -- 时空勋章
	{ name = "bosom_friend_certificate",       price = 8000 }, -- 挚友勋章
	{ name = "justice_certificate",            price = 10000 }, -- 正义勋章
	{ name = "merm_certificate",               price = 5000 }, -- 鱼人勋章
	{ name = "valkyrie_examine_certificate",   price = 800 }, -- 女武神的检验
	{ name = "valkyrie_test_certificate",      price = 5800 }, -- 女武神的考验
	{ name = "valkyrie_certificate",           price = 10000 }, -- 女武神勋章
	{ name = "naughty_certificate",            price = 5000 }, -- 淘气勋章
	{ name = "multivariate_certificate",       price = 1000 }, -- 融合勋章
	{name = "medium_multivariate_certificate", price = 2500}, -- 中级融合勋章
	{name = "large_multivariate_certificate",  price = 6000}, -- 高级融合勋章
	{ name = "inherit_certificate",            price = 1500 }, -- 传承勋章
	{ name = "down_filled_coat_certificate",   price = 3200 }, -- 羽绒勋章
	{ name = "blue_crystal_certificate",       price = 2000 }, -- 蓝晶勋章
	{ name = "ommateum_certificate",           price = 5000 }, -- 复眼勋章
	{ name = "treadwater_certificate",         price = 5000 }, -- 踏水勋章
	{ name = "tentacle_certificate",           price = 5000 }, -- 触手勋章
	{ name = "spider_certificate",             price = 5000 }, -- 蜘蛛勋章
	{ name = "silence_certificate",            price = 5000 }, -- 沉默勋章
	{ name = "bathingfire_certificate",        price = 5000 }, -- 浴火勋章
	{ name = "devour_soul_certificate",        price = 5000 }, -- 噬灵勋章
	{ name = "medium_devour_soul_certificate", price = 10000 }, -- 噬魂勋章
	{ name = "large_devour_soul_certificate",  price = 27000 }, -- 噬空勋章
	{ name = "bee_king_certificate",           price = 9000 }, -- 蜂王勋章
	{ name = "mediumfishing_certificate",      price = 5528 }, -- 垂钓勋章
	{ name = "largefishing_certificate",       price = 8000 }, -- 渔翁勋章
	{ name = "childishness_certificate",       price = 5000 }, -- 童心勋章
	{ name = "childlike_certificate",          price = 8000 }, -- 童真勋章
	{ name = "chef_certificate",               price = 5000 }, -- 大厨勋章
	{ name = "headchef_certificate",           price = 8000 }, -- 主厨勋章
	{ name = "mediumchop_certificate",         price = 4000 }, -- 中级伐木勋章
	{ name = "largechop_certificate",          price = 8000 }, -- 高级伐木勋章
	{ name = "mediumminer_certificate",        price = 4000 }, -- 中级矿工勋章
	{ name = "largeminer_certificate",         price = 8000 }, -- 高级矿工勋章
	{ name = "handy_certificate",              price = 7000 }, -- 巧手勋章
	{ name = "wisdom_certificate",             price = 5000 }, -- 智慧勋章
	{ name = "transplant_certificate",         price = 7000 }, -- 植物勋章
	{ name = "harvest_certificate",            price = 7000 }, -- 丰收勋章
	{ name = "shadowmagic_certificate",        price = 20000}, -- 暗影魔法勋章
}

itemlist.selist_blueprint_xz =
{

	{ name = "bearger_chest_blueprint",              price = 2000 }, --熊皮宝箱
	{ name = "medal_cookpot_blueprint",              price = 2000 }, --红晶锅
	{ name = "immortal_gem_blueprint",               price = 2000 }, --不朽宝石
	{ name = "medal_monster_essence_blueprint",      price = 2000 }, --怪物精华
	{ name = "medal_goathat_blueprint",              price = 2000 }, --羊角帽
	{ name = "trap_bat_blueprint",                   price = 2000 }, --蝙蝠陷阱
	{ name = "medal_firepit_obsidian_blueprint",     price = 2000 }, --红晶火坑
	{ name = "medal_coldfirepit_obsidian_blueprint", price = 2000 }, --蓝晶火坑
	{ name = "armor_medal_obsidian_blueprint",       price = 2000 }, --红晶甲
	{ name = "armor_blue_crystal_blueprint",         price = 2000 }, --蓝晶甲
	{ name = "medal_ice_machine_blueprint",          price = 2000 }, --制冰机
	{ name = "medal_seapond_blueprint",              price = 2000 }, --海上钓鱼池

}

itemlist.selist_food_lj =
{
	{ name = "dish_lovingrosecake",              price = 184 },                                                       -- 倾心玫瑰酥
	{ name = "dish_friedfishwithpuree",          price = 365 },                                                       -- 果泥香煎鱼
	{ name = "dish_sosweetjarkfruit",            price = 61 },                                                        -- 甜到裂开的松萝蜜
	{ name = "dish_murmurananas",                price = 101 },                                                       -- 松萝咕咾肉
	{ name = "dish_wrappedshrimppaste",          price = 162 },                                                       -- 白菇虾滑卷
	{ name = "dish_braisedmeatwithfoliages",     price = 55 },                                                        -- 蕨叶扣肉
	{ name = "dish_farewellcupcake",             price = 69 },                                                        -- 临别的纸杯蛋糕
	-- { name = "dish_flowermooncake",              price = 90 },                                                        -- 鲜花月饼
	{ name = "dish_sugarlesstrickmakercupcakes", price = 138 },                                                       -- 无糖捣蛋鬼纸杯蛋糕
	{ name = "dish_merrychristmassalad",         price = 60 },                                                        -- 圣诞快乐沙拉
	{ name = "dish_shyerryjam",                  price = 105 },                                                       -- 颤栗果酱
	{ name = "dish_duriantartare",               price = 104 },                                                       -- 怪味鞑靼
	{ name = "dish_ricedumpling",                price = 77 },                                                        -- 金黄香粽
	{ name = "dish_bananamousse",                price = 57 },                                                        -- 香蕉慕斯
	{ name = "dish_medicinalliquor",             price = 118, atl = "images/inventoryimages/dish_medicinalliquor.xml" }, -- 药酒
	{ name = "dish_pomegranatejelly",            price = 81 },                                                        -- 石榴子果冻
	{ name = "dish_roastedmarshmallows",         price = 77 },                                                        -- 烤棉花糖
	{ name = "dish_fishjoyramen",                price = 96 },                                                        -- 鱼乐拉面
	{ name = "dish_neworleanswings",             price = 118 },                                                       -- 新奥尔良烤翅
	{ name = "dish_frenchsnailsbaked",           price = 83 },                                                        -- 法式焗蜗牛
	{ name = "dish_beggingmeat",                 price = 47 },                                                        -- 叫花焖肉
	{ name = "dish_fleshnapoleon",               price = 91 },                                                        -- 真果拿破仑
	{ name = "dish_orchidcake",                  price = 75 },                                                        -- 兰花糕
	{ name = "dish_twistedrolllily",             price = 101 },                                                       -- 蹄莲花卷
	{ name = "dish_chilledrosejuice",            price = 89 },                                                        -- 蔷薇冰果汁
	--棱镜7.4.5更新
	{ name = "dish_mushedeggs",					price = 80  },														  -- 双菇烩蛋
	--棱镜7.4.9更新，鲜花月饼重做为月饼，添加了菌鱼双鲜堡、香蕈双峰(2024.12.14)
	{ name = "dish_l_mooncake",					price = 90 },														  -- 月饼 (满月食物)
	{ name = "dish_l_flowerbun",				price = 70 },														  -- 花儿粑 (满月食物)
	{ name = "dish_mushedkoi",					price = 100 },														  -- 菌鱼双鲜堡
	{ name = "dish_mushedmilk",					price = 50 },														  -- 香蕈双峰
	{ name = "albicans_cap",                     price = 45 },                                                        -- 采摘的素白菇
	{ name = "shyerry",                          price = 50 },                                                        -- 颤栗果
	{ name = "mint_l",                           price = 15 },                                                        -- 猫薄荷
	{ name = "pineananas",                       price = 20 },                                                        -- 松萝
	{ name = "squamousfruit",                    price = 35 },                                                        -- 鳞果
	{ name = "monstrain_leaf",                   price = 25 },                                                        -- 雨竹叶
	{ name = "petals_orchid",                    price = 17 },                                                        -- 兰草花瓣
	{ name = "petals_lily",                      price = 16 },                                                        -- 蹄莲花瓣
	{ name = "petals_rose",                      price = 18 },                                                        -- 蔷薇花瓣
}

itemlist.selist_cloth_lj =
{


	{ name = "hat_cowboy",         price = nil }, -- 牛仔帽
	{ name = "hat_mermbreathing",  price = nil }, -- 鱼之息
	{ name = "theemperorspendant", price = nil }, -- 皇帝的吊坠
	{ name = "theemperorsscepter", price = nil }, -- 皇帝的权杖
	{ name = "theemperorsmantle",  price = nil }, -- 皇帝的披风
	{ name = "theemperorscrown",   price = nil }, -- 皇帝的王冠
	{ name = "sachet",             price = nil }, -- 香包
	{ name = "hat_lichen",         price = nil }, -- 苔衣发卡
	{ name = "giantsfoot",         price = nil }, -- 巨人之脚


}

itemlist.selist_smithing_lj =
{

	{ name = "dish_tomahawksteak",    price = 350 }, -- 牛排战斧
	{ name = "guitar_whitewood",      price = nil }, -- 白木吉他
	{ name = "triplegoldenshovelaxe", price = nil }, -- 斧铲-黄金三用型
	{ name = "tripleshovelaxe",       price = nil }, -- 斧铲-三用型
	{ name = "dualwrench",            price = nil }, -- 扳手-双用型
	{ name = "fishhomingtool_normal", price = nil }, -- 简易打窝饵制作器
	{ name = "lance_carrot_l",        price = 1000 }, -- 胡萝卜长枪
	{ name = "shield_l_log",          price = nil }, -- 木盾
	{ name = "explodingfruitcake",    price = nil }, -- 爆炸水果蛋糕
	{ name = "pinkstaff",             price = nil }, -- 幻象法杖
	--{ name = "saddle_baggage",        price = nil }, -- 驮运鞍具，棱镜要删掉了
	{ name = "mat_whitewood_item",    price = nil }, -- 白木地片
	{ name = "carpet_plush_big",      price = 48 }, -- 线绒地毯
	{ name = "carpet_plush",    	  price = 96 }, -- 线绒地垫
}


--资源
itemlist.selist_resource_lj =
{
	{ name = "insectshell_l",     price = 26 }, -- 虫甲碎片
	{ name = "ahandfulofwings",   price = 25 }, -- 虫翅碎片
	{ name = "merm_scales",       price = 28 }, -- 鱼鳞
	{ name = "raindonate",        price = 55 }, -- 雨蝇
	{ name = "shyerrylog",        price = 40 }, -- 宽大的木墩
	{ name = "pineananas_seeds",  price = 50 }, -- 嵌合种子
	{ name = "dug_monstrain",     price = 100 }, -- 雨竹块茎
	{ name = "cattenball",        price = 200 }, -- 猫线球
	{ name = "cutted_orchidbush", price = 500 }, -- 兰草种籽
	{ name = "cutted_lilybush",   price = 500 }, -- 蹄莲芽束
	{ name = "cutted_rosebush",   price = 500 }, -- 蔷薇折枝
	{ name = "dug_orchidbush",    price = 100 }, -- 兰草花丛
	{ name = "dug_lilybush",      price = 100 }, -- 蹄莲花丛
	{ name = "dug_rosebush",      price = 100 }, -- 蔷薇花丛
}


itemlist.selist_precious_lj =
{
	--珍贵
	{ name = "siving_derivant_item",   price = 4000 }, -- 子圭奇型岩(物品)
	{ name = "siving_rocks",           price = 200 }, -- 子圭石
	{ name = "siving_feather_fake",    price = 1500 }, -- 子圭玄鸟绒羽
	{ name = "siving_ctlwater_item",   price = 5616 }, -- 子圭·利川
	{ name = "siving_ctldirt_item",    price = 5616 }, -- 子圭·益炬
	{ name = "siving_ctlall_item",     price = 14000 }, -- 子圭·利川
	{ name = "siving_soil_item",       price = 1875 }, -- 子圭·垄
	{ name = "siving_feather_real",    price = 14640 }, -- 子圭·翰
	{ name = "siving_mask_gold",       price = 6004 }, -- 子圭·歃
	{ name = "siving_mask",            price = 3200 }, -- 子圭·汲
	{ name = "siving_mask",            price = 4800 }, -- 子圭·庇
	{ name = "tourmalineshard",        price = 400 }, -- 带电的晶石
	{ name = "tourmalinecore",         price = 7200 }, -- 电气石
	{ name = "hat_elepheetle",         price = 2223 }, -- 犀金胄甲
	{ name = "armor_elepheetle",       price = 3276 }, -- 犀金护甲
	{ name = "boltwingout",            price = 1080 }, -- 脱壳之翅
	{ name = "fimbul_axe",             price = 3000 }, -- 芬布尔斧
	{ name = "foliageath",             price = 3000 }, -- 青枝绿叶
	{ name = "orchitwigs",             price = 2000 }, -- 兰草花穗
	{ name = "lileaves",               price = 2000 }, -- 蹄莲翠叶
	{ name = "rosorns",                price = 2000 }, -- 带刺蔷薇
	{ name = "neverfade",              price = 6240 }, -- 永不凋零
	{ name = "backcub",                price = 4000 }, -- 靠背熊
	{ name = "hiddenmoonlight_item",   price = 636 }, -- 月藏宝匣
	{ name = "revolvedmoonlight_item", price = 3146 }, -- 月轮宝盘
	{ name = "fishhomingtool_awesome", price = 500 }, -- 专业打窝饵制作器
	{ name = "icire_rock",             price = 888 }, -- 鸳鸯石
	{ name = "hat_albicans_mushroom",  price = 1440 }, -- 素白蘑菇帽
	{ name = "shield_l_sand",          price = 2028 }, -- 砂之抵御
	{ name = "guitar_miguel",          price = 3258 }, -- 米格尔的吉他
	{ name = "acc_l_shadowmirror",     price = 2000 }, -- --捉影之镜(棱镜7.4.9更新物品)
	{ name = "soul_contracts",    	   price = 3000 }, -- 灵魂契约 
	{ name = "shyerrycore_item",	   price = 3000 }, -- 颤栗树心芽
}
itemlist.selist_precious_ljlj =
{
	{ name = "refractedmoonlight", price = 20000 }, -- 月折宝剑
	{ name = "agronssword",        price = 20000 }, -- 艾力冈的剑
}


itemlist.selist_blueprint_lj =
{
	{ name = "hiddenmoonlight_item_blueprint",   price = 2000 }, --月藏宝匣
	{ name = "revolvedmoonlight_item_blueprint", price = 2000 }, --月轮宝盘
	{ name = "siving_feather_real_blueprint",    price = 2000 }, --子圭·翰	
}


itemlist.selist_food_ndnr = {
	{ name = "ndnr_chinesefood",          price = 113 },                                       -- 家常菜
	{ name = "ndnr_mushroom_wine",        price = 96 },                                        -- 蘑菇酒
	{ name = "ndnr_snakewine",            price = 200 },                                       -- 蛇酒
	{ name = "ndnr_dragoonheartlavaeegg", price = 1245 },                                      -- 龙心灌蛋
	{ name = "ndnr_figpudding",           price = 109 },                                       -- 无花果布丁
	{ name = "ndnr_scallopsoup",          price = 135 },                                       -- 瑶柱汤
	{ name = "ndnr_dongpopork",           price = 103 },                                       -- 东坡肉
	{ name = "ndnr_tomato_egg",           price = 113 },                                       -- 番茄炒蛋
	{ name = "ndnr_pineapplebun",         price = 191 },                                       -- 菠萝包
	{ name = "ndnr_haagendazs",           price = 375 },                                       -- 哈根达斯
	{ name = "ndnr_stewedmushroom",       price = 88 },                                        -- 红伞伞炒饭
	{ name = "ndnr_steamedporkdumplings", price = 105 },                                       -- 烧麦
	{ name = "ndnr_coconutchicken",       price = 84 },                                        -- 椰子鸡
	{ name = "ndnr_balut",                price = 179 },                                       -- 毛蛋
	{ name = "ndnr_shrimppullegg",        price = 151 },                                       -- 虾扯蛋
	{ name = "ndnr_wonton",               price = 103 },                                       -- 馄饨
	{ name = "ndnr_kopiluwak",            price = 125 },                                       -- 猫屎咖啡
	{ name = "ndnr_puff",                 price = 113 },                                       -- 泡芙
	{ name = "ndnr_yogurt",               price = 105 },                                       -- 酸奶
	{ name = "ndnr_seatreasure",          price = 212 },                                       -- 大海捞珍
	{ name = "ndnr_icecream",             price = 93 },                                        -- 甜筒
	{ name = "ndnr_coffee",               price = 110 },                                       -- 咖啡
	{ name = "dish_medicinalliquor",      price = 118, atl = "images/dish_medicinalliquor.xml" }, -- 药酒
	{ name = "ndnr_coconutjuice",         price = 65 },                                        -- 椰子汁
	{ name = "ndnr_creamballsoup",        price = 105 },                                       -- 奶油丸子汤
	{ name = "ndnr_caviar",               price = 105 },                                       -- 鱼子酱
	{ name = "ndnr_albumenpowder",        price = 97 },                                        -- 蛋白粉
	{ name = "ndnr_tofu",                 price = 78 },                                        -- 豆腐
	{ name = "ndnr_soybeanmilk1",         price = 90 },                                        -- 豆浆
	{ name = "ndnr_soybeanmilk2",         price = 110 },                                       -- 豆奶
	{ name = "ndnr_milk",                 price = 30 },                                        --牛奶
	{ name = "ndnr_ice_milk",             price = 50 },                                        --鹿奶
	{ name = "ndnr_dragoonheart",         price = 600 },                                       --龙心
	{ name = "ndnr_sharkfin",             price = 50 },                                        --鲨鱼鳍
	{ name = "ndnr_scallop",              price = 35 },                                        --瑶柱
	{ name = "ndnr_coffeebeans",          price = 20 },                                        --咖啡豆
	{ name = "ndnr_coffeebeans_cooked",   price = 22 },                                        --烘焙咖啡豆
	{ name = "ndnr_coconut",              price = 20 },                                        --椰子
	{ name = "ndnr_coconut_halved",       price = 12 },                                        --分成两半的椰子
	{ name = "ndnr_roe",                  price = 50 },                                        --鱼卵
	{ name = "ndnr_iceball",              price = 30 },                                        --水球
	{ name = "ndnr_stinkytofu",           price = 108 },                                       --臭豆腐
	{ name = "ndnr_soybean",              price = 20 },                                        --大豆
}

itemlist.selist_cloth_ndnr = {
	{ name = "ndnr_armor_snakeskin",     price = nil }, -- 蛇皮夹克
	{ name = "ndnr_snakeskinhat",        price = nil }, -- 蛇皮帽
	{ name = "turf_ndnr_snakeskinfloor", price = nil }, -- 蛇皮地毯
	{ name = "ndnr_palmleaf_umbrella",   price = nil }, -- 热带阳伞
	{ name = "ndnr_thatchpack",          price = nil }, -- 茅草袋
	{ name = "ndnr_aerodynamichat",      price = nil }, -- 流线型帽子
	{ name = "ndnr_pagodasugar",         price = nil }, -- 宝塔糖
	{ name = "ndnr_antivenom",           price = nil }, -- 解毒剂
}
itemlist.selist_smithing_ndnr = {
	{ name = "ndnr_obsidianaxe",    price = nil }, -- 黑曜石斧
	{ name = "ndnr_spear_obsidian", price = nil }, -- 黑曜石长矛
	{ name = "ndnr_armorobsidian",  price = nil }, -- 黑曜石甲
	{ name = "ndnr_alloyaxe",       price = nil }, -- 合金斧
	{ name = "ndnr_alloypickaxe",   price = nil }, -- 合金鹤嘴锄
	{ name = "ndnr_alloyshovel",    price = nil }, -- 合金铲子
	{ name = "ndnr_alloyhammer",    price = nil }, -- 合金锤
	{ name = "ndnr_alloyhoe",       price = nil }, -- 合金园艺锄
	{ name = "ndnr_alloyspear",     price = nil }, -- 合金长矛
	{ name = "ndnr_cutlass",        price = nil }, -- 剑鱼短剑
	{ name = "turf_ndnr_asphalt",   price = nil }, -- 柏油路
}

itemlist.selist_resource_ndnr = {
	{ name = "ndnr_snake",           price = 150 },                                                                   --蛇
	{ name = "ndnr_catpoop",         price = 30 },                                                                    --猫屎
	{ name = "ndnr_soybean_seeds",   price = 50 },                                                                    --大豆种子
	{ name = "ndnr_magma_milk",      price = 300, tex = "ndnr_magma_milk_0.tex", atl = "images/ndnr_magma_milk_0.xml" }, -- 岩浆
	{ name = "ndnr_weatherpole",     price = 500 },                                                                   -- 天候棒
	{ name = "ndnr_venomgland",      price = 40 },                                                                    -- 毒腺
	{ name = "ndnr_snakeoil",        price = 100 },                                                                   -- 蛇油
	{ name = "ndnr_snakeskin",       price = 25 },                                                                    -- 蛇皮
	{ name = "ndnr_dead_swordfish",  price = 300 },                                                                   --死剑鱼
	{ name = "ndnr_obsidian",        price = 100 },                                                                   -- 黑曜石
	{ name = "ndnr_alloy",           price = 192 },                                                                   -- 合金
	{ name = "ndnr_blue_sporeseed",  price = 100, tex = "spore_tall.tex" },                                           -- 蓝孢子种子
	{ name = "ndnr_green_sporeseed", price = 100, tex = "spore_small.tex" },                                          -- 绿孢子种子
	{ name = "ndnr_red_sporeseed",   price = 100, tex = "spore_medium.tex" },                                         -- 红孢子种子
	{ name = "ndnr_bigtooth",        price = 900 },                                                                   -- 狗王牙
	{ name = "dug_ndnr_coffeebush",  price = 100 },                                                                   -- 咖啡树
	{ name = "ndnr_godtoken",        price = 500 },                                                                   -- 天界令牌
	{ name = "ndnr_tentacleblood",   price = 150 },                                                                   -- 触手血
	{ name = "ndnr_palmleaf",        price = 20 },                                                                    -- 椰树叶
	{ name = "ndnr_iron",            price = 40 },                                                                    -- 铁矿石
	{ name = "ndnr_tar",             price = 46 },                                                                    -- 焦油
	{ name = "ndnr_roughrock",       price = 268 },                                                                   -- 原石	
}

itemlist.selist_precious_ndnr = {
	{ name = "ndnr_shark_teethhat",     price = nil }, -- 鲨齿王冠
	{ name = "ndnr_corruptionstaff",    price = nil }, -- 腐化魔杖
	{ name = "ndnr_waterballoon",       price = nil }, -- 生命水球
	{ name = "ndnr_opalpreciousamulet", price = 10000 }, -- 彩虹护符
	{ name = "ndnr_quackendrill_item",  price = nil }, -- 油井钻子
	{ name = "ndnr_quackenbeak",        price = 2000 }, -- 蟹钳
	{ name = "ndnr_energy_core",        price = 30000 }, -- 能量核
	{ name = "ndnr_hambat",             price = 4030 }, -- 贪婪火腿棒
	{ name = "ndnr_armorvortexcloak",   price = 30000 }, -- 旋涡斗篷
	{ name = "ndnr_waterdrop",          price = 1000 }, --魔力泉水
}
itemlist.selist_blueprint_ndnr =
{
	{ name = "ndnr_smelter_blueprint",            price = 2000 }, -- 炼钢炉
	{ name = "ancient_altar_blueprint",           price = 2000 }, -- 远古伪科学基地
	{ name = "ndnr_opalpreciousamulet_blueprint", price = 2000 }, -- 彩虹护符
	{ name = "beebox_hermit_blueprint",           price = 2000 }, -- 蟹奶奶蜂箱
	{ name = "meatrack_hermit_blueprint",         price = 2000 }, -- 蟹奶奶晾肉架
	{ name = "ndnr_fishfarm_blueprint",           price = 2000 }, -- 养鱼场
	{ name = "tallbirdnest_blueprint",            price = 2000 }, -- 高脚鸟巢
	{ name = "catcoonden_blueprint",              price = 2000 }, -- 空心树桩
	{ name = "pigtorch_blueprint",                price = 2000 }, -- 猪人火炬
	{ name = "houndmound_blueprint",              price = 2000 }, -- 猎犬丘
	{ name = "monkeybarrel_blueprint",            price = 2000 }, -- 暴躁猴窝
	{ name = "wobster_den_blueprint",             price = 2000 }, -- 龙虾窝
	{ name = "moonglass_wobster_den_blueprint",   price = 2000 }, -- 月光龙虾窝
	{ name = "slurtlehole_blueprint",             price = 2000 }, -- 尖壳蜗牛窝
	{ name = "archive_cookpot_blueprint",         price = 2000 }, -- 远古窑
	{ name = "ndnr_corruptionstaff_blueprint",    price = 2000 }, -- 腐化魔杖
}

--海难
itemlist.selist_food_Island = {
	{ name = "tropicalbouillabaisse",   price = 300 }, --热带鱼汤
	{ name = "sweetpotatosouffle",      price = 150 }, --甘薯蛋奶酥
	{ name = "musselbouillabaise",      price = 188 }, --贻贝浓汤
	{ name = "coffee",                  price = 150 }, --咖啡
	{ name = "coffee_spice_chili",      price = 200 }, --辣咖啡
	{ name = "coffee_spice_sugar",      price = 200 }, --甜咖啡
	{ name = "coffee_spice_garlic",     price = 200 }, --蒜香咖啡
	{ name = "wobsterbisque",           price = 127 }, --龙虾汤
	{ name = "bisque",                  price = 120 }, --鲜贝浓汤
	{ name = "wobsterdinner",           price = 217 }, --龙虾大餐
	{ name = "caviar",                  price = 98 }, --鱼子酱
	{ name = "jellyopop",               price = 48 }, --水母冻
	{ name = "sharkfinsoup",            price = 111 }, --鱼翅汤
	{ name = "coconut_halved",          price = 10 }, --对半分的椰子
	{ name = "coconut_cooked",          price = 15 }, --烤椰子
	{ name = "sweet_potato",            price = 12 }, --甜薯
	{ name = "sweet_potato_cooked",     price = 15 }, --烤甜薯
	{ name = "coffeebeans",             price = 30 }, --咖啡豆
	{ name = "coffeebeans_cooked",      price = 35 }, --烘培咖啡豆
	{ name = "seaweed",                 price = 10 }, --海带
	{ name = "seaweed_cooked",          price = 12 }, --烤海带
	{ name = "seaweed_dried",           price = 15 }, --干海带
	{ name = "roe",                     price = 50 }, --鱼卵
	{ name = "roe_cooked",              price = 20 }, --煮熟的鱼卵
	{ name = "shark_fin",               price = 70 }, --鱼翅
	{ name = "mussel",                  price = 23 }, --贻贝
	{ name = "mussel_cooked",           price = 28 }, --烤贻贝
	{ name = "limpets",                 price = 25 }, --帽贝
	{ name = "limpets_cooked",          price = 30 }, --烤帽贝
	{ name = "jellyfish_dead",          price = 20 }, --死水母
	{ name = "jellyfish_cooked",        price = 25 }, --烤水母
	{ name = "jellyjerky",              price = 30 }, --水母干
	{ name = "rainbowjellyfish_dead",   price = 65 }, --死彩虹水母
	{ name = "rainbowjellyfish_cooked", price = 25 }, --煮熟的彩虹水母
	{ name = "neon_quattro",            price = 80 }, --死霓虹鱼
	{ name = "neon_quattro_cooked",     price = 85 }, --烤霓虹鱼
	{ name = "purple_grouper",          price = 80 }, --死石斑鱼
	{ name = "purple_grouper_cooked",   price = 85 }, --烤石斑鱼
	{ name = "pierrot_fish",            price = 80 }, --死小丑鱼
	{ name = "pierrot_fish_cooked",     price = 85 }, --烤小丑鱼
	{ name = "fish_tropical",           price = 40 }, --死热带鱼
	{ name = "swordfish_dead",          price = 90 }, --死剑鱼
	{ name = "solofish_dead",           price = 35 }, --死狗鱼
	{ name = "lobster",                 price = 80 }, --龙虾
	{ name = "lobster_dead",            price = 44 }, --死龙虾
	{ name = "lobster_dead_cooked",     price = 45 }, --美味的龙虾
	{ name = "doydoyegg_cooked",        price = 50 }, --煎渡渡鸟蛋
}
itemlist.selist_cloth_Island = {
	{ name = "palmleaf_umbrella", price = nil }, --热带阳伞
	{ name = "snakeskinhat",      price = nil }, --蛇皮帽
	{ name = "gashat",            price = nil }, --空气过滤器
	{ name = "aerodynamichat",    price = nil }, --流线型帽子
	{ name = "shark_teethhat",    price = nil }, --齿鲨王冠
	{ name = "captainhat",        price = nil }, --船长帽
	{ name = "piratehat",         price = nil }, --海盗帽
	{ name = "armor_snakeskin",   price = nil }, --蛇皮衣
	{ name = "blubbersuit",       price = nil }, --鲸脂大衣
	{ name = "tarsuit",           price = nil }, --焦油套装
	{ name = "armor_windbreaker", price = nil }, --防风衣
	{ name = "armor_lifejacket",  price = nil }, --救生衣
	{ name = "antivenom",         price = nil }, --抗毒血清
	{ name = "poisonbalm",        price = nil }, --毒药膏
	{ name = "thatchpack",        price = nil }, --椰叶包
}
itemlist.selist_smithing_Island = {
	{ name = "spear_poison",                price = nil }, --毒矛
	{ name = "spear_launcher",              price = nil }, --矛枪
	{ name = "blowdart_poison",             price = nil }, --毒镖
	{ name = "cutlass",                     price = nil }, --剑鱼剑
	{ name = "coconade",                    price = nil }, --椰弹
	{ name = "armorlimestone",              price = nil }, --石灰石套装
	{ name = "armorcactus",                 price = nil }, --仙人掌护甲
	{ name = "armorseashell",               price = nil }, --海贝套装
	{ name = "oxhat",                       price = nil }, --牛角盔
	{ name = "machete",                     price = nil }, --砍刀
	{ name = "goldenmachete",               price = nil }, --黄金砍刀
	{ name = "monkeyball",                  price = nil }, --逗猴球
	{ name = "bottlelantern",               price = nil }, --水瓶提灯
	{ name = "ox_flute",                    price = nil }, --降雨排箫
	{ name = "boatrepairkit",               price = nil }, --修船工具
	{ name = "tarlamp",                     price = nil }, --焦油灯
	{ name = "surfboard_item",              price = 150 }, --冲浪板
	{ name = "boat_torch",                  price = nil }, --航海火炬
	{ name = "boat_lantern",                price = nil }, --船灯
	{ name = "sail_palmleaf",               price = nil }, --草帆
	{ name = "sail_cloth",                  price = nil }, --布帆
	{ name = "sail_snakeskin",              price = nil }, --蛇皮帆
	{ name = "boatcannon",                  price = nil }, --船炮
	{ name = "seatrap",                     price = nil }, --海上陷阱
	{ name = "trawlnet",                    price = nil }, --拖网
	{ name = "telescope",                   price = nil }, --望远镜
	{ name = "turf_jungle",                 price = nil }, --丛林地皮
	{ name = "turf_meadow",                 price = nil }, --草地地皮
	{ name = "turf_tidalmarsh",             price = nil }, --潮泽地皮
	{ name = "turf_magmafield",             price = nil }, --岩浆地皮
	{ name = "turf_ash",                    price = nil }, --灰烬地皮
	{ name = "turf_volcano",                price = nil }, --火山地皮
	{ name = "turf_snakeskin",              price = nil }, --蛇皮地毯
	{ name = "wall_limestone_item",         price = nil }, --石灰岩墙
	{ name = "wall_enforcedlimestone_item", price = nil }, --海上墙
	{ name = "sandbagsmall_item",           price = nil }, --沙袋
}
itemlist.selist_resource_Island = {
	{ name = "bamboo",                  price = 10 },                           --竹子
	{ name = "fabric",                  price = 35 },                           --布
	{ name = "vine",                    price = 12 },                           --藤
	{ name = "palmleaf",                price = 15 },                           --椰树叶
	{ name = "seashell",                price = 20 },                           --贝壳
	{ name = "sand",                    price = 10 },                           --沙
	{ name = "ia_messagebottleempty",   price = 35 },                           --空瓶子
	{ name = "coral",                   price = 15 },                           --珊瑚
	{ name = "limestonenugget",         price = 50 },                           --石灰岩
	{ name = "corallarve",              price = 50 },                           --珊瑚幼虫
	{ name = "tar",                     price = 75 },                           --焦油
	{ name = "dubloon",                 price = 4 },                            --金币
	{ name = "peg_leg",                 price = 50 },                           --木腿
	{ name = "needlespear",             price = 10 },                           --仙人掌刺
	{ name = "seaweed_stalk",           price = 70 },                           --海带根
	{ name = "dug_bambootree",          price = 40 },                           --竹根
	{ name = "dug_bush_vine",           price = 50 },                           --藤蔓根
	{ name = "dug_elephantcactus",      price = 99 },                           --巨型仙人掌
	{ name = "dug_coffeebush",          price = 240 },                          --咖啡丛
	{ name = "hail_ice",                price = 2 },                            --冰雹
	{ name = "sweet_potato_seeds",      price = 25 },                           --甜薯种子
	{ name = "nubbin",                  price = nil },                          --珊瑚礁块
	{ name = "mussel_bed",              price = nil },                          --贻贝岩
	{ name = "jungletreeseed",          price = 10 },                           --丛林树种子
	{ name = "coconut",                 price = 20 },                           --椰子
	{ name = "bioluminescence",         price = 99 },                           --海上萤火虫
	{ name = "venomgland",              price = 40 },                           --毒腺
	{ name = "blowdart_flup",           price = 20 },                           --眼睛吹箭
	{ name = "snakeskin",               price = 20 },                           --蛇皮
	{ name = "dorsalfin",               price = 50 },                           --背鳍
	{ name = "ox_horn",                 price = 200 },                          --水牛角
	{ name = "mosquitosack_yellow",     price = 40 },                           --毒蚊血囊
	{ name = "spoiled_fish_large",      price = 10 },                           --大的坏掉的鱼
	{ name = "blubber",                 price = 40 },                           --鲸脂
	{ name = "crab",                    price = 30 },                           --兔蟹
	{ name = "tropical_spider_warrior", price = 200 },                          --毒蜘蛛
	{ name = "mosquito_poison",         price = 98, tex = "mosquito_yellow.tex" }, --毒蚊子
	{ name = "cormorant",               price = 30 },                           --鸬鹚
	{ name = "seagull",                 price = 30 },                           --海鸥
	{ name = "toucan",                  price = 30 },                           --大嘴鸟
	{ name = "parrot",                  price = 50 },                           --鹦鹉
	{ name = "parrot_pirate",           price = 99 },                           --海盗鹦鹉
	{ name = "jellyfish",               price = 25 },                           --水母
	{ name = "rainbowjellyfish",        price = 80 },                           --彩虹水母
	{ name = "pondfish_tropical",       price = 45 },                           --热带鱼
	{ name = "pondneon_quattro",        price = 90 },                           --霓虹鱼
	{ name = "pondpurple_grouper",      price = 90 },                           --石斑鱼
	{ name = "pondpierrot_fish",        price = 90 },                           --小丑鱼
}
itemlist.selist_precious_Island = {
	{ name = "woodlegshat",                 price = 1200 }, --幸运帽
	{ name = "doydoy",                      price = 1500 }, --渡渡鸟
	{ name = "doydoybaby",                  price = 1200 }, --渡渡鸟宝宝
	{ name = "doydoyegg",                   price = 600 }, --渡渡鸟蛋
	{ name = "winter_ornament_boss_doydoy", price = 500 }, --渡渡鸟蛋装饰
	{ name = "doydoyfeather",               price = 200 }, --渡渡鸟羽毛
	{ name = "tropicalfan",                 price = nil }, --热带羽毛扇
	{ name = "sail_feather",                price = nil }, --羽毛帆
	{ name = "magic_seal",                  price = 1500 }, --魔法印章
	{ name = "turbine_blades",              price = 1500 }, --涡轮叶片
	{ name = "ironwind",                    price = nil }, --螺旋桨
	{ name = "quackenbeak",                 price = 2000 }, --海妖的喙
	{ name = "quackendrill",                price = nil }, --海妖钻子
	{ name = "quackeringram",               price = nil }, --海妖撞锤
	{ name = "tigereye",                    price = 1000 }, --虎鲨之眼
	{ name = "supertelescope",              price = nil }, --超级望远镜
	{ name = "shark_gills",                 price = 1000 }, --鲨鱼腮
	{ name = "double_umbrellahat",          price = nil }, --双层伞帽
	{ name = "seasack",                     price = nil }, --海上保鲜包	
	{ name = "coral_brain",                 price = 4000 }, --智慧果
	{ name = "brainjellyhat",               price = 6000 }, --智慧帽
	{ name = "obsidian",                    price = 150 }, --黑曜石
	{ name = "dragoonheart",                price = 300 }, --龙心
	{ name = "windstaff",                   price = nil }, --魔法海螺
	{ name = "wind_conch",                  price = nil }, --帆杆
	{ name = "obsidianaxe",                 price = nil }, --黑曜石斧子
	{ name = "obsidianmachete",             price = nil }, --黑曜石砍刀
	{ name = "spear_obsidian",              price = nil }, --黑曜石长矛
	{ name = "volcanostaff",                price = nil }, --火山法杖
	{ name = "armorobsidian",               price = nil }, --黑曜石护甲
	{ name = "obsidiancoconade",            price = nil }, --黑曜石炸弹
	{ name = "ia_trident",                  price = 1000 }, --三叉戟
	{ name = "harpoon",                     price = 500 }, --鱼叉
	{ name = "snakeoil",                    price = 666 }, --蛇油
	{ name = "piratepack",                  price = 1500 }, --藏宝袋
	{ name = "earring",                     price = 2000 }, --至尊耳环
	{ name = "ia_messagebottle",            price = 1000 }, --漂流瓶
	{ name = "mysterymeat",                 price = 2000 }, --胆汁盖肉
	{ name = "trinket_ia_13",               price = 500 }, --橘子汽水
	{ name = "trinket_ia_14",               price = 500 }, --巫毒娃娃
	{ name = "trinket_ia_15",               price = 500 }, --尤克里里
	{ name = "trinket_ia_16",               price = 500 }, --车票
	{ name = "trinket_ia_17",               price = 500 }, --鞋子
	{ name = "trinket_ia_18",               price = 500 }, --花瓶
	{ name = "trinket_ia_19",               price = 500 }, --云母丸
	{ name = "trinket_ia_20",               price = 500 }, --六分仪
	{ name = "trinket_ia_21",               price = 500 }, --玩具船
	{ name = "trinket_ia_22",               price = 500 }, --蜡烛瓶
	{ name = "trinket_ia_23",               price = 500 }, --亚克力板
}
return itemlist
