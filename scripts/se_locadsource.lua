local LAN_ = GetModConfigData('Language')
if LAN_ then
	require 'SEscripts/strings_cn'
	TUNING.SElan = "cn"
else
	require 'SEscripts/strings_en'
	TUNING.SElan = "en"
end

PrefabFiles = {
	"secoin",
    "stealer",
    "goldstaff",
    "vipcard",
    "luckamulet",
}

Assets = {
    Asset("ATLAS", "images/inventoryimages/secoin.xml"),
    Asset("IMAGE", "images/inventoryimages/secoin.tex"),
    Asset("ATLAS", "images/sehud/mainbutton.xml"),
    Asset("IMAGE", "images/sehud/mainbutton.tex"),
    Asset("ATLAS", "images/sehud/bg.xml"),
    Asset("IMAGE", "images/sehud/bg.tex"),
    Asset("ATLAS", "images/sehud/exp_act.xml"),
    Asset("IMAGE", "images/sehud/exp_act.tex"),
    Asset("ATLAS", "images/sehud/exp_dact.xml"),
    Asset("IMAGE", "images/sehud/exp_dact.tex"),
    Asset("ATLAS", "images/sehud/expmask.xml"),
    Asset("IMAGE", "images/sehud/expmask.tex"),
    Asset("ATLAS", "images/sehud/level_act.xml"),
    Asset("IMAGE", "images/sehud/level_act.tex"),
    Asset("ATLAS", "images/sehud/level_dact.xml"),
    Asset("IMAGE", "images/sehud/level_dact.tex"),
    Asset("ATLAS", "images/sehud/status_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/status_"..TUNING.SElan..".tex"),
    Asset("ATLAS", "images/sehud/hudcoin.xml"),
    Asset("IMAGE", "images/sehud/hudcoin.tex"),
    Asset("ATLAS", "images/sehud/slotbg_normal.xml"),
    Asset("IMAGE", "images/sehud/slotbg_normal.tex"),
    Asset("ATLAS", "images/sehud/slotbg_special.xml"),
    Asset("IMAGE", "images/sehud/slotbg_special.tex"),
    Asset("ATLAS", "images/sehud/slotbg_fresh.xml"),
    Asset("IMAGE", "images/sehud/slotbg_fresh.tex"),
    Asset("ATLAS", "images/sehud/back.xml"),
    Asset("IMAGE", "images/sehud/back.tex"),
    Asset("ATLAS", "images/sehud/next.xml"),
    Asset("IMAGE", "images/sehud/next.tex"),
    Asset("ATLAS", "images/sehud/close.xml"),
    Asset("IMAGE", "images/sehud/close.tex"),
    Asset("ATLAS", "images/sehud/infobutton.xml"),
    Asset("IMAGE", "images/sehud/infobutton.tex"),
    Asset("ATLAS", "images/sehud/infoback.xml"),
    Asset("IMAGE", "images/sehud/infoback.tex"),
    Asset("ATLAS", "images/sehud/infopage_"..TUNING.SElan..".xml"),
    Asset("IMAGE", "images/sehud/infopage_"..TUNING.SElan..".tex"),
    Asset("ATLAS", "images/sehud/new.xml"),
    Asset("IMAGE", "images/sehud/new.tex"),
    Asset("ATLAS", "images/sehud/up.xml"),
    Asset("IMAGE", "images/sehud/up.tex"),
    Asset("ATLAS", "images/sehud/low.xml"),
    Asset("IMAGE", "images/sehud/low.tex"),
    Asset("ATLAS", "images/sehud/refresh.xml"),
    Asset("IMAGE", "images/sehud/refresh.tex"),
}

for i=1, 5 do
    table.insert(Assets, Asset("ATLAS", "images/sehud/swdj_"..TUNING.SElan..i..".xml"))
    table.insert(Assets, Asset("IMAGE", "images/sehud/swdj_"..TUNING.SElan..i..".tex"))
end
for i=1, 6 do
    table.insert(Assets, Asset("ATLAS", "images/sehud/vip"..(i-1)..".xml"))
    table.insert(Assets, Asset("IMAGE", "images/sehud/vip"..(i-1)..".tex"))
end
for i=1, 10 do
    table.insert(Assets, Asset("ATLAS", "images/sehud/numbers/"..(i-1)..".xml"))
    table.insert(Assets, Asset("IMAGE", "images/sehud/numbers/"..(i-1)..".tex"))
end
for i=1, 10 do
    table.insert(Assets, Asset("ATLAS", "images/sehud/bignums/"..(i-1)..".xml"))
    table.insert(Assets, Asset("IMAGE", "images/sehud/bignums/"..(i-1)..".tex"))
end
local titles = {"food", "cloth", "smithing", "resource", "precious"}
for k,v in pairs(titles) do
    table.insert(Assets, Asset("ATLAS", "images/sehud/title_"..v..".xml"))
    table.insert(Assets, Asset("IMAGE", "images/sehud/title_"..v..".tex"))
    table.insert(Assets, Asset("ATLAS", "images/sehud/"..v.."_act_"..TUNING.SElan..".xml"))
    table.insert(Assets, Asset("IMAGE", "images/sehud/"..v.."_act_"..TUNING.SElan..".tex"))
    table.insert(Assets, Asset("ATLAS", "images/sehud/"..v.."_dact_"..TUNING.SElan..".xml"))
    table.insert(Assets, Asset("IMAGE", "images/sehud/"..v.."_dact_"..TUNING.SElan..".tex"))
end