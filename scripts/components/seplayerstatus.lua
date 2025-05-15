require "SEscripts/itemlist"

-- 定义各种属性的setter函数
local function seccoin(self,coin) self.inst.seccoin:set(coin) end
local function secexp(self,exp) self.inst.secexp:set(exp) end
local function seclevel(self,level) self.inst.seclevel:set(level) end
local function secvip(self,vip) self.inst.secvip:set(vip) end
local function secprecious(self,precious) self.inst.secprecious:set(precious) end
local function secpreciouschange(self,preciouschange) self.inst.secpreciouschange:set(preciouschange) end
local function secsoundm(self,soundm) self.inst.secsoundm:set(soundm) end

-- local function secunlocklist(self, unlocklist) self.inst.secunlocklist:set(unlocklist) end
local function secunlocklist(self, unlocklist)
    if unlocklist then
        if type(unlocklist) == "string" then
            self.inst.secunlocklist:set(unlocklist)
        elseif type(unlocklist) == "table" then
            local s = ""
            for item, _ in pairs(unlocklist) do
                s = s .. item .. ","
            end
            self.inst.secunlocklist:set(s)
        end
    else
        self.inst.secunlocklist:set("")
    end
end

local function init_unlocklist()
    local unlocklist = {}
    -- 开局解锁珍珠
    if TUNING.unlock_hermit_pearl then unlocklist["hermit_pearl"] = 1 end

    -- 开局解锁天体宝球
    if TUNING.unlock_moonrockseed then unlocklist["moonrockseed"] = 1 end

    -- 开局解锁三基佬草图
    if TUNING.unlock_chesspiece_sketch then
        unlocklist["chesspiece_rook_sketch"] = 1
        unlocklist["chesspiece_bishop_sketch"] = 1
        unlocklist["chesspiece_knight_sketch"] = 1
    end

    return unlocklist
end

local seplayerstatus = Class(function(self, inst)
    self.inst = inst
    self.coin = TUNING.INITIALCOIN  -- 初始金币数
    self.exp = 0                    -- 经验值
    self.level = 1                  -- 等级
    self.vip = 0                    -- VIP等级
    self.discount = (1-self.level*5/100)^self.vip  -- 折扣计算
    self.slist = {}                 -- 物品列表
    self.unlocklist = init_unlocklist()            -- 获取过的物品物品列表
    self.precious = {}              -- 珍贵物品列表
    self:preciousbuild()            -- 初始化珍贵物品
    self.alreadyspawn = false       -- 是否已生成初始物品
    self.preciouschange = false     -- 珍贵物品是否改变
    self.soundm = false             -- 音效开关
    self.day = 0                    -- 天数计数

end,
nil,
{
    -- 注册属性setter
	coin = seccoin,
	exp = secexp,
	level = seclevel,
	vip = secvip,
	unlocklist = secunlocklist,
	precious = secprecious,
	preciouschange = secpreciouschange,
	soundm = secsoundm,
})

-- 获取随机物品编号，确保不重复
function seplayerstatus:numget()
	local num = math.random(#TUNING.selist_precious)
	local check = false
    for i=1, #self.slist do
    	if num == self.slist[i] then
    		check = true
		end
	end
	if check == true then
		return self:numget()
	else
		return num
	end
end

-- 构建珍贵物品列表
function seplayerstatus:preciousbuild()
	self.slist = {}
    -- 根据等级增加物品数量
	for i=1, 10+4*self.level do
		if i == 1 then
			table.insert(self.slist, 1)
		else
	    	table.insert(self.slist, self:numget())
	    end
	end
	self.precious = self.slist
end

-- 将玩家数据同步到世界
function seplayerstatus:SendDataToTheWorld()
    if not TheWorld.ismastersim then return end
    if TheWorld and TheWorld.components.seworldstatus then
        local data = {
            coin = self.coin,
            exp = self.exp,
            level = self.level,
            alreadyspawn = self.alreadyspawn,
            precious = self.precious,
            unlocklist = self.unlocklist,
            day = self.day,
        }
        TheWorld.components.seworldstatus.playerdata[self.inst.userid] = data
    end
end

-- 保存数据
function seplayerstatus:OnSave()
    local function get_str(tbl)
        local str = ""
        for k, v in pairs(self.unlocklist) do
            if v then
                str = str .. k .. ","
            end
        end
        return str
    end
    local data = {
        coin = self.coin,
        exp = self.exp,
        level = self.level,
        alreadyspawn = self.alreadyspawn,
        precious = self.precious,
        day = self.day,
        -- unlocklist = self.unlocklist,
        unlocklist = get_str(self.unlocklist),
    }
    return data
end

-- 加载数据
function seplayerstatus:OnLoad(data)
    self.coin = data.coin or 0
    self.exp = data.exp or 0
    self.level = data.level or 0
    self.alreadyspawn = data.alreadyspawn or false
    if data.precious and #data.precious ~= 0 then
        self.precious = data.precious
	else
        self:preciousbuild()
    end
    self.day = data.day or 0

    -- self.unlocklist = data.unlocklist or {}
    self.unlocklist = init_unlocklist()
    if data.unlocklist then
        if type(data.unlocklist) == "string" then
            for item in string.gmatch(data.unlocklist, "([^,]+)") do
                self.unlocklist[item] = 1
            end
        elseif type(data.unlocklist) == "table" then
            for item, _ in pairs(data.unlocklist) do
                self.unlocklist[item] = 1
            end
        end
    end
end

-- 处理金币变化
function seplayerstatus:DoDeltaCoin(amount, multi)
    if not multi then multi = 1 end
	if amount < 0 then
        -- 计算折扣
        local discount = self.discount
        if TUNING.discount_new then
            discount = 1
        end
		self.coin = self.coin - math.ceil(-amount*discount)*multi
	else
		self.coin = self.coin + amount
		self.inst.components.talker:Say(STRINGS.SIMPLEECONOMY[9]..amount..STRINGS.SIMPLEECONOMY[18])
	end
    -- 设置金币上限
	if self.coin >= 99999999 then self.coin = 99999999 end
	self.inst:PushEvent("SEDoDeltaCoin")

    -- 切换音效状态
    if self.soundm == false then
        self.soundm = true
    else
        self.soundm = false
    end

    --判断是否需要增加经验
    if not TUNING.discount_new then
	self:DoDeltaExp(math.abs(amount)*multi)
    end
    --判断折扣以及取消折扣，这部分写的不好，暂时先这样吧。-太
    if TUNING.discount_new then
        if TUNING.discount_new == 1 then
            TUNING.discount_new = nil
        else
            TheWorld:DoTaskInTime(5, function()
                TUNING.discount_new = nil
            end)
        end
    end

end

-- 处理经验值变化
function seplayerstatus:DoDeltaExp(amount)
	if self.level < 5 then
		self.exp = self.exp + amount
		self.inst:PushEvent("SEDoDeltaExp")
        -- 检查是否升级
		if self.exp >= (self.level+1)^3*1000 then
			local a = self.exp-(self.level+1)^3*1000
			self.exp = 0
			self.level = self.level + 1
			self.inst:PushEvent("SELevelUp")
            -- 播放升级音效和提示
			self.inst:DoTaskInTime(1, function()
				self.inst.SoundEmitter:PlaySound("dontstarve/characters/wx78/levelup")
				self.inst.components.talker:Say(STRINGS.SIMPLEECONOMY[13])
			end)
			self:OnVIP(self.vip)
			self:DoDeltaExp(a)
		end
	else
		self.exp = 125000  -- 最高等级经验值上限
	end
    self:SendDataToTheWorld()
end

-- 处理VIP状态
function seplayerstatus:OnVIP(value)
	self.vip = value
	self.discount = (1-self.level*5/100)^self.vip
end

-- 查找玩家背包中的所有物品
local function findinventory(owner)
    local item = {}
    if owner.components.inventory then
        -- 检查普通物品栏
        for k_i, v_i in pairs(owner.components.inventory.itemslots) do
            if v_i then table.insert(item, v_i) end
        end
        -- 检查装备栏
        for k_e, v_e in pairs(owner.components.inventory.equipslots) do
            if v_e then table.insert(item, v_e) end
        end
        -- 检查手持物品
        if owner.components.inventory.activeitem then
            table.insert(item, owner.components.inventory.activeitem)
        end
    elseif owner.components.container then
        -- 检查容器
        for k_x, v_x in pairs(owner.components.container.slots) do
            if v_x then table.insert(item, v_x) end
        end
    end
    -- 递归检查容器内的容器
    for k_a, v_a in pairs(item) do
        if v_a and v_a.components and v_a.components.container then
            for k_c, v_c in pairs(findinventory(v_a)) do
                if v_c then table.insert(item, v_c) end
            end
        end
    end
    return item
end

-- 查找VIP卡 如果没有则返回卡
local function findcard(owner)
    local cards = {}
    if not owner then return end
    for k,v in pairs(findinventory(owner)) do
        if v and v.prefab == "vipcard" then
            table.insert(cards, v)
        end
    end
    return cards
end

-- 检查VIP状态
function seplayerstatus:checkvip(data)
    local cards = findcard(self.inst)
    self:OnVIP(#cards ~= 0 and 1 or 0)
---@diagnostic disable-next-line: param-type-mismatch
    -- 更新VIP卡使用次数
    for k,v in pairs(cards) do
    	if v then
    		v.components.finiteuses:SetUses(self.level*5)
    	end
    end
end

-- 给予金币
function seplayerstatus:givesecoin(secoin)
	local price = 0
	if secoin ~= nil then
		price = secoin.components.secoin.amount
        -- 创建金币飞向玩家的动画效果
        local x1,y1,z1 = self.inst.Transform:GetWorldPosition()
        local x0,y0,z0 = secoin.Transform:GetWorldPosition()
        local x,y,z = Vector3(0,0,0)
        local maxtime = 5
        for i=1, maxtime do
        	self.inst:DoTaskInTime(FRAMES*i, function()
        		if secoin == nil or secoin:IsValid() == nil then return end
        		x1,y1,z1 = self.inst.Transform:GetWorldPosition()
        		x0,y0,z0 = secoin.Transform:GetWorldPosition()
                if x0 == nil then return end
        		x = x1 - x0
        		y = y1 - y0
        		z = z1 - z0
        		secoin.Transform:SetPosition(x/(maxtime-i)+x0,y/(maxtime-i)+y0,z/(maxtime-i)+z0)
        		if i == maxtime then
					self:DoDeltaCoin(price)
                    if secoin then
            			secoin:Remove()
                    end
        		end
    		end)
        end
	end
end

-- 礼物包装封装函数
local function WrapperGift(resources)
    -- local resources = {
    --     {prefab = "cutgrass", count = 40},    -- 草
    --     {prefab = "twigs", count = 40},       -- 树枝
    -- }
    
    -- 先创建gift
    local gift = SpawnPrefab("gift")
    if not gift then return end
    
    -- 创建临时容器
    local temp_container = SpawnPrefab("bundle_container")
    if not temp_container then 
        gift:Remove()
        return 
    end
    
    -- 收集物品
    local items = {}
    for _, resource in ipairs(resources) do
        -- 生成指定实体并进行堆叠
        local item = SpawnPrefab(resource.prefab)
        if item then
            if item.components.stackable then
                item.components.stackable:SetStackSize(resource.count)
            end
            table.insert(items, item)
        end
    end
    
    -- 将物品打包到gift中
    if gift.components.unwrappable then
        gift.components.unwrappable:WrapItems(items)
    end
    
    temp_container:Remove()
    return gift
end

-- 初始化玩家状态
function seplayerstatus:Init(inst)
    -- 延迟3秒后给予初始物品
    inst:DoTaskInTime(3, function()
        if inst.components.seplayerstatus.alreadyspawn ~= true then
            inst.components.seplayerstatus.alreadyspawn = true
            self:SendDataToTheWorld()
            -- 给予金杖
            if TUNING.allowgoldstaff and TUNING.givegoldstaff then
                local item = SpawnPrefab("goldstaff")
                inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
                inst.components.talker:Say(STRINGS.SIMPLEECONOMY[1])
            end
            -- 给予幸运护符
            if TUNING.giveluckamulet then
                local item = SpawnPrefab("luckamulet")
                inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
                inst.components.talker:Say(STRINGS.SIMPLEECONOMY[1])
            end
            
            -- 定义等待时间，为了等待人物把话说完
            local wait_time = 0
            if TUNING.generate_ft and TUNING.ft_prefab_name then
                wait_time = wait_time + 2
                inst:DoTaskInTime(wait_time, function()
                    -- 如果打开了传送金塔的生成，则给予建造蓝图
                    local item = SpawnPrefab(TUNING.ft_prefab_name.."_blueprint")
                    inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
                    if TUNING.ft_prefab_name == "townportal" then
                        local item = SpawnPrefab("townportaltalisman")
                        inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
                    end
                end)
            end

            if TUNING.givebase_resources then
                wait_time = wait_time + 2
                inst:DoTaskInTime(wait_time, function()
                    -- 给予基础资源物资包：草*40 树枝*40 木头*40
                    local base_resources = {
                        {prefab = "cutgrass", count = 40},    -- 草
                        {prefab = "twigs", count = 40},       -- 树枝
                        {prefab = "log", count = 20},         -- 木头
                        {prefab = "log", count = 20},         -- 木头
                    }
                    local gift = WrapperGift(base_resources)
                    inst.components.inventory:GiveItem(gift, nil, inst:GetPosition())
                    inst.components.talker:Say(STRINGS.STARTPACKAGE[1])
                end)
            end

            
            if TUNING.giverocks_resources then
                wait_time = wait_time + 2
                inst:DoTaskInTime(wait_time, function()
                    -- 给予石头资源物资包：石头*40 燧石*20 硝石*20 金块*20
                    local rocks_resources = {
                        {prefab = "rocks", count = 40},       -- 石头
                        {prefab = "flint", count = 40},       -- 燧石
                        {prefab = "nitre", count = 20},       -- 硝石
                        {prefab = "goldnugget", count = 20},  -- 金块
                    }
                    local gift = WrapperGift(rocks_resources)
                    inst.components.inventory:GiveItem(gift, nil, inst:GetPosition())
                    inst.components.talker:Say(STRINGS.STARTPACKAGE[2])
                end)
            end
            
            if TUNING.givefight_resources then
                wait_time = wait_time + 2
                inst:DoTaskInTime(wait_time, function()
                    -- 给予战斗物资包：战斗长矛*1 战斗头盔*1 木甲*1 治疗药膏*3
                    local fight_resources = {
                        {prefab = "spear_wathgrithr", count = 1},       -- 战斗长矛
                        {prefab = "wathgrithrhat", count = 1},          -- 战斗头盔
                        {prefab = "armorwood", count = 1},              -- 木甲
                        {prefab = "healingsalve", count = 3},           -- 治疗药膏
                    }
                    local gift = WrapperGift(fight_resources)
                    inst.components.inventory:GiveItem(gift, nil, inst:GetPosition())
                    inst.components.talker:Say(STRINGS.STARTPACKAGE[3])
                end)
            end
            
            -- 给予勋章物资包，包含勋章盒 巧手考验勋章 初级伐木勋章 初级矿工勋章 暗影魔法工具
            if TUNING.FUNCTIONAL_MEDAL_IS_OPEN and TUNING.givemedal_resources then
                wait_time = wait_time + 2
                inst:DoTaskInTime(wait_time, function()
                    local medal_resources = {
                        {prefab = "medal_box", count = 1},              -- 勋章盒
                        {prefab = "handy_test_certificate", count = 1}, -- 巧手考验勋章
                        {prefab = "smallchop_certificate", count = 1},  -- 初级伐木勋章
                        {prefab = "smallminer_certificate", count = 1}, -- 初级矿工勋章
                    }
                    local gift = WrapperGift(medal_resources)
                    inst.components.inventory:GiveItem(gift, nil, inst:GetPosition())

                    local item = SpawnPrefab("medal_shadow_tool")
                    inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
                    inst.components.talker:Say(STRINGS.STARTPACKAGE[4])
                end)
            end
            
        end
    end)
    

    -- 监听天数变化
    inst:ListenForEvent("cycleschanged", function()
    	self.day = self.day + 1
    	if self.day >= 3 then
    		self.day = 0
	    	self:preciousbuild()
	    	if self.preciouschange == true then
	    		self.preciouschange = false
	    	else
	    		self.preciouschange = true
	    	end
	    end
        self:SendDataToTheWorld()
	end, TheWorld)

	--监听身上vip卡变化
    local checkvipfn = function(_, data)
        self:checkvip(data)
    end
	inst:ListenForEvent("SELevelUp", checkvipfn)
    inst:ListenForEvent("equip", checkvipfn)
    inst:ListenForEvent("unequip", checkvipfn)

    -- 监听获取物品进行解锁
    local function isin_table(tbl, element)
        -- 检查元素是否已存在于表中
        for _, existing_element in ipairs(tbl) do
            if existing_element == element then
                return true
            end
        end
        return false
    end
    local unlockitemfn = function(_, data)
        local item_name = data.item.prefab
        -- print("当前监听到人物获取到某个物品，物品名称为--"..item_name)
        self.unlocklist[item_name] = 1
        self.unlocklist = self.unlocklist  -- 触发 setter 更新
    end
    inst:ListenForEvent("itemget", unlockitemfn)
    inst:ListenForEvent("equip", unlockitemfn)
end

return seplayerstatus