-- 导入GLOBAL变量
GLOBAL = _G

local ftlist = {}

-- 创建森林世界全局篝火位置
ftlist.world_ft = {}
ftlist.world_ft["multiplayer_portal"] = "绚丽之门"
ftlist.world_ft["pigking"] = "猪王"
ftlist.world_ft["beequeenhive"] = "巨型蜂巢"
ftlist.world_ft["oasislake"] = "绿洲湖泊"
ftlist.world_ft["moon_altar_rock_glass"] = "月岛"
ftlist.world_ft["hermitcrab"] = "寄居蟹隐士"
ftlist.world_ft["sculpture_rookbody"] = "大理石雕像"
ftlist.world_ft["elecourmaline"] = "电气重铸台"
ftlist.world_ft["mermhouse"] = "鱼人小屋"
ftlist.world_ft["moonbase"] = "月亮石"
ftlist.world_ft["dragonfly_spawner"] = "龙蝇沙漠"
ftlist.world_ft["critterlab"] = "岩石洞穴"
ftlist.world_ft["junk_pile_big"] = "垃圾堆"
ftlist.world_ft["monkeyqueen"] = "月亮码头"
ftlist.world_ft["terrariumchest"] = "显眼箱子"
ftlist.world_ft["daywalker"] = "梦魇疯猪"
ftlist.world_ft["ancient_altar"] = "远古完整科技塔"
ftlist.world_ft["atrium_gate"] = "远古大门"
ftlist.world_ft["toadstool_cap"] = "毒菌蟾蜍"
ftlist.world_ft["minotaur"] = "远古守护者"
ftlist.world_ft["grotto_pool_big"] = "玻璃绿洲"
ftlist.world_ft["archive_orchestrina_base"] = "远古档案馆"
ftlist.world_ft["siving_thetree"] = "子圭神木岩"
ftlist.world_ft["lightninggoat"] = "电羊群"

-- 允许重复生成的实体
ftlist.repeat_gen = {}
ftlist.repeat_gen["toadstool_cap"] = true  -- 毒菌蟾蜍有多个刷新点

-- 特殊实体生成距离
ftlist.special_ent_radius = {}
ftlist.special_ent_radius["dragonfly_spawner"] = {30, 50}
ftlist.special_ent_radius["atrium_gate"] = {30, 50}
ftlist.special_ent_radius["minotaur"] = {30, 50}


return ftlist