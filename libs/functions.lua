if not mavmins then mavmins = {} end

--init target vars

if initTargets ~= true then
	TARGET_MODE = "ONE"
	initTargets = true
	print("-------MAVMINS PROBABLY ENHANCEMENT V1.0-------")	
	print("1 Target Mode")	
end



if TIER16_CHECK ~= true then

	T_16 = 0
	
	local EnhanceT16 = {
	  99341, -- Head Heroic
	  99343, -- Shoulders Heroic
	  99347, -- Chest Heroic
	  99340, -- Gloves Heroic
	  99342, -- Legs Heroic
	 }
  
	for i=1, 19 do
		if GetInventoryItemID("player", i) ~= nil then
			for j=1, 5 do
				if GetItemInfo(GetInventoryItemID("player", i)) == GetItemInfo(EnhanceT16[j]) then
					T_16 = T_16 + 1
				end
			end
		end
	end	
	
	TIER16_CHECK = true	
end

if TIER15_CHECK ~= true then

	T_15 = 0
	
	local EnhanceT15 = {
	  96691, -- Head Heroic
	  96693, -- Shoulders Heroic
	  96689, -- Chest Heroic
	  96690, -- Gloves Heroic
	  96692, -- Legs Heroic
	 }
	
	for i=1, 19 do
		if GetInventoryItemID("player", i) ~= nil then
			for j=1, 5 do
				if GetItemInfo(GetInventoryItemID("player", i)) == GetItemInfo(EnhanceT15[j]) then
					T_15 = T_15 + 1
				end
			end
		end
	end	
	
	TIER15_CHECK = true	
end

function mavmins.t16_2pc()
	if T_16 >= 2 then
		return true
	end
end

function mavmins.t16_4pc()
	if T_16 == 4 then
		return true
	end
end

function mavmins.t15_2pc()
	if T_15 >= 2 then
		return true
	end
end

function mavmins.t15_4pc()
	if T_15 == 4 then
		return true
	end
end

--function mavmins.frostShockglyph()
--	local enabled2, glyphType2, glyphTooltipIndex2, glyphSpellID2, icon2 = GetGlyphSocketInfo(2)
--	local enabled4, glyphType4, glyphTooltipIndex4, glyphSpellID4, icon4 = GetGlyphSocketInfo(4)
--	local enabled6, glyphType6, glyphTooltipIndex6, glyphSpellID6, icon6 = GetGlyphSocketInfo(6)

--	if glyphSpellID2 == 55443 or glyphSpellID4 == 55443 or glyphSpellID6 == 55443 then
--		return true
--	end
--end

--function mavmins.fireElementalglyph()
--	local enabled2, glyphType2, glyphTooltipIndex2, glyphSpellID2, icon2 = GetGlyphSocketInfo(2)
--	local enabled4, glyphType4, glyphTooltipIndex4, glyphSpellID4, icon4 = GetGlyphSocketInfo(4)
--	local enabled6, glyphType6, glyphTooltipIndex6, glyphSpellID6, icon6 = GetGlyphSocketInfo(6)
	
--	if glyphSpellID2 == 55455 or glyphSpellID4 == 55455 or glyphSpellID6 ~= 55455 then
--		return true
--	end
--end

function mavmins.heroism()
 
	local HeroismSpells = {
		32182, --Heroism
		2825, --Bloodlust
		90355, --Ancient Hysteria
		80353, --Timewarp
		120351, --Drums of war
	}
 
	for i=1, 40 do
		if select(11, UnitBuff("player", i)) ~= nil then
			for y = 1, 5 do
				if select(11, UnitBuff("player", i)) == HeroismSpells[y] then
					return true
				end
			end
		end
	end
	
end


if not (totemX and totemY) then
	totemX,totemY = 0,0
end

function totemDistance()
		local totemName = select(2,GetTotemInfo(1)) or select(2,GetTotemInfo(2))
		local fire = GetSpellInfo(2894)
		local earth = GetSpellInfo(2062)

		if totemX ~= (0 or nil) and totemY ~= (0 or nil) and totemName ~= (fire or earth) then
			local a,b,c,d,e,f,g,h,i,j = GetAreaMapInfo(GetCurrentMapAreaID())
			local a1 , b1 = GetPlayerMapPosition("Player")
			local x1 , y1 = a1 * 1000, b1 * 1000
			local a2 , b2 = totemX, totemY
			local x2 , y2 = a2 * 1000, b2 * 1000
			local w = (d - e)
			local h = (f - g)
			local distance = sqrt(min(x1 - x2, w - (x1 - x2))^2 + min(y1 - y2, h - (y1-y2))^2)
			
			return distance
		else
			return 0
		end
end

function mavmins.SearingTotem()
	local TOT1, FIRTOTNAME, FIRstartTime, FIRduration = GetTotemInfo(1)
	distance = totemDistance()
	
	if TARGET_MODE == "SIX" then return false end
	
	if FIRTOTNAME ~= tostring(GetSpellInfo(2894)) then
		if TOT1 == false or distance > 25 or FIRTOTNAME ~= tostring(GetSpellInfo(3599)) then
			totemX,totemY = GetPlayerMapPosition("Player")
			return true
		end
	end
end

function mavmins.magmaTotem()
	local TOT1, FIRTOTNAME, FIRstartTime, FIRduration = GetTotemInfo(1) --fire totem

	distance = totemDistance()

	if TARGET_MODE == "SIX" then
		if FIRTOTNAME ~= tostring(GetSpellInfo(2894)) then
			if TOT1 == false or FIRTOTNAME ~= tostring(GetSpellInfo(8190)) or distance > 8 then
				totemX,totemY = GetPlayerMapPosition("Player") 
				return true
			end
		end
	end
end

function mavmins.fireElemental()
	local TOT1, TOTNAME, startTime, duration = GetTotemInfo(1)
	if TOTNAME ~= tostring(GetSpellInfo(2894)) then
		return true
	end
end

function mavmins.oneTarget()
	if TARGET_MODE == "ONE" then
		return true
	else
		return false
	end
end

function mavmins.twoTarget()
	if TARGET_MODE == "TWO" then
		return true
	end
end

function mavmins.threeTarget()
	if TARGET_MODE == "THREE" then
		return true
	end
end

function mavmins.sixTarget()
	if TARGET_MODE == "SIX" then
		return true
	end
end

function mavmins.Gloves()
	if IsPlayerSpell(110403) == true then
		if GetInventoryItemCooldown("player",10) == 0 then
			UseInventoryItem(10)
			return true
		end
	end
end

function mavmins.interruptCast()

	local castName,_,_,_, castStartTime, castEndTime, _, _, castInterruptable = UnitCastingInfo("target") 

			if select(9, UnitCastingInfo("target")) == false then
			
				local timeSinceStart = (GetTime() * 1000 - castStartTime) / 1000
				local timeLeft = ((GetTime() * 1000 - castEndTime) * -1) / 1000
				local castTime = castEndTime - castStartTime
				local currentPercent = timeSinceStart / castTime * 100000
			
				if currentPercent >= 40 then
					return true
				end 
				
			elseif UnitChannelInfo("target") ~= nil then
			
				if select(8, UnitChannelInfo("target")) == false then
					return true
				end
			end
	
end

-- Register library
ProbablyEngine.library.register("mavmins", mavmins)
