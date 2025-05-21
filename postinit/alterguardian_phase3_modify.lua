local function add_attribute_from_chesspiece(inst)
    -- 保存原始的保存和加载函数
    local ori_save = inst.OnSave
    local ori_load = inst.OnLoad
    
    -- 注册新的保存和加载函数
    inst.OnSave = function(inst, data)
        if ori_save then
            ori_save(inst, data)
        end
        data.from_chesspiece = inst._from_chesspiece
    end
    
    inst.OnLoad = function(inst, data)
        if ori_load then
            ori_load(inst, data)
        end
        if data ~= nil then
            inst._from_chesspiece = data.from_chesspiece
        end
    end
end


-- 修改天体守卫者各个阶段的行为
local function AddPhaseTransition(inst)
    inst:RemoveAllEventCallbacks("phasetransition")  -- 取消当前实体的监听事件
    inst:ListenForEvent("phasetransition", function(inst)
        local px, py, pz = inst.Transform:GetWorldPosition()
        local target = inst.components.combat.target

        inst:Remove()
    
        -- 根据当前Boss的阶段确定下一阶段的Boss
        local next_phase_prefab = "alterguardian_phase2"
        if inst.prefab == next_phase_prefab then 
            next_phase_prefab = "alterguardian_phase3"
        end
        local next_phase = SpawnPrefab(next_phase_prefab)
        print(string.format("[调试] 判断是否是棋子生成的boss: %s", tostring(inst._from_chesspiece)))
        if inst._from_chesspiece then
            next_phase._from_chesspiece = true
            print(string.format("[调试] 判断成功，是棋子生成的boss，传递棋子召唤标记: %s", tostring(next_phase._from_chesspiece)))
            
            if next_phase_prefab == "alterguardian_phase3" then
                -- 监听实体初始化完成事件
                print("[调试] 检测天体英雄三阶段是棋子生成的boss，开始执行初始化...")
                print("[调试] 增加alterguardianhat（启迪之冠）到掉落表")
                if next_phase.components.lootdropper then
                    next_phase.components.lootdropper:AddChanceLoot("alterguardianhat", 1)
                    print("[调试] 成功增加alterguardianhat（启迪之冠）到掉落表！")
                end

                -- 重新设置状态图，死亡后不生成 alterguardian_phase3deadorb
                -- print("[调试] 开始重新设置状态图，棋子生成的boss不生成alterguardian_phase3deadorb")
                -- inst:SetStateGraph("SGalterguardian_phase3_mod")
                -- if inst.sg and inst.sg.states then
                --     local death_state = inst.sg.states.death
                --     if death_state then
                --         local new_events = {
                --             EventHandler("animover", function(inst) inst:Remove() end)
                --         }
                --         -- 遍历原有事件
                --         for i, event_handler in ipairs(death_state.events) do
                --             print(string.format("[调试] 遍历原有事件: %s", event_handler.name))
                --             if event_handler.name ~= "animover" then
                --                 -- 保持其他事件不变
                --                 table.insert(new_events, event_handler)
                --             end
                --         end
                --         -- 更新事件表
                --         death_state.events = new_events
                --         print("[调试] 重新设置状态图完成")
                --     else
                --         print("[调试] 警告：death_state 不存在")
                --     end
                -- else
                --     print("[调试] 警告：sg 或 states 不存在")
                -- end
            end
        end  -- 传递棋子召唤标记
        next_phase.Transform:SetPosition(px, py, pz)
        next_phase.components.combat:SuggestTarget(target)
        next_phase.sg:GoToState("spawn")
    end)
end


----------
---alterguardian_phase1
----------
AddPrefabPostInit("alterguardian_phase1", function(inst)
    add_attribute_from_chesspiece(inst)  -- 添加属性
    AddPhaseTransition(inst)  -- 添加阶段转换
end)

----------
---alterguardian_phase2
----------
AddPrefabPostInit("alterguardian_phase2", function(inst)
    add_attribute_from_chesspiece(inst)  -- 添加属性
    AddPhaseTransition(inst)  -- 添加阶段转换
end)

----------
---alterguardian_phase3
----------
AddPrefabPostInit("alterguardian_phase3", function(inst)
    add_attribute_from_chesspiece(inst)  -- 添加属性

    inst:ListenForEvent("onremove", function(inst)
        if inst._from_chesspiece then
            -- 在实体移除前保存位置
            local x, y, z = inst.Transform:GetWorldPosition()
            GLOBAL.TheWorld:DoTaskInTime(5, function()

                -- 先查找所有实体
                local all_ents = GLOBAL.TheSim:FindEntities(x, y, z, 4)
                -- 打印所有找到的实体的信息
                -- for _, ent in ipairs(all_ents) do
                --     if ent:IsValid() then
                --         print(string.format("[调试] 找到实体: %s, 位置: x=%.2f, y=%.2f, z=%.2f", 
                --             ent.prefab, 
                --             ent.Transform:GetWorldPosition()))
                --     end
                -- end
                
                -- 筛选并移除目标实体
                for _, ent in ipairs(all_ents) do
                    if ent:IsValid() and ent.prefab == "alterguardian_phase3deadorb" then
                        ent.AnimState:PlayAnimation("phase3_death_pst")
                        ent.SoundEmitter:PlaySound("moonstorm/creatures/boss/alterguardian3/death_pst")
                        ent:ListenForEvent("animover", function()
                            ent:Remove()
                        end)
                    end
                end
            end)
        end
    end)
end)

