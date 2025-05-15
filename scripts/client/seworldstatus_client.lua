local seworldstatus_client = Class(function(self, inst)
    self.inst = inst
end)

-- 注册RPC处理函数
AddModRPCHandler("SimpleEconomy", "SyncUnlockedItems", function(player, unlocked_items)
    local seworldstatus = TheWorld.components.seworldstatus
    if seworldstatus then
        seworldstatus:OnClientSyncUnlockedItems(unlocked_items)
    end
end)

return seworldstatus_client 