GLOBAL.setmetatable(env, { __index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })
TUNING.INITIALCOIN = GetModConfigData('initialcoin')                   --人物初始金币
TUNING.PRICERATE = GetModConfigData('pricerate')                       --商店物品价格倍率
TUNING.SEASONALCHANGE = GetModConfigData('seasonalchange')             --商店物品价格随季节变化
TUNING.GHOSTSHOPPING = GetModConfigData('ghostshopping')               --鬼魂能否购物
TUNING.EXCLUSIVEITEM = GetModConfigData('exclusiveitem')               --商店是否售卖唯一物品

TUNING.recyclingprice1 = GetModConfigData('recyclingprice1')           --普通物品回收倍率
TUNING.recyclingprice2 = GetModConfigData('recyclingprice2')           --珍贵物品回收倍率
TUNING.Functionalsell = GetModConfigData('Functionalsell')             --勋章特殊勋章开关
TUNING.Functionalswitch = GetModConfigData('Functionalswitch')         --勋章物品手动开关
TUNING.umswitch = GetModConfigData('umswitch')                         --永不妥协物品手动开关
TUNING.PRICERATErecovery = GetModConfigData('recovery_t')              --物品回收倍率
TUNING.PRICERATErecoverytime = GetModConfigData('recovery_time')       --物品回收倍率的间隔时间
TUNING.precious_sell = GetModConfigData('precious_sell')               --珍贵物品全开开关
TUNING.only_obtained = GetModConfigData('only_obtained')               --仅售卖已获取的物品开关
TUNING.Legionswitch = GetModConfigData('Legionswitch')                 --棱镜物品手动开关
TUNING.Legionsell = GetModConfigData('Legionsell')                     --棱镜唯一物品开关
TUNING.NDNR_SWITCH = GetModConfigData('ndnrswitch')                    --富贵险中求物品开关
TUNING.Island_switch = GetModConfigData('Island_switch')               --海难物品开关

TUNING.UPDATELIST = GetModConfigData('updatelist')                     --实时更新商品列表

TUNING.allow_selist_special = GetModConfigData('allow_selist_special') --商店是否售卖本模组特殊物品
TUNING.giveluckamulet = GetModConfigData('giveluckamulet')             --开局送项链
TUNING.givegoldstaff = GetModConfigData('givegoldstaff')               --开局送点金法杖
TUNING.givebase_resources = GetModConfigData('givebase_resources')     --开局送基础资源物资包
TUNING.giverocks_resources = GetModConfigData('giverocks_resources')   --开局送石头资源物资包
TUNING.givefight_resources = GetModConfigData('givefight_resources')   --开局送战斗物资包
TUNING.givemedal_resources = GetModConfigData('givemedal_resources')   --开局送勋章物资包
TUNING.unlock_hermit_pearl = GetModConfigData('unlock_hermit_pearl')   --开局商店解锁珍珠
TUNING.unlock_moonrockseed = GetModConfigData('unlock_moonrockseed')   --开局商店解锁天体宝球
TUNING.generate_ft = GetModConfigData('generate_ft')                   --开局生成传送实体
TUNING.ft_prefab_name = GetModConfigData('ft_prefab_name')             --生成的传送实体名
TUNING.FIXTWOPRICE = GetModConfigData('fixtwoprice')                   --固定法杖和项链价格
TUNING.allowgoldstaff = GetModConfigData('Disintegrate')               --点金分解开关
TUNING.stealercandig = GetModConfigData("Dig")                         --挖掘机当铲子
TUNING.stealercanhammer = GetModConfigData("Hammer")                   --挖掘机当锤子
TUNING.Refresh_Price = 300 * TUNING.PRICERATE                          --刷新商店的花费
modimport("scripts/se_locadsource.lua")                                --加载资源
modimport("scripts/se_rpc.lua")                                        --主客机通信
modimport("scripts/se_functionse.lua")                                 --各项函数
