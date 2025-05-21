--热更新商店列表，主客机数据同步，后端数据由服务器自己处理，只传送前端数据。
--转码--GLOBAL.json.encode
--解码--GLOBAL.json.decode

if TUNING.UPDATELIST then
    --服务端执行
    AddModRPCHandler("SimpleEconomy", "updatelist", function(player)
        --清空表
        GLOBAL.package.loaded["SEscripts/itemlist"] = nil
        --再重新加载,实现热加载
        TheWorld.components.seworldstatus:makelist()
        local tabhost = { TUNING.selist_food, TUNING.selist_cloth, TUNING.selist_smithing, TUNING.selist_resource, TUNING
            .selist_precious, TUNING.selist_special }
        local data = {}
        -- 使用ipairs函数遍历tabhost表中的每个子表
        for k, v in ipairs(tabhost) do
            -- 直接把子表复制到data表中
            data[k] = { unpack(v) }
        end
        local tabs = GLOBAL.json.encode(data)
        --向客户端发送指令和数据
        SendModRPCToClient(GetClientModRPC('SimpleEconomy', 'updatelist'), player, tabs)
    end)
    --客户端执行
    AddClientModRPCHandler("SimpleEconomy", "updatelist", function(tabs)
        TUNING.tabc = GLOBAL.json.decode(tabs)
    end)
end


--设置购物modrpc
AddModRPCHandler("SimpleEconomy", "sebuy", function(player, iname, more, lastskin)
    local alllist = {}
    -- 遍历 TUNING.allgoods 表
    for key, value in pairs(TUNING.allgoods) do
        -- 将每个元素添加到 alllist 表中
        table.insert(alllist, value)
    end

    -- 遍历 TUNING.selist_low 表
    for key, value in pairs(TUNING.selist_low) do
        -- 将每个元素添加到 alllist 表中
        table.insert(alllist, value)
    end
    local iprice = 100000
    for k, v in pairs(alllist) do
        if iname == v.name then
            iprice = v.price
            if not iprice then
                return
            end
            if TUNING.FIXTWOPRICE and iname == "luckamulet" or TUNING.FIXTWOPRICE and iname == "goldstaff" then

            else
                iprice = iprice * TUNING.PRICERATE
            end

            break
        end
    end
    local iiname = iname
    local multi = 1
    if more then multi = 10 end

    local discount = player.components.seplayerstatus.discount
    if iiname == "vipcard" or iiname == "luckamulet" then
        discount = 1
        TUNING.discount_new = 1
    end

    if player.components.health.currenthealth > 0 and not player:HasTag("playerghost") then
        if player.components.seplayerstatus.coin >= math.ceil(iprice * discount) * multi then
            for i = 1, multi do
                if iname == "blueprint" and math.random(0, 20) <= 1 then
                    iiname = TUNING.selist_blueprint[math.random(#TUNING.selist_blueprint)].name
                end
                if iname == "medal_losswetpouch" then
                    iiname = "medal_losswetpouch" .. tostring(math.random(1, 7))
                end
                if iname == "ndnr_roe" then
                    if math.random(1, 2) == 1 then
                        iiname = "ndnr_roe_oceanfish_medium_" .. tostring(math.random(1, 9))
                    else
                        iiname = "ndnr_roe_oceanfish_small_" .. tostring(math.random(1, 9))
                    end
                end
                local item = GLOBAL.SpawnPrefab(iiname, lastskin, nil, player.userid)
                -- 如果是月亮宝球，则自动升级
                if iname == "moonrockseed" then item:DoUpgrade() end
                player.components.inventory:GiveItem(item, nil, player:GetPosition())
                --用于解决稀有蓝图重复的问题
                for _, blueprint in ipairs(TUNING.selist_blueprint) do
                    if iiname == blueprint.name then
                        iiname = "blueprint"
                        break
                    end
                end
            end
            player.components.seplayerstatus:DoDeltaCoin(-iprice, multi)
        end
    else
        if TUNING.GHOSTSHOPPING then --设置鬼魂能否购物
            if player.components.seplayerstatus.coin >= math.ceil(iprice * discount) * multi then
                local pt = Point(player.Transform:GetWorldPosition())
                for i = 1, multi do
                    if iname == "blueprint" and math.random(0, 40) <= 1 then
                        iiname = TUNING.selist_blueprint[math.random(#TUNING.selist_blueprint)].name
                    end
                    if iname == "medal_losswetpouch" then
                        iiname = "medal_losswetpouch" .. tostring(math.random(1, 7))
                    end
                    if iname == "ndnr_roe" then
                        if math.random(1, 2) == 1 then
                            iiname = "ndnr_roe_oceanfish_medium_" .. tostring(math.random(1, 9))
                        else
                            iiname = "ndnr_roe_oceanfish_small_" .. tostring(math.random(1, 9))
                        end
                    end
                    local angle = math.random() * 2 * GLOBAL.PI
                    local loots = GLOBAL.SpawnPrefab(iiname, lastskin, nil, player.userid)
                    loots.Transform:SetPosition(pt.x, pt.y, pt.z)
                    loots.Physics:SetVel(2 * math.cos(angle), 10, 2 * math.sin(angle))
                    --用于解决稀有蓝图重复的问题
                    for _, blueprint in ipairs(TUNING.selist_blueprint) do
                        if iiname == blueprint.name then
                            iiname = "blueprint"
                            break
                        end
                    end
                end
                player.components.seplayerstatus:DoDeltaCoin(-iprice, multi)
            end
        end
    end
end)

--刷新功能取自workshop-2445937631
AddModRPCHandler("SimpleEconomy", "refresh", function(player) --刷新功能，与服务器通信
    if player.components.seplayerstatus.coin >= TUNING.Refresh_Price then
        player.components.seplayerstatus:preciousbuild()
        if player.components.seplayerstatus.preciouschange == true then
            player.components.seplayerstatus.preciouschange = false
        else
            player.components.seplayerstatus.preciouschange = true
        end
        player.components.seplayerstatus:DoDeltaCoin(-TUNING.Refresh_Price)
    end
end)
