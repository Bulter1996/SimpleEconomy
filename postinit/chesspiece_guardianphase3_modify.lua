-- 处理棋子的震动效果
-- @param inst: 棋子实例
-- @param count: 震动次数
local function DoStruggle(inst, count)
    -- 获取棋子的世界坐标
    local x, y, z = inst.Transform:GetWorldPosition()
    -- 播放震动动画
    inst.AnimState:PlayAnimation("jiggle")
    -- 播放震动音效
    inst.SoundEmitter:PlaySound("dontstarve/common/together/sculptures/shake")
    -- 设置下一次震动任务
    inst._task =
        count > 1 and
        -- 如果还有剩余次数，继续震动
        inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength(), DoStruggle, count - 1) or
        -- 否则随机延迟后再次震动1-3次
        inst:DoTaskInTime(inst.AnimState:GetCurrentAnimationLength() + math.random() + .6, DoStruggle, math.max(1, math.random(3) - 1))
end

-- 开始震动效果
-- @param inst: 棋子实例
local function StartStruggle(inst)
    -- 如果没有正在进行的震动任务，则开始新的震动
    if inst._task == nil then
        inst._task = inst:DoTaskInTime(math.random(), DoStruggle, 1)
    end
end

-- 停止震动效果
-- @param inst: 棋子实例
local function StopStruggle(inst)
    -- 如果有正在进行的震动任务，取消它
    if inst._task ~= nil then
        inst._task:Cancel()
        inst._task = nil
    end
end

-- 检查是否需要开始震动
-- @param inst: 棋子实例
local function CheckMorph(inst)
    -- 在月圆且棋子未睡眠时开始震动
    if TheWorld.state.isfullmoon and not inst:IsAsleep() then
        StartStruggle(inst)
    else
        StopStruggle(inst)
    end
end

-- 生成天体守卫者
-- @param inst: 棋子实例
local function do_boss_spawn(inst)
    local ix, _, iz = inst.Transform:GetWorldPosition()
    -- 生成天体守卫者第一阶段
    local boss = SpawnPrefab("alterguardian_phase1")
    boss.Transform:SetPosition(ix, 0, iz)
    -- 设置初始状态为预生成待机
    boss.sg:GoToState("prespawn_idle")
    -- 标记这个Boss是由棋子召唤的
    boss._from_chesspiece = true
    
    -- 延迟一帧后让Boss进入正常状态
    boss:DoTaskInTime(0, function()
        if boss:IsValid() then
            boss.sg:GoToState("idle")
        end
    end)
end

-- 雕像破坏后的回调函数
local function onworkfinished(inst)
    if inst._task ~= nil then
        do_boss_spawn(inst)
    end

    inst.components.lootdropper:DropLoot()
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("stone")
    inst:Remove()
end

-- 初始化棋子
AddPrefabPostInit("chesspiece_guardianphase3", function(inst)
    -- 添加必要的标签
    inst:AddTag("chess_moonevent")    -- 月圆事件标签
    inst:AddTag("event_trigger")      -- 事件触发器标签
    
    -- 设置实体唤醒和睡眠时的检查函数
    inst.OnEntityWake = CheckMorph    -- 实体唤醒时检查
    inst.OnEntitySleep = CheckMorph   -- 实体睡眠时检查
    
    -- 监听月圆状态变化
    inst:WatchWorldState("isfullmoon", CheckMorph)

    -- 重写工作回调函数
    if not inst.components.workable then
        inst:AddComponent("workable")
        inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
        inst.components.workable:SetWorkLeft(1)
    end
    inst.components.workable:SetOnFinishCallback(onworkfinished)
end)
