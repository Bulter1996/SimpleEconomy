local Ch = locale == "zh" or locale == "zhr"

name =
Ch and
[[ 简单经济学改(自用)]] or
[[  Simple Economy (self-use)]]

description =
Ch and
[[
经济学mod（自用修改）
增加了商店售卖的物品随获取进度进行解锁（可设置）
增加了人物初始物资获取（设置里可关闭，包含草树枝等基本物资）
增加了传送实体网络的生成（设置里可关闭，包含传送实体蓝图）

以下是原mod地址：https://steamcommunity.com/sharedfiles/filedetails/?id=3016346770
服主可实时对商店列表增删查改，无需重启。例如:增加物品、修改价格
物品列表位于你的模组目录下"3479277919\scripts\SEscripts\itemlist.lua"
本模组自动适配永不妥协、能力勋章、棱镜、富贵险中求、海难，自动增加对应物品，未开启相应的模组则不会增加相应的物品。
在原模组简单经济学的基础上做了一些修改。
可以设置点金法杖一定时间内对同一物品再次分解的倍率，防止短时间内刷钱。
开局默认赠送点金法杖, vip卡和幸运项链可以通过点金法杖无损卖出, 用于玩家之间给予金币。
玩家可通过击杀生物、佩戴幸运项链、回收物品获取金币。
生物掉落金币有更多细节可以设置。
调整部分商品价格，增加更多的游戏物品。
可设置商店商品价格倍率(零元购至5倍价格)。
可设置不同季节商品价格是否涨跌。
更换人物时保存经济学数据。
经济学图标可跟随鼠标右击移动。
可以设置点金法杖回收物品的价格倍率。

原作者：柴柴 太空人 巴乐(改)
]] or
[[
The server owner can make real-time modifications to the store list without the need for a restart, such as adding items or changing prices.
The item list is located in your mod directory at "\3016346770\scripts\SEscripts\itemlist.lua."
This mod automatically adjusts to "Uncompromising, Functional Medals, Legion, No Danger No Rich, Island Adventures" 
adding corresponding items if the respective mod is enabled. 
It builds on the Simple Economy of the original mod with a few modifications.
You can set a gold staff multiplier to prevent rapid money farming by decomposing the same item within a certain time. 
At the start, players receive a gold staff, and luck amulet. 
The VIP card and luck amulet can be sold without loss using the gold staff for player-to-player transactions.
Players earn gold by killing creatures, wearing the luck amulet, and recycling items, 
with configurable details for creature gold drops. 
Prices for some goods are adjusted, and more game items are added.
You can set shop item prices with a multiplier (from zero cost to five times the price) 
and decide if seasonal item prices should rise or fall.
Economic data is saved when changing characters, 
and the economic icon can be moved by right-clicking the mouse. 
The gold staff's item recycling price multiplier is also customizable.
    
Original Author: Chai Chai
]]

author = "原作者：柴柴，太空人，巴乐(改)"
version = "1.0.8"
forumthread = ""
api_version = 10
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true
server_filter_tags = {"Simple Economy"}
icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
Ch and
{
    {
        name = "Language",
        label = "语言",
        options =   {
                        {description = "English", data = false},
                        {description = "简体中文", data = true},
                    },
        default = true,
    },
    {
        name = "shop_hotkey",
        label = "商店快捷键",
        hover = "设置打开商店界面的快捷键",
        options = {
            {description = "关闭", data = 1},
            {description = "R", data = 114},
            {description = "T", data = 116},
            {description = "Y", data = 121},
            {description = "U", data = 117},
            {description = "I", data = 105},
            {description = "O", data = 111},
            {description = "P", data = 112},
        },
        default = 114,
    },
    {
        name = "updatelist",
        label = "物品实时更新",
        options =   {
                        {description = "关", data = false, hover = "商品由服主实时增删查改"},
                        {description = "开", data = true, hover = "商品由服主实时增删查改"},
                    },
        default = false,
    },
    {
        name = "initialcoin",
        label = "人物初始金币",
        options =   {
                        {description = "0", data = 0},
                        {description = "50", data = 50},
                        {description = "100", data = 100},
                        {description = "200", data = 200},
                        {description = "400", data = 400},
                        {description = "600", data = 600},
                        {description = "800", data = 800},
                        {description = "1000", data = 1000},
                    },
        default = 500,
    },
    {
        name = "Disintegrate",
        label = "允许点金分解",
        options =   {
                        {description = "否", data = false, hover = "不允许使用点金杖分解任何掉落物; 点金杖仅可用来击杀低血量怪物以换取金币。"},
                        {description = "是", data = true, hover = "允许使用点金杖分解大部分掉落物; 金杖攻击低血量生物仅可25%几率击杀"},
                        {description = "有限", data = 1, hover = "只能分解商店里售卖的物品;金杖攻击低血量生物仅可25%几率击杀"},
                    },
        default = true,
    },

    {name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
    {name = "Title", label = "开局物资", options = {{description = "", data = ""}}, default = ""},
    {
        name = "givegoldstaff",
        label = "开局送点金法杖",
        options =   {
                        {description = "否", data = false, hover = "需要开启允许点金分解才送"},
                        {description = "是", data = true, hover = "需要开启允许点金分解才送"},
                    },
        default = true,
    },
    {
        name = "giveluckamulet",
        label = "开局送幸运项链",
        options =   {
                        {description = "否", data = false},
                        {description = "是", data = true},
                    },
        default = true,
    },
    {
        name = "givebase_resources",
        label = "开局送基础资源物资包",
        hover = "包含草*40 树枝*40 木头*40",
        options =   {
                        {description = "否", data = false},
                        {description = "是", data = true},
                    },
        default = true,
    },
    {
        name = "giverocks_resources",
        label = "开局送石头资源物资包",
        hover = "包含石头*40 燧石*20 硝石*20 金块*20",
        options =   {
                        {description = "否", data = false},
                        {description = "是", data = true},
                    },
        default = true,
    },
    {
        name = "givefight_resources",
        label = "开局送战斗物资包",
        hover = "包含火腿球棒*1 猪皮头盔*1 木甲*1 治疗药膏*3",
        options =   {
                        {description = "否", data = false},
                        {description = "是", data = true},
                    },
        default = true,
    },
    {
        name = "givemedal_resources",
        label = "开局送勋章物资包，需要打开能力勋章模组才生效",
        hover = "包含勋章盒 巧手勋章 伐木勋章 挖矿勋章 暗影魔法工具",
        options =   {
                        {description = "否", data = false},
                        {description = "是", data = true},
                    },
        default = true,
    },

    {name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
    {name = "Title", label = "更好的体验", options = {{description = "", data = ""}}, default = ""},
    {
        name = "unlock_hermit_pearl",
        label = "开局商店解锁珍珠",
        hover = "拒绝奶奶任务，直接购买珍珠",
        options =   {
                        {description = "否", data = false},
                        {description = "是", data = true},
                    },
        default = true,
    },
    {
        name = "unlock_moonrockseed",
        label = "开局商店解锁天体宝球",
        hover = "拒绝运气，可直接购买宝球",
        options =   {
                        {description = "否", data = false},
                        {description = "是", data = true},
                    },
        default = true,
    },
    {
        name = "unlock_chesspiece_sketch",
        label = "开局商店解锁三基佬和天体英雄草图",
        hover = "拒绝搬运，可直接建造三基佬和天体英雄雕像",
        options =   {
                        {description = "否", data = false},
                        {description = "是", data = true},
                    },
        default = true,
    },

    {name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
    {name = "Title", label = "传送网络铺建", options = {{description = "", data = ""}}, default = ""},
    {
        name = "generate_ft",
        label = "是否开局在各个重要地点生成传送点",
        hover = "如猪王、月岛、月亮码头等重要地点生成传送点",
        options =   {
                        {description = "否", data = false},
                        {description = "是", data = true},
                    },
        default = false,
    },
    {
        name = "ft_prefab_name",
        label = "生成的传送实体选择，默认生成木牌",
        options =   {
                    {description = "木牌", data = "homesign", hover = "需要开启木牌传送才生效"},
                    {description = "懒人传送塔", data = "townportal", hover = "需要永恒新界模组才生效"},
                    },
        default = "homesign",
    },

    {name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
    {name = "Title", label = "价格设置", options = {{description = "", data = ""}}, default = ""},
    {
        name = "fixtwoprice",
        label = "法杖和项链价格固定",
        options =   {
                        {description = "否", data = false, hover = "项链和法杖售卖价格不会固定"},
                        {description = "是", data = true, hover = "项链和法杖售卖价格会固定"},
                    },
        default = true,
    },
    {
        name = "recyclingprice1",
        label = "商店物品价格回收倍率",
        options =   {
                    {description = "原价", data = 1},
                    {description = "二分之一", data = 2},
                    {description = "三分之一", data = 3},
                    {description = "四分之一", data = 4},
                    {description = "五分之一", data = 5},
                    {description = "六分之一", data = 6},
                    {description = "七分之一", data = 7},
                    {description = "八分之一", data = 8},
                    {description = "九分之一", data = 9},
                    {description = "十分之一", data = 10},
                    },
        default = 4,
    },
    {
        name = "recyclingprice2",
        label = "商店珍贵物品价格回收倍率",
        options =   {
                    {description = "原价", data = 1},
                    {description = "二分之一", data = 2},
                    {description = "三分之一", data = 3},
                    {description = "四分之一", data = 4},
                    {description = "五分之一", data = 5},
                    {description = "六分之一", data = 6},
                    {description = "七分之一", data = 7},
                    {description = "八分之一", data = 8},
                    {description = "九分之一", data = 9},
                    {description = "十分之一", data = 10},
                    {description = "十五分之一", data = 15},
                    {description = "二十分之一", data = 20},
                    },
        default = 10,
    },
    {
        name = "recovery_time",
        label = "多少时间内同一物品再次分解将被调整倍率",
        hover = "可以开启此功能防止刷钱",
        options =   {
                        {description = "关闭", data = false},
                        {description = "30S", data = 30},
                        {description = "60S", data = 60},
                        {description = "120S", data = 120},
                        {description = "180S", data = 180},
                        {description = "240S", data = 240},
                        {description = "300S", data = 300},
                        {description = "480S", data = 480},
                    },
        default = false,
    },
    {
        name = "recovery_t",
        label = "时间内同一物品再次分解回收的倍率",
        hover = "堆叠后物品的算一个物品",
        options =   {
                        {description = "好好好，不给钱是吧。", data = 0},
                        {description = "10%", data = 0.1},
                        {description = "20%", data = 0.2},
                        {description = "30%", data = 0.3},
                        {description = "40%", data = 0.4},
                        {description = "50%", data = 0.5},
                        {description = "60%", data = 0.6},
                        {description = "70%", data = 0.7},
                        {description = "80%", data = 0.8},
                        {description = "90%", data = 0.90},
                        {description = "100%", data = 1.0},
                    },
        default = 0.5,
    },
    {
        name = "pricerate",
        label = "商店物品价格倍率",
        options =   {
                        {description = "零元购", data = 0},
                        {description = "0.5倍", data = 0.5},
                        {description = "1倍(原价)", data = 1},
                        {description = "1.5倍", data = 1.5},
                        {description = "2.0倍", data = 2.0},
                        {description = "2.5倍", data = 2.5},
                        {description = "3.0倍", data = 3.0},
                        {description = "3.5倍", data = 3.5},
                        {description = "4.0倍", data = 4.0},
                        {description = "4.5倍", data = 4.5},
                        {description = "5.0倍", data = 5.0},
                        {description = "10.0倍", data = 10.0},
                        {description = "20.0倍", data = 20.0},
                        {description = "50.0倍", data = 50.0},
                        {description = "100.0倍", data = 100.0},
                    },
        default = 1,
    },
    {
        name = "seasonalchange",
        label = "商店物品价格随季节变化",
        options =   {
                        {description = "开", data = true},
                        {description = "关", data = false},

                    },
        default = true,
    },
    {
        name = "exclusiveitem",
        label = "商店是否售卖唯一物品(例如珍珠)",
        options =   {
                        {description = "卖", data = true},
                        {description = "不", data = false},
                    },
        default = true,
    },
    {
        name = "allow_selist_special",
        label = "商店是否售卖本模组特殊物品",
        hover = "不卖的话只能打怪赚钱了",
        options =   {
                        {description = "卖", data = true},
                        {description = "不", data = false},
                    },
        default = true,
    },
    {
        name = "creaturesdeath",
        label = "生物死亡掉落金币",
        options =   {
                        {description = "关闭", data = false},
						{description = "最大生命值100%", data = 1.0},
						{description = "最大生命值50%", data = 0.50},
						{description = "最大生命值25%", data = 0.25},
                        {description = "最大生命值10%", data = 0.1},
						{description = "最大生命值8%", data = 0.08},
						{description = "最大生命值5%", data = 0.05},
						{description = "最大生命值3%", data = 0.03},
						{description = "最大生命值1%", data = 0.01},
						{description = "最大生命值0.5%", data = 0.005},
						{description = "最大生命值0.1%", data = 0.001},
                    },
        default = 0.25,
    },
    {
        name = "deathcd",
        label = "生物死亡多少时间内会调整金币倍率",
        hover = "可以开启此功能防止刷钱",
        options =   {
                        {description = "关闭", data = 0},
                        {description = "10S", data = 10},
                        {description = "30S", data = 30},
                        {description = "50S", data = 50},
                        {description = "60S", data = 60},
                        {description = "120S", data = 120},
                        {description = "180S", data = 180},
                        {description = "240S", data = 240},
                        {description = "300S", data = 300},
                        {description = "480S", data = 480},
                    },
        default = 10,
    },
    {
        name = "coinrate",
        label = "生物死亡时间内的金币倍率",
        options =   {
                        {description = "好好好，不给钱是吧。", data = 0},
                        {description = "10%", data = 0.1},
                        {description = "20%", data = 0.2},
                        {description = "30%", data = 0.3},
                        {description = "40%", data = 0.4},
                        {description = "50%", data = 0.5},
                        {description = "60%", data = 0.6},
                        {description = "70%", data = 0.7},
                        {description = "80%", data = 0.8},
                        {description = "90%", data = 0.90},
                        {description = "100%", data = 1.0},
                    },
        default = 0.5,
    },
    {
        name = "limitphmod",
        label = "只对特定血量(大于等于)的生物进行时间设定",
        options =   {
                        {description = "关闭", data = 0},
                        {description = "100", data = 100},
                        {description = "200", data = 200},
                        {description = "300", data = 300},
                        {description = "600", data = 600},
                        {description = "900", data = 900},
                        {description = "1000", data = 1000},
                        {description = "3000", data = 3000},
                        {description = "6000", data = 6000},
                        {description = "10000", data = 10000},
                    },
        default = 0,
    },

    {
        name = "limitcoin",
        label = "单次生物死亡获得金币上限",
        options =   {
                        {description = "关闭", data = 0},
                        {description = "100", data = 100},
                        {description = "200", data = 200},
                        {description = "300", data = 300},
                        {description = "600", data = 600},
                        {description = "900", data = 900},
                        {description = "1000", data = 1000},
                        {description = "3000", data = 3000},
                        {description = "6000", data = 6000},
                        {description = "10000", data = 10000},
                    },
        default = 0,
    },
    {
        name = "ghostshopping",
        label = "鬼魂能否购物",
        options =   {
                        {description = "能", data = true},
                        {description = "不能", data = false},
                    },
        default = false,
    },

    {name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
    {name = "Title", label = "模组物品相关", options = {{description = "", data = ""}}, default = ""},
    {
        name = "Functionalswitch",
        label = "加入勋章物品",
        hover = "手动开关,未开启模组则不管",
        options =   {
                        {description = "开", data = true},
                        {description = "关", data = false},
                    },
        default = true,
    },
    {
        name = "Functionalsell",
        label = "(能力勋章)售卖特殊勋章",
        hover = "手动开关,未开启模组则不管",
        options =   {
                        {description = "卖", data = true},
                        {description = "不", data = false},
                    },
        default = true,
    },
    {
        name = "umswitch",
        label = "加入永不妥协物品",
        hover = "手动开关,未开启模组则不管",
        options =   {
                        {description = "开", data = true},
                        {description = "关", data = false},
                    },
        default = true,
    },
    {
        name = "The_New_Constant_SWITCH",
        label = "加入永恒新界物品",
        hover = "手动开关,未开启模组则不管",
        options =   {
                        {description = "开", data = true},
                        {description = "关", data = false},
                    },
        default = true,
    },
    {
        name = "Legionswitch",
        label = "加入棱镜物品",
        hover = "手动开关,未开启模组则不管",
        options =   {
                        {description = "开", data = true},
                        {description = "关", data = false},
                    },
        default = true,
    },
    {
        name = "Legionsell",
        label = "售卖月折宝剑,艾力冈的剑",
        hover = "手动开关,未开启模组则不管",
        options =   {
                        {description = "卖", data = true},
                        {description = "不", data = false},
                    },
        default = true,
    },
    {
        name = "ndnrswitch",
        label = "加入富贵物品",
        hover = "手动开关,未开启模组则不管",
        options =   {
                        {description = "开", data = true},
                        {description = "关", data = false},
                    },
        default = true,
    },
    {
        name = "Island_switch",
        label = "加入海难物品",
        hover = "手动开关,未开启模组则不管",
        options =   {
                        {description = "开", data = true},
                        {description = "关", data = false},
                    },
        default = true,
    },

    {name = "Title", label = "", options = {{description = "", data = ""}}, default = ""},
    {name = "Title", label = "其他设置", options = {{description = "", data = ""}}, default = ""},
    {
        name = "precious_sell",
        label = "开启全部珍贵品",
        options =   {
                        {description = "否", data = false, hover = "商店每三天刷新部分珍贵品"},
                        {description = "是", data = true, hover = "商店售卖全部珍贵品"},
                    },
        default = true,
    },
    {
        name = "only_obtained",
        label = "仅售卖获取过的商品",
        options =   {
                        {description = "否", data = false, hover = "商店售卖所有商品"},
                        {description = "是", data = true, hover = "商店仅售卖获取过的商品"},
                    },
        default = true,
    },
    {
        name = "Dig",
        label = "挖掘机当铲子",
        options =   {
                        {description = "否", data = false},
                        {description = "是", data = true},
                    },
        default = true,
    },
    {
        name = "Hammer",
        label = "挖掘机当锤子",
        options =   {
                        {description = "否", data = false},
                        {description = "是", data = true},
                    },
        default = true,
    },
} or
{
    {
        name = "Language",
        label = "Language",
        options =   {
                        {description = "English", data = false},
                        {description = "Chinese", data = true},
                    },
        default = false,
    },
    {
        name = "updatelist",
        label = "Real-time Item Updates",
        options = {
            {description = "Off", data = false, hover = "Items are customized by the server owner"},
            {description = "On", data = true, hover = "Items are customized by the server owner"},
        },
        default = false,
    },
    {
        name = "initialcoin",
        label = "initial coin",
        options =   {
                        {description = "0", data = 0},
                        {description = "50", data = 50},
                        {description = "100", data = 100},
                        {description = "200", data = 200},
                        {description = "400", data = 400},
                        {description = "600", data = 600},
                        {description = "800", data = 800},
                        {description = "1000", data = 1000},
                    },
        default = 200,
    },
    {
        name = "Disintegrate",
        label = "Disintegrate",
        options =   {
                        {description = "No", data = false, hover = "Not allow to use Midas Wand to disintegrate something;the Golden Staff a 25% chance to kill low-health creatures when used in an attack."},
                        {description = "Yes", data = true, hover = "Allow to disintegrate most items;Golden Staff attacks low health creatures with a 25% chance to kill them"},
                        {description = "limited", data = 1, hover = "Can only decompose items sold in stores; Golden Staff attacks low health creatures with a 25% chance to kill them"},
                    },
        default = true,
    },
    {
        name = "givegoldstaff",
        label = "Start with a goldstaff",
        options =   {
                        {description = "on", data = false, hover = "You need to enable Disintegrate"},
                        {description = "yes", data = true, hover = "You need to enable Disintegrate"},
                    },
        default = true,
    },
    {
        name = "giveluckamulet",
        label = "Start with a luckamulet",
        options =   {
                        {description = "no", data = false},
                        {description = "yes", data = true},
                    },
        default = false,
    },
    {
        name = "fixtwoprice",
        label = "Fixed Prices for Staff and Amulet",
        options = {
            {description = "No", data = false, hover = "The selling prices for the amulet and staff will change"},
            {description = "Yes", data = true, hover = "The selling prices for the amulet and staff will not change"},
        },
        default = true,
    },
    {
        name = "recyclingprice1",
        label = "shop item price recycling multiplier",
        hover = "shop item price recycling multiplier",
        options =   {
                        {description = "Original Price", data = 1},
                        {description = "Two Tenths", data = 2},
                        {description = "Three Tenths", data = 3},
                        {description = "Four Tenths", data = 4},
                        {description = "Five Tenths", data = 5},
                        {description = "Six Tenths", data = 6},
                        {description = "Seven Tenths", data = 7},
                        {description = "Eight Tenths", data = 8},
                        {description = "Nine Tenths", data = 9},
                        {description = "Ten Tenths", data = 10},
                    },
        default = 4,
    },
    {
        name = "recyclingprice2",
        label = "precious item price recycling multiplier",
        hover = "precious item price recycling multiplier",
        options =   {
                        {description = "Original Price", data = 1},
                        {description = "Two Tenths", data = 2},
                        {description = "Three Tenths", data = 3},
                        {description = "Four Tenths", data = 4},
                        {description = "Five Tenths", data = 5},
                        {description = "Six Tenths", data = 6},
                        {description = "Seven Tenths", data = 7},
                        {description = "Eight Tenths", data = 8},
                        {description = "Nine Tenths", data = 9},
                        {description = "Ten Tenths", data = 10},
                        {description = "Fifteen Tenths", data = 15},
                        {description = "Twenty Tenths", data = 20},
                    },
        default = 10,
    },
    {
        name = "recovery_time",
        label = "The adjustment multiplier for recycling the same item over time.",
        hover = "The adjustment multiplier for recycling the same item over time.",
        options =   {
                        {description = "off", data = false, hover = "It is currently disabled, and this feature can be enabled to prevent money farming."},
                        {description = "30S", data = 30},
                        {description = "60S", data = 60},
                        {description = "120S", data = 120},
                        {description = "180S", data = 180},
                        {description = "240S", data = 240},
                        {description = "300S", data = 300},
                        {description = "480S", data = 480},
                    },
        default = 120,
    },
    {
        name = "recovery_t",
        label = "The multiplier for recycling the same item again.",
        hover = "Counting stacked items as one item.",
        options =   {
                        {description = "0", data = 0},
                        {description = "10%", data = 0.1},
                        {description = "20%", data = 0.2},
                        {description = "30%", data = 0.3},
                        {description = "40%", data = 0.4},
                        {description = "50%", data = 0.5},
                        {description = "60%", data = 0.6},
                        {description = "70%", data = 0.7},
                        {description = "80%", data = 0.8},
                        {description = "90%", data = 0.90},
                        {description = "100%", data = 1.0},
                    },
        default = 0.5,
    },
    {
        name = "precious_sell",
        label = "All precious items",
        options =   {
                        {description = "no", data = false, hover = "The shop refreshes some precious items every three days."},
                        {description = "yes", data = true, hover = "The shop sells all precious items."},
                    },
        default = false,
    },
    {
        name = "pricerate",
        label = "Shop Item Price Multiplier",
        options =   {
                        {description = "free", data = 0},
                        {description = "0.5 times", data = 0.5},
                        {description = "1 times", data = 1},
                        {description = "1.5 times", data = 1.5},
                        {description = "2.0 times", data = 2.0},
                        {description = "2.5 times", data = 2.5},
                        {description = "3.0 times", data = 3.0},
                        {description = "3.5 times", data = 3.5},
                        {description = "4.0 times", data = 4.0},
                        {description = "4.5 times", data = 4.5},
                        {description = "5.0 times", data = 5.0},
                        {description = "10.0 times", data = 10.0},
                        {description = "20.0 times", data = 20.0},
                        {description = "50.0 times", data = 50.0},
                        {description = "100.0 times", data = 100.0},
                    },
        default = 1,
    },
    {
        name = "seasonalchange",
        label = "Shop item prices vary with the seasons",
        options =   {
                        {description = "yes", data = true},
                        {description = "no", data = false},

                    },
        default = true,
    },
    {
        name = "exclusiveitem",
        label = "Is the unique item (e.g., pearls) for sale",
        hover = "Is the unique item (e.g., pearls) for sale",
        options =   {
                        {description = "yes", data = true},
                        {description = "no", data = false},
                    },
        default = true,
    },
    {
        name = "allow_selist_special",
        label = "Does the store sell mod-special items?",
        hover = "If not, fight monsters for earnings",
        options =   {
                        {description = "yes", data = true},
                        {description = "no", data = false},
                    },
        default = true,
    },
    {
        name = "creaturesdeath",
        label = "Creature drops coins upon death",
        options =   {
                        {description = "close", data = false},
						{description = "maximum health100%", data = 1.0},
						{description = "maximum health50%", data = 0.50},
						{description = "maximum health25%", data = 0.25},
                        {description = "maximum health10%", data = 0.1},
						{description = "maximum health8%", data = 0.08},
						{description = "maximum health5%", data = 0.05},
						{description = "maximum health3%", data = 0.03},
						{description = "maximum health1%", data = 0.01},
						{description = "maximum health0.5%", data = 0.005},
						{description = "maximum health0.1%", data = 0.001},
                    },
        default = 0.1,
    },
    {
        name = "deathcd",
        label = "Creature death coin multiplier adjustment timeframe.",
        hover = "Creature death coin multiplier adjustment timeframe.",
        options =   {
                        {description = "off", data = 0},
                        {description = "10S", data = 10},
                        {description = "30S", data = 30},
                        {description = "50S", data = 50},
                        {description = "60S", data = 60},
                        {description = "120S", data = 120},
                        {description = "180S", data = 180},
                        {description = "240S", data = 240},
                        {description = "300S", data = 300},
                        {description = "480S", data = 480},
                    },
        default = 120,
    },
    {
        name = "coinrate",
        label = "Coin multiplier during creature death",
        hover = "Coin multiplier during creature death",
        options =   {
                        {description = "0", data = 0},
                        {description = "10%", data = 0.1},
                        {description = "20%", data = 0.2},
                        {description = "30%", data = 0.3},
                        {description = "40%", data = 0.4},
                        {description = "50%", data = 0.5},
                        {description = "60%", data = 0.6},
                        {description = "70%", data = 0.7},
                        {description = "80%", data = 0.8},
                        {description = "90%", data = 0.90},
                        {description = "100%", data = 1.0},
                    },
        default = 0.1,
    },
    {
        name = "limitphmod",
        label = "For in-time settings only on creature health (≥).",
        hover = "For in-time settings only on creature health (≥).",
        options =   {
                        {description = "off", data = 0},
                        {description = "100", data = 100},
                        {description = "200", data = 200},
                        {description = "300", data = 300},
                        {description = "600", data = 600},
                        {description = "900", data = 900},
                        {description = "1000", data = 1000},
                        {description = "3000", data = 3000},
                        {description = "6000", data = 6000},
                        {description = "10000", data = 10000},
                    },
        default = 0,
    },

    {
        name = "limitcoin",
        label = "Max gold coins per creature death.",
        options =   {
                        {description = "off", data = 0},
                        {description = "100", data = 100},
                        {description = "200", data = 200},
                        {description = "300", data = 300},
                        {description = "600", data = 600},
                        {description = "900", data = 900},
                        {description = "1000", data = 1000},
                        {description = "3000", data = 3000},
                        {description = "6000", data = 6000},
                        {description = "10000", data = 10000},
                    },
        default = 0,
    },
    {
        name = "ghostshopping",
        label = "ghostshopping",
        options =   {
                        {description = "no", data = true},
                        {description = "yes", data = false},
                    },
        default = true,
    },
    {
        name = "Functionalswitch",
        label = "Add Medal Items",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options =   {
                        {description = "yes", data = true},
                        {description = "no", data = false},
                    },
        default = true,
    },
    {
        name = "Functionalsell",
        label = "Does the store sell functional medal",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options =   {
                        {description = "yes", data = true},
                        {description = "no", data = false},
                    },
        default = false,
    },
    {
        name = "Legionswitch",
        label = "Add Legion Items",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options =   {
                        {description = "yes", data = true},
                        {description = "no", data = false},
                    },
        default = true,
    },
    {
        name = "Legionsell",
        label = "sell Legion unique items",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options =   {
                        {description = "yes", data = true},
                        {description = "no", data = false},
                    },
        default = true,
    },
    {
        name = "ndnrswitch",
        label = "Add NoDangerNoRich Items",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options =   {
                        {description = "yes", data = true},
                        {description = "no", data = false},
                    },
        default = true,
    },
    {
        name = "Island_switch",
        label = "Add Island Adventures Items",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options =   {
                        {description = "yes", data = true},
                        {description = "no", data = false},
                    },
        default = true,
    },    
    {
        name = "umswitch",
        label = "Enable Uncompromising Items",
        hover = "Manual toggle, doesn't matter if the mod is not enabled",
        options =   {
                        {description = "yes", data = true},
                        {description = "no", data = false},
                    },
        default = true,
    },
    {
        name = "Dig",
        label = "Use the stealer as a shovel",
        options =   {
                        {description = "No", data = false},
                        {description = "Yes", data = true},
                    },
        default = false,
    },
    {
        name = "Hammer",
        label = "Use the stealer as a hammer",
        options =   {
                        {description = "No", data = false},
                        {description = "Yes", data = true},
                    },
        default = false,
    },
}