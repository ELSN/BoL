 
 
if myHero.charName ~= "Ryze" then return end

local QReady, WReady, EReady, RReady
local EnemyTable
local AllyTable
local levelSequence = { 1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3 }
local qRange = 625
local wRange = 600
local eRange = 600

function PluginOnLoad()
    PrintChat("Ryze: The Rogue Mage By ELSN Successfully Loaded")
	AutoCarry.PluginMenu:addSubMenu("Combo Settings", "ComboSettings")
	AutoCarry.PluginMenu.ComboSettings:addParam("useQ", "Use Overload (Q) In Combo", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.ComboSettings:addParam("useW", "Use Rune Prison (W) In Combo", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.ComboSettings:addParam("useE", "Use Spell Flux (E) In Combo", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.ComboSettings:addParam("useR", "Use Desperate Power (R) In Combo", SCRIPT_PARAM_ONOFF, false)
	AutoCarry.PluginMenu:addSubMenu("Mixed Mode Settings (Harass)", "MixedModeSettings")
	AutoCarry.PluginMenu.MixedModeSettings:addParam("useQm", "Use Overload (Q) In Mixed Mode", SCRIPT_PARAM_ONOFF, true) 
	AutoCarry.PluginMenu.MixedModeSettings:addParam("useWm", "Use Rune Prison (W) In Mixed Mode", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.MixedModeSettings:addParam("useEm", "Use Spell Flux (E) In Mixed Mode", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.MixedModeSettings:addParam("useRm", "Use Desperate Power (R) In Mixed Mode", SCRIPT_PARAM_ONOFF, false)
	AutoCarry.PluginMenu.MixedModeSettings:addParam("MCH", "Don't Harass With Spells If Mana < %", SCRIPT_PARAM_SLICE, 0, 0, 100)
	AutoCarry.PluginMenu:addSubMenu("Kill steal Settings", "KillstealSettings")
	AutoCarry.PluginMenu.KillstealSettings:addParam("useQks", "Use Overload (Q) To Kill steal", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.KillstealSettings:addParam("useWks", "Use Rune Prison (W) To Kill steal", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu:addSubMenu("Farm Settings", "FarmSettings")
	AutoCarry.PluginMenu.FarmSettings:addSubMenu("Last Hit Mode Settings", "Lh")
	AutoCarry.PluginMenu.FarmSettings.Lh:addParam("qFarmLh", "Farm With Overload (Q)", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.FarmSettings.Lh:addParam("wFarmLh", "Farm With Rune Prison (W)", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.FarmSettings.Lh:addParam("eFarmLh", "Farm With Spell Flux (E)", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.FarmSettings.Lh:addParam("rFarmLh", "Farm With Desperate Power (R)", SCRIPT_PARAM_ONOFF, false)
	AutoCarry.PluginMenu.FarmSettings.Lh:addParam("MCLh", "Don't Farm With Spells If Mana < %", SCRIPT_PARAM_SLICE, 0, 0, 100)
	AutoCarry.PluginMenu.FarmSettings:addSubMenu("Mixed Mode Settings", "Mm")
	AutoCarry.PluginMenu.FarmSettings.Mm:addParam("qFarmMm", "Farm With Overload (Q)", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.FarmSettings.Mm:addParam("wFarmMm", "Farm With Rune Prison (W)", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.FarmSettings.Mm:addParam("eFarmMm", "Farm With Spell Flux (E)", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.FarmSettings.Mm:addParam("rFarmMm", "Farm With Desperate Power (R)", SCRIPT_PARAM_ONOFF, false)
	AutoCarry.PluginMenu.FarmSettings.Mm:addParam("MCMm", "Don't Farm With Spells If Mana < %", SCRIPT_PARAM_SLICE, 0, 0, 100)
	AutoCarry.PluginMenu.FarmSettings:addSubMenu("Lane Clear Mode Settings", "Lc")
	AutoCarry.PluginMenu.FarmSettings.Lc:addParam("qFarmLc", "Farm With Overload (Q)", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.FarmSettings.Lc:addParam("wFarmLc", "Farm With Rune Prison (W)", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.FarmSettings.Lc:addParam("eFarmLc", "Farm With Spell Flux (E)", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.FarmSettings.Lc:addParam("rFarmLc", "Farm With Desperate Power (R)", SCRIPT_PARAM_ONOFF, false)
	AutoCarry.PluginMenu.FarmSettings.Lc:addParam("MCLc", "Don't Farm With Spells If Mana < %", SCRIPT_PARAM_SLICE, 0, 0, 100)
	 AutoCarry.PluginMenu:addSubMenu("Jungle Clear", "JC")
	 AutoCarry.PluginMenu.JC:addParam("QJC", "Jungle Clear With Overload (Q)", SCRIPT_PARAM_ONOFF, true)
	 AutoCarry.PluginMenu.JC:addParam("WJC", "Jungle Clear With Rune Prison (W)", SCRIPT_PARAM_ONOFF, true)
	 AutoCarry.PluginMenu.JC:addParam("EJC", "Jungle Clear With Spell Flux (E)", SCRIPT_PARAM_ONOFF, true)
	 AutoCarry.PluginMenu.JC:addParam("RJC", "Jungle Clear With Desperate Power (R)", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu:addSubMenu("Draw Settings", "Draw")
	AutoCarry.PluginMenu.Draw:addParam("qDraw", "Draw Q Range", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.Draw:addParam("weDraw", "Draw W and E Range (Same Range)", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu:addSubMenu("Tear Settings", "Tes")
	AutoCarry.PluginMenu.Tes:addParam("hTes", "Tear Of The Goddess Mode Hotkey", SCRIPT_PARAM_ONKEYTOGGLE, false, 65)
	AutoCarry.PluginMenu.Tes:addParam("qTes", "Use Q In Tear Of The Goddess Mode", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.Tes:addParam("wTes", "Use W In Tear Of The Goddess Mode", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.Tes:addParam("eTes", "Use E In Tear Of The Goddess Mode", SCRIPT_PARAM_ONOFF, true)
	AutoCarry.PluginMenu.Tes:addParam("MCTes", "Don't Use Spells In Tear Mode If Mana < %", SCRIPT_PARAM_SLICE, 0, 0, 100)
	AutoCarry.PluginMenu:addSubMenu("Extra's", "extra")
	AutoCarry.PluginMenu.extra:addParam("ALevel", "Auto-Level Spells R > Q > W > E", SCRIPT_PARAM_ONOFF, true)
end

--[[function OnDraw()
    if AutoCarry.PluginMenu.Draw.qDraw then DrawCircle(myHero.x, myHero.y, myHero.z, 625, 0x111121) end
    if AutoCarry.PluginMenu.Draw.weDraw then DrawCircle(myHero.x, myHero.y, myHero.z, 600, 0x111121) end
end]]

function CDHandler()
	QReady = (myHero:CanUseSpell(_Q) == READY)
	WReady = (myHero:CanUseSpell(_W) == READY)
	EReady = (myHero:CanUseSpell(_E) == READY)
	RReady = (myHero:CanUseSpell(_R) == READY)
	--TearReady = (myHero:CanUseSpell(_3070) == READY)
end

function PluginOnTick()
    CDHandler()
	if(AutoCarry.MainMenu.LastHit) then QFarmLh() end
	if(AutoCarry.MainMenu.LastHit) then WFarmLh() end
	if(AutoCarry.MainMenu.LastHit) then EFarmLh() end
	if(AutoCarry.MainMenu.LastHit) then RFarmLh() end
	if(AutoCarry.MainMenu.MixedMode) then QFarmMm() end
	if(AutoCarry.MainMenu.MixedMode) then WFarmMm() end
	if(AutoCarry.MainMenu.MixedMode) then EFarmMm() end
	if(AutoCarry.MainMenu.MixedMode) then RFarmMm() end	
	if(AutoCarry.MainMenu.LaneClear) then QFarmLc() end
	if(AutoCarry.MainMenu.LaneClear) then WFarmLc() end
	if(AutoCarry.MainMenu.LaneClear) then EFarmLc() end
	if(AutoCarry.MainMenu.LaneClear) then RFarmLc() end
	if(AutoCarry.PluginMenu.Tes.hTes) then TearMode() end
	if(AutoCarry.PluginMenu.extra.ALevel) then AutoLevel() end
	if(AutoCarry.Keys.LaneClear) then JungleFarm() end
end

function Plugin:__init()
	SkillQ = AutoCarry.Skills:NewSkill(false, _Q, 625, "Overload", AutoCarry.SPELL_TARGETED, 0, false, false, 1400,0, 0, 0, false)
	SkillW = AutoCarry.Skills:NewSkill(false, _W, 600, "Rune Prison", AutoCarry.SPELL_TARGETED, 0, false, false, 0, 0,0, 0, false)
	SkillE = AutoCarry.Skills:NewSkill(false, _E, 600, "Spell Flux", AutoCarry.SPELL_TARGETED, 0, false, false, 1000, 0, 0, false)
	SkillR = AutoCarry.Skills:NewSkill(false, _R, 0, "Desperate Power", AutoCarry.SPELL_SELF, 0, false, false, 0, 0, 0, 0, false)
	AutoCarry.Crosshair:SetSkillCrosshairRange(1000)
end

function JungleFarm()
    myHero:MoveTo(mousePos.x, mousePos.z)
	JungleMob = AutoCarry.Jungle:GetAttackableMonster() 
	if JungleMob then
		if QReady and(AutoCarry.PluginMenu.JC.QJC) and GetDistance(JungleMob) <= qRange then CastSpell(_Q, JungleMob) end
		if WReady and(AutoCarry.PluginMenu.JC.WJC) and GetDistance(JungleMob) <= wRange then CastSpell(_W, JungleMob) end
		if EReady and(AutoCarry.PluginMenu.JC.EJC) and GetDistance(JungleMob) <= eRange then CastSpell(_E, JungleMob) end
		if RReady and(AutoCarry.PluginMenu.JC.RJC) then CastSpell(_R) end
    end
end

function TearMode()
    if not QReady or not TearReady or (AutoCarry.PluginMenu.Tes.MCTes > (myHero.mana / myHero.maxMana) * 100) or (AutoCarry.Keys.AutoCarry) or (AutoCarry.Keys.MixedMode) then return end
        if (AutoCarry.PluginMenu.Tes.hTes) then
	        if GetInventorySlotItem(3070) ~= nil then		
	            for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		        if ValidTarget(minion, RangeQ) and QReady then
			        CastSpell(_Q, minion)
		        end
	        end
	    end
    
    if not WReady or not TearReady or (AutoCarry.PluginMenu.Tes.MCTes > (myHero.mana / myHero.maxMana) * 100) or (AutoCarry.Keys.AutoCarry) or (AutoCarry.Keys.MixedMode) then return end
        if (AutoCarry.PluginMenu.Tes.hTes) then
	        if GetInventorySlotItem(3070) ~= nil then		
	            for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		        if ValidTarget(minion, RangeW) and WReady then
			        CastSpell(_W, minion)
		       end
	        end
	    end
    end
	if not EReady or not TearReady or (AutoCarry.PluginMenu.Tes.MCTes > (myHero.mana / myHero.maxMana) * 100) or (AutoCarry.Keys.AutoCarry) or (AutoCarry.Keys.MixedMode) then return end
        if (AutoCarry.PluginMenu.Tes.hTes) then
	        if GetInventorySlotItem(3070) ~= nil then		
	            for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		        if ValidTarget(minion, RangeW) and EReady then
			        CastSpell(_E, minion)
		       end
	        end
	    end
	end
	end
end

function CastWTear()
    if not WReady or not TearReady or (AutoCarry.PluginMenu.Tes.MCTes > (myHero.mana / myHero.maxMana) * 100) or (AutoCarry.Keys.AutoCarry) or (AutoCarry.Keys.MixedMode) then return end
    if (AutoCarry.PluginMenu.Tes.hTes) then
	if GetInventorySlotItem(3070) ~= nil then		
	for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		if ValidTarget(minion, RangeW) and WReady then
			CastSpell(_W, minion)
		end
	end
	end
end
end

function CastETear()
    if not EReady or not TearReady or (AutoCarry.PluginMenu.Tes.MCTes > (myHero.mana / myHero.maxMana) * 100) or (AutoCarry.Keys.AutoCarry) or (AutoCarry.Keys.MixedMode) then return end
        if (AutoCarry.PluginMenu.Tes.hTes) then
	        if GetInventorySlotItem(3070) ~= nil then		
	        for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		        if ValidTarget(minion, RangeE) and EReady then
			CastSpell(_E, minion)
		        end
	        end
	    end
    end
end

function Plugin:OnTick()
	Target = AutoCarry.Crosshair:GetTarget()
	KillSteal()
	if AutoCarry.Keys.AutoCarry then
	    if QReady then SkillQ:Cast(Target) end
		if LastCast == "Q" then
		    if not QReady and RReady then SkillR:Cast(Target) end
			if not QReady and not RReady and EReady then SkillE:Cast(Target) end
			if not QReady and not RReady and not EReady and WReady then SkillW:Cast(Target) end
		end
		if LastCast == "R" then
		   if not RReady and QReady then SkillQ:Cast(Target) end
		end
		if LastCast == "E" then
		   if not RReady and not EReady and QReady then SkillQ:Cast(Target) end
		end
		if LastCast == "W" then
		    if not RReady and not EReady and not WReady and QReady then SkillQ:Cast(Target) end
		end
    end
		
	if AutoCarry.Keys.MixedMode then
	    if(AutoCarry.PluginMenu.FarmSettings.Lh.MCLh > (myHero.mana / myHero.maxMana) * 100) then return end
	    if AutoCarry.PluginMenu.MixedModeSettings.useWm then SkillW:Cast(Target) end
	    if AutoCarry.PluginMenu.MixedModeSettings.useRm then SkillR:Cast(Target) end
	    if AutoCarry.PluginMenu.MixedModeSettings.useQm then SkillQ:Cast(Target) end 
	    if AutoCarry.PluginMenu.MixedModeSettings.useEm then SkillE:Cast(Target) end
	end
end 

function KillSteal()
	if ValidTarget(Target) then
		local qDamage = getDmg("Q", Target, myHero)
		local wDamage = getDmg("W", Target, myHero)
		if AutoCarry.PluginMenu.KillstealSettings.useQks then if Target.health <= qDamage then SkillQ:Cast(Target) end 
		end
		if AutoCarry.PluginMenu.KillstealSettings.useWks then if Target.health <= wDamage then SkillW:Cast(Target) end
		end
	end
end

function QFarmLh() --approved
	if not QReady or (AutoCarry.PluginMenu.FarmSettings.Lh.MCLh > (myHero.mana / myHero.maxMana) * 100) then return end    
	        if AutoCarry.PluginMenu.FarmSettings.Lh.qFarmLh then
	for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		if ValidTarget(minion, RangeQ) and getDmg("Q", minion, myHero) >= minion.health and (not AutoCarry.GetKillableMinion() or AutoCarry.GetKillableMinion().networkID ~= minion.networkID) then  CastSpell(_Q, minion)
		    end
		end
	end
end	

function WFarmLh() --approved
	if not WReady or (AutoCarry.PluginMenu.FarmSettings.Lh.MCLh > (myHero.mana / myHero.maxMana) * 100) then return end 
	        if AutoCarry.PluginMenu.FarmSettings.Lh.wFarmLh then
	for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		if ValidTarget(minion, RangeW) and getDmg("W", minion, myHero) >= minion.health and (not AutoCarry.GetKillableMinion() or AutoCarry.GetKillableMinion().networkID ~= minion.networkID) then CastSpell(_W, minion)
		    end
		end
	end
end	

function EFarmLh() --approved
	if not EReady or (AutoCarry.PluginMenu.FarmSettings.Lh.MCLh > (myHero.mana / myHero.maxMana) * 100) then return end
	        if AutoCarry.PluginMenu.FarmSettings.Lh.eFarmLh then
	for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		if ValidTarget(minion, RangeE) and getDmg("E", minion, myHero) >= minion.health and (not AutoCarry.GetKillableMinion() or AutoCarry.GetKillableMinion().networkID ~= minion.networkID) then CastSpell(_E, minion)
		    end
		end
	end
end	

function RFarmLh()
    if not RREADY or (AutoCarry.PluginMenu.FarmSettings.Lh.MCLh > (myHero.mana / myHero.maxMana) * 100) then return end
    if AutoCarry.PluginMenu.FarmSettings.Lh.rFarmLh then
	CastSpell(_R)
    end
end

function QFarmMm() --approved
	if not QReady or (AutoCarry.PluginMenu.FarmSettings.Mm.MCMm > (myHero.mana / myHero.maxMana) * 100) then return end
    
	        if AutoCarry.PluginMenu.FarmSettings.Mm.qFarmMm then
	for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		if ValidTarget(minion, RangeQ) and getDmg("Q", minion, myHero) >= minion.health and (not AutoCarry.GetKillableMinion() or AutoCarry.GetKillableMinion().networkID ~= minion.networkID) then  CastSpell(_Q, minion)
		    end
		end
	end
end	

function WFarmMm() --approved
	if not WReady or (AutoCarry.PluginMenu.FarmSettings.Mm.MCMm > (myHero.mana / myHero.maxMana) * 100) then return end
    
	        if AutoCarry.PluginMenu.FarmSettings.Mm.wFarmMm then
	for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		if ValidTarget(minion, RangeW) and getDmg("W", minion, myHero) >= minion.health and (not AutoCarry.GetKillableMinion() or AutoCarry.GetKillableMinion().networkID ~= minion.networkID) then CastSpell(_W, minion)
		    end
		end
	end
end	

function EFarmMm() --approved
	if not EReady or (AutoCarry.PluginMenu.FarmSettings.Mm.MCMm > (myHero.mana / myHero.maxMana) * 100) then return end
    
	        if AutoCarry.PluginMenu.FarmSettings.Mm.eFarmMm then
	for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		if ValidTarget(minion, RangeE) and getDmg("E", minion, myHero) >= minion.health and (not AutoCarry.GetKillableMinion() or AutoCarry.GetKillableMinion().networkID ~= minion.networkID) then CastSpell(_E, minion)
		    end
		end
	end
end	

function RFarmMm()
    if not RREADY or (AutoCarry.PluginMenu.FarmSettings.Lh.MCLh > (myHero.mana / myHero.maxMana) * 100) then return end
    if AutoCarry.PluginMenu.FarmSettings.Mm.rFarmMm then
	CastSpell(_R)
    end
end

function QFarmLc() --approved
    if not QReady or (AutoCarry.PluginMenu.FarmSettings.Lc.MCLc > (myHero.mana / myHero.maxMana) * 100) then return end
    for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		if ValidTarget(minion, RangeQ) and getDmg("Q", minion, myHero) >= minion.health and (not AutoCarry.GetKillableMinion() or AutoCarry.GetKillableMinion().networkID ~= minion.networkID) then  CastSpell(_Q, minion)	
		end
	end
end

function WFarmLc() --approved
    if not WReady or (AutoCarry.PluginMenu.FarmSettings.Lc.MCLc > (myHero.mana / myHero.maxMana) * 100) then return end
    if (AutoCarry.PluginMenu.FarmSettings.Lc.wFarmLc) then	
	for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		if ValidTarget(minion, RangeW) and getDmg("W", minion, myHero) >= minion.health and (not AutoCarry.GetKillableMinion() or AutoCarry.GetKillableMinion().networkID ~= minion.networkID) then CastSpell(_W, minion)
		    end
		end
	end
end	

function EFarmLc() --approved
 if not EReady or (AutoCarry.PluginMenu.FarmSettings.Lc.MCLc > (myHero.mana / myHero.maxMana) * 100) then return end
    if (AutoCarry.PluginMenu.FarmSettings.Lc.eFarmLc) then	
	for _, minion in pairs(AutoCarry.EnemyMinions().objects) do
		if ValidTarget(minion, RangeE) and getDmg("E", minion, myHero) >= minion.health and (not AutoCarry.GetKillableMinion() or AutoCarry.GetKillableMinion().networkID ~= minion.networkID) then CastSpell(_E, minion)
		    end
		end
	end
end	

function RFarmLc() 
    if not RREADY or (AutoCarry.PluginMenu.FarmSettings.Lh.MCLh > (myHero.mana / myHero.maxMana) * 100) then return end
    if AutoCarry.PluginMenu.FarmSettings.Lc.rFarmLc then
	CastSpell(_R)
    end
end 

function AutoLevel()
   Sequence = { 1,2,3,1,1,4,1,2,1,2,4,2,2,3,3,4,3,3 }
   autoLevelSetSequence(Sequence)
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
		

local Menu = AutoCarry.Plugins:RegisterPlugin(Plugin(), "Options Above")

--UPDATEURL=
--HASH=6A96B92370FBA8CAEFD7595157EB9619
