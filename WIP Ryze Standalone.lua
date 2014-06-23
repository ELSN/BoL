--[[
    Ryze To Tha Wood By ELSN
	Credits: Honda7 for SOW
]]--

if myHero.charName ~= "Ryze" then return end

require 'SOW'

local ts
local qRange = 625
local wRange = 600
local eRange = 600
local rRange = math.huge

function OnLoad()
    SOWi = SOW(VP)
    ts = TargetSelector(TARGET_LOW_HP_PRIORITY,650)
    Config = scriptConfig("Ryze Standalone", "ryzeStandalone")
	 Config:addSubMenu("Key Bindings", "kb")
	  Config.kb:addParam("combo", "Combo Key", SCRIPT_PARAM_ONKEYDOWN, false, 32)
	  SOWi:LoadToMenu(Config.kb)
	 Config:addSubMenu("Draw Settings", "DS")
	  Config.DS:addParam("DrawQ", "Draw Q If Ready", SCRIPT_PARAM_ONOFF, true)
	  Config.DS:addParam("DrawW", "Draw W If Ready", SCRIPT_PARAM_ONOFF, true)
	  Config.DS:addParam("DrawE", "Draw E If Ready", SCRIPT_PARAM_ONOFF, true)
	 Config:addSubMenu("Extras", "Ex")
	  Config.Ex:addParam("ALevel", "Auto Level R > Q > W > E", SCRIPT_PARAM_ONOFF, true)
	 
    PrintChat("Ryze To Tha Wood By ELSN Succesfully loaded")
end

function OnTick()
    ts:update()
	CDHandler()
    if(Config.kb.combo) then Combo() end
	if(Config.Ex.ALevel) then AutoLevel() end
end

function OnDraw()
   if(Config.DS.DrawQ) and QReady then DrawCircle(myHero.x, myHero.y, myHero.z, 625, 250, 0, 250) end
   if(Config.DS.DrawW) and WReady then DrawCircle(myHero.x, myHero.y, myHero.z, 600, 250, 0, 250) end
   if(Congig.DS.DrawE) and EReady then DrawCircle(myHero.x, myHero.y, myHero.z, 600, 250, 0, 250) end 
end   

function CDHandler()
    QReady = (myHero:CanUseSpell(_Q) == READY)
	WReady = (myHero:CanUseSpell(_W) == READY)
	EReady = (myHero:CanUseSpell(_E) == READY)
	RReady = (myHero:CanUseSpell(_R) == READY)
end

function Combo()
    myHero:MoveTo(mousePos.x, mousePos.z)
    if (ts.target ~= nil) then
        if QReady and GetDistance(ts.target) < 626 then CastSpell(_Q, ts.target) end
		if LastCast == "Q" then
		    if not QReady and RReady then CastSpell(_R) end
			if not QReady and not RReady and EReady and GetDistance(ts.target) < 601  then CastSpell(_E, ts.target) end
			if not QReady and not RReady and not EReady and WReady and GetDistance(ts.target) < 601 then CastSpell(_W, ts.target) end
		end
		
		if LastCast == "W" then
		    if not WReady and not RReady and not EReady and QReady and GetDistance(ts.target) < 626 then CastSpell(_Q, ts.target) end
		end
		
		if LastCast == "E" then
		    if not EReady and not RReady and QReady and GetDistance(ts.target) < 625 then CastSpell(_Q, ts.target) end
		end
		
		if LastCast == "R" then
		    if not RReady and QReady and GetDistance(ts.target) < 626 then CastSpell(_Q, ts.target) end
		end
	end
end

function OnProcessSpell(unit, spell)
    if unit.isMe then
	    if spell.name:lower() == "overload" then
		    LastCast = "Q"
		elseif spell.name:lower() == "runeprison" then
		    LastCast = "W"
		elseif spell.name:lower() == "spellflux" then
		    LastCast = "E"
		elseif spell.name:lower() == "desperatepower" then
		    LastCast = "R"
		end
	end
end

function AutoLevel()
   Sequence = { 1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3 }
   autoLevelSetSequence(Sequence)
end
