VUHDO_RAID = { };
VUHDO_GROUPS = { };
VUHDO_RAID_SORTED = { };
VUHDO_RAID_NAMES = { };
VUHDO_RAID_GUIDS = { };
VUHDO_EMERGENCIES = { };
VUHDO_MAINTANKS = { };
VUHDO_PROFILES = nil;
VUHDO_PLAYER_TARGETS = { };
VUHDO_PLAYER_CLASS = nil;
VUHDO_PLAYER_NAME = nil;
VUHDO_PLAYER_RAID_ID = nil;
local VUHDO_RESURRECTIONS = { };
local VUHDO_IS_RESURRECTING = false;

VUHDO_GLOBAL = getfenv();

--
function VUHDO_updateAllRaidNames()
	local tempUnit, tempInfo;

	VUHDO_RAID_NAMES = { };
	for tempUnit, tempInfo in pairs(VUHDO_RAID) do
		VUHDO_RAID_NAMES[tempInfo.name] = tempUnit;
	end
	-- SPELLCAST_SENT will report "player" in favor of "raidxx"
	VUHDO_RAID_NAMES["player"] = VUHDO_PLAYER_NAME;
end



--
function VUHDO_setAggroByName(aName, anHasAggro)
	if (not VUHDO_CONFIG["DETECT_AGGRO"]) then
		return;
	end

	local tempUnit = VUHDO_RAID_NAMES[aName];

	if (tempUnit ~= nil) then
		VUHDO_RAID[tempUnit].aggro = anHasAggro;
	end
end



--
function VUHDO_updateAllAggro()
	local tempUnit, tempInfo;
	local tempAggroOldArray = { };

	for tempUnit, tempInfo in pairs(VUHDO_RAID) do
		tempAggroOldArray[tempUnit] = tempInfo.aggro;
		tempInfo.aggro = false;
	end

	for tempUnit, tempInfo in pairs(VUHDO_RAID) do
		if (UnitIsEnemy(tempUnit, tempUnit .. "target")) then
			if (UnitIsFriend(tempUnit, tempUnit .. "targettarget")) then
				VUHDO_setAggroByName(UnitName(tempUnit .. "targettarget"), true);
			end
		end

		if (UnitIsEnemy(tempUnit, tempUnit .. "focus")) then
			if (UnitIsFriend(tempUnit, tempUnit .. "focustarget")) then
				VUHDO_setAggroByName(UnitName(tempUnit .. "focustarget"), true);
			end
		end
	end

	for tempUnit, tempInfo in pairs(VUHDO_RAID) do
		if (tempInfo.aggro ~= tempAggroOldArray[tempUnit]) then
 			VUHDO_updateAllUnitButtons(tempUnit);
 		end
	end
end



--
function VUHDO_isValidEmergency(aUnit)
	if (UnitIsDeadOrGhost(aUnit)
			or not UnitIsConnected(aUnit)
			or VUHDO_RAID[aUnit].charmed) then
		return false;
	end

	local tempInfo = VUHDO_RAID[aUnit];
	if (not tempInfo.range) then
		return false;
	end

	local tempHealthPerc = VUHDO_getUnitHealthPercent(tempInfo);
	if (tempHealthPerc >= VUHDO_CONFIG["EMERGENCY_TRIGGER"]) then
		return false;
	end

	return true;
end



--
function VUHDO_setTopEmergencies(aMaxNumber)
	local tempUnit;
	VUHDO_EMERGENCIES = { };

	for _, tempUnit in ipairs(VUHDO_RAID_SORTED) do
		if (VUHDO_isValidEmergency(tempUnit)) then
			table.insert(VUHDO_EMERGENCIES, tempUnit);
			if (table.getn(VUHDO_EMERGENCIES) == aMaxNumber) then
				break;
			end
		end
	end
end



--
function VUHDO_sortRaidTable()
	if (VUHDO_MODE_NEUTRAL == VUHDO_CONFIG["MODE"]) then
		return;
	end

	local tempUnit, tempInfo;
	VUHDO_RAID_SORTED = { };
	local tempInfoA, tempInfoB;
	local tempMode = VUHDO_CONFIG["MODE"];

	for tempUnit, tempInfo in pairs(VUHDO_RAID) do
		if (VUHDO_getUnitHealthPercent(tempInfo) <= VUHDO_CONFIG["EMERGENCY_TRIGGER"]) then
			table.insert(VUHDO_RAID_SORTED, tempUnit);
		end
	end

	table.sort(VUHDO_RAID_SORTED,
		function(aUnit, anotherUnit)
			tempInfoA = VUHDO_RAID[aUnit];
			tempInfoB = VUHDO_RAID[anotherUnit];

			if (tempMode == VUHDO_MODE_EMERGENCY_MOST_MISSING) then
				return (tempInfoA.healthmax - tempInfoA.health
						> tempInfoB.healthmax - tempInfoB.health);
			elseif (tempMode == VUHDO_MODE_EMERGENCY_PERC) then
				return (tempInfoA.health / tempInfoA.healthmax
						< tempInfoB.health / tempInfoB.healthmax);
			else -- VUHDO_MODE_EMERGENCY_LEAST_LEFT
				return tempInfoA.health < tempInfoB.health;
			end
		end
	);

	VUHDO_setTopEmergencies(VUHDO_CONFIG["MAX_EMERGENCIES"]);
end



-- Returns health of unit info in Percent
function VUHDO_getUnitHealthPercent(anInfo, aModifier)
	if (anInfo.healthmax == 0) then
		return 0;
	end

	local tempHealth = anInfo.health;
	if (aModifier ~= nil) then
		tempHealth = tempHealth + aModifier;
	end

	local tempPerc = (tempHealth / anInfo.healthmax) * 100;

	if (tempPerc > 100) then
		return 100.1; -- Flag for detecting overheal
	else
		return tempPerc;
	end
end



-- Returns power of unit info in Percent
function VUHDO_getUnitPowerPercent(anInfo)
	if (anInfo.powermax == 0) then
		return 0;
	end

	return (anInfo.power / anInfo.powermax) * 100;
end



-- Avoid reordering sorting by max-health if someone dies or gets offline
function VUHDO_getUnitHealthMax(aUnit)
	if (UnitIsDeadOrGhost(aUnit) or not UnitIsConnected(aUnit)) then
		if (VUHDO_RAID[aUnit] ~= nil) then
			return VUHDO_RAID[aUnit].healthmax;
		end
	end

	return UnitHealthMax(aUnit);
end



-- Sets a Member info into raid array
function VUHDO_setHealth(aUnit, anUpdateMode, aPowerType)
	local tempUnitId, tempPetUnitId, _ = VUHDO_getUnitIds();
	local tempIsPet = strfind(aUnit, tempPetUnitId) ~= nil;

	if (strfind(aUnit, tempUnitId) ~= nil
		or tempIsPet
		or strfind(aUnit, "player") ~= nil) then

		if (VUHDO_UPDATE_ALL == anUpdateMode) then
			local tempClassName;
			_, tempClassName = UnitClass(aUnit);

			local tempMemberInfo = {
				["healthmax"] = VUHDO_getUnitHealthMax(aUnit),
				["health"] = UnitHealth(aUnit),
				["name"] = UnitName(aUnit),
				["number"] = VUHDO_getUnitNo(aUnit),
				["unit"] = aUnit,
				["class"] = tempClassName,
				["range"] = VUHDO_isInRange(aUnit),
				["debuff"] = VUHDO_determineDebuff(aUnit, tempClassName),
				["isPet"] = tempIsPet,
				["powertype"] = tonumber(UnitPowerType(aUnit)),
				["power"] = UnitMana(aUnit),
				["powermax"] = UnitManaMax(aUnit),
				["charmed"] = VUHDO_isUnitCharmed(aUnit),
				["aggro"] = false,
				["group"] = VUHDO_getUnitGroup(aUnit, tempIsPet),
				["clTimestamp"] = 0
			};

			VUHDO_RAID[aUnit] = tempMemberInfo;

		elseif (VUHDO_RAID[aUnit] ~= nil and UnitExists(aUnit)) then

			if(VUHDO_UPDATE_HEALTH == anUpdateMode) then
				VUHDO_RAID[aUnit]["health"] = UnitHealth(aUnit);
			elseif(VUHDO_UPDATE_HEALTH_MAX == anUpdateMode) then
				VUHDO_RAID[aUnit]["healthmax"] = VUHDO_getUnitHealthMax(aUnit);
			elseif(VUHDO_UPDATE_DEBUFF == anUpdateMode) then
				VUHDO_RAID[aUnit]["debuff"] = VUHDO_determineDebuff(aUnit, VUHDO_RAID[aUnit].class);
			elseif(VUHDO_UPDATE_RANGE == anUpdateMode) then
				VUHDO_RAID[aUnit]["range"] = VUHDO_isInRange(aUnit);
			elseif(VUHDO_UPDATE_POWER == anUpdateMode) then
				VUHDO_RAID[aUnit]["powertype"] = tonumber(aPowerType);
				VUHDO_RAID[aUnit]["power"] = UnitMana(aUnit);
			elseif(VUHDO_UPDATE_POWER_MAX == anUpdateMode) then
				VUHDO_RAID[aUnit]["powertype"] = tonumber(aPowerType);
				VUHDO_RAID[aUnit]["powermax"] = UnitManaMax(aUnit);
			elseif(VUHDO_UPDATE_TARGET == anUpdateMode) then
				-- nothing, just update buttons
			end

		else -- Update für unbekanntes Raid-Member? Lieber mal neu laden

			if (VUHDO_RELOAD_RAID_TIMER <= 0 and not VUHDO_IS_RELOADING) then
				VUHDO_RELOAD_RAID_TIMER = VUHDO_RELOAD_RAID_DELAY_QUICK;
			end

		end
	end
end



-- Callback for UNIT_HEALTH / UNIT_MAXHEALTH events
function VUHDO_updateHealth(aUnit, anUpdateMode, aPowerType)
	if (VUHDO_RAID[aUnit] == nil) then
		return;
	end

	--VUHDO_initProfiler();

	--local tempCnt;
	--@TESTING
	--for tempCnt = 1, 1000 do
		VUHDO_setHealth(aUnit, anUpdateMode, aPowerType);

		if (VUHDO_MODE_NEUTRAL == VUHDO_CONFIG["MODE"]) then
			VUHDO_updateAllUnitButtons(aUnit);
		else
			local tempUnit;
			for tempUnit, _ in pairs(VUHDO_RAID) do
				VUHDO_updateAllUnitButtons(tempUnit);
			end
		end
	--end
	--VUHDO_seeProfiler();
end



--
function VUHDO_addUnitToGroup(aUnit, aGroupNum)
	if (VUHDO_GROUPS[aGroupNum] == nil) then
		VUHDO_GROUPS[aGroupNum] = { };
	end

	table.insert(VUHDO_GROUPS[aGroupNum], aUnit);
end



--
function VUHDO_addUnitToClass(aUnit, aClassFileName)
	if (aClassFileName == nil) then
		return;
	end

	local tempModelId = VUHDO_CLASS_IDS[aClassFileName];

	if (VUHDO_GROUPS[tempModelId] == nil) then
		VUHDO_GROUPS[tempModelId] = { };
	end

	table.insert(VUHDO_GROUPS[tempModelId], aUnit);
end



-- @TESTING: This doesn't seem to work pre WotLK
function VUHDO_addUnitToSpecial(aUnit, aRole)
	--if (aRole ~= nil) then
		--VUHDO_Msg("Role: " .. aRole);
	--end

  -- MTs
	if ("MAINTANK" == aRole) then
		if (VUHDO_GROUPS[VUHDO_ID_MAINTANKS] == nil) then
			VUHDO_GROUPS[VUHDO_ID_MAINTANKS] = { };
		end

		table.insert(VUHDO_GROUPS[VUHDO_ID_MAINTANKS], aUnit);
	end

	-- Main Assist
	if ("MAINASSIST" == aRole) then
		if (VUHDO_GROUPS[VUHDO_ID_MAINASSIST] == nil) then
			VUHDO_GROUPS[VUHDO_ID_MAINASSIST] = { };
		end

		table.insert(VUHDO_GROUPS[VUHDO_ID_MAINASSIST], aUnit);
	end
end



--
function VUHDO_addUnitToCtraMainTanks()
	if (VUHDO_GROUPS[VUHDO_ID_MAINTANKS] == nil or table.getn(VUHDO_GROUPS[VUHDO_ID_MAINTANKS]) == 0) then
		VUHDO_GROUPS[VUHDO_ID_MAINTANKS] = { };
		local tempCnt;
		local tempUnit;

		for tempCnt = 1, VUHDO_MAX_MTS do
			tempUnit = VUHDO_MAINTANKS[tempCnt];
			if (tempUnit ~= nil) then
				table.insert(VUHDO_GROUPS[VUHDO_ID_MAINTANKS], tempUnit);
			end
		end
	end
end



--
function VUHDO_addUnitToOwnPlayerTargets()
	local tempUnit, tempName;

	if (VUHDO_GROUPS[VUHDO_ID_MAINASSIST] == nil) then
		VUHDO_GROUPS[VUHDO_ID_MAINASSIST] = { };
	end

	for tempName, _ in pairs(VUHDO_PLAYER_TARGETS) do
		tempUnit = VUHDO_getUnitFromName(tempName);
		if (tempUnit ~= nil) then
			table.insert(VUHDO_GROUPS[VUHDO_ID_MAINASSIST], tempUnit);
		else
			VUHDO_PLAYER_TARGETS[tempName] = nil;
		end
	end

end



--
function VUHDO_addUnitToPets(aPetUnit)
	if (VUHDO_GROUPS[VUHDO_ID_PETS] == nil) then
		VUHDO_GROUPS[VUHDO_ID_PETS] = { };
	end

	table.insert(VUHDO_GROUPS[VUHDO_ID_PETS], aPetUnit);
end



--
function 	VUHDO_updateGroupArrays()
	local tempUnit, tempInfo;
	local tempIsInRaid = UnitInRaid("player");

	VUHDO_GROUPS = { };

	for tempUnit, tempInfo in pairs(VUHDO_RAID) do
		if (not tempInfo.isPet) then
			VUHDO_addUnitToGroup(tempUnit, VUHDO_RAID[tempUnit].group);
			VUHDO_addUnitToClass(tempUnit, tempInfo.class);
			--VUHDO_addUnitToSpecial(tempUnit, tempRole); -- doesn't work yet
	  else
	  	VUHDO_addUnitToPets(tempUnit);
		end
	end

	VUHDO_addUnitToCtraMainTanks();
	VUHDO_addUnitToOwnPlayerTargets();
	VUHDO_initDynamicPanelModels();
end



--
function VUHDO_isUnitInModel(aUnit, aModelId)
	local tempModelType = VUHDO_getModelType(aModelId);

	if (VUHDO_ID_TYPE_GROUP == tempModelType) then
		return aModelId == VUHDO_RAID[aUnit].group;
	elseif(VUHDO_ID_TYPE_CLASS == tempModelType) then
		return aModelId == VUHDO_CLASS_IDS[VUHDO_RAID[aUnit].class];
	else
		return aModelId == VUHDO_ID_PETS and VUHDO_RAID[aUnit].isPet;
	end
end



--
function VUHDO_isUnitInPanel(aPanelNum, aUnit)
	local tempModelId;

	for _, tempModelId in pairs(VUHDO_PANEL_MODELS[aPanelNum]) do
		if (VUHDO_isUnitInModel(aUnit, tempModelId)) then
			return true;
		end
	end

	return false;
end



-- For LOOSE ordering Uniquely buffer all units defined in a panel
function VUHDO_updateAllPanelUnits()
	local tempUnit;
	local tempPanelNum;
	local tempPanelUnits;
	VUHDO_PANEL_UNITS = { };

	for tempPanelNum, _ in pairs(VUHDO_PANEL_MODELS) do
		if (VUHDO_PANEL_SETUP[tempPanelNum]["MODEL"].ordering == VUHDO_ORDERING_LOOSE) then

			tempPanelUnits = { };
			for tempUnit, _ in pairs(VUHDO_RAID) do
				if (VUHDO_isUnitInPanel(tempPanelNum, tempUnit)) then
					tempPanelUnits[tempUnit] = tempUnit;
				end
			end

			VUHDO_PANEL_UNITS[tempPanelNum]	= { };
			for _, tempUnit in pairs(tempPanelUnits) do
				table.insert(VUHDO_PANEL_UNITS[tempPanelNum], tempUnit);
			end

		end
	end
end



--
function VUHDO_updateAllGuids()
	VUHDO_RAID_GUIDS = { };
	for tempUnit, _ in pairs(VUHDO_RAID) do
		VUHDO_RAID_GUIDS[UnitGUID(tempUnit)] = tempUnit;
	end
end



--
function VUHDO_discardOldMainTanks()
	local tempCnt, tempMt;
	for tempCnt = 1, VUHDO_MAX_MTS do
		tempMt = VUHDO_MAINTANK_NAMES[tempCnt];
		if (tempMt ~= nil and VUHDO_RAID_NAMES[tempMt] == nil) then
			VUHDO_MAINTANK_NAMES[tempCnt] = nil;
		end
	end
end



-- Reload all raid members into the raid array e.g. in case of raid roster change
function VUHDO_reloadRaidMembers()
	local i;
	local tempPlayer, tempPet;

	local tempUnit, tempPetUnit, tempMaxMembers = VUHDO_getUnitIds();

	VUHDO_RAID = { };

	if (tempMaxMembers > 0) then
		for i = 1, tempMaxMembers do
			tempPlayer = tempUnit .. i;
			if (UnitExists(tempPlayer)) then
				VUHDO_setHealth(tempPlayer, VUHDO_UPDATE_ALL);
			end

			tempPet = tempPetUnit .. i;
			if (UnitExists(tempPet)) then
				VUHDO_setHealth(tempPet, VUHDO_UPDATE_ALL);
			end
		end

		if (not UnitInRaid("player")) then
			VUHDO_setHealth("player", VUHDO_UPDATE_ALL);

			if (UnitExists("playerpet")) then
				VUHDO_setHealth("playerpet", VUHDO_UPDATE_ALL);
			end
		end
	else
		if (UnitExists(tempUnit)) then
			VUHDO_setHealth(tempUnit, VUHDO_UPDATE_ALL);
		end
		if (UnitExists(tempPetUnit)) then
			VUHDO_setHealth(tempPetUnit, VUHDO_UPDATE_ALL);
		end
	end
	VUHDO_updateAllRaidNames();
	VUHDO_discardOldMainTanks();
	VUHDO_convertMainTanks();
	VUHDO_updateGroupArrays();
	VUHDO_sortRaidTable();
	VUHDO_updateAllPanelUnits();
	VUHDO_updateAllGuids();

	VUHDO_PLAYER_RAID_ID = VUHDO_getPlayerRaidUnit();
end



--
function VUHDO_updateRange()
	local tempUnit, tempInfo;

  for tempUnit, tempInfo in pairs(VUHDO_RAID) do
  	local tempIsInRange = VUHDO_isInRange(tempUnit);
  	if (tempInfo.range ~= tempIsInRange) then
  		tempInfo.range = tempIsInRange;
			VUHDO_updateAllUnitButtons(tempUnit);
  	end
  end
end



--
function VUHDO_isBeingResurrected(aUnit)
	return VUHDO_RESSING_NAMES[VUHDO_RAID[aUnit].name] ~= nil;
end



--
function VUHDO_spellcastStop(aUnit)
	if ("player" ~= aUnit) then
		return;
	end

	if (VUHDO_IS_RESURRECTING) then
		VUHDO_sendCtraMessage("RESNO");
		VUHDO_IS_RESURRECTING = false;
	end
end



--
function VUHDO_spellcastSent(aUnit, aSpellName, aSpellRank, aTargetName)
	-- not necessary as only sent for player unit
	if ("player" ~= aUnit) then
		return;
	end

	if (VUHDO_isSpellResurrection(aSpellName) and aTargetName ~= nil) then
    VUHDO_sendCtraMessage("RES " .. aTargetName);
		VUHDO_IS_RESURRECTING = true;
	end
end
