--
function VUHDO_getDebuffColor(anInfo)
	if (anInfo.charmed) then
		return VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"];
	end

	return VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. anInfo.debuff];
end



--
function VUHDO_hasUnitInfoDebuff(anInfo)
	return (anInfo.debuff ~= VUHDO_DEBUFF_TYPE_NONE)
		or anInfo.charmed;
end



--
function VUHDO_isDebuffRelevant(aDebuffName, aUnitClassFileName)
	if (VUHDO_IGNORE_DEBUFFS_BY_CLASS[aUnitClassFileName][aDebuffName]) then
		return false;
	end

	if (VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_NO_HARM"] and VUHDO_IGNORE_DEBUFFS_NO_HARM[aDebuffName]) then
		return false;
	end

	if (VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_MOVEMENT"] and VUHDO_IGNORE_DEBUFFS_MOVEMENT[aDebuffName]) then
		return false;
	end

	if (VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_DURATION"] and VUHDO_IGNORE_DEBUFFS_DURATION[aDebuffName]) then
		return false;
	end

	return true;
end



--
function VUHDO_isUnitCharmed(aUnit)
	if (not VUHDO_CONFIG["DETECT_DEBUFFS"]) then
		return false;
	end

	return UnitIsCharmed(aUnit)
		and UnitCanAttack("player", aUnit)
		and UnitCreatureType(aUnit) == "Humanoid";
end



--
function VUHDO_updateAllCharmed()
	if (not VUHDO_CONFIG["DETECT_DEBUFFS"]) then
    return;
	end

	local tempUnit, tempInfo;

	for tempUnit, tempInfo in pairs(VUHDO_RAID) do
		tempInfo["charmed"] = VUHDO_isUnitCharmed(tempUnit);
	end
end



--
function VUHDO_determineDebuff(aUnit, aClassName)
	if (not VUHDO_CONFIG["DETECT_DEBUFFS"] or aClassName == nil) then
		return VUHDO_DEBUFF_TYPE_NONE;
	end

	local tempCnt;
	local tempIsRemovableOnly;
	local tempName, tempIconTexture, tempTypeName;
	local tempChosenType;
	local tempDebuffType;

	tempIsRemovableOnly = VUHDO_CONFIG["DETECT_DEBUFFS_REMOVABLE_ONLY"];
	tempChosenType = VUHDO_DEBUFF_TYPE_NONE;
	tempCnt = 1;

	while (true) do
		tempName, _, tempIconTexture, _, tempTypeName = UnitDebuff(aUnit, tempCnt, tempIsRemovableOnly);

		if (tempIconTexture == nil or tempName == nil) then
			break;
		end

		if (VUHDO_isDebuffRelevant(tempName, aClassName) and tempTypeName ~= nil) then
			tempDebuffType = VUHDO_DEBUFF_TYPES[tempTypeName];

			if (VUHDO_DEBUFF_ABILITIES[aClassName][tempDebuffType] ~= nil) then
				return tempDebuffType;
			elseif (tempChosenType == VUHDO_DEBUFF_TYPE_NONE) then
				tempChosenType = tempDebuffType;
			end
		end

		tempCnt = tempCnt + 1;
	end

	return tempChosenType;
end
