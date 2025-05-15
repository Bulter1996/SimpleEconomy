---@diagnostic disable: need-check-nil
local UIAnim = require "widgets/uianim"
local Text = require "widgets/text"
local Widget = require "widgets/widget"
local Image = require "widgets/image"
local ImageButton = require "widgets/imagebutton"
local AnimButton = require "widgets/animbutton"
local HoverText = require "widgets/hoverer"
local ItemSlot = require "widgets/itemslot"


--保存客户端坐标信息至客户端游戏目录
local function coordinates(str)
	local coordfilepath = "unsafedata/SimpleEconomycoord.json"
	local coordfile = io.open(coordfilepath, "w")
	if coordfile then
		local coordstring = json.encode(str)
		coordfile:write(coordstring)
		coordfile:close()
	end
end

--获取屏幕分辨率
local screen_width, screen_height = TheSim:GetScreenSize()
--读取客户端游戏目录文件的客户端坐标信息并返回坐标信息
local function readcoordinates()
	local coordfilepath = "unsafedata/SimpleEconomycoord.json"
	local coordfile = io.open(coordfilepath, "r")
	if coordfile then
		local coordstring = coordfile:read()
		coordfile:close()
		if coordstring then
			local decoded = json.decode(coordstring)
			if decoded and decoded.x and decoded.y and decoded.z then
				return decoded.x, decoded.y, decoded.z
			end
		end
	end
	if screen_width and screen_height then
		return -screen_width / 3, screen_height / 3, 0
	else
		return 0, 0, 0
	end
end

--ui跟随鼠标移动，参考了呼吸的mod
local function FollowMouseForUI(UI, func_stop)
	UI.FollowMouse = function(self)
		if self.followhandler == nil then
			local cur_pos = TheInput:GetScreenPosition()
			local scale = 1 / UI.parent:GetLooseScale()
			local ori_pos = self:GetPosition()
			self.followhandler = TheInput:AddMoveHandler(function(x, y)
				self:SetPosition((Vector3(x, y, 0) - cur_pos) * scale + ori_pos)
			end)
		end
	end
	local _OnMouseButton = UI.OnMouseButton
	UI.OnMouseButton = function(ui, press, down, ...)
		local result = _OnMouseButton(ui, press, down, ...)
		if press == MOUSEBUTTON_RIGHT then
			if down then
				return ui:FollowMouse()
			elseif type(func_stop) == "function" then
				func_stop(ui:GetPosition())
			end
		end
		ui:StopFollowMouse()
		return result
	end
end

local xse, yse, zse = readcoordinates()

--此函数由LuneFox提供，优化了冗长的价格计算显示。
local function printNumber(position, num, max)
	local str_num = string.format("%0" .. max .. "d", num)
	local first = false
	for i = 1, #str_num do
		local v = tonumber(str_num:sub(i, i))
		if position['num' .. i] then
			if v <= 0 and first == false then
				position['num' .. i]:Hide()
			else
				if first == false then
					first = true
				end
				position['num' .. i]:SetTexture("images/sehud/numbers/" .. v .. ".xml", v .. ".tex")
			end
		end
	end
end

-- 修改辅助函数来转换键值
local function exchangekv(tablekv)
	local tablevk = {}
	for k,v in pairs(tablekv) do
		tablevk[v] = k
	end
	return tablevk
end

-- 修改辅助函数来转换键值
local function string2table(s)
	local t = {}
	for item in string.gmatch(s, "([^,]+)") do
		t[item] = 1
	end
	return t
end

local uiseconomy = Class(Widget, function(self, owner)
	Widget._ctor(self, "uiseconomy")
	self.owner = owner
	self.numpage = 1
	self.mainui = self:AddChild(Widget("mainui"))
	self.mainui:SetScale(.75, .75, 1)
	self.mainui:SetPosition(0, 20, 0)
	self.mainui:Hide()

	self.mainui.bg = self.mainui:AddChild(Image("images/sehud/bg.xml", "bg.tex"))
	self.mainui.bg:SetTint(1, 1, 1, 0.95)
	self.mainui.bg:SetPosition(0, 45, 0)

	self.mainui.bg.title = self.mainui.bg:AddChild(Image("images/sehud/title_food.xml", "title_food.tex"))
	self.mainui.bg.title:SetPosition(0, 246, 0)

	self.mainui.status = self.mainui:AddChild(Widget("status"))
	self.mainui.status.bg = self.mainui.status:AddChild(Image("images/sehud/status_" .. TUNING.SElan .. ".xml",
		"status_" .. TUNING.SElan .. ".tex"))
	self.mainui.status:SetPosition(410, 25, 0)

	self.mainui.status.coinamount = self.mainui.status:AddChild(Widget("coinamount"))
	self.mainui.status.coinamount:SetPosition(-110, 159, 0)
	self.mainui.status.coinamount:SetScale(1, 1, 1)

	self.mainui.status.coinamount.num = {}
	for i = 1, 8 do
		self.mainui.status.coinamount.num[i] = self.mainui.status.coinamount:AddChild(Image("images/sehud/bignums/0.xml",
			"0.tex"))
		self.mainui.status.coinamount.num[i]:SetPosition(i * 17, 0, 0)
	end
	self:displaycoinamount(self.mainui.status.coinamount.num)

	self.mainui.status.level = {}
	for i = 1, 5 do
		self.mainui.status.level[i] = self.mainui.status:AddChild(Image("images/sehud/level_dact.xml", "level_dact.tex"))
		self.mainui.status.level[i]:SetPosition(-130 + (i - 1) * 23, 87, 0)
	end

	self.mainui.status.vipinfo = self.mainui.status:AddChild(Image("images/sehud/vip0.xml", "vip0.tex"))
	self.mainui.status.vipinfo:SetPosition(0, 66, 0)

	self.mainui.status.swdjinfo = self.mainui.status:AddChild(Image("images/sehud/swdj_" .. TUNING.SElan .. "1.xml",
		"swdj_" .. TUNING.SElan .. "1.tex"))
	self.mainui.status.swdjinfo:SetPosition(0, 66, 0)

	self.mainui.status.exp = self.mainui.status:AddChild(Image("images/sehud/exp_dact.xml", "exp_dact.tex"))
	self.mainui.status.exp:SetPosition(-115, 64, 0)
	self.mainui.status.exp:SetClickable(false)

	self.mainui.status.expact = self.mainui.status:AddChild(Image("images/sehud/exp_act.xml", "exp_act.tex"))
	self.mainui.status.expact:SetPosition(self.mainui.status.exp:GetPosition().x, self.mainui.status.exp:GetPosition().y,
		0)
	self.mainui.status.expact:SetClickable(false)

	self.mainui.status.expmask = self.mainui.status:AddChild(Image("images/sehud/expmask.xml", "expmask.tex"))
	self.mainui.status.expmask:SetPosition(0, 64, 0)
	self.mainui.status.expmask:SetTint(1, 1, 1, 0)
	--self.mainui.status.expmask:SetHoverText(self.owner.secexp:value().."/"..(self.owner.seclevel:value()+1)^3*1000)

	self.mainui.status.specialitem = self.mainui.status:AddChild(Widget("specialitem"))
	self.mainui.status.specialitem:SetPosition(0, -84, 0)
	self.spitemslot = {}
	self:spitembuild(73)



	self.mainbutton = self:AddChild(ImageButton("images/sehud/mainbutton.xml", "mainbutton.tex"))
	self.mainbutton:SetPosition(xse, yse, 0)
	self.mainbutton:SetNormalScale(1, 1, 1)
	self.mainbutton:SetFocusScale(1, 1, 1)
	self.mainbutton:SetHoverText(STRINGS.SIMPLEECONOMY[2])
	self.mainbutton:SetOnGainFocus(function()
		self.mainbutton:ScaleTo(1, 1.15, .125)
		self.mainbutton.new.middle = -15
	end)
	self.mainbutton:SetOnLoseFocus(function()
		self.mainbutton:ScaleTo(1.15, 1, .25)
		self.mainbutton.new.middle = 15
	end)
	self.cooldown = true
	FollowMouseForUI(self.mainbutton, coordinates)
	self.mainbutton:SetOnClick(function()
		if TheInput:IsKeyDown(KEY_CTRL) then
			if self.cooldown then
				if TheInput:IsKeyDown(KEY_SHIFT) then
					TheNet:Say(
						STRINGS.LMB ..
						STRINGS.SIMPLEECONOMY[14] .. self.owner.seccoin:value() .. STRINGS.SIMPLEECONOMY[15],
						true)
				else
					TheNet:Say(
						STRINGS.LMB ..
						STRINGS.SIMPLEECONOMY[16] .. self.owner.seccoin:value() .. STRINGS.SIMPLEECONOMY[17],
						false)
				end
				self.cooldown = false
				self.owner:DoTaskInTime(5, function() self.cooldown = true end)
			end
		else
			if self.mainui.shown then
				self:onclose()
			else
				if TUNING.UPDATELIST then
					SendModRPCToServer(MOD_RPC["SimpleEconomy"]["updatelist"])
				end
				self:onopen()
			end
		end
	end)
	self.mainbutton.coinamount = self.mainbutton:AddChild(Widget("coinamount"))
	self.mainbutton.coinamount:SetPosition(-50, -40, 0)
	self.mainbutton.coinamount:SetScale(.8, .8, 1)
	self.mainbutton.coinamount:SetClickable(false)
	self.mainbutton.coinamount.icon = self.mainbutton.coinamount:AddChild(Image("images/sehud/hudcoin.xml", "hudcoin.tex"))
	self.mainbutton.coinamount.icon:SetPosition(-5, 0, 0)
	self.mainbutton.coinamount.icon:SetScale(.2, .2, 1)

	self.mainbutton.coinamount.num = {}
	for i = 1, 8 do
		self.mainbutton.coinamount.num[i] = self.mainbutton.coinamount:AddChild(Image("images/sehud/bignums/0.xml",
			"0.tex"))
		self.mainbutton.coinamount.num[i]:SetPosition(i * 17, 0, 0)
	end
	self:displaycoinamount(self.mainbutton.coinamount.num)

	self.mainbutton.new = self.mainbutton:AddChild(Image("images/sehud/new.xml", "new.tex"))
	self.mainbutton.new.middle = 15
	self.mainbutton.new:SetPosition(15, self.mainbutton.new.middle, 0)
	self.mainbutton.new:SetClickable(false)
	self.mainbuttonnewmove = true
	self.owner:DoPeriodicTask(.25, function()
		if self.mainbuttonnewmove == true then
			self.mainbutton.new:MoveTo(Vector3(15, self.mainbutton.new.middle - 2, 0),
				Vector3(15, self.mainbutton.new.middle + 2, 0), .25)
			self.mainbuttonnewmove = false
		else
			self.mainbutton.new:MoveTo(Vector3(15, self.mainbutton.new.middle + 2, 0),
				Vector3(15, self.mainbutton.new.middle - 2, 0), .25)
			self.mainbuttonnewmove = true
		end
	end)

	self.mainui.goodslist = self.mainui:AddChild(Widget("goodslist"))
	self.mainui.goodslist:SetPosition(-530, 190, 0)
	self.mainui.goodslist:SetScale(.99, .99, 1)
	self.listslot = {}
	self:buildlist("food")
	self.title = "food"

	self.mainui.buttonfood = self.mainui:AddChild(ImageButton("images/sehud/food_act_" .. TUNING.SElan .. ".xml",
		"food_act_" .. TUNING.SElan .. ".tex"))
	self.mainui.buttonfood:SetPosition(-530, -315, 0)
	self.mainui.buttonfood:SetNormalScale(1, 1, 1)
	self.mainui.buttonfood:SetFocusScale(1, 1, 1)
	self.mainui.buttonfood:SetOnGainFocus(function() self.mainui.buttonfood:ScaleTo(1, 1.15, .125) end)
	self.mainui.buttonfood:SetOnLoseFocus(function() self.mainui.buttonfood:ScaleTo(1.15, 1, .25) end)
	self.mainui.buttonfood:SetOnClick(function()
		self.numpage = 1
		self:buildbutton("food")
	end)

	self.mainui.buttonfood.uplow = self.mainui.buttonfood:AddChild(Image("images/sehud/up.xml", "up.tex"))
	self.mainui.buttonfood.uplow:SetPosition(20, 20, 0)
	self.mainui.buttonfood.uplow:SetClickable(false)
	self.mainui.buttonfood.uplow:Hide()
	self.buttonfoodmove = true
	self.owner:DoPeriodicTask(.25, function()
		if self.buttonfoodmove == true then
			self.mainui.buttonfood.uplow:MoveTo(Vector3(20, 20 - 2, 0), Vector3(20, 20 + 2, 0), .25)
			self.buttonfoodmove = false
		else
			self.mainui.buttonfood.uplow:MoveTo(Vector3(20, 20 + 2, 0), Vector3(20, 20 - 2, 0), .25)
			self.buttonfoodmove = true
		end
	end)

	self.mainui.buttoncloth = self.mainui:AddChild(ImageButton("images/sehud/cloth_dact_" .. TUNING.SElan .. ".xml",
		"cloth_dact_" .. TUNING.SElan .. ".tex"))
	self.mainui.buttoncloth:SetPosition(-440, -315, 0)
	self.mainui.buttoncloth:SetNormalScale(1, 1, 1)
	self.mainui.buttoncloth:SetFocusScale(1, 1, 1)
	self.mainui.buttoncloth:SetOnGainFocus(function() self.mainui.buttoncloth:ScaleTo(1, 1.15, .125) end)
	self.mainui.buttoncloth:SetOnLoseFocus(function() self.mainui.buttoncloth:ScaleTo(1.15, 1, .25) end)
	self.mainui.buttoncloth:SetOnClick(function()
		self.numpage = 1
		self:buildbutton("cloth")
	end)

	self.mainui.buttoncloth.uplow = self.mainui.buttoncloth:AddChild(Image("images/sehud/up.xml", "up.tex"))
	self.mainui.buttoncloth.uplow:SetPosition(20, 20, 0)
	self.mainui.buttoncloth.uplow:SetClickable(false)
	self.mainui.buttoncloth.uplow:Hide()
	self.buttonclothmove = true
	self.owner:DoPeriodicTask(.25, function()
		if self.buttonclothmove == true then
			self.mainui.buttoncloth.uplow:MoveTo(Vector3(20, 20 - 2, 0), Vector3(20, 20 + 2, 0), .25)
			self.buttonclothmove = false
		else
			self.mainui.buttoncloth.uplow:MoveTo(Vector3(20, 20 + 2, 0), Vector3(20, 20 - 2, 0), .25)
			self.buttonclothmove = true
		end
	end)

	self.mainui.buttonsmithing = self.mainui:AddChild(ImageButton(
		"images/sehud/smithing_dact_" .. TUNING.SElan .. ".xml",
		"smithing_dact_" .. TUNING.SElan .. ".tex"))
	self.mainui.buttonsmithing:SetPosition(-350, -315, 0)
	self.mainui.buttonsmithing:SetNormalScale(1, 1, 1)
	self.mainui.buttonsmithing:SetFocusScale(1, 1, 1)
	self.mainui.buttonsmithing:SetOnGainFocus(function() self.mainui.buttonsmithing:ScaleTo(1, 1.15, .125) end)
	self.mainui.buttonsmithing:SetOnLoseFocus(function() self.mainui.buttonsmithing:ScaleTo(1.15, 1, .25) end)
	self.mainui.buttonsmithing:SetOnClick(function()
		self.numpage = 1
		self:buildbutton("smithing")
	end)

	self.mainui.buttonsmithing.uplow = self.mainui.buttonsmithing:AddChild(Image("images/sehud/up.xml", "up.tex"))
	self.mainui.buttonsmithing.uplow:SetPosition(20, 20, 0)
	self.mainui.buttonsmithing.uplow:SetClickable(false)
	self.mainui.buttonsmithing.uplow:Hide()
	self.buttonsmithingmove = true
	self.owner:DoPeriodicTask(.25, function()
		if self.buttonsmithingmove == true then
			self.mainui.buttonsmithing.uplow:MoveTo(Vector3(20, 20 - 2, 0), Vector3(20, 20 + 2, 0), .25)
			self.buttonsmithingmove = false
		else
			self.mainui.buttonsmithing.uplow:MoveTo(Vector3(20, 20 + 2, 0), Vector3(20, 20 - 2, 0), .25)
			self.buttonsmithingmove = true
		end
	end)

	self.mainui.buttonresource = self.mainui:AddChild(ImageButton(
		"images/sehud/resource_dact_" .. TUNING.SElan .. ".xml",
		"resource_dact_" .. TUNING.SElan .. ".tex"))
	self.mainui.buttonresource:SetPosition(-260, -315, 0)
	self.mainui.buttonresource:SetNormalScale(1, 1, 1)
	self.mainui.buttonresource:SetFocusScale(1, 1, 1)
	self.mainui.buttonresource:SetOnGainFocus(function() self.mainui.buttonresource:ScaleTo(1, 1.15, .125) end)
	self.mainui.buttonresource:SetOnLoseFocus(function() self.mainui.buttonresource:ScaleTo(1.15, 1, .25) end)
	self.mainui.buttonresource:SetOnClick(function()
		self.numpage = 1
		self:buildbutton("resource")
	end)

	self.mainui.buttonresource.uplow = self.mainui.buttonresource:AddChild(Image("images/sehud/up.xml", "up.tex"))
	self.mainui.buttonresource.uplow:SetPosition(20, 20, 0)
	self.mainui.buttonresource.uplow:SetClickable(false)
	self.mainui.buttonresource.uplow:Hide()
	self.buttonresourcemove = true
	self.owner:DoPeriodicTask(.25, function()
		if self.buttonresourcemove == true then
			self.mainui.buttonresource.uplow:MoveTo(Vector3(20, 20 - 2, 0), Vector3(20, 20 + 2, 0), .25)
			self.buttonresourcemove = false
		else
			self.mainui.buttonresource.uplow:MoveTo(Vector3(20, 20 + 2, 0), Vector3(20, 20 - 2, 0), .25)
			self.buttonresourcemove = true
		end
	end)

	self.mainui.buttonprecious = self.mainui:AddChild(ImageButton(
		"images/sehud/precious_dact_" .. TUNING.SElan .. ".xml",
		"precious_dact_" .. TUNING.SElan .. ".tex"))
	self.mainui.buttonprecious:SetPosition(-170, -315, 0)
	self.mainui.buttonprecious:SetNormalScale(1, 1, 1)
	self.mainui.buttonprecious:SetFocusScale(1, 1, 1)
	self.mainui.buttonprecious:SetOnGainFocus(function() self.mainui.buttonprecious:ScaleTo(1, 1.15, .125) end)
	self.mainui.buttonprecious:SetOnLoseFocus(function() self.mainui.buttonprecious:ScaleTo(1.15, 1, .25) end)
	self.mainui.buttonprecious:SetOnClick(function()
		self.numpage = 1
		self:buildbutton("precious")
	end)

	self.mainui.buttonprecious.new = self.mainui.buttonprecious:AddChild(Image("images/sehud/new.xml", "new.tex"))
	self.mainui.buttonprecious.new:SetPosition(20, 20, 0)
	self.mainui.buttonprecious.new:SetClickable(false)
	self.mainui.buttonprecious.new:Hide()
	self.preciousnewmove = true
	self.owner:DoPeriodicTask(.25, function()
		if self.preciousnewmove == true then
			self.mainui.buttonprecious.new:MoveTo(Vector3(20, 20 - 2, 0), Vector3(20, 20 + 2, 0), .25)
			self.preciousnewmove = false
		else
			self.mainui.buttonprecious.new:MoveTo(Vector3(20, 20 + 2, 0), Vector3(20, 20 - 2, 0), .25)
			self.preciousnewmove = true
		end
	end)

	self.mainui.refresh = self.mainui:AddChild(ImageButton("images/sehud/refresh.xml", "refresh.tex")) --刷新按钮
	self.mainui.refresh:SetPosition(30, -315, 0)
	self.mainui.refresh:SetNormalScale(1, 1, 1)
	self.mainui.refresh:SetFocusScale(1, 1, 1)
	self.mainui.refresh:SetHoverText(STRINGS.SIMPLEECONOMY[23])
	self.mainui.refresh:SetOnGainFocus(function() self.mainui.refresh:ScaleTo(1, 1.15, .125) end)
	self.mainui.refresh:SetOnLoseFocus(function() self.mainui.refresh:ScaleTo(1.15, 1, .25) end)
	self.mainui.refresh:Hide()
	self.mainui.refresh:SetOnClick(function()
		self:onrefresh()
	end)

	self.mainui.infopage = self.mainui:AddChild(Image("images/sehud/infopage_" .. TUNING.SElan .. ".xml",
		"infopage_" .. TUNING.SElan .. ".tex"))
	self.mainui.infopage:SetPosition(0, 0, 0)
	self.mainui.infopage:Hide()

	self.mainui.close = self.mainui:AddChild(ImageButton("images/sehud/close.xml", "close.tex"))
	self.mainui.close:SetPosition(-25, -315, 0)
	self.mainui.close:SetNormalScale(1, 1, 1)
	self.mainui.close:SetFocusScale(1, 1, 1)
	self.mainui.close:SetHoverText(STRINGS.SIMPLEECONOMY[5])
	self.mainui.close:SetOnGainFocus(function() self.mainui.close:ScaleTo(1, 1.15, .125) end)
	self.mainui.close:SetOnLoseFocus(function() self.mainui.close:ScaleTo(1.15, 1, .25) end)
	self.mainui.close:SetOnClick(function()
		self:onclose()
	end)

	self.mainui.infobutton = self.mainui:AddChild(ImageButton("images/sehud/infobutton.xml", "infobutton.tex"))
	self.mainui.infobutton:SetPosition(-80, -315, 0)
	self.mainui.infobutton:SetNormalScale(1, 1, 1)
	self.mainui.infobutton:SetFocusScale(1, 1, 1)
	self.mainui.infobutton:SetHoverText(STRINGS.SIMPLEECONOMY[3])
	self.mainui.infobutton:SetOnGainFocus(function() self.mainui.infobutton:ScaleTo(1, 1.15, .125) end)
	self.mainui.infobutton:SetOnLoseFocus(function() self.mainui.infobutton:ScaleTo(1.15, 1, .25) end)
	self.mainui.infobutton:SetOnClick(function()
		if self.mainui.infopage.shown then
			self.mainui.infobutton:SetTextures("images/sehud/infobutton.xml", "infobutton.tex")
			self.mainui.infobutton:SetHoverText(STRINGS.SIMPLEECONOMY[3])
			self.mainui.goodslist:Show()
			self.mainui.status:Show()
			self.mainui.next:Show()
			self.mainui.back:Show()
			self.mainui.infopage:Hide()
		else
			self.mainui.infobutton:SetTextures("images/sehud/infoback.xml", "infoback.tex")
			self.mainui.infobutton:SetHoverText(STRINGS.SIMPLEECONOMY[4])
			self.mainui.goodslist:Hide()
			self.mainui.status:Hide()
			self.mainui.next:Hide()
			self.mainui.back:Hide()
			self.mainui.infopage:Show()
		end
	end)

	self.mainui.next = self.mainui:AddChild(ImageButton("images/sehud/next.xml", "next.tex"))
	self.mainui.next:SetPosition(170, -200, 0)
	self.mainui.next:SetNormalScale(1, 1, 1)
	self.mainui.next:SetFocusScale(1, 1, 1)
	self.mainui.next:SetHoverText(STRINGS.SIMPLEECONOMY[6])
	self.mainui.next.image:SetTint(1, 1, 1, 1)
	self.mainui.next:SetOnGainFocus(function() self.mainui.next:ScaleTo(1, 1.15, .125) end)
	self.mainui.next:SetOnLoseFocus(function() self.mainui.next:ScaleTo(1.15, 1, .25) end)
	self.mainui.next:SetOnClick(function()
		if self.numpage < self.maxpage then
			self.numpage = self.numpage + 1
			self:buildlist(self.title)
			self.mainui.back.image:SetTint(1, 1, 1, 1)
			if self.numpage >= self.maxpage then
				self.mainui.next.image:SetTint(1, 1, 1, .5)
			end
		end
	end)

	self.mainui.back = self.mainui:AddChild(ImageButton("images/sehud/back.xml", "back.tex"))
	self.mainui.back:SetPosition(120, -200, 0)
	self.mainui.back:SetNormalScale(1, 1, 1)
	self.mainui.back:SetFocusScale(1, 1, 1)
	self.mainui.back:SetHoverText(STRINGS.SIMPLEECONOMY[7])
	self.mainui.back.image:SetTint(1, 1, 1, .5)
	self.mainui.back:SetOnGainFocus(function() self.mainui.back:ScaleTo(1, 1.15, .125) end)
	self.mainui.back:SetOnLoseFocus(function() self.mainui.back:ScaleTo(1.15, 1, .25) end)
	self.mainui.back:SetOnClick(function()
		if self.numpage > 1 then
			self.numpage = self.numpage - 1
			self:buildlist(self.title)
			self.mainui.next.image:SetTint(1, 1, 1, 1)
			if self.numpage <= 1 then
				self.mainui.back.image:SetTint(1, 1, 1, .5)
			end
		end
	end)

	-- 监听物品解锁事件
	-- self.owner:ListenForEvent("seitemunlocked", function()
	-- 	if self.mainui.shown then
	-- 		self:buildlist(self.title)
	-- 	end
	-- end)

	self.owner:DoTaskInTime(.2, function()
		self.vip = -1
		self.money = 0
		self.level = 0
		self.secpreciouschange = false
		self.seasonchange = false
		self.soundm = false
		self:uplowchange()
		self:StartUpdating()
	end)
end)

function uiseconomy:OnUpdate(dt)
	if self.money ~= self.owner.seccoin:value() then
		self:displaycoinamount(self.mainbutton.coinamount.num)
		self:displaycoinamount(self.mainui.status.coinamount.num)
		self.money = self.owner.seccoin:value()
	end
	if self.level ~= self.owner.seclevel:value() then
		for i = 1, 5 do
			if self.owner.seclevel:value() >= i then
				self.mainui.status.level[i]:SetTexture("images/sehud/level_act.xml", "level_act.tex")
			else
				self.mainui.status.level[i]:SetTexture("images/sehud/level_dact.xml", "level_dact.tex")
			end
		end
		self.mainui.status.swdjinfo:SetTexture("images/sehud/swdj_" .. TUNING.SElan ..
			self.owner.seclevel:value() .. ".xml", "swdj_" .. TUNING.SElan .. self.owner.seclevel:value() .. ".tex")
		self.level = self.owner.seclevel:value()
		self.mainui.status.vipinfo:SetTexture("images/sehud/vip" .. (self.owner.seclevel:value()) .. ".xml",
			"vip" .. (self.owner.seclevel:value()) .. ".tex")
		self:buildlist(self.title)
		self:spitembuild()
	end
	if self.vip ~= self.owner.secvip:value() then
		self.mainui.status.vipinfo:SetTexture("images/sehud/vip" .. (self.owner.seclevel:value()) .. ".xml",
			"vip" .. (self.owner.seclevel:value()) .. ".tex")
		self.vip = self.owner.secvip:value()
		self:buildlist(self.title)
		self:spitembuild()
	end
	-- 检查解锁状态变化
	-- if self.mainui.shown and TUNING.only_obtained then
	-- 	self:buildlist(self.title)
	-- end
	local currentexp = self.owner.secexp:value()
	local maxexp = (self.owner.seclevel:value() + 1) ^ 3 * 1000
	if self.owner.seclevel:value() >= 5 then maxexp = self.owner.seclevel:value() ^ 3 * 1000 end
	local percent = math.ceil(currentexp / maxexp * 100) / 100
	self.mainui.status.expact:SetScale(percent, 1, 1)
	self.mainui.status.expmask:SetHoverText(currentexp .. "/" .. maxexp)
	if self.secpreciouschange ~= self.owner.secpreciouschange:value() then
		if self.title == "precious" then
			self:buildlist(self.title)
		end
		if not TUNING.precious_sell then
			if not self.mainui.shown then
				self.mainbutton.new:Show()
				self.mainui.buttonprecious.new:Show()
			else
				self.mainui.buttonprecious.new:Show()
			end
		end
		self.secpreciouschange = self.owner.secpreciouschange:value()
	end
	if self.seasonchange ~= TUNING.SEseasonchange then
		self:uplowchange()
		self.seasonchange = TUNING.SEseasonchange
	end
	if self.soundm ~= self.owner.secsoundm:value() then
		--TheFocalPoint.SoundEmitter:PlaySound("dontstarve/HUD/research_available")
		TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/research_available")
		self.soundm = self.owner.secsoundm:value()
	end
end

function uiseconomy:uplowchange()
	if TUNING.SEASONALCHANGE then
		local buttonname = { "food", "cloth", "smithing", "resource" }
		for i = 1, #buttonname do
			local seasont = nil
			local buttont = nil
			if buttonname[i] == "food" then
				seasont = TUNING.seseasonfood
				buttont = self.mainui.buttonfood
			end
			if buttonname[i] == "cloth" then
				seasont = TUNING.seseasoncloth
				buttont = self.mainui.buttoncloth
			end
			if buttonname[i] == "smithing" then
				seasont = TUNING.seseasonsmithing
				buttont = self.mainui.buttonsmithing
			end
			if buttonname[i] == "resource" then
				seasont = TUNING.seseasonresource
				buttont = self.mainui.buttonresource
			end
			if seasont == 1 then
				buttont.uplow:Hide()
			end
			if seasont == .5 then
				buttont.uplow:Show()
				buttont.uplow:SetTexture("images/sehud/low.xml", "low.tex")
			end
			if seasont == 1.5 then
				buttont.uplow:Show()
				buttont.uplow:SetTexture("images/sehud/up.xml", "up.tex")
			end
		end
	end
	self:buildlist(self.title)
end

function uiseconomy:buildlist(title)
	local all_list = {}
	local discount = (1 - self.owner.seclevel:value() * 5 / 100) ^ self.owner.secvip:value()
	if title == "food" then all_list = TUNING.tabc and TUNING.tabc[1] or TUNING.selist_food end
	if title == "cloth" then all_list = TUNING.tabc and TUNING.tabc[2] or TUNING.selist_cloth end
	if title == "smithing" then all_list = TUNING.tabc and TUNING.tabc[3] or TUNING.selist_smithing end
	if title == "resource" then all_list = TUNING.tabc and TUNING.tabc[4] or TUNING.selist_resource end
	if title == "precious" then
		if TUNING.precious_sell then
			all_list = TUNING.tabc and TUNING.tabc[5] or TUNING.selist_precious
		else
			local secp = self.owner.secprecious:value()
			local seclevel_value = self.owner.seclevel:value()
			local numElementsToAdd = 10 + 4 * seclevel_value
			for i = 1, numElementsToAdd do
				table.insert(all_list, TUNING.tabc and TUNING.tabc[5][secp[i]] or TUNING.selist_precious[secp[i]])
			end
		end
	end

	local list = {}
	if TUNING.only_obtained then  -- 仅展示已获取的物品
		-- local secunlocl = exchangekv(self.owner.secunlocklist:value())
		local secunlocl = string2table(self.owner.secunlocklist:value())
		-- print(secunlocl)
		-- if type(secunlocl) == "string" then
		-- 	print("当前unlocklist是字符串:"..secunlocl)
		-- elseif type(secunlocl) == "table" then
		-- 	print("当前unlocklist是table:")
		-- 	for k, v in pairs(secunlocl) do
		-- 		print(k)
		-- 		print(v)
		-- 		print("---")
		-- 	end
		-- end
		-- print("打印完成")

		for _, v in ipairs(all_list) do
			if secunlocl[v.name] then
				table.insert(list, v)
			end
		end
	else
		list = all_list
	end
	self.maxpage = math.ceil(#list / 48)
	self.mainui.goodslist:KillAllChildren()

	local x = 0
	local y = 0
	for i = 1 + 48 * (self.numpage - 1), math.min(#list, 48 * (1 + self.numpage - 1)) do
		if math.ceil((i - 48 * (self.numpage - 1)) / 10) ~= math.ceil((i - 48 * (self.numpage - 1) - 1) / 10) then
			x = 0
		else
			x = x + 80
		end
		y = -100 * (math.ceil((i - 48 * (self.numpage - 1)) / 10) - 1)
		--标题为食物时，使用新鲜度的背景贴图
		self.listslot[i] = self.mainui.goodslist:AddChild(ImageButton("images/sehud/slotbg_normal.xml",
			"slotbg_normal.tex"))
		if title == "food" or list[i].name == "moonstorm_spark" then
			self.listslot[i]:SetTextures("images/sehud/slotbg_fresh.xml", "slotbg_fresh.tex")
		end
		self.listslot[i]:SetPosition(x, y, 0)
		self.listslot[i]:SetNormalScale(1, 1, 1)
		self.listslot[i]:SetFocusScale(1, 1, 1)
		self.listslot[i]:SetOnGainFocus(function() self.listslot[i]:ScaleTo(1, 1.15, .125) end)
		self.listslot[i]:SetOnLoseFocus(function() self.listslot[i]:ScaleTo(1.15, 1, .25) end)

		--用GetInventoryItemAtlas重写,配合判断贴图地址能显示绝大部分的物品,itemlist里手动填入地址信息几乎能显示所有物品--太
		--local _atl = "images/inventoryimages2.xml"
		local _atl = GetInventoryItemAtlas(list[i].name .. ".tex")
		local _tex = list[i].name .. ".tex"
		local atlas = "images/" .. list[i].name .. ".xml"

		--处理调料料理
		local _tex2
		local _atl2
		local _name
		if list[i].name and string.find(list[i].name, "_spice_") then
			_name = list[i].name
			if list[i].name and string.find(list[i].name, "_spice_chili") then
				list[i].name = string.gsub(list[i].name, "_spice_chili", "")
				_tex2 = "spice_chili_over.tex"
			elseif list[i].name and string.find(list[i].name, "_spice_garlic") then
				list[i].name = string.gsub(list[i].name, "_spice_garlic", "")
				_tex2 = "spice_garlic_over.tex"
			elseif list[i].name and string.find(list[i].name, "_spice_salt") then
				list[i].name = string.gsub(list[i].name, "_spice_salt", "")
				_tex2 = "spice_salt_over.tex"
			elseif list[i].name and string.find(list[i].name, "_spice_sugar") then
				list[i].name = string.gsub(list[i].name, "_spice_sugar", "")
				_tex2 = "spice_sugar_over.tex"
			end
		end
		if _tex2 then
			_tex = list[i].name .. ".tex"
			_atl2 = GetInventoryItemAtlas(_tex2)
		end
		--处理调料料理结束

		if pcall(resolvefilepath, atlas) then --判断这个文件是否存在
			_atl = atlas
		else
			local atlastwo = "images/inventoryimages/" .. list[i].name .. ".xml"
			if pcall(resolvefilepath, atlastwo) then
				_atl = atlastwo
			end
		end

		--处理使用官方资源的物品
		if list[i].tex then
			_tex = list[i].tex
			_atl = GetInventoryItemAtlas(list[i].tex)
		end
		--处理特殊情况
		if list[i].atl then
			_atl = list[i].atl
		end

		self.listslot[i].im = self.listslot[i]:AddChild(Image(_atl, _tex))
		self.listslot[i].im:SetPosition(0, 10, 0)
		self.listslot[i].im:SetSize(60, 60)
		self.listslot[i].im:SetScale(.95, .95, 1)

		--显示调料料理
		if _tex2 then
			self.listslot[i].im.tex2 = self.listslot[i].im:AddChild(Image(_atl2, _tex2))
			self.listslot[i].im.tex2:SetPosition(0, -9, 0)
			self.listslot[i].im.tex2:SetSize(60, 60)
			self.listslot[i].im.tex2:SetScale(.95, .95, 1)
		end

		--蓝图和月光龙虾、勋章塑料袋、富贵鱼卵、三基佬草图
		if list[i].name == "blueprint" then
			self.listslot[i]:SetHoverText(STRINGS.SIMPLEECONOMY[8])
		elseif list[i].name == "wobster_moonglass_land" then
			self.listslot[i]:SetHoverText(STRINGS.SIMPLEECONOMY[20])
		elseif list[i].name == "medal_losswetpouch" then
			self.listslot[i]:SetHoverText(STRINGS.SIMPLEECONOMY[21])
		elseif list[i].name == "ndnr_roe" then
			self.listslot[i]:SetHoverText(STRINGS.SIMPLEECONOMY[22])
		elseif list[i].name == "chesspiece_rook_sketch" then
			self.listslot[i]:SetHoverText(STRINGS.SIMPLEECONOMY[24])
		elseif list[i].name == "chesspiece_bishop_sketch" then
			self.listslot[i]:SetHoverText(STRINGS.SIMPLEECONOMY[25])
		elseif list[i].name == "chesspiece_knight_sketch" then
			self.listslot[i]:SetHoverText(STRINGS.SIMPLEECONOMY[26])
		else
			self.listslot[i]:SetHoverText(STRINGS.NAMES[string.upper(list[i].name)] or "nil")
		end
		if _name then
			list[i].name = _name
		end

		local p1 = self.listslot[i].hovertext:GetPosition()
		local p2 = self.listslot[i].hovertext_bg:GetPosition()
		self.listslot[i].hovertext:SetPosition(p1.x, p1.y + 30, p1.z)
		self.listslot[i].hovertext_bg:SetPosition(p2.x, p2.y + 30, p2.z)

		-- 将生成num对象的代码进行循环优化
		local positions = { -29, -21, -13, -5, 3, 11, 19, 27 } -- 位置列表
		local scale = { 1.15, 1.15, 1 }                  -- 缩放比例

		for j = 1, #positions do
			self.listslot[i]["num" .. j] = self.listslot[i]:AddChild(Image("images/sehud/numbers/0.xml", "0.tex"))
			self.listslot[i]["num" .. j]:SetPosition(positions[j], -33, 0) -- 设置位置
			self.listslot[i]["num" .. j]:SetScale(unpack(scale))  -- 设置缩放比例
		end

		local m = math.ceil(list[i].price * discount * TUNING.PRICERATE)
		--		local m = math.ceil(list[i].price*discount)
		printNumber(self.listslot[i], m, 8)

		self.listslot[i]:SetOnClick(function()
			SendModRPCToServer(MOD_RPC["SimpleEconomy"]["sebuy"], list[i].name)
		end)
		self.listslot[i].OnControl = function(self, control, down)
			if not self:IsEnabled() or not self.focus or self:IsSelected() then return end
			if control == CONTROL_ACCEPT or control == CONTROL_SECONDARY then
				if down then
					TheFrontEnd:GetSound():PlaySound("dontstarve/HUD/click_move")
					self.o_pos = self:GetLocalPosition()
					self:SetPosition(self.o_pos + self.clickoffset)
					self.down = true
					if self.whiledown then
						self:StartUpdating()
					end
					if self.ondown then
						self.ondown()
					end
				else
					if self.down then
						self.down = false
						self:SetPosition(self.o_pos)
						if control == CONTROL_ACCEPT then
							SendModRPCToServer(MOD_RPC["SimpleEconomy"]["sebuy"], list[i].name, false,
								Profile:GetLastUsedSkinForItem(list[i].name))
						elseif control == CONTROL_SECONDARY then
							SendModRPCToServer(MOD_RPC["SimpleEconomy"]["sebuy"], list[i].name, true,
								Profile:GetLastUsedSkinForItem(list[i].name))
						end
						self:StopUpdating()
					end
				end
				return true
			end
		end
	end
end

function uiseconomy:spitembuild(distance)
	if not distance then distance = 73 end
	local list = TUNING.tabc and TUNING.tabc[6] or TUNING.selist_special
	local discount = (1 - self.owner.seclevel:value() * 5 / 100) ^ self.owner.secvip:value()

	self.mainui.status.specialitem:KillAllChildren()

	local x = 0
	for i = 1, #list do
		x = distance * (i - 2.5)

		self.spitemslot[i] = self.mainui.status.specialitem:AddChild(ImageButton("images/sehud/slotbg_special.xml",
			"slotbg_special.tex"))
		self.spitemslot[i]:SetPosition(x, 0, 0)
		self.spitemslot[i]:SetNormalScale(1, 1, 1)
		self.spitemslot[i]:SetFocusScale(1, 1, 1)
		self.spitemslot[i]:SetOnGainFocus(function() self.spitemslot[i]:ScaleTo(1, 1.15, .125) end)
		self.spitemslot[i]:SetOnLoseFocus(function() self.spitemslot[i]:ScaleTo(1.15, 1, .25) end)

		self.spitemslot[i].im = self.spitemslot[i]:AddChild(Image("images/inventoryimages/" .. list[i].name .. ".xml",
			list[i].name .. ".tex"))
		self.spitemslot[i].im:SetPosition(0, 10, 0)
		self.spitemslot[i].im:SetScale(.95, .95, 1)

		self.spitemslot[i]:SetHoverText(STRINGS.NAMES[string.upper(list[i].name)])
		local p1 = self.spitemslot[i].hovertext:GetPosition()
		local p2 = self.spitemslot[i].hovertext_bg:GetPosition()
		self.spitemslot[i].hovertext:SetPosition(p1.x, p1.y + 30, p1.z)
		self.spitemslot[i].hovertext_bg:SetPosition(p2.x, p2.y + 30, p2.z)

		-- 将生成num对象的代码进行循环优化
		local positions = { -29, -21, -13, -5, 3, 11, 19, 27 } -- 位置列表
		local scale = { 1.15, 1.15, 1 }                  -- 缩放比例

		for j = 1, #positions do
			self.spitemslot[i]["num" .. j] = self.spitemslot[i]:AddChild(Image("images/sehud/numbers/0.xml", "0.tex"))
			self.spitemslot[i]["num" .. j]:SetPosition(positions[j], -33, 0) -- 设置位置
			self.spitemslot[i]["num" .. j]:SetScale(unpack(scale))  -- 设置缩放比例
		end

		local m = math.ceil(list[i].price * discount * TUNING.PRICERATE)
		if list[i].name == "vipcard" or list[i].name == "luckamulet" then
			m = math.ceil(list[i].price * TUNING.PRICERATE)
		end
		if TUNING.FIXTWOPRICE and list[i].name == "goldstaff" then
			m = math.ceil(list[i].price * discount)
		end
		if TUNING.FIXTWOPRICE and list[i].name == "luckamulet" then
			m = math.ceil(list[i].price)
		end
		printNumber(self.spitemslot[i], m, 8)
		self.spitemslot[i]:SetOnClick(function()
			SendModRPCToServer(MOD_RPC["SimpleEconomy"]["sebuy"], list[i].name)
		end)
	end
end

function uiseconomy:buildbutton(title)
	self.mainui.buttonfood:SetTextures("images/sehud/food_dact_" .. TUNING.SElan .. ".xml",
		"food_dact_" .. TUNING.SElan .. ".tex")
	self.mainui.buttoncloth:SetTextures("images/sehud/cloth_dact_" .. TUNING.SElan .. ".xml",
		"cloth_dact_" .. TUNING.SElan .. ".tex")
	self.mainui.buttonsmithing:SetTextures("images/sehud/smithing_dact_" .. TUNING.SElan .. ".xml",
		"smithing_dact_" .. TUNING.SElan .. ".tex")
	self.mainui.buttonresource:SetTextures("images/sehud/resource_dact_" .. TUNING.SElan .. ".xml",
		"resource_dact_" .. TUNING.SElan .. ".tex")
	self.mainui.buttonprecious:SetTextures("images/sehud/precious_dact_" .. TUNING.SElan .. ".xml",
		"precious_dact_" .. TUNING.SElan .. ".tex")
	if title == "food" then
		self.mainui.buttonfood:SetTextures("images/sehud/food_act_" .. TUNING.SElan .. ".xml",
			"food_act_" .. TUNING.SElan .. ".tex")
		self.mainui.bg.title:SetTexture("images/sehud/title_food.xml", "title_food.tex")
		if self.title == "precious" then
			self.mainui.buttonprecious.new:Hide()
			self.mainui.refresh:Hide()
		end
		--local pb = self.mainui.buttonfood:GetPosition()
		--self.mainui.buttonfood:MoveTo(pb, Vector3(pb.x, pb.y-15, pb.z), .25)
	end
	if title == "cloth" then
		self.mainui.buttoncloth:SetTextures("images/sehud/cloth_act_" .. TUNING.SElan .. ".xml",
			"cloth_act_" .. TUNING.SElan .. ".tex")
		self.mainui.bg.title:SetTexture("images/sehud/title_cloth.xml", "title_cloth.tex")
		if self.title == "precious" then
			self.mainui.buttonprecious.new:Hide()
			self.mainui.refresh:Hide()
		end
		--local pb = self.mainui.buttoncloth:GetPosition()
		--self.mainui.buttoncloth:MoveTo(pb, Vector3(pb.x, pb.y-15, pb.z), .25)
	end
	if title == "smithing" then
		self.mainui.buttonsmithing:SetTextures("images/sehud/smithing_act_" .. TUNING.SElan .. ".xml",
			"smithing_act_" .. TUNING.SElan .. ".tex")
		self.mainui.bg.title:SetTexture("images/sehud/title_smithing.xml", "title_smithing.tex")
		if self.title == "precious" then
			self.mainui.buttonprecious.new:Hide()
			self.mainui.refresh:Hide()
		end
		--local pb = self.mainui.buttonsmithing:GetPosition()
		--self.mainui.buttonsmithing:MoveTo(pb, Vector3(pb.x, pb.y-15, pb.z), .25)
	end
	if title == "resource" then
		self.mainui.buttonresource:SetTextures("images/sehud/resource_act_" .. TUNING.SElan .. ".xml",
			"resource_act_" .. TUNING.SElan .. ".tex")
		self.mainui.bg.title:SetTexture("images/sehud/title_resource.xml", "title_resource.tex")
		if self.title == "precious" then
			self.mainui.buttonprecious.new:Hide()
			self.mainui.refresh:Hide()
		end
		--local pb = self.mainui.buttonresource:GetPosition()
		--self.mainui.buttonresource:MoveTo(pb, Vector3(pb.x, pb.y-15, pb.z), .25)
	end
	if title == "precious" then
		self.mainui.buttonprecious:SetTextures("images/sehud/precious_act_" .. TUNING.SElan .. ".xml",
			"precious_act_" .. TUNING.SElan .. ".tex")
		self.mainui.bg.title:SetTexture("images/sehud/title_precious.xml", "title_precious.tex")
		self.mainui.buttonprecious.new:Hide()
		if not TUNING.precious_sell then
			self.mainui.refresh:Show()
		end
		--local pb = self.mainui.buttonprecious:GetPosition()
		--self.mainui.buttonprecious:MoveTo(pb, Vector3(pb.x, pb.y-15, pb.z), .25)
	end

	self.numpage = 1
	self.title = title

	self.mainui.goodslist:Show()
	self.mainui.status:Show()
	self.mainui.next:Show()
	self.mainui.back:Show()
	self.mainui.infopage:Hide()
	self.mainui.infobutton:SetTextures("images/sehud/infobutton.xml", "infobutton.tex")
	self.mainui.infobutton:SetHoverText(STRINGS.SIMPLEECONOMY[3])

	self:buildlist(title)
	self.mainui.back.image:SetTint(1, 1, 1, .5)
	if self.numpage >= self.maxpage then
		self.mainui.next.image:SetTint(1, 1, 1, .5)
	else
		self.mainui.next.image:SetTint(1, 1, 1, 1)
	end
end

function uiseconomy:OnControl(control, down)
	if uiseconomy._base.OnControl(self, control, down) then
		return true
	end

	if not down then
		if (control == CONTROL_PAUSE or control == CONTROL_CANCEL) and self.mainui.shown then
			self:onclose()
		end
	end

	return true
end

function uiseconomy:onclose()
	self.mainui:ScaleTo(1, .25, .25)
	self.owner:DoTaskInTime(.125, function() self.mainui:Hide() end)
	if self.title == "precious" then self.mainui.buttonprecious.new:Hide() end
	self.mainbutton.new:Hide()
end

function uiseconomy:onrefresh()
	SendModRPCToServer(MOD_RPC["SimpleEconomy"]["refresh"])
	--self.mainui.buttonprecious.new:Show()
end

function uiseconomy:onopen()
	self.mainui:Show()
	self.mainui:ScaleTo(.75, 1, .125)
	self.mainbutton.new:Hide()
end

function uiseconomy:displaycoinamount(child)
	local m = self.owner.seccoin:value()
	local x = 17
	local str_num = string.format("%08d", m)
	local len = #tostring(m)
	local single = {}
	local first = false

	for i = 1, #str_num do
		single[i] = tonumber(str_num:sub(i, i))

		if single[i] <= 0 and first == false then
			child[i]:Hide()
		else
			if first == false then
				first = true
			end
			child[i]:Show()
			child[i]:SetTexture("images/sehud/bignums/" .. single[i] .. '.xml', single[i] .. '.tex')
		end
	end

	local pos = len < 6 and (8 - len - 2) or 0

	for i = 1, 8 do
		child[i]:SetPosition(x * (i - pos), 0, 0)
	end
end

return uiseconomy
