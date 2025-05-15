local assets=
{
    Asset("ANIM", "anim/goldstaff.zip"),
    Asset("ATLAS", "images/inventoryimages/goldstaff.xml"),
}

local prefabs = {
}

local itemlist = require "SEscripts/itemlist"

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "goldstaff", "swap")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

--计算配方材料价格总和
local function SumOfRecipePrices(name, staff)
    local recipe = AllRecipes[name]
    local repeative = false
    for kre,vre in pairs(staff.repeativecheck) do--循环重复材料检测
        if name == vre.name or name == vre then
            repeative = true
            break
        end
    end
    if recipe == nil or repeative then return false end
    table.insert(staff.repeativecheck, name)
    local tab = {}
    for k,v in pairs(TUNING.allgoods) do table.insert(tab, v) end
    for k,v in pairs(TUNING.selist_low) do table.insert(tab, v) end
    local price = 0
    for i,ingredient in ipairs(recipe.ingredients) do
        local ingreprice = 0
        for _,tabv in pairs(tab) do
            if tabv.name == ingredient.type then
                local salemult = 3
                for k,v in pairs(TUNING.selist_low) do
                    if ingredient.type == v.name then
                        salemult = 10
                        break
                    end
                end
                ingreprice = (tabv.price or 0)/salemult
                break
            end
        end
        if ingreprice == 0 then
            local sumrecipes = SumOfRecipePrices(ingredient.type, staff)
            ingreprice = sumrecipes ~= 0 and sumrecipes or ingreprice
        end
        price = price + ingreprice*(ingredient.amount or 1)
    end
    return price/(recipe.numtogive or 1)
end

local function IsInallowItems(item, tab)
    for _, value in ipairs(tab) do
        if item == value then
            return true
        end
    end
    return false
end

local itemCounts = {}  -- 用于跟踪物品数量的表
local lastConversionTime = {}  -- 用于跟踪上次转化时间的表
local function goldstafffn(staff, target, pos)

    local tab = {}

    for _, item in ipairs(TUNING.allgoods) do
        table.insert(tab, item.name)
    end
    for _, item in ipairs(TUNING.selist_low) do
        table.insert(tab, item.name)
    end
    for _, item in ipairs(TUNING.selist_precioustwo) do
         table.insert(ForbiddenItems, item)
    end
    local caster = staff.components.inventoryitem.owner
    local temp = TheSim:FindEntities(pos.x,pos.y,pos.z, 2.7)
    for k,v in pairs(temp) do
        if v.components.unwrappable then
            if v.components.inventoryitem and not v.components.inventoryitem.owner then
                v.components.unwrappable:Unwrap(caster)
            end
        end
    end
    local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 2.7)
    local talkprice = 0
    local pass = 1
    local noprice = true
    local recovery = 1
    for k,v in pairs(ents) do
        if v.components.inventoryitem
        and v.components.inventoryitem.owner == nil
        and not IsInallowItems(v.prefab, ForbiddenItems)
        and (IsInallowItems(v.prefab, tab) or TUNING.allowgoldstaff ~= 1)
        and (TUNING.allowgoldstaff or IsInallowItems(v.prefab, allowtwo))
        and staff.components.finiteuses.current >= 1 then
            local price = 0
            local stacksize = 1
            if v.components.stackable then stacksize = v.components.stackable.stacksize end

            --设置物品回收的二次倍率调整
            if TUNING.PRICERATErecoverytime then
                if not IsInallowItems(v.prefab,allowone) then
                local currentTime = GetTime()
                    if itemCounts[v.prefab] then
                        local lastTime = lastConversionTime[v.prefab] or 0
                        if currentTime - lastTime < TUNING.PRICERATErecoverytime then
                            recovery = TUNING.PRICERATErecovery
                        end
                    end
                    -- 更新上次转化时间
                    itemCounts[v.prefab] = v.prefab or nil
                    lastConversionTime[v.prefab] = currentTime
                end
            end

            for i,j in pairs(TUNING.allgoods) do
                if v.prefab == j.name then
                    price = j.price/TUNING.recyclingprice1*stacksize*TUNING.PRICERATE*recovery
                end
            end
            for i,j in pairs(TUNING.selist_low) do
                if v.prefab == j.name then
                    price = j.price/TUNING.recyclingprice2*stacksize*TUNING.PRICERATE*recovery
                end
            end

            if v.prefab == "goldstaff" then
                for _, item in ipairs(itemlist.selist_special) do
                    if item.name == "goldstaff" then
                        if TUNING.FIXTWOPRICE then
                            price = item.price / TUNING.recyclingprice2*recovery
                        else
                            price = item.price / TUNING.PRICERATE * TUNING.recyclingprice2*recovery
                        end
                        break  -- 可以结束遍历，因为已经找到目标项
                    end
                end
                --TUNING.discount_new = true
            end
            
            if v.prefab == "vipcard" then
                for _, item in ipairs(itemlist.selist_special) do
                    if item.name == "vipcard" then
                        price = item.price * TUNING.PRICERATE
                        break  -- 可以结束遍历，因为已经找到目标项
                    end
                end
                TUNING.discount_new = true
            end
            if v.prefab == "luckamulet" then
                for _, item in ipairs(itemlist.selist_special) do
                    if item.name == "luckamulet" then
                        if TUNING.FIXTWOPRICE then
                            price = item.price
                        else
                            price = item.price * TUNING.PRICERATE
                        end
                        break  -- 可以结束遍历，因为已经找到目标项
                    end
                end
                TUNING.discount_new = true
            end
            staff.repeativecheck = {}
            local sumrecipes = SumOfRecipePrices(v.prefab, staff)
            price = price == 0 and sumrecipes and sumrecipes*stacksize or price
            if price == 0 then
                price = math.random(1, 5)
            else
                noprice = false
            end
            if v.components.finiteuses and v.prefab ~= "vipcard" then
                local percent = v.components.finiteuses:GetPercent()
                price = price*percent
            end
            if v.components.fueled and v.prefab ~= "vipcard" then
                local percent = v.components.fueled:GetPercent()
                price = price*percent
            end
            if v.components.armor and v.components.armor.maxcondition > 0 and v.prefab ~= "vipcard" then
                local percent = v.components.armor:GetPercent()
                price = price*percent
            end
            if caster.components.builder and AllRecipes[v.prefab] then
                price = price * caster.components.builder.ingredientmod
            end
            price = math.ceil(price)
            talkprice = talkprice + price
            local pt = Point(v.Transform:GetWorldPosition())
            local secoin = SpawnPrefab("secoin")
            secoin.components.secoin.amount = price
            local angle = math.random()*2*PI
            secoin.Transform:SetPosition(pt.x,pt.y,pt.z)
            secoin.Physics:SetVel(2*math.cos(angle), 10, 2*math.sin(angle))
            secoin:DoTaskInTime(pass*FRAMES*3+.3, function()
                if caster and caster.components.seplayerstatus and secoin then
                    caster.components.seplayerstatus:givesecoin(secoin)
                end
            end)
            pass = pass + 1
            staff.components.inventoryitem.owner.SoundEmitter:PlaySound("dontstarve/common/staff_dissassemble")
            if v.components.inventory then v.components.inventory:DropEverything() end
            if v.components.container then v.components.container:DropEverything() end
            staff.components.finiteuses:Use(1)
            v:Remove()
        end
    end
    if talkprice > 0 then
        SpawnPrefab("explode_small_slurtle").Transform:SetPosition(pos:Get())
        caster:DoTaskInTime(pass*FRAMES*3+.4, function()
            caster.components.talker:Say(STRINGS.SIMPLEECONOMY[10]..talkprice..STRINGS.SIMPLEECONOMY[19])
            if noprice == true then
                caster:DoTaskInTime(1, function()
                    caster.components.talker:Say(STRINGS.SIMPLEECONOMY[11])
                end)
            end
        end)
    else
        caster.components.talker:Say(STRINGS.SIMPLEECONOMY[12])
        staff.components.finiteuses:Use(1)
    end
end




local function onattack(self, attacker, target, projectile)
    local maxhp = 25
    local chance = 25
    if TUNING.allowgoldstaff == false then
        chance = 100
    end
    if attacker then
        if attacker.components.seplayerstatus.level >= 2 then maxhp = 100 end
        if attacker.components.seplayerstatus.level >= 3 then maxhp = 200 end
        if attacker.components.seplayerstatus.level >= 4 then maxhp = 400 end
        if attacker.components.seplayerstatus.level >= 5 then maxhp = 500 end
    end
    if target
    and target:IsValid()
    and target.components.health
    and target.components.health.currenthealth <= maxhp
    and math.random(0, 100) <= chance
    and self.inst.components.finiteuses.current >= 1
    and target.components.lootdropper
    and (target.components.freezable or target:HasTag("monster")) then
        local amount = target.components.health.maxhealth
        SpawnPrefab("explode_small_slurtle").Transform:SetPosition(target:GetPosition():Get())
        if target.components.health.currenthealth > 0 then
            target.components.combat:GetAttacked(attacker, amount)
        end
    --    local item = target.components.lootdropper:SpawnLootPrefab("secoin")
    --    item.components.secoin.amount = math.random(math.ceil(amount/16),math.ceil(amount/8))
    --    attacker:DoTaskInTime(.3, function()
    --        attacker.components.seplayerstatus:givesecoin(item)
    --    end)
    end
    self.inst.components.finiteuses:Use(1)
end

local function fn()
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()

    anim:SetBank("goldstaff")
    anim:SetBuild("goldstaff")
    anim:PlayAnimation("idle")

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/goldstaff.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )

    inst:AddComponent("tool")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)
    inst.components.weapon.OnAttack = onattack

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetOnFinished(inst.Remove)
    inst.components.finiteuses:SetMaxUses(35)
    inst.components.finiteuses:SetUses(35)


        inst:AddComponent("spellcaster")
        --inst.components.spellcaster.canuseontargets = true
        --inst.components.spellcaster.canonlyuseonrecipes = true
        inst.components.spellcaster.canuseonpoint = true
        inst.components.spellcaster:SetSpellFn(goldstafffn)


    return inst
end


return Prefab( "goldstaff", fn, assets, prefabs)