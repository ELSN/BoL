if myHero.charName ~= "Kayle" then return end

require "SOW"
require "VPrediction"

local qRange = 650
local wRange = 900
local eRange = 525
local rRange = 900
local version = 0.27
local Recalling = false

function OnLoad()
  VP = VPrediction()
  SOW = SOW(VP)
  ts = TargetSelector(TARGET_LESS_CAST, qRange)
  enemyMinions = minionManager(MINION_ENEMY, qRange, myHero, MINION_SORT_MAXHEALTH_DEC)
  jungleMinions = minionManager(MINION_JUNGLE, qRange, myHero, MINION_SORT_MAXHEALTH_DEC)

  Menu = scriptConfig("Kayle: The angel of elohell", "Kayle")
  Menu:addSubMenu("Script info", "info")
   Menu.info:addParam("info", "Name: The angel of elohell", SCRIPT_PARAM_INFO, "")
   Menu.info:addParam("info", "Author: ELSN", SCRIPT_PARAM_INFO, "")
   Menu.info:addParam("info", "Credits: Honda7, Bilbao", SCRIPT_PARAM_INFO, "")
   Menu.info:addParam("info", "Version: "..version.."", SCRIPT_PARAM_INFO, "")
  Menu:addSubMenu("Kayle - Target Selector", "ts")
    Menu.ts:addTS(ts)
    ts.name = "Focus"
   Menu:addSubMenu("Kayle - SOW", "SOWorb")
    SOW:LoadToMenu(Menu.SOWorb) 
   Menu:addSubMenu("Kayle - Key bindings", "Kb")
    Menu.Kb:addParam("combo", "Combo mode", SCRIPT_PARAM_ONKEYDOWN, false, 32)
    Menu.Kb:addParam("lasthit", "Lasthit mode", SCRIPT_PARAM_ONKEYDOWN, false, 88)
    Menu.Kb:addParam("laneclear", "Laneclear mode", SCRIPT_PARAM_ONKEYDOWN, false, 86)
    Menu.Kb:addParam("jungleclear", "Juncleclear mode", SCRIPT_PARAM_ONKEYDOWN, false, 74)
    Menu.Kb:addParam("autoheal", "Always auto-heal on/off", SCRIPT_PARAM_ONKEYTOGGLE, true, 72)
    Menu.Kb:addParam("autoult", "Always auto-ult on/off", SCRIPT_PARAM_ONKEYTOGGLE, true, 85)
   Menu:addSubMenu("Kayle - Combo", "combo")
    Menu.combo:addParam("useQ", "Use Q in combo", SCRIPT_PARAM_ONOFF, true)
    Menu.combo:addParam("useW", "Use W in combo", SCRIPT_PARAM_ONOFF, true)
    Menu.combo:addParam("useE", "Use E in combo", SCRIPT_PARAM_ONOFF, true)
    Menu.combo:addParam("useR", "Use R in combo", SCRIPT_PARAM_ONOFF, true)
   Menu:addSubMenu("Kayle - Lasthit", "lasthit")
    Menu.lasthit:addParam("useQ", "Use Q to lasthit", SCRIPT_PARAM_ONOFF, false)
    Menu.lasthit:addParam("useE", "Use E to lasthit", SCRIPT_PARAM_ONOFF, true)
    Menu.lasthit:addParam("manaamount", "Don't use spells if mana < %", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
   Menu:addSubMenu("Kayle - Laneclear", "laneclear")
    Menu.laneclear:addParam("useQ", "Use Q in laneclear", SCRIPT_PARAM_ONOFF, true)
    Menu.laneclear:addParam("useE", "Use E in laneclear", SCRIPT_PARAM_ONOFF, true)
    Menu.laneclear:addParam("manaamount", "Don't use spells if mana < %", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
   Menu:addSubMenu("Kayle - Jungleclear", "jungleclear")
    Menu.jungleclear:addParam("useQ", "Use Q in jungleclear", SCRIPT_PARAM_ONOFF, true)
    Menu.jungleclear:addParam("useE", "Use E in jungleclear", SCRIPT_PARAM_ONOFF, true)
    Menu.jungleclear:addParam("manaamount", "Don't use spells if mana < %", SCRIPT_PARAM_SLICE, 25, 0, 100, 0)
   Menu:addSubMenu("Kayle - Auto-heal", "autoheal")
    Menu.autoheal:addParam("amount", "Auto-Heal if health < %", SCRIPT_PARAM_SLICE, 100, 0, 100, 0)
    Menu.autoheal:addParam("amountmana", "Don't auto-heal if mana > %", SCRIPT_PARAM_SLICE, 60, 0, 100, 0)
   Menu:addSubMenu("Kayle - Auto-ult", "autoult")
    Menu.autoult:addParam("amount", "Auto-Ult if health < %", SCRIPT_PARAM_SLICE, 5, 1, 100, 0)
    --Menu.autoult:addParam("recall", "Don't auto-ult on recall", SCRIPT_PARAM_ONOFF, true)
   Menu:addSubMenu("Extra's", "extra")
    Menu.extra:addParam("autolevel", "Auto-level skills", SCRIPT_PARAM_LIST, 1, {"No", "R>Q>E>W", "R>E>Q>W"})
  PrintChat("<font color = \"#81F781\">Kayle: The</font> <font color = \"#81F7F3\">angel</font> <font color = \"#81F781\">of</font> <font color = \"#FF0040\">elohell</font> <font color = \"#81F781\">by</font> <font color = \"#FFFF00\">ELSN</font> <font color = \"#81F781\">version "..version.."</font>")
end

function OnTick()
 ts:update()
 target = ts.target
 enemyMinions:update()
 jungleMinions:update()

  CDHandler()

  if Menu.Kb.combo then ComboMode() end
  if Menu.Kb.lasthit then LastHitMode() end
  if Menu.Kb.laneclear then LaneclearMode() end
  if Menu.Kb.jungleclear then JungleClearMode() end
  if Menu.Kb.autoheal then wCast() end
  if Menu.Kb.autoult then rCast() end
  if Menu.extra.autolevel ~= 1 then AutoLevel() end
end
  
function CDHandler()
    qReady = myHero:CanUseSpell(_Q) == READY
    wReady = myHero:CanUseSpell(_W) == READY
    eReady = myHero:CanUseSpell(_E) == READY
    rReady = myHero:CanUseSpell(_R) == READY
end 

function ComboMode()
  if target ~= nil then
    if Menu.combo.useQ then qCast() end
    if Menu.combo.useE then eCast() end
  end
    if Menu.combo.useW then wCast() end
    if Menu.combo.useR then rCast() end
end

function qCast() -- 
    if qReady and ValidTarget(target, qRange) then
      CastSpell(_Q, target)
    end
end

function wCast() -- Made this alot better
  if wReady and myHero.health < (myHero.maxHealth * (Menu.autoheal.amount/100)) and not Recalling then
    if not Menu.Kb.combo then
      if myHero.mana > (myHero.maxMana * (Menu.autoheal.amountmana/100)) then
        CastSpell(_W, myHero)
      end
    else CastSpell(_W, myHero)
    end
  end
end

function eCast() 
    if eReady and ValidTarget(target, eRange) then
      CastSpell(_E)
    end
end

function rCast() -- This still needs the update
  if rReady and myHero.health < (myHero.maxHealth * (Menu.autoult.amount/100)) then 
    CastSpell(_R, myHero)
    end
  end
end

function LastHitMode()
  for i, minion in pairs(enemyMinions.objects) do
    if minion ~= nil and myHero.mana > (myHero.maxMana * (Menu.lasthit.manaamount/100)) then
      if ValidTarget(minion, qRange) and Menu.lasthit.useQ and getDmg("Q", minion, myHero) >= minion.health then
        CastSpell(_Q, minion)
      end
      if ValidTarget(minion, eRange) and Menu.lasthit.useE and (getDmg("AD", minion, myHero) + (30)) >= minion.health then 
        CastSpell(_E)
      end
    end
  end
end

function LaneclearMode() -- Made this better in the last update
  for i, minion in pairs(enemyMinions.objects) do
    if minion ~= nil and ValidTarget(minion, qRange) and qReady and Menu.laneclear.useQ and myHero.mana > (myHero.maxMana * (Menu.laneclear.manaamount/100)) then
      if getDmg("Q", minion, myHero) >= minion.health then
        CastSpell(_Q, minion)
      else
        CastSpell(_Q, minion)
      end
    end
    if minion ~= nil and ValidTarget(minion, eRange) and eReady and Menu.laneclear.useE and myHero.mana > (myHero.maxMana * (Menu.laneclear.manaamount/100)) then
        CastSpell(_E)
    end
  end
end

function JungleClearMode() 
  for i, jminion in pairs(jungleMinions.objects) do
    if jminion ~= nil then
      if ValidTarget(jminion, qRange) and qReady and Menu.jungleclear.useQ and myHero.mana > (myHero.maxMana * (Menu.jungleclear.manaamount/100)) then
        CastSpell(_Q, jminion)
      end
      if ValidTarget(jminion, eRange) and eReady and Menu.jungleclear.useE and myHero.mana > (myHero.maxMana * (Menu.jungleclear.manaamount/100)) then
        CastSpell(_E)
      end
    end
  end
end

function AutoLevel() -- Added this in the last update
  if Menu.extra.autolevel == 2 then abilitySequence = {3, 1, 1, 2, 1, 4, 1, 3, 1, 3, 4, 3, 3, 2, 2, 4, 2, 2} 
  else abilitySequence = {3, 1, 3, 2, 3, 4, 3, 1, 3, 1, 4, 1, 1, 2, 2}
  end
  autoLevelSetSequence(abilitySequence)
end


function OnCreateObj(obj) -- Added this in the last update
  if obj and obj.name and obj.name:lower():find("teleport") and GetDistance(obj) < 30 then
    Recalling = true
   end
end

function OnDeleteObj(obj) -- Added this in the last update
  if obj and obj.name and obj.name:lower():find("teleport") and GetDistance(obj) < 30 then
    Recalling = false
  end
end


--[[ todo:
 - An AutoUpdater 
 - Disable Auto-ult on recall (and after -.-)
 - Better Last hit mode
 - Packet cast for VIP users
 - MMA/SAC support
 - Better Auto-ult
 - Item and ignite cast
 - Draws
 - W to Gapclose
 ]]--
