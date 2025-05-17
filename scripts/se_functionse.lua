--角色交易属性
AddPlayerPostInit(function(inst)
    inst.seccoin = GLOBAL.net_int(inst.GUID, "seccoin")
    inst.secexp = GLOBAL.net_int(inst.GUID, "secexp")
    inst.seclevel = GLOBAL.net_shortint(inst.GUID, "seclevel")
    inst.secvip = GLOBAL.net_shortint(inst.GUID, "secvip")
    inst.secprecious = GLOBAL.net_bytearray(inst.GUID, "secprecious")
    inst.secunlocklist = GLOBAL.net_string(inst.GUID, "secunlocklist")
    inst.secpreciouschange = GLOBAL.net_bool(inst.GUID, "secpreciouschange")
    inst.secsoundm = GLOBAL.net_bool(inst.GUID, "secsoundm", "secsoundm")
    if not GLOBAL.TheNet:GetIsClient() then
        inst:AddComponent("seplayerstatus")
        inst.components.seplayerstatus:Init(inst)
    end
end)
--全局经济数据
AddPrefabPostInit("forest", function(inst)
    if not GLOBAL.TUNING then GLOBAL.TUNING = {} end
    GLOBAL.TUNING.generate_ft = GetModConfigData('generate_ft')
    GLOBAL.TUNING.ft_prefab_name = GetModConfigData('ft_prefab_name')
    GLOBAL.TheWorld:AddComponent("seworldstatus")
    GLOBAL.TheWorld:AddComponent("ftgenstatus")
    GLOBAL.TheWorld.components.ftgenstatus:Init(inst)
end)
AddPrefabPostInit("cave", function(inst)
    if not GLOBAL.TUNING then GLOBAL.TUNING = {} end
    GLOBAL.TUNING.generate_ft = GetModConfigData('generate_ft')
    GLOBAL.TUNING.ft_prefab_name = GetModConfigData('ft_prefab_name')
    GLOBAL.TheWorld:AddComponent("seworldstatus")
    GLOBAL.TheWorld:AddComponent("ftgenstatus")
    GLOBAL.TheWorld.components.ftgenstatus:Init(inst)
end)


--UI尺寸
local function ScaleUI(self, screensize)
    local hudscale = self.top_root:GetScale()
    self.uiseconomy:SetScale(.75 * hudscale.x, .75 * hudscale.y, 1)
end

local uiseconomy = require("widgets/uiseconomy")
local function Adduiseconomy(self)
    self.uiseconomy = self.top_root:AddChild(uiseconomy(self.owner))
    local screensize = { GLOBAL.TheSim:GetScreenSize() }
    ScaleUI(self, screensize)
    self.uiseconomy:SetHAnchor(0)
    self.uiseconomy:SetVAnchor(0)
    self.uiseconomy:MoveToFront()
    local OnUpdate_base = self.OnUpdate
    self.OnUpdate = function(self, dt)
        OnUpdate_base(self, dt)
        local curscreensize = { GLOBAL.TheSim:GetScreenSize() }
        if curscreensize[1] ~= screensize[1] or curscreensize[2] ~= screensize[2] then
            ScaleUI(self)
            screensize = curscreensize
        end
    end
end

AddClassPostConstruct("widgets/controls", Adduiseconomy)

-- 添加传送点生成代码
local creaturesdeath = GetModConfigData('creaturesdeath') --打怪开关

--检测其他mod是否启用
local function CheckMod(name)
    for k, v in pairs(GLOBAL.ModManager.mods) do
        if v.modinfo.name == name then
            return true
        end
    end
    return false
end

TUNING.autoLegion = CheckMod("[DST] Legion") or CheckMod("[DST] 棱镜")
TUNING.UNCOMPROMISING_MODE = CheckMod("󰀕 Uncompromising Mode")
TUNING.Island_Adventures_se = CheckMod("Island Adventures - Shipwrecked") or CheckMod("岛屿冒险")
TUNING.The_New_Constant = CheckMod("The New Constant") or CheckMod("永恒新界")

local creaturesdeath = GetModConfigData('creaturesdeath') --打怪开关
local deathcd = GetModConfigData('deathcd')               --打怪的cd
local limitphmod = GetModConfigData('limitphmod')         --只对特定血量
local coinrate = GetModConfigData('coinrate')             --生物死亡时间内的金币倍率
local limitcoin = GetModConfigData('limitcoin')           --单次生物死亡获得金币上限
--以下代码非本人原创，另外对打怪的代码进行了优化和额外添加功能。
--打怪功能取自workshop-244593763
--生物死亡掉落金币
if creaturesdeath then
    local function ShouldReward(inst)
        return not inst:HasTag("wall") and inst:IsValid() and
            inst.components.lootdropper and inst.components.health and
            not inst.components.health.invincible and inst.components.combat and
            inst.components.combat.target and
            inst.components.combat.defaultdamage > 0
    end
    local function RewardPlayers(inst)
        local mob_namesd = inst.prefab -- 获取生物的名称
        local mobPosition = inst:GetPosition()
        local bounty = math.floor(inst.components.health.maxhealth * creaturesdeath)
        if bounty > 0 then
            for k, player in pairs(GLOBAL.FindPlayersInRange(mobPosition.x, mobPosition.y, mobPosition.z, GLOBAL.TUNING.BOOMERANG_DISTANCE * 2, true)) do
                local item = inst.components.lootdropper:SpawnLootPrefab("secoin")
                item.components.secoin.amount = bounty
                if deathcd ~= 0 then --判断是否启用时间内倍率调整，这里是总开关。
                    if inst.components.health.maxhealth >= limitphmod or limitphmod == nil then
                        player.last_get_coin_time = player.last_get_coin_time or {}
                        if not player.last_get_coin_time[mob_namesd] then
                            -- 初始化奖励的时间为负数，表示可以立即获取奖励
                            player.last_get_coin_time[mob_namesd] = -1 * deathcd
                        end
                        if GLOBAL.GetTime() - player.last_get_coin_time[mob_namesd] <= deathcd then -- 如果时间差小于等于规定的数值，就把金币数量缩减成特定数值
                            item.components.secoin.amount = item.components.secoin.amount * coinrate
                        end
                        -- 更新最后获取奖励的时间
                        player.last_get_coin_time[mob_namesd] = GLOBAL.GetTime()
                    end
                end
                --单次获得金币上限
                if item.components.secoin.amount > limitcoin and limitcoin ~= 0 then
                    item.components.secoin.amount = limitcoin
                end
                --取整
                item.components.secoin.amount = math.ceil(item.components.secoin.amount)
                if item.components.secoin.amount > 0 then
                    -- 执行奖励玩家的任务
                    player:DoTaskInTime(.3, function()
                        player.components.seplayerstatus:givesecoin(item)
                    end)
                end
            end
        end
    end
    AddPrefabPostInitAny(function(inst)
        inst:ListenForEvent("death", function()
            if ShouldReward(inst) then
                RewardPlayers(inst)
            end
        end)
    end)
end


-- --换人不掉钱，功能参考了workshop-2846621983
-- local restartlist = {}            --换人物时，当前经济学数据存放在此
-- local function ListInsert(player) --存放数据
--     if player.userid and player.components then
--         restartlist[player.userid] = {
--             coin = 500,
--             exp = 0,
--             level = 1,
--             vip = 0,
--             discount = 0,
--             slist = {},
--             precious = {},
--             alreadyspawn = false,
--             preciouschange = false,
--             soundm = false,
--             day = 0,
--             used = true,
--         }
--     end
--     restartlist[player.userid].coin = player.components.seplayerstatus.coin
--     restartlist[player.userid].exp = player.components.seplayerstatus.exp
--     restartlist[player.userid].level = player.components.seplayerstatus.level
--     restartlist[player.userid].vip = player.components.seplayerstatus.vip
--     restartlist[player.userid].discount = player.components.seplayerstatus.discount
--     restartlist[player.userid].slist = player.components.seplayerstatus.slist
--     restartlist[player.userid].precious = player.components.seplayerstatus.precious
--     restartlist[player.userid].alreadyspawn = true
--     restartlist[player.userid].preciouschange = player.components.seplayerstatus.presciouschange
--     restartlist[player.userid].soundm = player.components.seplayerstatus.soundm
--     restartlist[player.userid].day = player.components.seplayerstatus.day
--     restartlist[player.userid].used = false
-- end

-- AddComponentPostInit("playerspawner", function(OnPlayerSpawn, inst)
--     inst:ListenForEvent("ms_playerjoined", function(self, player)
--         if restartlist[player.userid] and ((not restartlist[player.userid].used) or player.prefab == "wonkey") then
--             player.components.seplayerstatus.coin = restartlist[player.userid].coin
--             player.components.seplayerstatus.exp = restartlist[player.userid].exp
--             player.components.seplayerstatus.level = restartlist[player.userid].level
--             player.components.seplayerstatus.vip = restartlist[player.userid].vip
--             player.components.seplayerstatus.discount = restartlist[player.userid].discount
--             player.components.seplayerstatus.slist = restartlist[player.userid].slist
--             player.components.seplayerstatus.precious = restartlist[player.userid].precious
--             player.components.seplayerstatus.alreadyspawn = true
--             player.components.seplayerstatus.presciouschange = restartlist[player.userid].preciouschange
--             player.components.seplayerstatus.soundm = restartlist[player.userid].soundm
--             player.components.seplayerstatus.day = restartlist[player.userid].day
--             restartlist[player.userid].used = true
--             if player.prefab == "wonkey" then
--                 restartlist[player.userid].used = false
--             end
--         end
--     end)
--     inst:ListenForEvent("ms_playerdespawnanddelete", function(self, player)
--         ListInsert(player)
--     end)
-- end)
-- --修复变猴丢失货币的bug
-- AddPlayerPostInit(function(inst)
--     inst:ListenForEvent("monkeycursehit", function(player, data)
--         if player.prefab == "wonkey" then
--             return
--         end
--         if restartlist[player.userid] then
--             player.components.seplayerstatus.coin = restartlist[player.userid].coin
--             player.components.seplayerstatus.exp = restartlist[player.userid].exp
--             player.components.seplayerstatus.level = restartlist[player.userid].level
--             player.components.seplayerstatus.vip = restartlist[player.userid].vip
--             player.components.seplayerstatus.discount = restartlist[player.userid].discount
--             player.components.seplayerstatus.slist = restartlist[player.userid].slist
--             player.components.seplayerstatus.precious = restartlist[player.userid].precious
--             player.components.seplayerstatus.alreadyspawn = true
--             player.components.seplayerstatus.presciouschange = restartlist[player.userid].preciouschange
--             player.components.seplayerstatus.soundm = restartlist[player.userid].soundm
--             player.components.seplayerstatus.day = restartlist[player.userid].day
--             restartlist[player.userid].used = true
--         end
--         ListInsert(player)
--     end)
-- end)
AddPlayerPostInit(function(inst)
    local Old_SaveFn = inst.OnSave
    local Old_LoadFn = inst.OnLoad

    inst.OnSave = function(inst, data)
        if inst.components.seplayerstatus then
            -- 将 inst.components.seplayerstatus 的内容保存到 data.seplayerstatus 中
            data.seplayerstatus = {
                coin = inst.components.seplayerstatus.coin,                       -- 保存金币
                exp = inst.components.seplayerstatus.exp,                         -- 保存经验值
                level = inst.components.seplayerstatus.level,                     -- 保存等级
                vip = inst.components.seplayerstatus.vip,                         -- 保存VIP等级
                discount = inst.components.seplayerstatus.discount,               -- 保存折扣信息
                slist = inst.components.seplayerstatus.slist,                     -- 保存特殊物品列表
                precious = inst.components.seplayerstatus.precious,               -- 保存珍贵物品信息
                unlocklist = inst.components.seplayerstatus.unlocklist,           -- 保存已解锁的物品信息
                alreadyspawn = inst.components.seplayerstatus.alreadyspawn,       -- 保存是否已生成标记
                presciouschange = inst.components.seplayerstatus.presciouschange, -- 保存珍贵物品改变记录
                soundm = inst.components.seplayerstatus.soundm,                   -- 保存音效设置
                day = inst.components.seplayerstatus.day                          -- 保存天数记录
            }
        end
        if Old_SaveFn then
            Old_SaveFn(inst, data)
        end
    end

    inst.OnLoad = function(inst, data)
        -- 判断 data.seplayerstatus 存在且不为空，并且 inst.components.seplayerstatus 存在
        if data.seplayerstatus and next(data.seplayerstatus) and inst.components.seplayerstatus then
            local status = inst.components.seplayerstatus -- 将 inst.components.seplayerstatus 缓存为局部变量
            local source = data.seplayerstatus            -- 将 data.seplayerstatus 缓存为局部变量

            -- 依次检查 source 中的每个值是否存在，再赋值给 status
            if source.coin then status.coin = source.coin end                                  -- 恢复金币
            if source.exp then status.exp = source.exp end                                     -- 恢复经验值
            if source.level then status.level = source.level end                               -- 恢复等级
            if source.vip then status.vip = source.vip end                                     -- 恢复VIP等级
            if source.discount then status.discount = source.discount end                      -- 恢复折扣信息
            if source.slist then status.slist = source.slist end                               -- 恢复特殊物品列表
            if source.precious then status.precious = source.precious end                      -- 恢复珍贵物品信息
            if source.unlocklist then status.unlocklist = source.unlocklist end                -- 恢复已解锁物品的信息
            if source.alreadyspawn then status.alreadyspawn = source.alreadyspawn end          -- 恢复是否已生成标记
            if source.presciouschange then status.presciouschange = source.presciouschange end -- 恢复珍贵物品改变记录
            if source.soundm then status.soundm = source.soundm end                            -- 恢复音效设置
            if source.day then status.day = source.day end                                     -- 恢复天数记录
        end

        if Old_LoadFn then
            Old_LoadFn(inst, data)
        end
    end
    -- 换人时保存数据表
    local Old_SaveForReroll = inst.SaveForReroll
    inst.SaveForReroll = function(inst)
        local data = Old_SaveForReroll(inst)
        if data then
            -- 将 inst.components.seplayerstatus 的内容保存到 data.seplayerstatus 中
            data.seplayerstatus = {
                coin = inst.components.seplayerstatus.coin,                       -- 保存金币
                exp = inst.components.seplayerstatus.exp,                         -- 保存经验值
                level = inst.components.seplayerstatus.level,                     -- 保存等级
                vip = inst.components.seplayerstatus.vip,                         -- 保存VIP等级
                discount = inst.components.seplayerstatus.discount,               -- 保存折扣信息
                slist = inst.components.seplayerstatus.slist,                     -- 保存特殊物品列表
                precious = inst.components.seplayerstatus.precious,               -- 保存珍贵物品信息
                unlocklist = inst.components.seplayerstatus.unlocklist,           -- 保存已解锁物品信息
                alreadyspawn = inst.components.seplayerstatus.alreadyspawn,       -- 保存是否已生成标记
                presciouschange = inst.components.seplayerstatus.presciouschange, -- 保存珍贵物品改变记录
                soundm = inst.components.seplayerstatus.soundm,                   -- 保存音效设置
                day = inst.components.seplayerstatus.day                          -- 保存天数记录
            }
        end
        return data
    end
    local Old_LoadForReroll = inst.LoadForReroll
    inst.LoadForReroll = function(inst, data)
        -- 判断 data.seplayerstatus 存在且不为空，并且 inst.components.seplayerstatus 存在
        if data.seplayerstatus and next(data.seplayerstatus) and inst.components.seplayerstatus then
            local status = inst.components.seplayerstatus -- 将 inst.components.seplayerstatus 缓存为局部变量
            local source = data.seplayerstatus            -- 将 data.seplayerstatus 缓存为局部变量

            -- 依次检查 source 中的每个值是否存在，再赋值给 status
            if source.coin then status.coin = source.coin end                                  -- 恢复金币
            if source.exp then status.exp = source.exp end                                     -- 恢复经验值
            if source.level then status.level = source.level end                               -- 恢复等级
            if source.vip then status.vip = source.vip end                                     -- 恢复VIP等级
            if source.discount then status.discount = source.discount end                      -- 恢复折扣信息
            if source.slist then status.slist = source.slist end                               -- 恢复特殊物品列表
            if source.precious then status.precious = source.precious end                      -- 恢复珍贵物品信息
            if source.unlocklist then status.unlocklist = source.unlocklist end                -- 恢复已解锁物品信息
            if source.alreadyspawn then status.alreadyspawn = source.alreadyspawn end          -- 恢复是否已生成标记
            if source.presciouschange then status.presciouschange = source.presciouschange end -- 恢复珍贵物品改变记录
            if source.soundm then status.soundm = source.soundm end                            -- 恢复音效设置
            if source.day then status.day = source.day end                                     -- 恢复天数记录
        end
        if Old_LoadForReroll then
            Old_LoadForReroll(inst, data)
        end
    end
end)
