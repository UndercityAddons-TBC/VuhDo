-- Remember every units heal-buttons
VUHDO_PANEL_MODELS = {};
VUHDO_PANEL_DYN_MODELS = {};
VUHDO_PANEL_UNITS = {};
local VUHDO_UNIT_BUTTONS = {};


--
function VUHDO_removeFromModel(aPanelNum, anOrderNum)
	tremove(VUHDO_PANEL_MODELS[aPanelNum], anOrderNum);
	VUHDO_initDynamicPanelModels();
end



--
function VUHDO_insertIntoModel(aPanelNum, anOrderNum, anIsLeft, aModelId)
	local tempIndex;

	if (anIsLeft) then
		tinsert(VUHDO_PANEL_MODELS[aPanelNum], anOrderNum, aModelId)
	else
		tinsert(VUHDO_PANEL_MODELS[aPanelNum], anOrderNum + 1, aModelId)
	end
	VUHDO_initDynamicPanelModels();
end



--
function VUHDO_customizeHeader(aHeader, aPanelNum, aModelId)
	local tempHeaderText = VUHDO_getHeaderTextId(aHeader);

	local tempText = VUHDO_getHeaderText(aModelId);
	tempHeaderText:SetText(tempText);

	if (VUHDO_PANEL_SETUP[aPanelNum]["PANEL_COLOR"].classColorsHeader
 		and VUHDO_ID_TYPE_CLASS == VUHDO_getModelType(aModelId)) then
 		local tempClassColor = VUHDO_getClassColorByModelId(aModelId);
 		tempHeaderText:SetTextColor(tempClassColor.TR, tempClassColor.TG, tempClassColor.TB, tempClassColor.TO);
 	else
		local tempColor = VUHDO_PANEL_SETUP[aPanelNum]["PANEL_COLOR"]["HEADER"];
	 	tempHeaderText:SetTextColor(tempColor.TR, tempColor.TG, tempColor.TB, tempColor.TO);
	end
end



--
function VUHDO_getHeaderText(aModelId)
	return VUHDO_HEADER_TEXTS[aModelId];
end



--
function VUHDO_positionTableHeaders(aPanel, aPanelNum)
	local tempCnt;
	local tempHeader;
	local tempX, tempY
  local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];

	local tempModel = VUHDO_PANEL_DYN_MODELS[aPanelNum];
	local tempAnzColumns;
	local tempWidth = VUHDO_getBarWidth(aPanelNum);
	local tempHealthBar;
	local tempHeaderText;
	local tempColor = VUHDO_PANEL_SETUP[aPanelNum]["PANEL_COLOR"]["HEADER"];


	if (VUHDO_isTableHeadersShowing(aPanelNum)) then
		tempAnzColumns = table.getn(tempModel);
	else
		tempAnzColumns = 0;
	end

	for tempCnt = 1, VUHDO_MAX_GROUPS_PER_PANEL do
		tempHeader = VUHDO_getHeader(tempCnt, aPanelNum);
	 	tempHeader:SetWidth(tempWidth * (tempBarScaling.headerWidth / 100));
		tempHeader:SetHeight(tempBarScaling.headerHeight);

		tempHealthBar = VUHDO_getHealthBar(tempHeader, nil);
		tempHealthBar:SetMinMaxValues(0,100);
 		tempHealthBar:SetValue(100);
	 	tempHealthBar:SetStatusBarColor(tempColor.R, tempColor.G, tempColor.B, tempColor.O);
	 	tempHealthBar:SetHeight(VUHDO_PANEL_SETUP[aPanelNum]["SCALING"].headerHeight);
	 	tempHealthBar:SetStatusBarTexture(VUHDO_TEXTURE_SPEC .. tempColor.barTexture);

		tempHeaderText = VUHDO_getHeaderTextId(tempHeader);
		tempHeaderText:SetFont(GameFontNormal:GetFont(), tonumber(tempColor.textSize), "OUTLINE");
		tempHeader:Hide();
	end

	for tempCnt = 1, tempAnzColumns do
		tempHeader = VUHDO_getHeader(tempCnt, aPanelNum);
		tempX, tempY = VUHDO_getHeaderPos(tempCnt, aPanelNum);
		tempHeader:ClearAllPoints();
    tempHeader:SetPoint("TOPLEFT", aPanel:GetName(), "TOPLEFT", tempX + tempWidth / 2 * (1 - (tempBarScaling.headerWidth / 100)), -tempY);
    VUHDO_customizeHeader(tempHeader, aPanelNum, tempModel[tempCnt]);
		tempHeader:Show();
	end
end



--
function VUHDO_refreshPositionTableHeaders(aPanel, aPanelNum)
	local tempCnt;
	local tempHeader;
	local tempX, tempY
  local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];

	local tempModel = VUHDO_PANEL_DYN_MODELS[aPanelNum];
	local tempAnzColumns;
	local tempWidth = VUHDO_getBarWidth(aPanelNum);

	if (VUHDO_isTableHeadersShowing(aPanelNum)) then
		tempAnzColumns = table.getn(tempModel);
	else
		tempAnzColumns = 0;
	end

	for tempCnt = 1, tempAnzColumns do
		tempHeader = VUHDO_getHeader(tempCnt, aPanelNum);
		tempX, tempY = VUHDO_getHeaderPos(tempCnt, aPanelNum);
    tempHeader:SetPoint("TOPLEFT", aPanel:GetName(), "TOPLEFT", tempX + tempWidth / 2 * (1 - (tempBarScaling.headerWidth / 100)), -tempY);
    VUHDO_customizeHeader(tempHeader, aPanelNum, tempModel[tempCnt]);
		tempHeader:Show();
	end

	for tempCnt = tempAnzColumns + 1, VUHDO_MAX_GROUPS_PER_PANEL do
		tempHeader = VUHDO_getHeader(tempCnt, aPanelNum);
		tempHeader:Hide();
	end

end



--
function VUHDO_getLifeLeftColor(aLifePercentage)
	local tempFactor = aLifePercentage / 100;
	local tempR, tempG, tempB

	-- Color change flow quadratic instead of linear makes red an green portions of the color more intense
	if (VUHDO_GUI_BAR_COLOR_FALLOFF_VIVID == VUHDO_PANEL_SETUP["BAR_COLORS"].neutralFalloff) then
		tempFactor = tempFactor * tempFactor;
	end

	if (tempFactor > 0.5) then
		tempR = 1 - ((tempFactor - 0.5) * 2);
		tempG = 1;
	else
		tempR = 1;
		tempG = tempFactor * 2;
	end

	tempB = 0;

	local tempCols = {
		["R"] = tempR,
		["G"] = tempG,
		["B"] = tempB,
		["O"] = 1,
		["useBackground"] = true,
		["useOpacity"] = true
	};

	return tempCols;
end



--
function VUHDO_getEmergencyColor(anInfo)
	local tempUnit;
	local tempPosition;
	local tempIndex;
	for tempIndex, tempUnit in ipairs(VUHDO_EMERGENCIES) do
		if (anInfo.unit == tempUnit) then
			local tempFactor = 1 / tempIndex;
			local tempColor = VUHDO_copyColor(VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"]);
			tempColor.R = tempColor.R * tempFactor;
			tempColor.G = tempColor.G * tempFactor;
			tempColor.B = tempColor.B * tempFactor;
			return tempColor;
		end
	end

	return VUHDO_copyColor(VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"]);
end



--
function VUHDO_customizeHealButton(aButton)
	local tempHealthBar;
	local tempHealthText;
	local tempColor;
	local tempBarColor = nil;
	local tempUnit, tempInfo;
	local tempTextString;
	local tempTarget;
	local tempPanelNum = VUHDO_getComponentPanelNum(aButton);
	local tempIsUseClassColors = VUHDO_PANEL_SETUP[tempPanelNum]["PANEL_COLOR"].classColorsName;
	local tempDefaultColor = VUHDO_PANEL_SETUP[tempPanelNum]["PANEL_COLOR"]["TEXT"];
	local tempIsManaBars = VUHDO_PANEL_SETUP[tempPanelNum]["SCALING"].showManaBars;

 	tempHealthBar = VUHDO_getHealthBar(aButton, 1);
 	tempHealthText = VUHDO_getBarText(tempHealthBar, false);
	local tempIncBar = VUHDO_getHealthBar(aButton, 6);

	tempUnit = aButton:GetAttribute("unit");
	tempInfo = VUHDO_RAID[tempUnit];

	if (tempUnit == nil or tempInfo == nil or not UnitExists(tempUnit)) then
		tempHealthBar:SetStatusBarColor(0, 0, 0, 1);
		tempHealthBar:SetValue(100);
		tempHealthText:SetText("[ VOID ]");
		return;
	end

	tempTextString = tempInfo.name;

 	tempColor = VUHDO_PANEL_SETUP["BAR_COLORS"];
	if (not UnitIsConnected(tempUnit)) then
 		tempHealthBar:SetValue(100);
		tempIncBar:SetValue(0);
		if (tempIsManaBars) then
			VUHDO_getHealthBar(aButton, 2):SetValue(0);
		end
		tempBarColor = VUHDO_copyColor(tempColor["OFFLINE"]);
	elseif (UnitIsDeadOrGhost(tempUnit)) then
 		tempHealthBar:SetValue(100);
		tempIncBar:SetValue(0);
		if (tempIsManaBars) then
			VUHDO_getHealthBar(aButton, 2):SetValue(0);
		end
		tempBarColor = VUHDO_copyColor(tempColor["DEAD"]);

		if (VUHDO_isBeingResurrected(tempUnit)) then
			tempBarColor.TR = 0.4;
			tempBarColor.TG = 1;
			tempBarColor.TB = 0.4;
			tempBarColor.TO = 1;
		elseif (not tempInfo.range) then
			tempBarColor.O = tempBarColor.O * tempColor["OUTRANGED"].O;
			tempBarColor.TO = tempBarColor.TO * tempColor["OUTRANGED"].TO;
		end
	else
	 	local tempHealthPerc = VUHDO_getUnitHealthPercent(tempInfo);
 		tempHealthBar:SetValue(tempHealthPerc);

		local tempAmountInc = VUHDO_getIncHealOnUnit(tempUnit);
		local tempHealthPlusInc = VUHDO_getUnitHealthPercent(tempInfo, tempAmountInc);

		if (VUHDO_MODE_NEUTRAL == VUHDO_CONFIG["MODE"]) then
			tempBarColor = VUHDO_getLifeLeftColor(tempHealthPerc);

			if (tempHealthPerc > VUHDO_CONFIG["EMERGENCY_TRIGGER"]) then
				tempBarColor = VUHDO_getDiffColor(tempBarColor, tempColor["IRRELEVANT"]);
			end

			-- IncomingBar
			if (tempAmountInc > 0) then
	 			tempIncBar:SetValue(tempHealthPlusInc);
	 			local tempIncColor = VUHDO_copyColor(tempBarColor);
	 			tempIncColor = VUHDO_getDiffColor(tempIncColor, tempColor["INCOMING"]);
				VUHDO_setStatusBarColor(tempIncBar, tempIncColor);
			else
				tempIncBar:SetValue(0);
			end
		else
			tempBarColor = VUHDO_getEmergencyColor(tempInfo);
		end

		-- Overheal
		if (VUHDO_CONFIG["SHOW_OVERHEAL"] and tempHealthPlusInc > 100) then
			tempBarColor = VUHDO_brightenColor(tempBarColor, (tempInfo.health + tempAmountInc) / tempInfo.healthmax);
		end

		local tempTextColor;
		if (tempIsUseClassColors) then
			tempTextColor = VUHDO_getClassColor(tempInfo);
		end
		-- Pets may have no class color
		if (tempTextColor == nil or not tempIsUseClassColors) then
			tempTextColor = tempDefaultColor;
		end

		tempBarColor.TR = tempTextColor.TR;
		tempBarColor.TG = tempTextColor.TG;
		tempBarColor.TB = tempTextColor.TB;
		tempBarColor.TO = tempTextColor.TO;

		if (VUHDO_hasUnitInfoDebuff(tempInfo)) then
 			tempBarColor = VUHDO_getDiffColor(tempBarColor, VUHDO_getDebuffColor(tempInfo));

			if (not tempInfo.range) then
				tempBarColor.O = tempBarColor.O * tempColor["OUTRANGED"].O;
				tempBarColor.TO = tempBarColor.TO * tempColor["OUTRANGED"].TO;
			end
		elseif (not tempInfo.range) then
			tempBarColor = VUHDO_getDiffColor(tempBarColor, tempColor["OUTRANGED"]);
		end

		-- Mana Bar
		if (tempIsManaBars) then
		 	local tempManaBar = VUHDO_getHealthBar(aButton, 2);
			tempManaBar:SetValue(VUHDO_getUnitPowerPercent(tempInfo));
			local tempManaColor = VUHDO_POWER_TYPE_COLORS[tempInfo.powertype];
			tempManaBar:SetStatusBarColor(tempManaColor.R, tempManaColor.G, tempManaColor.B, tempManaColor.O);
		end
	end

	-- Life Bar
	VUHDO_setStatusBarColor(tempHealthBar, tempBarColor);
	VUHDO_setTextColor(tempHealthText, tempBarColor, tempIsUseClassColors, tempInfo, tempDefaultColor);

  -- Aggro Bar
  if (VUHDO_CONFIG["DETECT_AGGRO"]) then
  	local tempAggroBar = VUHDO_getHealthBar(aButton, 4);

		if (tempInfo.aggro) then
  		tempHealthText:SetText(">>" .. tempTextString .. "<<");
			tempAggroBar:SetValue(100);
		else
			tempHealthText:SetText(tempTextString);
			tempAggroBar:SetValue(0);
		end
	else
		tempHealthText:SetText(tempTextString);
	end

	-- Target Bar
	if (VUHDO_PANEL_SETUP[tempPanelNum]["SCALING"].showTarget) then
	 	local tempTargetBar = VUHDO_getHealthBar(aButton, 5);

		tempTarget = tempUnit .. "target";
		if (UnitExists(tempTarget)) then
			--local tempHealth = UnitHealth(tempTarget);
			--local tempHealthMax = UnitHealthMax(tempTarget);
			--if (tempHealth ~= nil and tempHealthMax ~= nil and tempHealthMax > 0) then
			--	tempTargetBar:SetValue((tempHealth / tempHealthMax) * 100);
			--end
			tempTargetBar:Show();
			if (UnitIsFriend(tempUnit, tempTarget)) then
				tempTargetBar:SetStatusBarColor(0, 1, 0, 1);
			elseif (UnitIsEnemy(tempUnit, tempTarget)) then
				tempTargetBar:SetStatusBarColor(1, 0, 0, 1);
			else
				tempTargetBar:SetStatusBarColor(1, 1, 0, 1);
			end

			local tempTexture = VUHDO_getRaidTargetTexture(tempTargetBar);
			local tempRaidTargetIcon = GetRaidTargetIndex(tempTarget);

			if (tempRaidTargetIcon ~= nil) then
				VUHDO_setRaidTargetIconTexture(tempTexture, tempRaidTargetIcon);
				local tempTargetText = VUHDO_getBarText(tempTargetBar, true);
				tempTargetText:SetText(VUHDO_getUnitNameShort(tempTarget, tempTargetBar:GetWidth()));
				tempTexture:Show();

				local tempTargetText = VUHDO_getBarText(tempTargetBar, false);
				tempTargetText:SetText("");
			else
				local tempTargetText = VUHDO_getBarText(tempTargetBar, false);
				tempTargetText:SetText(VUHDO_getUnitNameShort(tempTarget, tempTargetBar:GetWidth()));
				tempTexture:Hide();
				local tempTargetText = VUHDO_getBarText(tempTargetBar, true);
				tempTargetText:SetText("");
			end
		else
			tempTargetBar:Hide();
		end
	end
end



--
function VUHDO_getAllHealButtons(aUnit)
	local tempButtons = VUHDO_UNIT_BUTTONS[aUnit];
	if (tempButtons == nil) then
		return {};
	else
		return tempButtons;
	end
end



--
function VUHDO_updateAllUnitButtons(aUnit)
	local tempButton;

	for _, tempButton in pairs(VUHDO_getAllHealButtons(aUnit)) do
		VUHDO_customizeHealButton(tempButton);
	end
end



--
function VUHDO_getPanelUnits(aPanelNum)
	if (VUHDO_PANEL_UNITS[aPanelNum] == nil) then
		return { };
	else
		return VUHDO_PANEL_UNITS[aPanelNum];
	end
end



--
function VUHDO_getGroupMembers(anIdentifier, aPanelNum)
  local tempGroupArray;

	if (anIdentifier ~= VUHDO_ID_ALL) then
		tempGroupArray = VUHDO_GROUPS[anIdentifier];
	else
		tempGroupArray = VUHDO_getPanelUnits(aPanelNum);
	end

  if (tempGroupArray == nil) then
  	tempGroupArray = {};
  end

	return tempGroupArray;
end



--
function VUHDO_getGroupMembersSorted(anIdentifier, aSortCriterion, aPanelNum)
	local tempMembers = VUHDO_getGroupMembers(anIdentifier, aPanelNum);
	local tempSortedArray = { };
	local tempUnit;

	if (VUHDO_ID_MAINTANKS ~= anIdentifier) then
		for _, tempUnit in pairs(tempMembers) do
			table.insert(tempSortedArray, tempUnit);
		end

		table.sort(tempSortedArray,
			function(aUnitId, anotherUnitId)
				if (aSortCriterion == VUHDO_SORT_RAID_NAME) then
					return VUHDO_RAID[aUnitId].name < VUHDO_RAID[anotherUnitId].name
				elseif (aSortCriterion == VUHDO_SORT_RAID_MAX_HEALTH) then
					return VUHDO_RAID[aUnitId].healthmax > VUHDO_RAID[anotherUnitId].healthmax
				else -- by UnitId
					return aUnitId < anotherUnitId;
				end
			end

		);

		return tempSortedArray;
	else -- for main tanks keep the order of CTRA/ORA
		return tempMembers;
	end
end



--
function VUHDO_addUnitButton(aHealButton)
	local tempUnit = aHealButton:GetAttribute("unit");

	if (tempUnit == nil) then
		return
	end

  if (VUHDO_UNIT_BUTTONS[tempUnit] == nil) then
  	VUHDO_UNIT_BUTTONS[tempUnit] = { };
  end

  table.insert(VUHDO_UNIT_BUTTONS[tempUnit], aHealButton);
end



--
function VUHDO_getSpellId(aSpellName)
	local tempAktSpellId;
	local tempBestMatchId;
	local tempSpellName, tempSubSpellName;
	local tempSubSequence;

	tempBestMatchId = 0;
	tempAktSpellId = 1;
  while (true) do
    tempSpellName, tempSubSpellName = GetSpellName(tempAktSpellId, BOOKTYPE_SPELL);

    if (tempSpellName ~= nil) then
    	tempSubSequence = tempSpellName .. "(" .. tempSubSpellName .. ")";

    	if (tempSubSequence == aSpellName) then
      	return tempAktSpellId;
      end

      if (aSpellName == tempSpellName) then
        tempBestMatchId = tempAktSpellId;
      end
    else
      break;
    end

    tempAktSpellId = tempAktSpellId + 1;
  end

  if (tempBestMatchId > 0) then
    return tempBestMatchId;
  else
    return nil;
  end
end



--
function VUHDO_getMacroId(aMacroName)
  local tempMacroId = GetMacroIndexByName(aMacroName);
  return tempMacroId;
end


--
function VUHDO_setupHealButtonAttributes(aModifierKey, aButtonId, anActionName, aButton)
		local tempMacroId, tempMacroText, tempSpellId;

		if (anActionName ~= nil and anActionName ~= "") then
			local tempActionLowerName = strlower(anActionName);

		  if (VUHDO_SPELL_KEY_ASSIST == tempActionLowerName) then
			  aButton:SetAttribute(aModifierKey .. "type" .. aButtonId, "assist");
		  elseif (VUHDO_SPELL_KEY_FOCUS == tempActionLowerName) then
  			aButton:SetAttribute(aModifierKey .. "type" .. aButtonId, "focus");
	  	elseif (VUHDO_SPELL_KEY_TARGET == tempActionLowerName) then
		  	aButton:SetAttribute(aModifierKey .. "type" .. aButtonId, "target");
		  elseif (VUHDO_SPELL_KEY_MENU == tempActionLowerName
		  	or VUHDO_SPELL_KEY_TELL == tempActionLowerName) then
		  	aButton:SetAttribute(aModifierKey .. "type" .. aButtonId, nil);
	    else
	  	  tempMacroId = VUHDO_getMacroId(anActionName);
			  if (tempMacroId ~= 0) then
				  _, _, tempMacroText = GetMacroInfo(tempMacroId);
					aButton:SetAttribute(aModifierKey .. "helpbutton" .. aButtonId, nil);
          aButton:SetAttribute(aModifierKey .. "type" .. aButtonId, "macro");
          aButton:SetAttribute(aModifierKey .. "macrotext" .. aButtonId, tempMacroText);
			  else
				  tempSpellId = VUHDO_getSpellId(anActionName);
				  if (tempSpellId ~= nil) then
				  	-- Cleansing charmed players is an offensive thing to do
				  	local tempPurgeSpell = VUHDO_BUFF_REMOVAL_SPELLS[VUHDO_PLAYER_CLASS];
				  	if (tempPurgeSpell ~= nil) then
				  		local tempBaseSpell = strtrim(VUHDO_extractSpellName(anActionName));
				  		if (tempPurgeSpell == tempBaseSpell) then
			          aButton:SetAttribute(aModifierKey .. "helpbutton" .. aButtonId, nil);
		            aButton:SetAttribute(aModifierKey .. "harmbutton" .. aButtonId, "nuke" .. aButtonId);
  		          aButton:SetAttribute(aModifierKey .. "type-nuke" .. aButtonId, "spell");
    		        aButton:SetAttribute(aModifierKey .. "spell-nuke" .. aButtonId, anActionName);
								return;
				  		end
				  	end

				  	-- Heal if friendly
		        aButton:SetAttribute(aModifierKey .. "harmbutton" .. aButtonId, nil);
	          aButton:SetAttribute(aModifierKey .. "helpbutton" .. aButtonId, "heal" .. aButtonId);
  	        aButton:SetAttribute(aModifierKey .. "type-heal" .. aButtonId, "spell");
    	      aButton:SetAttribute(aModifierKey .. "spell-heal" .. aButtonId, anActionName);
				  else -- try to use item
					  aButton:SetAttribute(aModifierKey .. "helpbutton" .. aButtonId, "item" .. aButtonId);
            aButton:SetAttribute(aModifierKey .. "type-item" .. aButtonId, "item");
            aButton:SetAttribute(aModifierKey .. "item-item" .. aButtonId, anActionName);
				  end
				end
			end

		else
			--aButton:SetAttribute(aModifierKey .. "helpbutton" .. aButtonId, nil);
			aButton:SetAttribute(aModifierKey .. "type" .. aButtonId, "");
			aButton:SetAttribute(aModifierKey .. "item" .. aButtonId, "");
		end
end



-- Parse and interpret action-type
function VUHDO_setupAllHealButtonAttributes(aButton, anInfo, anIsDisable, anIsAutoRank)
	local tempSpellDescriptor;
	local tempModifierKey, tempButtonId, tempActionName;

	if (anInfo ~= nil) then
		aButton:SetAttribute("unit", anInfo.unit);
	end

	for _, tempSpellDescriptor in pairs(VUHDO_SPELL_ASSIGNMENTS) do
		tempModifierKey = tempSpellDescriptor[1];
		tempButtonId = strlower(tempSpellDescriptor[2]);
		if (anIsDisable) then
			tempActionName = nil;
		else
			tempActionName = tempSpellDescriptor[3];

			if (anIsAutoRank) then
				tempActionName = strtrim(VUHDO_extractSpellName(tempActionName));
				if (VUHDO_SPELLS[tempActionName] ~= nil) then
					local tempUnit = aButton:GetAttribute("unit");
					local tempInfo = VUHDO_RAID[tempUnit];
					local tempDeficit = tempInfo.healthmax - tempInfo.health - VUHDO_getIncHealOnUnit(tempUnit);
					local tempRank = VUHDO_getSpellRankForLifeDeficit(tempActionName, tempDeficit);

					if (tempRank ~= nil) then
						tempActionName = VUHDO_getQualifiedSpellName(tempActionName, tempRank);
					end
				end
			end
		end

		VUHDO_setupHealButtonAttributes(tempModifierKey, tempButtonId, tempActionName, aButton);
	end
end



--
function VUHDO_setupAllButtonsTo(aButton, aSpellName)
	local tempSpellDescriptor;
	local tempModifierKey, tempButtonId, tempActionName;

	for _, tempSpellDescriptor in pairs(VUHDO_SPELL_ASSIGNMENTS) do
		tempModifierKey = tempSpellDescriptor[1];
		tempButtonId = strlower(tempSpellDescriptor[2]);
		tempActionName = tempSpellDescriptor[3];

		if ("target" == tempActionName or "assist" == tempActionName or "focus" == tempActionName) then
			VUHDO_setupHealButtonAttributes(tempModifierKey, tempButtonId, tempActionName, aButton);
		else
			VUHDO_setupHealButtonAttributes(tempModifierKey, tempButtonId, aSpellName, aButton);
		end
	end
end



--
function VUHDO_setupAllTargetButtonAttributes(aButton, anInfo)
	aButton:SetAttribute("unit", anInfo.unit .. "target");
	VUHDO_setupAllButtonsTo(aButton, VUHDO_SPELL_KEY_TARGET);
end



--
function VUHDO_disableActions(aButton)
	VUHDO_setupAllHealButtonAttributes(aButton, nil, true, false);
end



--
function VUHDO_setupSmartCast(aButton)
	if (not VUHDO_CONFIG["SMARTCAST"] or VUHDO_isInFight()) then
		return false;
	end

	local tempUnit = aButton:GetAttribute("unit");

	-- Resurrect?
	if (VUHDO_CONFIG["SMARTCAST_RESURRECT"]
			and tempUnit ~= nil
			and UnitIsDeadOrGhost(tempUnit)) then

		if (VUHDO_RESURRECTION_SPELLS[VUHDO_PLAYER_CLASS] ~= nil) then
			if (not UnitIsGhost(tempUnit)) then
				VUHDO_setupAllButtonsTo(aButton, VUHDO_RESURRECTION_SPELLS[VUHDO_PLAYER_CLASS]);
				return true;
			else
				VUHDO_disableActions(aButton);
				VUHDO_Msg("Can't resurrect, " .. UnitName(tempUnit) .. " has realeased spirit.");
				return true;
			end
		end
	end

	-- Cleanse
	if (VUHDO_CONFIG["SMARTCAST_CLEANSE"]) then
		local _, _, _, _, tempTypeName = UnitDebuff(tempUnit, 1, true);
		if (tempTypeName ~= nil) then
			local tempAbilities = VUHDO_DEBUFF_ABILITIES[VUHDO_PLAYER_CLASS];
			local tempDebuffType = VUHDO_DEBUFF_TYPES[tempTypeName];
			if (tempAbilities[tempDebuffType] ~= nil and tempAbilities[tempDebuffType] ~= "") then
				VUHDO_setupAllButtonsTo(aButton, tempAbilities[tempDebuffType]);
				return true;
			end
		end
	end

	-- Heal
	if (VUHDO_CONFIG["SMARTCAST_HEAL"]) then
		local tempInfo = VUHDO_RAID[tempUnit];
		local tempDeficit = tempInfo.healthmax - tempInfo.health - VUHDO_getIncHealOnUnit(tempUnit);

		if (tempDeficit < 0) then
			tempDeficit = 0;
		end
		if (VUHDO_CONFIG["SMARTCAST_AUTO_HEAL_SPELL"]) then
			local tempSpellName, tempRank = VUHDO_getSpellForLifeDeficit(tempDeficit);

			if (tempSpellName ~= nil) then
				--VUHDO_Msg("Advised spell:  " .. tempSpellName .. "(Rang " .. tempRank .. ")");
				VUHDO_setupAllButtonsTo(aButton, VUHDO_getQualifiedSpellName(tempSpellName, tempRank), false, false);
				return true;
			end
		else
			VUHDO_setupAllHealButtonAttributes(aButton, tempInfo, false, true);
			return true;
		end
	end

	return false;
end



--
function VUHDO_getDynamicModelArray(aPanelNum)
	if (VUHDO_PANEL_SETUP[aPanelNum]["MODEL"].ordering == VUHDO_ORDERING_STRICT) then
		return VUHDO_PANEL_DYN_MODELS[aPanelNum];
	else
		return { VUHDO_ID_ALL };
	end
end



--
function VUHDO_positionAllHealButtons(aPanel, aPanelNum)

	if (VUHDO_isConfigPanelShowing()) then
		VUHDO_positionAllGroupConfigPanels(aPanelNum);
		return;
	end

	local tempXPos, tempYPos;
	local tempHealButton;
	local tempUnit, tempInfo;
	local tempGroupArray;
	local tempModelId;
	local tempGroupIndex, tempColumnIndex, tempButtonIndex;

	local tempModelArray;

	tempModelArray = VUHDO_getDynamicModelArray(aPanelNum);

  local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];
  local tempSortCriterion = VUHDO_PANEL_SETUP[aPanelNum]["MODEL"].sort;
  local tempPanelName = aPanel:GetName();
  local tempHealthBarHeight = VUHDO_getHealthBarHeight(aPanelNum);
  local tempManaBarHeight = VUHDO_getManaBarHeight(aPanelNum);
  local tempIncBar, tempHealBar, tempManaBar;

	tempColumnIndex = 1;
	tempButtonIndex = 1;

	local tempCnt;
	for tempCnt = 1, VUHDO_MAX_BUTTONS_PANEL do
		tempHealButton = VUHDO_getHealButton(tempCnt, aPanelNum);
	 	tempHealButton:SetWidth(tempBarScaling.barWidth);
		tempHealButton:SetHeight(tempBarScaling.barHeight);
		tempHealBar = VUHDO_getHealthBar(tempHealButton, 1);
		tempHealBar:SetHeight(tempHealthBarHeight);

		tempIncBar = VUHDO_getHealthBar(tempHealButton, 6);
		tempIncBar:SetAllPoints(tempHealBar);

		tempManaBar = VUHDO_getHealthBar(tempHealButton, 2);
		tempManaBar:ClearAllPoints();
		tempManaBar:SetPoint("BOTTOMLEFT", tempHealButton:GetName(), "BOTTOMLEFT", 0, 0);
		tempManaBar:SetHeight(tempManaBarHeight);
		tempManaBar:SetWidth(tempBarScaling.barWidth);
	end


  for _, tempModelId in ipairs(tempModelArray) do
  	tempGroupArray = VUHDO_getGroupMembersSorted(tempModelId, tempSortCriterion, aPanelNum);

  	tempGroupIndex = 1;
  	for _, tempUnit in ipairs(tempGroupArray) do

  		tempInfo = VUHDO_RAID[tempUnit];

	  	tempHealButton = VUHDO_getHealButton(tempButtonIndex, aPanelNum);
	  	tempButtonIndex = tempButtonIndex + 1;

	  	tempXPos, tempYPos = VUHDO_getHealButtonPos(tempColumnIndex, tempGroupIndex, aPanelNum);
  		tempHealButton:ClearAllPoints();
      tempHealButton:SetPoint("TOPLEFT", tempPanelName, "TOPLEFT", tempXPos, -tempYPos);

      VUHDO_setupAllHealButtonAttributes(tempHealButton, tempInfo, false, false);
      VUHDO_setupAllTargetButtonAttributes(VUHDO_getTargetButton(tempHealButton), tempInfo);
	  	VUHDO_addUnitButton(tempHealButton);
      VUHDO_customizeHealButton(tempHealButton);
      tempHealButton:Show();
  		tempGroupIndex = tempGroupIndex + 1;
  	end

  	tempColumnIndex = tempColumnIndex + 1;
  end
end



--
function VUHDO_refreshPositionAllHealButtons(aPanel, aPanelNum)
	local tempXPos, tempYPos;
	local tempHealButton;
	local tempUnit, tempInfo;
	local tempGroupArray;
	local tempModelId;
	local tempGroupIndex, tempColumnIndex, tempButtonIndex;
	local tempCnt;

	local tempModelArray;

	tempModelArray = VUHDO_getDynamicModelArray(aPanelNum);

  local tempSortCriterion = VUHDO_PANEL_SETUP[aPanelNum]["MODEL"].sort;
  local tempPanelName = aPanel:GetName();

	tempColumnIndex = 1;
	tempButtonIndex = 1;

  for _, tempModelId in ipairs(tempModelArray) do
  	tempGroupArray = VUHDO_getGroupMembersSorted(tempModelId, tempSortCriterion, aPanelNum);

  	tempGroupIndex = 1;
  	for _, tempUnit in ipairs(tempGroupArray) do

  		tempInfo = VUHDO_RAID[tempUnit];

	  	tempHealButton = VUHDO_getHealButton(tempButtonIndex, aPanelNum);
	  	tempButtonIndex = tempButtonIndex + 1;


	  	tempXPos, tempYPos = VUHDO_getHealButtonPos(tempColumnIndex, tempGroupIndex, aPanelNum);
  		tempHealButton:ClearAllPoints();
      tempHealButton:SetPoint("TOPLEFT", tempPanelName, "TOPLEFT", tempXPos, -tempYPos);

      VUHDO_setupAllHealButtonAttributes(tempHealButton, tempInfo, false, false);
      VUHDO_setupAllTargetButtonAttributes(VUHDO_getTargetButton(tempHealButton), tempInfo);
	  	VUHDO_addUnitButton(tempHealButton);
      VUHDO_customizeHealButton(tempHealButton);
      tempHealButton:Show();
  		tempGroupIndex = tempGroupIndex + 1;
  	end

  	tempColumnIndex = tempColumnIndex + 1;
  end

  for tempCnt = tempButtonIndex, VUHDO_MAX_BUTTONS_PANEL do
		tempHealButton = VUHDO_getHealButton(tempCnt, aPanelNum);
		tempHealButton:Hide();
  end
end



--
function VUHDO_initGroupOrderPanel(aGroupOrderPanel)
  aGroupOrderPanel:Hide();
 	aGroupOrderPanel:ClearAllPoints();
end



--
function VUHDO_initHealButton(aButton, aPanelNum)
 	local tempCnt;
	local tempScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];
	local tempTextureFrame;

 	for tempCnt = 1, 6 do
 		tempHealthBar = VUHDO_getHealthBar(aButton, tempCnt);

 		tempHealthBar:SetMinMaxValues(0,100);
 		tempHealthBar:SetStatusBarTexture(VUHDO_TEXTURE_SPEC
 				.. VUHDO_PANEL_SETUP[aPanelNum]["PANEL_COLOR"].barTexture);
 	end

	-- Background-Bar
	local tempBgColor = VUHDO_PANEL_SETUP[aPanelNum]["PANEL_COLOR"]["TEXT"];
	local tempBackBar = VUHDO_getHealthBar(aButton, 3);
	tempBackBar:SetStatusBarColor(tempBgColor.R, tempBgColor.G, tempBgColor.B, tempBgColor.O);
	tempBackBar:SetHeight(tempScaling.barHeight);
	tempBackBar:Show();

	-- Mana Bar
	if (VUHDO_PANEL_SETUP[aPanelNum]["SCALING"].showManaBars) then
		VUHDO_getHealthBar(aButton, 2):Show();
	else
		VUHDO_getHealthBar(aButton, 2):Hide();
	end

	-- Aggro Bar
	if (VUHDO_CONFIG["DETECT_AGGRO"]) then
		local tempAggroColor = VUHDO_PANEL_SETUP["BAR_COLORS"]["AGGRO"];
		local tempAggroBar = VUHDO_getHealthBar(aButton, 4);
		tempAggroBar:SetStatusBarColor(tempAggroColor.R, tempAggroColor.G, tempAggroColor.B, tempAggroColor.O);
		tempAggroBar:SetHeight(VUHDO_PANEL_SETUP[aPanelNum]["SCALING"].rowSpacing);
		tempAggroBar:Show();
	else
		VUHDO_getHealthBar(aButton, 4):Hide();
	end

	-- Target Bar
	if (tempScaling.showTarget) then
		local tempTargetBar = VUHDO_getTargetButton(aButton, 5);
		tempTargetBar:ClearAllPoints();
		tempTargetBar:SetPoint("TOPLEFT", VUHDO_getHealthBar(aButton, 1):GetName(), "TOPRIGHT", tempScaling.targetSpacing, 0);
		tempTargetBar:SetWidth(tempScaling.targetWidth);
		tempTargetBar:SetHeight(tempScaling.barHeight);
		VUHDO_getHealthBar(aButton, 5):SetValue(100);
		VUHDO_getHealthBar(aButton, 5):SetHeight(tempScaling.barHeight);
		tempTextureFrame = VUHDO_getRaidTargetTextureFrame(VUHDO_getHealthBar(aButton, 5));
		tempTextureFrame:SetWidth(tempScaling.barHeight - 2);
		tempTextureFrame:SetHeight(tempScaling.barHeight - 2);
		tempTargetBar:Show();
		local tempTargetText = VUHDO_getBarText(VUHDO_getHealthBar(aButton, 5), true);
		tempTargetText:SetShadowColor(0, 0, 0, 1);
		tempTargetText:SetShadowOffset(1, -0.5);
		tempTargetText = VUHDO_getBarText(VUHDO_getHealthBar(aButton, 5), false);
		tempTargetText:SetShadowColor(0, 0, 0, 1);
		tempTargetText:SetShadowOffset(1, -0.5);
	else
		VUHDO_getTargetButton(aButton, 5):Hide();
	end

	-- Inc bar
	VUHDO_getHealthBar(aButton, 6):SetValue(0);

 	aButton:Hide();
 	aButton:ClearAllPoints();
end



--
function VUHDO_initAllHealButtons(aPanel, aPanelNum)
	local tempHealButton, tempGroupPanel;
	local tempCnt;

  for tempCnt = 1, VUHDO_MAX_BUTTONS_PANEL do
  	tempHealButton = VUHDO_getHealButton(tempCnt, aPanelNum);
	  VUHDO_initHealButton(tempHealButton, aPanelNum);
  end

  for tempCnt = 1, VUHDO_MAX_GROUPS_PER_PANEL do
  	tempGroupPanel = VUHDO_getGroupOrderPanel(aPanelNum, tempCnt);
	  VUHDO_initGroupOrderPanel(tempGroupPanel);
	  tempGroupPanel = VUHDO_getGroupSelectPanel(aPanelNum, tempCnt);
	  VUHDO_initGroupOrderPanel(tempGroupPanel);
  end
end



--
function VUHDO_initPanel(aPanel, aPanelNum)
	local tempSetup = VUHDO_PANEL_SETUP[aPanelNum];
	local tempPosition = tempSetup["POSITION"];
	local tempPanelColor = tempSetup["PANEL_COLOR"];
	local tempLabel;
	local tempX, tempY, tempWidth, tempHeight;
	local tempGrowth;

	tempGrowth = tempPosition.growth;

	aPanel:ClearAllPoints();
	aPanel:SetWidth(tempPosition.width);
	aPanel:SetHeight(tempPosition.height);
  aPanel:SetPoint(tempPosition.orientation, "UIParent", tempPosition.relativePoint, tempPosition.x, tempPosition.y);

  tempX, tempY = VUHDO_getAnchorCoords(aPanel, tempGrowth);

  aPanel:ClearAllPoints();
	aPanel:SetPoint(tempGrowth, "UIParent", "BOTTOMLEFT", tempX, tempY);
  VUHDO_PANEL_SETUP[aPanelNum]["POSITION"].orientation = tempGrowth;

	tempWidth = VUHDO_getHealPanelWidth(aPanelNum);
	tempHeight = VUHDO_getHealPanelHeight(aPanelNum);

	if (tempHeight < 30) then
		tempHeight = 30;
	end

	aPanel:SetWidth(tempWidth);
	aPanel:SetHeight(tempHeight);
	VUHDO_savePanelCoords(aPanel);

	local tempLabel = VUHDO_getPanelNumLabel(aPanel, aPanelNum);

	if (VUHDO_IS_PANEL_CONFIG) then
		tempLabel:SetText("{PANEL " .. aPanelNum .. "}");
		tempLabel:Show();
		if (DESIGN_MISC_PANEL_NUM ~= nil and DESIGN_MISC_PANEL_NUM == aPanelNum) then
			tempLabel:SetTextColor(1, 1, 1, 1);
		else
			tempLabel:SetTextColor(0.4, 0.4, 0.4, 1);
		end

		VUHDO_getMiscButton(aPanel):Show();
		VUHDO_getConfigCloseTexture(aPanel):Show();
		VUHDO_getTooltipTexture(aPanel):Show();

		if (VUHDO_DESIGN_PANEL_EXTENDED[aPanelNum]) then
			VUHDO_getDesignPanel(aPanel):Show();
			VUHDO_getPanelExtendTexture(aPanel):Hide();
			VUHDO_getTooltipTexture(aPanel):Hide();
		else
			VUHDO_getDesignPanel(aPanel):Hide();
			VUHDO_getPanelExtendTexture(aPanel):Show();
			VUHDO_getTooltipTexture(aPanel):Show();
		end
	else
		tempLabel:Hide();
		VUHDO_getMiscButton(aPanel):Hide();
		VUHDO_getPanelExtendTexture(aPanel):Hide();
		VUHDO_getDesignPanel(aPanel):Hide();
		VUHDO_getConfigCloseTexture(aPanel):Hide();
		VUHDO_getTooltipTexture(aPanel):Hide();
	end

	aPanel:SetBackdropColor(
		tempPanelColor["BACK"].R,
		tempPanelColor["BACK"].G,
		tempPanelColor["BACK"].B,
		tempPanelColor["BACK"].O
	);

	aPanel:SetBackdropBorderColor(
		tempPanelColor["BORDER"].R,
		tempPanelColor["BORDER"].G,
		tempPanelColor["BORDER"].B,
		tempPanelColor["BORDER"].O
	);

end



--
function VUHDO_refreshInitPanel(aPanel, aPanelNum)
	local tempWidth = VUHDO_getHealPanelWidth(aPanelNum);
	local tempHeight = VUHDO_getHealPanelHeight(aPanelNum);

	if (tempHeight < 30) then
		tempHeight = 30;
	end

	aPanel:SetWidth(tempWidth);
	aPanel:SetHeight(tempHeight);
end



---
function VUHDO_isPanelVisible(aPanelNum)
	if (not VUHDO_CONFIG["SHOW_PANELS"]) then
		return false;
	end

  local tempPanelModel = VUHDO_PANEL_MODELS[aPanelNum];

  if (tempPanelModel == nil) then
  	return false;
  else
  	return true;
  end

end



--
function VUHDO_redrawPanel(aPanelNum)
  local tempPanel = VUHDO_getActionPanel(aPanelNum);

  if (VUHDO_isPanelVisible(aPanelNum)) then
		VUHDO_initAllHealButtons(tempPanel, aPanelNum);
  	VUHDO_positionAllHealButtons(tempPanel, aPanelNum);
		VUHDO_positionTableHeaders(tempPanel, aPanelNum);
		VUHDO_initPanel(tempPanel, aPanelNum);
		if (VUHDO_MOVE_PANEL == nil or VUHDO_getComponentPanelNum(VUHDO_MOVE_PANEL) ~= aPanelNum) then
 			tempPanel:Show();
 		end
  else
  	tempPanel:Hide();
	end
end



--
function VUHDO_refreshPanel(aPanelNum)
  local tempPanel = VUHDO_getActionPanel(aPanelNum);

  if (VUHDO_isPanelVisible(aPanelNum)) then
		VUHDO_refreshInitPanel(tempPanel, aPanelNum);
		VUHDO_refreshPositionTableHeaders(tempPanel, aPanelNum);
  	VUHDO_refreshPositionAllHealButtons(tempPanel, aPanelNum);
		if (VUHDO_MOVE_PANEL == nil or VUHDO_getComponentPanelNum(VUHDO_MOVE_PANEL) ~= aPanelNum) then
	 		tempPanel:Show();
	 	end
  else
  	tempPanel:Hide();
	end
end



--
function VUHDO_customizePanel(aPanelNum)
	local tempHealButton;
	local tempCnt;

	for tempCnt = 1, VUHDO_MAX_BUTTONS_PANEL do
		tempHealButton = VUHDO_getHealButton(tempCnt, aPanelNum);
		if (tempHealButton:IsVisible()) then
			VUHDO_customizeHealButton(tempHealButton);
		else
			break;
		end
	end
end



--
function VUHDO_initPanelModels()
	VUHDO_PANEL_MODELS = { };
	local tempCnt;

	for tempCnt = 1, VUHDO_MAX_PANELS do
		VUHDO_PANEL_MODELS[tempCnt] = VUHDO_PANEL_SETUP[tempCnt]["MODEL"].groups;
	end
end



--
function VUHDO_initDynamicPanelModels()
	local tempIsShowModel;
	local tempIsOmmitEmpty;
	local tempPanelNum, tempModelArray;
	local tempModelIndex, tempModelId;

	if (VUHDO_isConfigPanelShowing()) then
		VUHDO_PANEL_DYN_MODELS = VUHDO_PANEL_MODELS;
		return;
	end

	VUHDO_PANEL_DYN_MODELS = { };

	for tempPanelNum, tempModelArray in pairs(VUHDO_PANEL_MODELS) do
		tempIsOmmitEmpty = VUHDO_PANEL_SETUP[tempPanelNum]["SCALING"].ommitEmptyWhenStructured;
		VUHDO_PANEL_DYN_MODELS[tempPanelNum] = { };

		for tempModelIndex, tempModelId in pairs(tempModelArray) do
			if ((not tempIsOmmitEmpty)
				or table.getn(VUHDO_getGroupMembers(tempModelId)) > 0) then
					table.insert(VUHDO_PANEL_DYN_MODELS[tempPanelNum], tempModelId);
			end
		end
	end

end


--
function VUHDO_rewritePanelModels()
	local tempCnt;

	for tempCnt = 1, VUHDO_MAX_PANELS do
		VUHDO_PANEL_SETUP[tempCnt]["MODEL"].groups = VUHDO_PANEL_MODELS[tempCnt];
	end
end



--
function VUHDO_redrawAllPanels()
	local tempCnt;
	for tempCnt = 1, VUHDO_MAX_PANELS do
		VUHDO_redrawPanel(tempCnt);
	end
end



--
function VUHDO_refreshAllPanels()
	local tempCnt;
	for tempCnt = 1, VUHDO_MAX_PANELS do
		VUHDO_refreshPanel(tempCnt);
	end
end



--
function VUHDO_customizeAllPanels()
	local tempCnt;
	for tempCnt = 1, VUHDO_MAX_PANELS do
		VUHDO_customizePanel(tempCnt);
	end
end



--
function VUHDO_reloadUI()
	VUHDO_IS_RELOADING = true;
	VUHDO_reloadRaidMembers();
	VUHDO_UNIT_BUTTONS = { };
	VUHDO_redrawAllPanels();
	VUHDO_IS_RELOADING = false;
	VUHDO_reloadBuffPanel();
end



--
function VUHDO_refreshUI()
	VUHDO_IS_RELOADING = true;
	VUHDO_reloadRaidMembers();
	VUHDO_UNIT_BUTTONS = { };
	VUHDO_refreshAllPanels();
	VUHDO_IS_RELOADING = false;
	VUHDO_reloadBuffPanel();
end

