VUHDO_PROFILE_TIMER = 0; -- Profilers starting time stamp



-- Init by setting start time stamp
function VUHDO_initProfiler()
	VUHDO_Msg("Init Profiler");
	VUHDO_PROFILE_TIMER = GetTime() * 1000;
end



-- Dump the duration in ms since profiler has been initialized
function VUHDO_seeProfiler()
	local tempTimeDelta = floor(GetTime()*1000 - VUHDO_PROFILE_TIMER);
	VUHDO_Msg("Duration: " .. tempTimeDelta);
end



-- Print chat frame line with no "{Vuhdo} prefix
function VUHDO_MsgC(aMessage, aRed, aGreen, aBlue, anImpactLevel)
	if (aRed == nil) then aRed = 1; end
	if (aGreen == nil) then aGreen = 0.7; end
	if (aBlue == nil) then aBlue = 0.2; end

	if (aMessage == "") then
		aMessage = " ";
	end

	DEFAULT_CHAT_FRAME:AddMessage(aMessage, aRed, aGreen, aBlue);
end



-- Print a standard chat frame
function VUHDO_Msg(aMessage, aRed, aGreen, aBlue, anImpactLevel)
	VUHDO_MsgC("|cffffe566{VuhDo}|r " .. aMessage, aRed, aGreen, aBlue, anImpactLevel)
end



-- Returns the type of a given model id
function VUHDO_getModelType(aModelId)
	local tempType;

	if (aModelId >= VUHDO_ID_GROUP_1 and aModelId <= VUHDO_ID_GROUP_8) then
		tempType = VUHDO_ID_TYPE_GROUP;
	elseif (aModelId >= VUHDO_ID_WARRIORS and aModelId <= VUHDO_ID_DEATH_KNIGHT) then
		tempType = VUHDO_ID_TYPE_CLASS;
	elseif (aModelId == VUHDO_ID_UNDEFINED) then
	  tempType = VUHDO_ID_TYPE_UNDEFINED;
	else
		tempType = VUHDO_ID_TYPE_SPECIAL;
	end

	return tempType;
end



-- returns unit-prefix, pet-prefix and maximum number of players in a party
function VUHDO_getUnitIds()
	if (UnitInRaid("player")) then
		return "raid", "raidpet", 40;
	-- UnitInParty() ist buggy
	elseif (UnitExists("party1")) then
		return "party", "partypet", 5;
	else
		return "player", "pet", 0;
	end
end



-- Extracts unit number from a Unit's name
function VUHDO_getUnitNo(aUnit)
	local tempNumber = tonumber(string.sub(aUnit, -2, -1));
	if (tempNumber ~= nil) then
		return tempNumber;
	end

	tempNumber = tonumber(string.sub(aUnit, -1));
	if (tempNumber ~= nil) then
		return tempNumber;
	end

	return 1;
end



-- returns the units subgroup number, or 0 for pets
function VUHDO_getUnitGroup(aUnit, anIsPet)
	local tempGroupNo;

	if (anIsPet) then
		return 0;
	elseif (UnitInRaid("player")) then
		_, _, tempGroupNo, _, _, _, _, _ = GetRaidRosterInfo(VUHDO_getUnitNo(aUnit));
	else
		tempGroupNo = 1;
	end

	return tempGroupNo;
end



-- returns wether or not a unit is in range
function VUHDO_isInRange(aUnit)
	if (VUHDO_CONFIG["RANGE_CHECK"]) then
		if (VUHDO_CONFIG["RANGE_PESSIMISTIC"]) then
			return UnitInRange(aUnit);
		else
			return UnitInRange(aUnit) or (1 == IsSpellInRange(VUHDO_CONFIG["RANGE_SPELL"], aUnit));
		end
	else
		return true;
	end
end



-- returns an array of numbers (!!!as Number Strings!!!) sequentially found in a string
function VUHDO_getNumbersFromString(aName, aMaxAnz)
	local tempCnt;
	local tempNumbers = {};
	local tempIndex = 0;
	local tempStrlen = strlen(aName);
	local tempChar;
	local tempIsInNumber = false;

	for tempCnt = 1, tempStrlen do
		tempChar = strsub(aName, tempCnt, tempCnt);
		if (tempChar >= "0" and tempChar <= "9") then
			if (tempIsInNumber) then
				tempNumbers[tempIndex] = tempNumbers[tempIndex] .. tempChar;
			else
				tempIsInNumber = true;
				tempIndex = tempIndex + 1;
				tempNumbers[tempIndex] = tempChar;
			end
		else
			if (tempIndex >= aMaxAnz) then
				return tempNumbers;
			end

			tempIsInNumber = false;
		end
	end

	return tempNumbers;
end



-- adds a value uniquely into an array, which means it will do nothing if aValue already exists
function VUHDO_arrayUniqueAdd(anArray, aValue)
	local tempValue;

	for _, tempValue in pairs(anArray) do
		if (aValue == tempValue) then
			return;
		end
	end

	table.insert(anArray, aValue);
end



-- Parses a Text line into an array of arguments
function VUHDO_textParse(aString)
   local Text = aString;
   local tempTextLen = 1;
   local tempOutStrings = {};
   local OTIndex = 1;
   local tempStartIdx = 1;
   local tempStopIdx = 1;
   local tempTextIdxStart = 1;
   local tempTextIdxStop = 1;
   local tempTextLeft = 1;
   local tempNextSpaceIdx = 1;
   local tempTextChunk = "";
   local tempAnzIterations = 1;
   local tempIsErroneous = false;

   if ((Text ~= nil) and (Text ~= "")) then
      while (string.find(Text, "  ") ~= nil) do
         Text = string.gsub(Text, "  ", " ");
      end

      if (string.len(Text) <= 1) then
         tempIsErroneous = true;
      end

      if tempIsErroneous ~= true then
        tempTextIdxStart = 1;
        tempTextIdxStop = string.len(Text);

        if (string.sub(Text, tempTextIdxStart, tempTextIdxStart) == " ") then
           tempTextIdxStart = tempTextIdxStart+1;
        end

        if (string.sub(Text, tempTextIdxStop, tempTextIdxStop) == " ") then
           tempTextIdxStop = tempTextIdxStop-1;
        end

        Text = string.sub(Text, tempTextIdxStart, tempTextIdxStop);
      end

      OTIndex = 1;
      tempTextLeft = string.len(Text);

      while (tempStartIdx <= tempTextLeft) and (tempIsErroneous ~= true) do

         tempNextSpaceIdx = string.find(Text, " ",tempStartIdx);
         if (tempNextSpaceIdx ~= nil) then
            tempStopIdx = (tempNextSpaceIdx - 1);
         else
            tempStopIdx = string.len(Text);
            LetsEnd = true;
         end

         tempTextChunk = string.sub(Text, tempStartIdx, tempStopIdx);
         tempOutStrings[OTIndex] = tempTextChunk;
         OTIndex = OTIndex + 1;

         tempStartIdx = tempStopIdx + 2;

      end
   else
      tempOutStrings[1] = "Error: Bad value passed to TextParse!";
   end

   if (tempIsErroneous ~= true) then
      return tempOutStrings;
   else
      return {"Error: Bad value passed to TextParse!"};
   end
end



-- returns true if a string represents a valid description of a spell in our spell book
function VUHDO_isSpellValid(anActionName)
	if (anActionName == nil or "" == anActionName) then
		return false;
	end

	tempSpellId = VUHDO_getSpellId(anActionName);
	if (tempSpellId ~= nil) then
		return true;
	end

	return false;
end



-- return wether or not player is in fight an thus certain secure unit
-- operations cannot be done.
function VUHDO_isInFight()
	return VUHDO_IN_FIGHT;
end



-- Returns a "deep" copy of a table,
-- which means containing tables will be copies value-wise, not by reference
function VUHDO_deepCopyTable(aTable)
	local tempDestTable = { };
	local tempKey, tempValue;

	for tempKey, tempValue in pairs(aTable) do
		if ("table" == type(tempValue)) then
			tempDestTable[tempKey] = VUHDO_deepCopyTable(tempValue);
		else
			tempDestTable[tempKey] = tempValue;
		end
	end

	return tempDestTable;
end



-- Tokenizes a String into an array of strings, which were delimited by "aChar"
function VUHDO_splitString(aMessage, aChar)
	local tempFragments = { };

	while (string.find(aMessage, aChar)) do
		local iStart, iEnd = string.find(aMessage, aChar);
		tinsert(tempFragments, strsub(aMessage, 1, iStart-1));
		aMessage = strsub(aMessage, iEnd+1, strlen(aMessage));
	end

	if (strlen(aMessage) > 0) then
		tinsert(tempFragments, aMessage);
	end

	return tempFragments;
end



-- returns the Units Name from its Unit-ID, if aName is part of our raid, nil otherwise
function VUHDO_getUnitFromName(aName)
	return VUHDO_RAID_NAMES[aName];
end



-- return true if aSpellName describes a resurrection spell of any class
function VUHDO_isSpellResurrection(aSpellName)
	local tempSpellName;

  for _, tempSpellName in pairs(VUHDO_RESURRECTION_SPELLS) do
  	if (tempSpellName == aSpellName) then
  		return true;
  	end
  end

  return false;
end



-- returns true if player currently is in a battleground
function VUHDO_isInBattleground()
	local tempZoneName = GetRealZoneText();

	return VUHDO_BG_ZONES[tempZoneName];
end



-- returns the appropriate addon message channel for player
function VUHDO_getAddOnDistribution()
	if (VUHDO_isInBattleground()) then
		return "BATTLEGROUND";
	elseif(UnitInRaid("player")) then
		return "RAID";
	else
		return "PARTY";
	end
end



-- return the ordinality of aUnits main tank entry, returns nil if unit is no main tank
function VUHDO_getMainTankNumber(aUnit)
	local tempNumber, tempName;

	for tempNumber, tempName in pairs(VUHDO_MAINTANK_NAMES) do
		if (tempName == VUHDO_RAID[aUnit].name)	then
			return tempNumber;
		end
	end

	return nil;
end



-- returns the players rank in a raid which is 0 = raid member, 1 = assist, 2 = leader
-- returns leader if not in raid, and member if solo, as no main tank are needed
function VUHDO_getPlayerRank()
	for tempUnit, _ in pairs(VUHDO_RAID) do
		if (UnitIsUnit(tempUnit, "player")) then
			if (UnitInRaid("player")) then
				local tempUnitNo = VUHDO_getUnitNo(tempUnit);
				local tempRank;
				_, tempRank, _, _, _, _, _, _, _, _, _ = GetRaidRosterInfo(tempUnitNo);
				return tempRank;
			elseif (GetNumPartyMembers() > 1) then
				return 2;
			else
				return 2;
			end
		end
	end

	return 2;
end



-- returns the raid unit of player eg. "raid13" or "party4"
function VUHDO_getPlayerRaidUnit()
	for tempUnit, _ in pairs(VUHDO_RAID) do
		if (UnitIsUnit("player", tempUnit)) then
			return tempUnit;
		end
	end

	return nil;
end



-- returns a String with full spell description including rank
-- eg. "asswipe", 1 => "asswipe(rank 1)"
function VUHDO_getQualifiedSpellName(aSpellName, aRankNum)
	return aSpellName .. "(" .. VUHDO_I18N_RANK .. " " .. aRankNum .. ")";
end



-- returns the bare spell name of a potentially fully fledged spell description
-- eg. "ganking(rank 7)" => "ganking"
function VUHDO_extractSpellName(aSpellName)
	local tempName;
	local tempPos = strfind(aSpellName, "(", 1, true);
	if (tempPos ~= nil) then
		tempName = strsub(aSpellName, 1, tempPos - 1);
	else
		tempName = aSpellName;
	end
	return tempName;
end



-- returns the spell rank of a spell rank description
function VUHDO_getSpellRankNum(aRankName)
	local tempRankNum = VUHDO_getNumbersFromString(aRankName, 1)[1];

	if (tempRankNum == nil) then
		return 1;
	else
		return tonumber(tempRankNum);
	end
end



-- Appends an array of string (from on anOffset) to a new string (delimited with blanks)
function VUHDO_appendAllStrings(aStringArray, anOffset)
	local tempCnt;
	local tempString = "";

	for tempCnt = anOffset, 1000 do
		if (aStringArray[tempCnt] ~= nil) then
			tempString = tempString .. aStringArray[tempCnt] .. " ";
		else
			break;
		end
	end

	return strtrim(tempString);
end



--
function VUHDO_getSpellCooldown(aSpellName)
	local tempStart, tempDuration, _ = GetSpellCooldown(VUHDO_BUFFS[aSpellName].id, BOOKTYPE_SPELL);
	if (tempDuration == 0) then
		return 0, tempDuration;
	else
		return tempStart + tempDuration - GetTime(), tempDuration;
	end
end



--
function VUHDO_getVersion(aVersionAwareArray)
	if (aVersionAwareArray ~= nil) then
		if (aVersionAwareArray["VERSION"] == nil) then
			return -1;
		else
			return aVersionAwareArray["VERSION"];
		end
	else
		return -1;
	end
end



--
function VUHDO_getNumGroupMembers(aGroupId)
	local tempGroup = VUHDO_GROUPS[aGroupId];
	if (tempGroup == nil) then
		return 0;
	else
		return table.getn(tempGroup);
	end
end



--
function VUHDO_trimSpellName(aSpellName)
	local tempChar;
	local tempPrefix;
	local tempIsInNumber = false;

	if (aSpellName == nil or "" == aSpellName) then
		return "";
	end
	aSpellName = strtrim(aSpellName .. "§");
	aSpellName = strsub(aSpellName, 1, -2);
	tempPrefix = VUHDO_extractSpellName(aSpellName);

	local tempRest = strtrim(strsub(aSpellName .. "§", strlen(tempPrefix) + 1));
	tempRest = strsub(tempRest, 1, -2);
	local tempLowRest = strlower(tempRest);

	if (strfind(tempRest, "(", 1, true) and strfind(tempRest, ")", 1, true)
	and (strfind(tempLowRest, strlower(VUHDO_I18N_RANK)) or strfind(tempLowRest, "rank"))) then
		local tempRank = VUHDO_getNumbersFromString(tempRest, 1)[1];
		if (tempRank ~= nil) then
			tempPrefix = strtrim(tempPrefix)
			tempRest = "(" .. VUHDO_I18N_RANK .. " " .. tempRank .. ")";
		end
	end

	return tempPrefix .. tempRest;
end



--
function VUHDO_isInSameZone(aUnit)
	if (UnitIsUnit(aUnit, "player")) then
		return true;
	end

	local tempZoneOkay = true;
	if (UnitInRaid("player") and UnitExists(aUnit)) then

		local tempUnitZone, tempPlayerZone;
  	local tempIndex = VUHDO_getUnitNo(aUnit);
		_, _, _, _, _, _, tempUnitZone, _, _ = GetRaidRosterInfo(tempIndex);

		if (VUHDO_PLAYER_RAID_ID ~= nil) then
			tempIndex = VUHDO_getUnitNo(VUHDO_PLAYER_RAID_ID);
			_, _, _, _, _, _, tempPlayerZone, _, _ = GetRaidRosterInfo(tempIndex);
			if (tempUnitZone ~= tempPlayerZone) then
				tempZoneOkay = false;
			end
		end
	end

	return tempZoneOkay;
end