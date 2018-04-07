


--
function VUHDO_sendCtraMessage(aMessage)
	SendAddonMessage(VUHDO_CHAT_PREFIX_CTRA, aMessage, VUHDO_getAddOnDistribution());
end



--
function VUHDO_ctraBroadCastMaintanks()
	local tempUnit, tempInfo, tempMtNumber;
	for tempUnit, tempInfo in pairs(VUHDO_RAID) do
		tempMtNumber = VUHDO_getMainTankNumber(tempUnit);
		if (tempMtNumber ~= nil) then
			VUHDO_sendCtraMessage("SET " .. tempMtNumber .. " " .. tempInfo.name);
		else
			VUHDO_sendCtraMessage("R " .. tempInfo.name);
		end
	end
end



--
function VUHDO_parseCtraMessage(aNick, aMessage)
	local tempCnt;
	local tempAnzMembers = GetNumRaidMembers();
	local tempNum, tempName;
	local tempKey;

	-- Ended Resurrection
	if (aMessage == "RESNO") then
		local tempObject, tempSubject;
		for tempObject, tempSubject in pairs(VUHDO_RESSING_NAMES) do
			if (tempSubject == aNick) then
				VUHDO_RESSING_NAMES[tempObject] = nil;
				local tempUnit = VUHDO_RAID_NAMES[tempObject];
				if (tempUnit ~= nil) then
					VUHDO_updateHealth(tempUnit, VUHDO_UPDATE_HEALTH);
					VUHDO_sortRaidTable();
				end
			end
		end
	-- started resurrection
	elseif (strsub(aMessage, 1, 3) == "RES") then
		local tempObject;
		_, _, tempObject = strfind(aMessage, "^RES (.+)$");
		if (tempObject ~= nil) then
			VUHDO_RESSING_NAMES[tempObject] = aNick;
			local tempUnit = VUHDO_RAID_NAMES[tempObject];
			if (tempUnit ~= nil) then
				VUHDO_updateHealth(tempUnit, VUHDO_UPDATE_HEALTH);
				VUHDO_sortRaidTable();
			end
		end
	-- Setting maint tanks
	elseif (strsub(aMessage, 1, 4) == "SET ") then
		local _, _, tempNum, tempName = string.find(aMessage, "^SET (%d+) (.+)$");
		if (tempNum ~= nil and tempName ~= nil) then
			for tempKey, _ in pairs(VUHDO_MAINTANK_NAMES) do
				if (VUHDO_MAINTANK_NAMES[tempKey] == tempName) then
					VUHDO_MAINTANK_NAMES[tempKey] = nil;
				end
			end
			VUHDO_MAINTANK_NAMES[tonumber(tempNum)] = tempName;
			VUHDO_RELOAD_RAID_TIMER = VUHDO_RELOAD_RAID_DELAY;
		end
	-- Removing main tanks
	elseif(strsub(aMessage, 1, 2) == "R ") then
		local _, _, tempName = string.find(aMessage, "^R (.+)$");
		if (tempName ~= nil) then
			for tempKey, _ in pairs(VUHDO_MAINTANK_NAMES) do
				if (VUHDO_MAINTANK_NAMES[tempKey] == tempName) then
					VUHDO_MAINTANK_NAMES[tempKey] = nil;
					break;
				end
			end
			VUHDO_RELOAD_RAID_TIMER = VUHDO_RELOAD_RAID_DELAY;
		end
	end
end
