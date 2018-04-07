--local VUHDO_HEAL_COMM_REQUEST_VERSION = "999";
--local VUHDO_HEAL_COMM_REPLY_VERSION = "998";
local VUHDO_HEAL_COMM_SPELL_END = "001";
local VUHDO_HEAL_COMM_SPELL_DIRECT = "000";
local VUHDO_HEAL_COMM_SPELL_BINDING = "002";


local VUHDO_INC_HEAL = { };

local VUHDO_CLEANUP_INC_DELAY = 5;

--
function VUHDO_getIncHealOnName(aName)
	local tempAllInfos = VUHDO_INC_HEAL[aName];
	local tempSummand;
	if (tempAllInfos == nil) then
		return 0;
	end

	local tempInfo;
	local tempSumme = 0;

	for _, tempInfo in pairs(tempAllInfos) do
		tempSummand = tempInfo[2];
		-- This may happen if concurrent events occur
		if (tempSummand ~= nil) then
			tempSumme = tempSumme + tempSummand;
		end
	end

	return tempSumme;
end



--
function VUHDO_getIncHealOnUnit(aUnit)
	if (not VUHDO_CONFIG["SHOW_INCOMING"]) then
		return 0;
	end

	local tempName = VUHDO_RAID[aUnit].name;
	if (tempName == nil) then
		return 0;
	end

	return VUHDO_getIncHealOnName(tempName);
end



--
function VUHDO_addIncHeal(aCasterName, aTargetName, anAmount)
	if (VUHDO_INC_HEAL[aTargetName] == nil) then
		VUHDO_INC_HEAL[aTargetName] = { };
	end

	table.insert(VUHDO_INC_HEAL[aTargetName], { aCasterName, anAmount, GetTime() + VUHDO_CLEANUP_INC_DELAY });
	VUHDO_updateAllUnitButtons(VUHDO_RAID_NAMES[aTargetName]);
end



--
function VUHDO_clearIncHeal(aCasterName)
	local tempTargetName, tempAllCastInfos;
	local tempIndex, tempCastInfo, tempUnit;

	local tempCurrentTime = GetTime();

	for tempTargetName, tempAllCastInfos in pairs(VUHDO_INC_HEAL) do

		tempUnit = VUHDO_RAID_NAMES[tempTargetName];
		if (tempUnit == nil) then
			-- Obsolete raid member
			VUHDO_INC_HEAL[tempTargetName] = nil;
		else
			for tempIndex, tempCastInfo in pairs(tempAllCastInfos) do
				if (tempCastInfo[3] < tempCurrentTime or aCasterName == tempCastInfo[1]) then
					-- Cleanup too old entries also
					VUHDO_INC_HEAL[tempTargetName][tempIndex] = nil;
					VUHDO_updateAllUnitButtons(tempUnit);
				end
			end
		end
	end
end



--
-- pppAAAAAIza:Vuh:Panushkin:Izaak
function VUHDO_parseHealCommMessage(aMessage, aCasterName)
	if (not VUHDO_CONFIG["SHOW_INCOMING"]) then
		return;
	end

	if ((not VUHDO_CONFIG["SHOW_OWN_INCOMING"]) and VUHDO_PLAYER_NAME == aCasterName) then
		return;
	end

	local tempPrefix = strsub(aMessage, 1, 3);

	if (VUHDO_HEAL_COMM_SPELL_DIRECT == tempPrefix) then
		local tempAmount = tonumber(strsub(aMessage, 4, 8));
		local tempTargetName = strsub(aMessage, 9, -1);
		VUHDO_addIncHeal(aCasterName, tempTargetName, tempAmount);
	elseif (VUHDO_HEAL_COMM_SPELL_BINDING == tempPrefix) then
		local tempAmount = tonumber(strsub(aMessage, 4, 8));
		local tempTargets = VUHDO_splitString(strsub(aMessage, 9, -1), ":");
		local tempTargetName;
		for _, tempTargetName in pairs(tempTargets) do
			VUHDO_addIncHeal(aCasterName, tempTargetName, tempAmount);
		end
	elseif (VUHDO_HEAL_COMM_SPELL_END == tempPrefix) then
		VUHDO_clearIncHeal(aCasterName);
	end
end
