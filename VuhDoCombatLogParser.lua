--
function VUHDO_parseCombatLogEvent(aTimeStamp, aMessage, aSrcGUID, aSrcName, someSrcFlags, aDstGUID, aDstName, someDstFlags, aMessage1, aMessage2, aMessage3, aMessage4)
	if (not VUHDO_CONFIG["PARSE_COMBAT_LOG"]) then
		return;
	end

	local tempTargetUnit = VUHDO_RAID_GUIDS[aDstGUID];
	-- Nobody we care about?
	if (tempTargetUnit == nil) then
		return;
	end

	local tempHealthImpact = VUHDO_getTargetHealthImpact(aTimeStamp, aMessage, aSrcGUID, aSrcName, someSrcFlags, aDstGUID, aDstName, someDstFlags, aMessage1, aMessage2, aMessage3, aMessage4);

	if (tempHealthImpact ~= 0) then
		--VUHDO_Msg(UnitName(tempTargetUnit) .. " " .. tempHealthImpact);
		VUHDO_addUnitHealth(tempTargetUnit, tempHealthImpact);
	end
end



--
function VUHDO_addUnitHealth(aUnit, aHealthDelta)
	local tempInfo = VUHDO_RAID[aUnit];

	if (tempInfo ~= nil) then
		local tempNewHealth = tempInfo.health + aHealthDelta;

		if (tempNewHealth < 0) then
			tempNewHealth = 0;
		elseif(tempNewHealth > tempInfo.healthmax) then
			tempNewHealth = tempInfo.healthmax;
		end

		if (tempInfo.health ~= tempNewHealth) then
			tempInfo.health = tempNewHealth;
			tempInfo.clTimestamp = GetTime();
			VUHDO_updateAllUnitButtons(aUnit);
		end
	end
end



--
function VUHDO_getTargetHealthImpact(aTimeStamp, aMessage, aSrcGUID, aSrcName, someSrcFlags, aDstGUID, aDstName, someDstFlags, aMessage1, aMessage2, aMessage3, aMessage4)
	local tempPrefix, tempSuffix, tempSpecial = strsplit("_", aMessage);

	if ("SPELL" == tempPrefix) then
		if ("HEAL" == tempSuffix or "HEAL" == tempSpecial) then
			return aMessage4;
		elseif ("DAMAGE" == tempSuffix or "DAMAGE" == tempSpecial) then
			return -aMessage4;
		end
	elseif ("DAMAGE" == tempSuffix) then
		if ("SWING" == tempPrefix) then
			return -aMessage1;
		elseif ("RANGE" == tempPrefix) then
			return -aMessage4;
		elseif ("ENVIRONMENTAL" == tempPrefix) then
			return -aMessage2
		end
	elseif ("DAMAGE" == tempPrefix and "MISSED" ~= tempSpecial) then
		return -aMessage4;
	end

	return 0;
end
