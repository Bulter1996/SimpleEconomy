local assets=
{
    Asset("ANIM", "anim/vipcard.zip"),
    Asset("ATLAS", "images/inventoryimages/vipcard.xml"),
}

local function removeorputin(inst)
    if not inst then return end
    local owner = inst.components.inventoryitem.owner
    local se = nil
    if owner and owner.components.seplayerstatus then
        se = owner.components.seplayerstatus
    elseif owner
    and owner.components.inventoryitem
    and owner.components.inventoryitem.owner
    and owner.components.inventoryitem.owner.components.seplayerstatus then
        se = owner.components.inventoryitem.owner.components.seplayerstatus
    end
    if se ~= nil then
        se:checkvip()
    end
end

local function fn(Sim)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
    inst.entity:AddNetwork()
    inst.entity:AddSoundEmitter()
    
    anim:SetBank("vipcard")
    anim:SetBuild("vipcard")
    anim:PlayAnimation("idle")

    inst:AddTag("molebait")
    inst:AddTag("quakedebris")

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst._player = nil

    inst:AddComponent("inspectable")

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(100)
    inst.components.finiteuses:SetUses(0)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.atlasname = "images/inventoryimages/vipcard.xml"
    inst.components.inventoryitem:SetOnPutInInventoryFn(removeorputin)
    inst.components.inventoryitem:SetOnActiveItemFn(removeorputin)
    inst.components.inventoryitem.oOldOnRemoved = inst.components.inventoryitem.OnRemoved
    inst.components.inventoryitem.OnRemoved = function(self)
        removeorputin(self.inst)
        return self.inst.components.inventoryitem.oOldOnRemoved(self)
    end
    
    return inst
end

return Prefab( "vipcard", fn, assets) 
