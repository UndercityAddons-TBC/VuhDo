local VUHDO_SPELL_TARGET_SELF = 1;            -- Heal target is player
local VUHDO_SPELL_TARGET_TARGET = 2;					-- Heal target is selected target
local VUHDO_SPELL_TARGET_GROUP_OWN = 3;       -- Heal target is players group
local VUHDO_SPELL_TARGET_GROUP_TARGET = 4;    -- Heal target is selected target's group
local VUHDO_SPELL_TARGET_SELF_TARGET = 5;     -- Heal target is player and selected target


local VUHDO_SPELL_TYPE_HOT = 1;  -- Spell type heal over time
local VUHDO_SPELL_TYPE_CAST = 2; -- Spell type is regular cast


-- target
-- type
-- casttime (auto)
-- regulartime
-- lasts
-- nobonus
-- icon (auto)
-- present (auto)
-- <rangx>.average (auto)
-- <rangx>.level { }
-- <rangx>.present (auto)
-- <rangx>.bonus

-- All healing spells and their ranks we will take notice of
VUHDO_SPELLS = {
	-- Paladin
  [VUHDO_I18N_FLASH_OF_LIGHT] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 1500,
		[1] = { ["level"] = 20 },
		[2] = { ["level"] = 26 },
		[3] = { ["level"] = 34 },
		[4] = { ["level"] = 42 },
		[5] = { ["level"] = 50 },
		[6] = { ["level"] = 58 },
		[7] = { ["level"] = 66 },
  },
  [VUHDO_I18N_HOLY_LIGHT] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 2500,
		[1] = { ["level"] = 1 },
		[2] = { ["level"] = 6 },
		[3] = { ["level"] = 14 },
		[4] = { ["level"] = 22 },
		[5] = { ["level"] = 30 },
		[6] = { ["level"] = 38 },
		[7] = { ["level"] = 46 },
		[8] = { ["level"] = 54 },
		[9] = { ["level"] = 60 },
		[10] = { ["level"] = 62 },
		[11] = { ["level"] = 70 },
  },

  -- Priest
  [VUHDO_I18N_FLASH_HEAL] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 1500,
		[1] = { ["level"] = 20 },
		[2] = { ["level"] = 26 },
		[3] = { ["level"] = 32 },
		[4] = { ["level"] = 38 },
		[5] = { ["level"] = 44 },
		[6] = { ["level"] = 50 },
		[7] = { ["level"] = 56 },
		[8] = { ["level"] = 61 },
		[9] = { ["level"] = 67 },
  },
  [VUHDO_I18N_RENEW] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_HOT,
		["regulartime"] = 0,
		[1] = { ["level"] = 8 },
		[2] = { ["level"] = 14 },
		[3] = { ["level"] = 20 },
		[4] = { ["level"] = 26 },
		[5] = { ["level"] = 32 },
		[6] = { ["level"] = 38 },
		[7] = { ["level"] = 44 },
		[8] = { ["level"] = 50 },
		[9] = { ["level"] = 56 },
		[10] = { ["level"] = 60 },
		[11] = { ["level"] = 65 },
		[12] = { ["level"] = 70 },
  },
  [VUHDO_I18N_LESSER_HEAL] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 2500,
		[1] = { ["level"] = 1 },
		[2] = { ["level"] = 4 },
		[3] = { ["level"] = 10 },
  },
  [VUHDO_I18N_HEAL] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 3000,
		[1] = { ["level"] = 16 },
		[2] = { ["level"] = 22 },
		[3] = { ["level"] = 28 },
		[4] = { ["level"] = 34},
  },
  [VUHDO_I18N_GREATER_HEAL] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 3000,
		[1] = { ["level"] = 40 },
		[2] = { ["level"] = 46 },
		[3] = { ["level"] = 52 },
		[4] = { ["level"] = 58 },
		[5] = { ["level"] = 60 },
		[6] = { ["level"] = 63 },
		[7] = { ["level"] = 68 },
  },
  [VUHDO_I18N_BINDING_HEAL] = {
  	["target"] = VUHDO_SPELL_TARGET_SELF_TARGET,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 1500,
		[1] = { ["level"] = 64 },
  },
  [VUHDO_I18N_PRAYER_OF_HEALING] = {
  	["target"] = VUHDO_SPELL_TARGET_GROUP_OWN,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 3000,
		[1] = { ["level"] = 30 },
		[2] = { ["level"] = 40 },
		[3] = { ["level"] = 50 },
		[4] = { ["level"] = 60 },
		[5] = { ["level"] = 60 },
		[6] = { ["level"] = 68 },
  },
  [VUHDO_I18N_CIRCLE_OF_HEALING] = {
  	["target"] = VUHDO_SPELL_TARGET_GROUP_TARGET,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 0,
		[1] = { ["level"] = 50 },
		[2] = { ["level"] = 56 },
		[3] = { ["level"] = 60 },
		[4] = { ["level"] = 65 },
		[5] = { ["level"] = 70 },
  },

  -- Shaman
  [VUHDO_I18N_HEALING_WAVE] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 3000,
		[1] = { ["level"] = 1 },
		[2] = { ["level"] = 6 },
		[3] = { ["level"] = 12 },
		[4] = { ["level"] = 18 },
		[5] = { ["level"] = 24 },
		[6] = { ["level"] = 32 },
		[7] = { ["level"] = 40 },
		[8] = { ["level"] = 48 },
		[9] = { ["level"] = 56 },
		[10] = { ["level"] = 60 },
		[11] = { ["level"] = 63 },
		[12] = { ["level"] = 70 },
  },
  [VUHDO_I18N_LESSER_HEALING_WAVE] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 1500,
		[1] = { ["level"] = 20 },
		[2] = { ["level"] = 28 },
		[3] = { ["level"] = 36 },
		[4] = { ["level"] = 44 },
		[5] = { ["level"] = 52 },
		[6] = { ["level"] = 60 },
		[7] = { ["level"] = 66 },
  },
  [VUHDO_I18N_CHAIN_HEAL] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 2500,
		[1] = { ["level"] = 40 },
		[2] = { ["level"] = 46 },
		[3] = { ["level"] = 54 },
		[4] = { ["level"] = 61 },
		[5] = { ["level"] = 68 },
  },

  -- Druid
  [VUHDO_I18N_REJUVENATION] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_HOT,
		["regulartime"] = 0,
		[1] = { ["level"] = 4 },
		[2] = { ["level"] = 10 },
		[3] = { ["level"] = 16 },
		[4] = { ["level"] = 22 },
		[5] = { ["level"] = 28 },
		[6] = { ["level"] = 34 },
		[7] = { ["level"] = 40 },
		[8] = { ["level"] = 46 },
		[9] = { ["level"] = 52 },
		[10] = { ["level"] = 58 },
		[11] = { ["level"] = 60 },
		[12] = { ["level"] = 63 },
		[13] = { ["level"] = 69 },
  },
  [VUHDO_I18N_HEALING_TOUCH] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_CAST,
		["regulartime"] = 3500,
		[1] = { ["level"] = 1 },
		[2] = { ["level"] = 8 },
		[3] = { ["level"] = 14 },
		[4] = { ["level"] = 20 },
		[5] = { ["level"] = 26 },
		[6] = { ["level"] = 32 },
		[7] = { ["level"] = 38 },
		[8] = { ["level"] = 44 },
		[9] = { ["level"] = 50 },
		[10] = { ["level"] = 56 },
		[11] = { ["level"] = 60 },
		[12] = { ["level"] = 62 },
		[13] = { ["level"] = 69 },
  },
  [VUHDO_I18N_REGROWTH] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_HOT,
		["regulartime"] = 2000,
		[1] = { ["level"] = 12 },
		[2] = { ["level"] = 18 },
		[3] = { ["level"] = 24 },
		[4] = { ["level"] = 30 },
		[5] = { ["level"] = 36 },
		[6] = { ["level"] = 42 },
		[7] = { ["level"] = 48 },
		[8] = { ["level"] = 54 },
		[9] = { ["level"] = 60 },
		[10] = { ["level"] = 65 },
  },
  [VUHDO_I18N_LIFEBLOOM] = {
  	["target"] = VUHDO_SPELL_TARGET_TARGET,
		["type"] = VUHDO_SPELL_TYPE_HOT,
		["regulartime"] = 0,
		[1] = { ["level"] = 64 },
  },
};



-- Patterns for all base healing amount tooltip texts
local VUHDO_TOOLTIPS_AMOUNT = {
	VUHDO_I18N_TOOLTIP_FOR_1,
	VUHDO_I18N_TOOLTIP_FOR_2,
	VUHDO_I18N_TOOLTIP_FOR_3,
	VUHDO_I18N_TOOLTIP_FOR_4,
	VUHDO_I18N_TOOLTIP_FOR_5,
	VUHDO_I18N_TOOLTIP_FOR_6,
	VUHDO_I18N_TOOLTIP_FOR_7,
	VUHDO_I18N_TOOLTIP_FOR_8,
	VUHDO_I18N_TOOLTIP_FOR_9,
};



-- Patterns for all additional healing amount tooltip texts
local VUHDO_TOOLTIPS_MORE_AMOUNT = {
	VUHDO_I18N_TOOLTIP_MORE_1,
	VUHDO_I18N_TOOLTIP_MORE_2,
};



-- Patterns for additional spell duration
local VUHDO_TOOLTIPS_DURATION = {
	VUHDO_I18N_TOOLTIP_UBER_1,
	VUHDO_I18N_TOOLTIP_UBER_2,
};



-- parses base and additional healing amounts from a tooltip line by text patterns
function VUHDO_parseTooltipText(aSpellInfo, aText, aSpellName, aSpellRank)
	local tempPattern;
	local tempStart, tempEnd, tempValue1, tempValue2;

	local tempRankNum = VUHDO_getSpellRankNum(aSpellRank);
	if (aSpellInfo[tempRankNum] == nil) then
		aSpellInfo[tempRankNum] = { };
	end

	-- Healing amount
	for _, tempPattern in ipairs(VUHDO_TOOLTIPS_AMOUNT) do
		tempStart, tempEnd, tempValue1, tempValue2 = strfind(aText, tempPattern);

		if (tempStart ~= nil and tempEnd ~= nil) then
			if (tempValue2 ~= nil) then
				--VUHDO_Msg(aSpellName .. " heilt von: " .. tempValue1 .. " bis: " .. tempValue2);
				aSpellInfo[tempRankNum]["average"] = (tempValue1 + tempValue2) / 2;
				break;
			elseif (tempValue1 ~= nil) then
				--VUHDO_Msg(aSpellName .. " heilt fix: " .. tempValue1);
				aSpellInfo[tempRankNum]["average"] = tonumber(tempValue1);
				break;
			end
		end
	end

	-- Additional healing
	for _, tempPattern in ipairs(VUHDO_TOOLTIPS_MORE_AMOUNT) do
		tempStart, tempEnd, tempValue1, tempValue2 = strfind(aText, tempPattern);

		if (tempStart ~= nil and tempEnd ~= nil) then
			if (tempValue2 ~= nil) then
				--VUHDO_Msg(aSpellName .. " weitere von: " .. tempValue1 .. " bis: " .. tempValue2);
				aSpellInfo[tempRankNum]["average"] = aSpellInfo[tempRankNum]["average"] + (tempValue1 + tempValue2) / 2;
				break;
			elseif (tempValue1 ~= nil) then
				--VUHDO_Msg(aSpellName .. " weitere fix: " .. tempValue1);
				aSpellInfo[tempRankNum]["average"] = aSpellInfo[tempRankNum]["average"] + tempValue1;
				break;
			end
		end
	end

end



-- sets a spell into a virtual tooltip and scans informations from its text lines
function VUHDO_scanSpell(aSpellInfo, aSpellName, aSpellRank, aSpellId)
	local tempCastTime, tempIcon;
	local tempTooltipTexts = { };
	local tempText;
	local tempFrom, tempTo;

	_, _, tempIcon, _, _, _, tempCastTime, _, _ = GetSpellInfo(aSpellName, aSpellRank);

	aSpellInfo["casttime"] = tempCastTime;
	aSpellInfo["icon"] = tempIcon;

	if (not VuhDoScanTooltip:IsOwned(this)) then
  	VuhDoScanTooltip:SetOwner(this, 'ANCHOR_NONE');
  	VuhDoScanTooltip:ClearLines();
  end

	VuhDoScanTooltip:SetSpell(aSpellId, BOOKTYPE_SPELL);

	table.insert(tempTooltipTexts, getglobal("VuhDoScanTooltipTextLeft2"):GetText());
	table.insert(tempTooltipTexts, getglobal("VuhDoScanTooltipTextLeft3"):GetText());
	table.insert(tempTooltipTexts, getglobal("VuhDoScanTooltipTextLeft4"):GetText());
	table.insert(tempTooltipTexts, getglobal("VuhDoScanTooltipTextRight2"):GetText());
	table.insert(tempTooltipTexts, getglobal("VuhDoScanTooltipTextRight3"):GetText());
	table.insert(tempTooltipTexts, getglobal("VuhDoScanTooltipTextRight4"):GetText());

	for	_, tempText in pairs(tempTooltipTexts) do
		if (tempText ~= nil) then
			VUHDO_parseTooltipText(aSpellInfo, tempText, aSpellName, aSpellRank);
		end
	end

	if (aSpellInfo[VUHDO_getSpellRankNum(aSpellRank)].average == nil) then
		VUHDO_Msg("WARNING: Spell average healing of " .. aSpellName .. " " .. aSpellRank .. " could not be determined!", 1, 0.4, 0.4);
		aSpellInfo[VUHDO_getSpellRankNum(aSpellRank)].average = 0;
	end
end



-- initializes some dynamic information into VUHDO_SPELLS
function VUHDO_initFromSpellbook()
	local tempCnt;
	local tempSpellName, tempSpellRank, tempRankNum;

	tempCnt = 1;
	while (true) do
		tempSpellName, tempSpellRank = GetSpellName(tempCnt, BOOKTYPE_SPELL);
		if (tempSpellName == nil) then
			break;
		end

		if (tempSpellRank == nil or tempSpellRank == "") then
			tempSpellRank = VUHDO_I18N_RANK .. " 1"; -- dummy index
		end

		tempRankNum = VUHDO_getSpellRankNum(tempSpellRank);
		if (VUHDO_SPELLS[tempSpellName] ~= nil and VUHDO_SPELLS[tempSpellName][tempRankNum] ~= nil) then
			VUHDO_SPELLS[tempSpellName].present = true;
			VUHDO_SPELLS[tempSpellName][tempRankNum].present = true;

			VUHDO_scanSpell(VUHDO_SPELLS[tempSpellName], tempSpellName, tempSpellRank, tempCnt);
			VUHDO_setBonusHealing(tempSpellName, tempRankNum);
		end

		tempCnt = tempCnt + 1;
	end
end



-- Sets effective bonus healing from equip into VUHDO_SPELLS for a spell and a spell rank
function VUHDO_setBonusHealing(aSpellName, aSpellRankNum)
	--VUHDO_Msg("SpellName is" .. aSpellName .. " Rank: " .. aSpellRankNum);

	local tempSpellInfo = VUHDO_SPELLS[aSpellName];
	local tempRankInfo = tempSpellInfo[aSpellRankNum];

	if (tempSpellInfo.nobonus) then
		tempRankInfo.bonus = 0;
	else
		local tempBonusHealing = GetSpellBonusHealing();
		local tempMalusFactor = 1;

		if (tempRankInfo.level < 20) then
			tempMalusFactor = 1 - ((20 - tempRankInfo.level) * 0.0375);
		end

		local tempNormTime;

		if (tempSpellInfo.regulartime >= 1500 and tempSpellInfo.regulartime < 3000) then
			tempNormTime = tempSpellInfo.regulartime;
		else
			tempNormTime = 3000;
		end

		local tempBonusEffective = tempBonusHealing * tempMalusFactor * (tempNormTime / 3000);
		local tempDownScaleMalus = (tempRankInfo.level + 6) / UnitLevel("player");

		if (tempDownScaleMalus < 1) then
			tempBonusEffective = tempBonusEffective * tempDownScaleMalus;
		end

		tempRankInfo.bonus = floor(tempBonusEffective);
	end
end



-- Returns the real value a heal spell will heal for by average
function VUHDO_getEffectiveHealing(aSpellName, aSpellRankNum)
	--VUHDO_Msg("Spell: " .. aSpellName .. " Rank:" .. aSpellRankNum);
	local tempRankInfo = VUHDO_SPELLS[aSpellName][aSpellRankNum];
	return tempRankInfo.average + tempRankInfo.bonus;
end



-- returns spell name and rank most suitable for a Units health missing
function VUHDO_getSpellForLifeDeficit(aDeficitAmount)
	local tempBestDelta = 999999; -- initial way bad difference
	local tempBestSpell = nil;
	local tempBestRank = nil;

	local tempCurName, tempCurRankNum;
	local tempCurSpellInfo, tempCurRankInfo;
	local tempCurAmount, tempCurDelta;
	local tempCastTime;

	for tempCurName, tempCurSpellInfo in pairs(VUHDO_SPELLS) do
		if (tempCurSpellInfo.present) then
			for tempCurRankNum = 1, 9999 do
				tempCurRankInfo = tempCurSpellInfo[tempCurRankNum];

				if (tempCurRankInfo == nil or not tempCurRankInfo.present) then
					break;
				end

				if (tempCurSpellInfo.target == VUHDO_SPELL_TARGET_TARGET) then
					tempCurAmount = VUHDO_getEffectiveHealing(tempCurName, tempCurRankNum);
					tempCastTime = tempCurSpellInfo.casttime;
					if (tempCastTime < 1500) then
						tempCastTime = 1500;
					end

					tempCurDelta = abs(aDeficitAmount - tempCurAmount) * (tempCastTime/1000);

					if (tempCurDelta < tempBestDelta) then
						tempBestDelta = tempCurDelta;
						tempBestSpell = tempCurName;
						tempBestRank = tempCurRankNum;
					end
				end

			end
		end
	end

	return tempBestSpell, tempBestRank;
end



-- Return the most suitable rank of a Spell for a Units HP missing
function VUHDO_getSpellRankForLifeDeficit(aSpellName, aDeficitAmount)
	local tempBestDelta = 999999; -- initial way bad difference
	local tempBestRank = nil;

	local tempCurRankNum;
	local tempCurSpellInfo, tempCurRankInfo;
	local tempCurAmount, tempCurDelta;

	if (VUHDO_SPELLS[aSpellName].present) then
		tempCurSpellInfo = VUHDO_SPELLS[aSpellName];
		for tempCurRankNum = 1, 9999 do
			tempCurRankInfo = tempCurSpellInfo[tempCurRankNum];

			if (tempCurRankInfo == nil or not tempCurRankInfo.present) then
				break;
			end

			tempCurAmount = VUHDO_getEffectiveHealing(aSpellName, tempCurRankNum);
			tempCurDelta = abs(aDeficitAmount - tempCurAmount);

			if (tempCurDelta < tempBestDelta) then
				tempBestDelta = tempCurDelta;
				tempBestRank = tempCurRankNum;
			end
		end
	end

	return tempBestRank;
end
