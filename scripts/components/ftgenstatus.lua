local ftlist = require "SEscripts/ftlist"

-- 创建自定义组件
local ftgenstatus = Class(function(self, inst)
    self.inst = inst
    self.alreadyspawn = false
end)

function ftgenstatus:OnSave()
    local data = {
        alreadyspawn = self.alreadyspawn
    }
    return data
end

function ftgenstatus:OnLoad(data)
    self.alreadyspawn = data.alreadyspawn or false
end

function ftgenstatus:IsGenerated()
    return self.alreadyspawn
end

function ftgenstatus:SetGenerated()
    self.alreadyspawn = true
end

local function is_passable_land(x, y, z, radius)
    local is_passable_land = true  -- 是否在陆地上
    -- 检查中心点是否在陆地上
    if not GLOBAL.TheWorld.Map:IsPassableAtPoint(x, y, z) then
        is_passable_land = false
    else
        -- 检查半径范围内的点是否都是陆地
        local check_points = 8  -- 检查8个方向
        for i = 1, check_points do
            local angle = (i - 1) * (2 * math.pi / check_points)
            local check_x = x + radius * math.cos(angle)
            local check_z = z + radius * math.sin(angle)
            
            if not GLOBAL.TheWorld.Map:IsPassableAtPoint(check_x, y, check_z) then
                is_passable_land = false
                break
            end
        end
    end
    return is_passable_land
end

local function is_passable_near(x, y, z, radius)
    local ents = GLOBAL.TheSim:FindEntities(x, y, z, radius)
    if #ents ~= 0 then
        return false
    end
    return true
end

-- 检查生成位置是否合适（在陆地上且周围没有实体）
local function IsValidPosition(x, y, z, radius)
    local is_valid = false

    local is_passable_land = is_passable_land(x, y, z, radius)  -- 是否在陆地上
    local is_passable_near = is_passable_near(x, y, z, radius)  -- 周围时候存在其他实体

    if is_passable_land and is_passable_near then
        is_valid = true
    end

    return is_valid
end

-- 随机生成位置并检查时候合适
local function FindValidPosition(center_x, center_z, min_radius, max_radius, attempts, check_valid_fn)
    check_valid_fn = check_valid_fn or IsValidPosition  -- 默认陆地和周围有没实体都要检查
    attempts = attempts or 30  -- 默认尝试30次
    min_radius = min_radius
    max_radius = max_radius
    
    for i = 1, attempts do
        -- 随机角度
        local angle = math.random() * 2 * math.pi
        -- 随机距离（在最小和最大半径之间）
        local radius = min_radius + math.random() * (max_radius - min_radius)
        -- 计算偏移位置
        local offset_x = radius * math.cos(angle)
        local offset_z = radius * math.sin(angle)
        local x = center_x + offset_x
        local z = center_z + offset_z
        
        -- 检查位置是否合适
        local check_radius = 4  -- 4个半径内不能有其他实体
        if check_valid_fn(x, 0, z, check_radius) then
            return x, z
        end
    end
    
    -- 如果找不到合适位置，返回原始位置
    print("--传送点[生成]:--找不到合适生成位置，返回x轴偏移最小位置")
    return center_x + min_radius, center_z
end

local function GenerateTravelFire(gen_ent_name, world_ft, min_radius, max_radius, repeat_gen, special_ent_radius)
    -- 仅在服务器上生成
    if not GLOBAL.TheWorld.ismastersim then return end

    world_ft = world_ft or ftlist.world_ft
    min_radius = min_radius or 8
    max_radius = max_radius or 16
    repeat_gen = repeat_gen or ftlist.repeat_gen
    special_ent_radius = special_ent_radius or ftlist.special_ent_radius
    
    local counts = {}
    -- 便利目标实体，在目标实体附近生成传送篝火
    for _, ent in pairs(GLOBAL.Ents) do
        if world_ft[ent.prefab] ~= nil then
            local ent_name = ent.prefab
            local ent_text = world_ft[ent_name]

            -- 检查元素是否已经出现过
            counts[ent_name] = (counts[ent_name] or 0) + 1

            local continue_flag = false
            if counts[ent_name] < 2 then continue_flag = true
            else
                if  repeat_gen[ent_name] then continue_flag = true end
            end
            if continue_flag then
                print("--传送点[生成]:开始在" .. ent_text .. "附近创建传送篝火...")

                -- 获取目标实体位置
                local px, _, pz = ent.Transform:GetWorldPosition()

                -- 寻找合适的生成位置
                local x, z = FindValidPosition(px, pz, min_radius, max_radius)
                if special_ent_radius[ent_name] then
                    x, z = FindValidPosition(px, pz, special_ent_radius[ent_name][1], special_ent_radius[ent_name][2])
                else
                end

                -- 生成传送篝火
                local firepit = GLOBAL.SpawnPrefab(gen_ent_name)
                firepit.Transform:SetPosition(x, 0, z)

                -- 打标记
                if firepit.components.writeable then
                    firepit.components.writeable:SetText(ent_text .. "_" .. counts[ent_name])
                    print("--传送点[生成]:"..ent_text.."位置传送篝火已生成完成.")
                end
            else
                print("--传送点[生成]:" .. ent_text .. "不是可重复生成对象，默认选择第一次找到的实体附近创建传送篝火...")
            end
        end
    end
end

-- 初始化玩家状态
function ftgenstatus:Init(inst)
    -- 延迟3秒后给予初始物品
    inst:DoTaskInTime(3, function()
        if inst.components.ftgenstatus.alreadyspawn ~= true then
            inst.components.ftgenstatus.alreadyspawn = true
            -- self:SendDataToTheWorld()
            -- 生成传送点
            if TUNING.generate_ft and TUNING.ft_prefab_name then
                TheWorld:DoTaskInTime(1, function()
                    GenerateTravelFire(TUNING.ft_prefab_name)
                end)
            end
        end
    end)
end

return ftgenstatus
