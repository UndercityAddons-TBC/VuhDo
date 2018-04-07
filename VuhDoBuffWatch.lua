
local VUHDO_BUFF_PANEL_GAP_X = 4;
local VUHDO_BUFF_PANEL_GAP_TOP = 4;


--
VUHDO_BUFFS = {};
VUHDO_BUFF_SETTINGS = {};

local VUHDO_BUFF_PANEL_BASE_HEIGHT = nil;
local VUHDO_CLICKED_BUFF = nil;
local VUHDO_CLICKED_TARGET = nil;

local VUHDO_IN_PANEL_X;
local VUHDO_IN_PANEL_Y;
local VUHDO_IN_GRID_X;
local VUHDO_IN_PANEL_WIDTH;
local VUHDO_IN_PANEL_HEIGHT;
local VUHDO_IN_PANEL_MAX_GRID_X;

local VUHDO_PANEL_OFFSET_Y;
local VUHDO_PANEL_OFFSET_X;
local VUHDO_PANEL_WIDTH = 0;
local VUHDO_PANEL_HEIGHT = 0;
local VUHDO_IS_USED_SMART_BUFF;


--
function VUHDO_buffWatchOnMouseDown(aPanel)
	if (VUHDO_mayMoveHealPanels()) then
  	aPanel:StartMoving();
  end
end


--
function VUHDO_buffWatchOnMouseUp(aPanel)
	if (VUHDO_mayMoveHealPanels()) then
		aPanel:StopMovingOrSizing();

		local tempPosition;
		local tempX, tempY, tempRelative, tempOrientation;

		tempPosition = VUHDO_BUFF_SETTINGS["CONFIG"]["POSITION"];
		tempOrientation, _, tempRelative, tempX, tempY = aPanel:GetPoint(0);

		tempPosition.x = VUHDO_roundCoords(tempX);
		tempPosition.y = VUHDO_roundCoords(tempY);
		tempPosition.relativePoint = tempRelative;
		tempPosition.point = tempOrientation;
	end
end


--
function VUHDO_isUseSingleBuff(aSwatch)
	local tempVariants = aSwatch:GetAttribute("buff");

	if (table.getn(tempVariants) <= 1) then
		return false;
	end

	local tempConfig = VUHDO_BUFF_SETTINGS["CONFIG"];
	if (tempConfig["GROUP_SPELL_VERSION"] == "always") then
		return false;
	elseif (tempConfig["GROUP_SPELL_VERSION"] == "never") then
		return true;
	end

	if (VUHDO_isInFight()) then
		return false;
	end
	local tempVariants = aSwatch:GetAttribute("buff");
	local tempMaxVariant = VUHDO_getBuffVariantMaxTarget(tempVariants);
	if (not VUHDO_GROUPS_BUFFS[tempMaxVariant[2]]) then
		return false;
	end
	local tempLowTarget = aSwatch:GetAttribute("lowtarget");
	if (tempLowTarget == nil or not UnitInRange(tempLowTarget)) then
		return false;
	end

	local tempNumLow = aSwatch:GetAttribute("numlow");
	if (tempNumLow == 0 or tempNumLow >= tempConfig["AT_LEAST_MISSING"]) then
		return false;
	end

	return true;
end



--
function VUHDO_setupBuffButtonAttributes(aModifierKey, aButtonId, anActionName, aButton)
	local tempSpellId;

	if (anActionName ~= nil and anActionName ~= "") then
		aButton:SetAttribute(aModifierKey .. "type" .. aButtonId, "spell");
		aButton:SetAttribute(aModifierKey .. "spell" .. aButtonId, anActionName);
	else
		aButton:SetAttribute(aModifierKey .. "type" .. aButtonId, "");
		aButton:SetAttribute(aModifierKey .. "item" .. aButtonId, "");
	end
end



--
function VUHDO_setupAllBuffButtonsTo(aButton, aBuffName, aUnit, aMaxTargetBuff)
	local tempSpellDescriptor;
	local tempModifierKey, tempButtonId;

	if (VUHDO_isInFight()) then
		return;
	end

	VUHDO_setupAllBuffButtonUnits(aButton, aUnit);

	for _, tempSpellDescriptor in pairs(VUHDO_SPELL_ASSIGNMENTS) do
		tempModifierKey = tempSpellDescriptor[1];
		tempButtonId = tonumber(tempSpellDescriptor[2]);

		if (tempButtonId == 2) then
			VUHDO_setupBuffButtonAttributes(tempModifierKey, tempButtonId, nil, aButton);
		elseif (tempButtonId == 1) then
			VUHDO_setupBuffButtonAttributes(tempModifierKey, tempButtonId, aBuffName, aButton);
		else
			VUHDO_setupBuffButtonAttributes(tempModifierKey, tempButtonId, aMaxTargetBuff, aButton);
		end
	end
end



--
function VUHDO_setupAllBuffButtonUnits(aButton, aUnit)
	if (not VUHDO_isInFight()) then
		aButton:SetAttribute("unit", aUnit);
	end
end




--
function VUHDO_buffSelectDropdownOnLoad()
	UIDropDownMenu_Initialize(VuhDoBuffSelectDropdown, VUHDO_buffSelectDropdown_Initialize, "MENU", 1);
end



--
function VUHDO_buffSelectDropdown_Initialize(aLevel)
	if (VUHDO_CLICKED_BUFF == nil or VUHDO_CLICKED_TARGET == nil) then
		return;
	end

	local tempCategorySpec = VUHDO_getBuffCategory(VUHDO_CLICKED_BUFF);
	local tempCategoryName = strsub(tempCategorySpec, 3);
	local tempCategory = VUHDO_CLASS_BUFFS[VUHDO_PLAYER_CLASS][tempCategorySpec];
	local tempSettings = VUHDO_BUFF_SETTINGS[tempCategoryName];
	local tempMaxVariant = VUHDO_getBuffVariantMaxTarget(tempCategory[1]);
	local tempMaxTarget = tempMaxVariant[2];

	if (VUHDO_BUFF_TARGET_GROUP == tempMaxTarget) then
		local tempCnt;
		for tempCnt = 1,8 do
			local tempGroupName = VUHDO_HEADER_TEXTS[tempCnt];

			local tempInfo;
			tempInfo = UIDropDownMenu_CreateInfo();
			tempInfo.text = tempGroupName;
			tempInfo.keepShownOnClick = true;
			tempInfo.arg1 = tempCategoryName;
			tempInfo.arg2 = tempCnt;
			tempInfo.func = VUHDO_buffSelectDropdownGroupSelected;
			tempInfo.checked = tempSettings["groups"][tempCnt];
			UIDropDownMenu_AddButton(tempInfo);
		end
	elseif (table.getn(tempCategory) > 1) then
		local tempCategBuff
		for _, tempCategBuff in ipairs(tempCategory) do
			local tempSingleBuffName = VUHDO_getBuffVariantSingleTarget(tempCategBuff)[1];

			local tempTargetType = strsub(VUHDO_CLICKED_TARGET, 1, 1);
			local tempSelected;
			local tempTargetGroup;
			if ("C" == tempTargetType) then
				tempTargetGroup = strsub(VUHDO_CLICKED_TARGET, 2);
				--VUHDO_Msg(tempSettings["classes"][tempTargetGroup] .."/".. tempSingleBuffName);
				tempSelected = tempSettings["classes"][tempTargetGroup] == tempSingleBuffName;
			else
				tempSelected = tempSettings["buff"] == tempSingleBuffName;
			end

			if (VUHDO_BUFFS[tempSingleBuffName] ~= nil and VUHDO_BUFFS[tempSingleBuffName].present) then
				local tempInfo;
				tempInfo = UIDropDownMenu_CreateInfo();
				tempInfo.text = tempSingleBuffName;
				tempInfo.keepShownOnClick = false;
				tempInfo.icon = VUHDO_BUFFS[tempSingleBuffName].icon;
				tempInfo.arg1 = tempCategoryName
				if ("C" == tempTargetType) then
					tempInfo.func = VUHDO_buffSelectDropdownClassSelected;
					tempInfo.arg2 = tempTargetGroup .. "#" .. tempSingleBuffName;
				else
					tempInfo.func = VUHDO_buffSelectDropdownBuffSelected;
					tempInfo.arg2 = tempSingleBuffName;
				end

				tempInfo.checked = tempSelected;
				UIDropDownMenu_AddButton(tempInfo);
			end

		end
	else
		VuhDoBuffSelectDropdown:Hide();
	end

end



--
function VUHDO_buffSelectDropdownGroupSelected(aCategoryName, aGroupNum)
	if (aCategoryName ~= nil) then
		VUHDO_BUFF_SETTINGS[aCategoryName]["groups"][aGroupNum] = not VUHDO_BUFF_SETTINGS[aCategoryName]["groups"][aGroupNum];
		VUHDO_reloadBuffPanel();
	end
end



--
function VUHDO_buffSelectDropdownClassSelected(aCategoryName, aClassBuffName)

	if (aCategoryName ~= nil) then
		local tempClassBuff = VUHDO_splitString(aClassBuffName, "#");
		VUHDO_BUFF_SETTINGS[aCategoryName]["classes"][tempClassBuff[1]] = tempClassBuff[2];
		VUHDO_reloadBuffPanel();
	end
end



--
function VUHDO_buffSelectDropdownBuffSelected(aCategoryName, aBuffName)
	if (aCategoryName ~= nil) then
		VUHDO_BUFF_SETTINGS[aCategoryName]["buff"] = aBuffName;
		VUHDO_reloadBuffPanel();
	end
end



--
function VuhDoBuffPreClick(aButton, aMouseButton)
	local tempSwatch = aButton:GetParent();
	local tempVariants = tempSwatch:GetAttribute("buff");
	local tempTarget;

	local tempSuffix = SecureButton_GetButtonSuffix(aMouseButton);

	if (2 == tonumber(tempSuffix)) then
		VUHDO_CLICKED_BUFF = tempVariants[1][1];
		VUHDO_CLICKED_TARGET = tempSwatch:GetAttribute("target");
		ToggleDropDownMenu(1, nil, VuhDoBuffSelectDropdown, aButton:GetName(), 0, -5);
	end

	VUHDO_IS_USED_SMART_BUFF = VUHDO_isUseSingleBuff(tempSwatch);

	if (VUHDO_IS_USED_SMART_BUFF) then
		tempTarget = tempSwatch:GetAttribute("lowtarget");
		local tempBuff = VUHDO_getBuffVariantSingleTarget(tempVariants)[1];
		VUHDO_setupAllBuffButtonsTo(aButton, tempBuff, tempTarget, VUHDO_getBuffVariantMaxTarget(tempVariants)[1]);
	else
		tempTarget = tempSwatch:GetAttribute("goodtarget");
		VUHDO_setupAllBuffButtonUnits(aButton, tempTarget);
	end

	if (tempTarget ~= nil) then
		--VUHDO_Msg(tempTarget .. " " ..VUHDO_getBuffVariantMaxTarget(tempVariants)[1]);
	end

end



--
function VuhDoBuffPostClick(aButton, aMouseButton)
	if (VUHDO_IS_USED_SMART_BUFF) then
		local tempSwatch = aButton:GetParent();
		local tempVariants = tempSwatch:GetAttribute("buff");
		tempTarget = tempSwatch:GetAttribute("goodtarget");
		tempBuff = VUHDO_getBuffVariantMaxTarget(tempVariants)[1];
		VUHDO_setupAllBuffButtonsTo(aButton, tempBuff, tempTarget, tempBuff);
	end
end



--
function VUHDO_getAllUniqueSpells()
	local tempUniqueBuffs = { };

	local tempAllBuffs = VUHDO_CLASS_BUFFS[VUHDO_PLAYER_CLASS];
	local tempCategBuffs;

	for _, tempCategBuffs in pairs(tempAllBuffs) do
		local tempVariant = tempCategBuffs[1];
		local tempName = tempVariant[1][1];
		if (VUHDO_BUFFS[tempName] ~= nil and VUHDO_BUFFS[tempName].present and VUHDO_BUFF_TARGET_UNIQUE == tempVariant[1][2]) then
			table.insert(tempUniqueBuffs, tempName);
		end

	end

	return tempUniqueBuffs;
end



--
function VUHDO_initDynamicBuffArray()
	local tempAllBuffs = VUHDO_CLASS_BUFFS[VUHDO_PLAYER_CLASS];
	local tempCategory, tempCategorySpells;

	if (tempAllBuffs == nil) then
		return false;
	end

	for _, tempCategory in pairs(tempAllBuffs) do
		for _, tempCategorySpells in pairs(tempCategory) do
			for _, tempBuffInfo in pairs(tempCategorySpells) do
				VUHDO_BUFFS[tempBuffInfo[1]] = { ["present"] = false };
			end
		end
	end
end



--
function getUnitBuffRestSecs(aUnit, aBuffBuffName, anIsCastableOnly)
	local tempName, tempSecs;
	local tempCnt;

	for tempCnt = 1, 9999 do
		tempName, _, _, _, _, tempSecs = UnitBuff(aUnit, tempCnt, anIsCastableOnly);
		if (tempName == nil or tempSecs == nil) then
			break;
		end

		if (tempName == aBuffBuffName) then
			return tempSecs;
		end
	end

	return 0;
end



-- The buff-buff name is the name of the player buff a buff causes
function VUHDO_getBuffBuffName(aBuffSpellName)
	if (VUHDO_BUFF_BUFF_IRREGUALAR_NAMES[aBuffSpellName] ~= nil) then
		return VUHDO_BUFF_BUFF_IRREGUALAR_NAMES[aBuffSpellName];
	end

	return aBuffSpellName;
end



--
function VUHDO_initBuffSettings()
	if (VUHDO_getVersion(VUHDO_BUFF_SETTINGS) ~= VUHDO_VERSION_BUFFS) then
		VUHDO_Msg("Your buff settings have been reset due to changed compatibility!", 1, 0.4, 0.4);
		VUHDO_BUFF_SETTINGS = { ["VERSION"] = VUHDO_VERSION_BUFFS };
	end

	if (VUHDO_BUFF_SETTINGS["CONFIG"] == nil) then
		VUHDO_BUFF_SETTINGS["CONFIG"] = VUHDO_deepCopyTable(VUHDO_DEFAULT_BUFF_CONFIG);
	end

	VUHDO_REFRESH_BUFFS_TIMER = VUHDO_BUFF_SETTINGS["CONFIG"]["REFRESH_SECS"];
end



--
function VUHDO_initBuffsFromSpellBook()
	local tempCnt;
	local tempSpellName;

	VUHDO_initDynamicBuffArray();

	tempCnt = 1;
	while (true) do
		tempSpellName, _ = GetSpellName(tempCnt, BOOKTYPE_SPELL);
		if (tempSpellName == nil) then
			break;
		end

		if (VUHDO_BUFFS[tempSpellName] ~= nil and not VUHDO_BUFFS[tempSpellName].present) then
			local _, _, tempIcon = GetSpellInfo(tempCnt, BOOKTYPE_SPELL);
			local tempBuffInfo = {
				["present"] = true;
				["icon"] = tempIcon;
				["id"] = tempCnt;
			};

			VUHDO_BUFFS[tempSpellName] = tempBuffInfo;
		end

		tempCnt = tempCnt + 1;
	end
end



--
function VUHDO_getValidBuffGroups(someSettings)
	local tempCnt;
	local tempGroups = {};

	for tempCnt = 1,8 do
		if (someSettings["groups"][tempCnt]) then
			table.insert(tempGroups, tempCnt);
		end
	end

	return tempGroups;
end



--
function VUHDO_getValidBuffClasses(someSettings)
	local tempClassName;
	local tempGroups = {};

	for _, tempClassName in ipairs(VUHDO_CLASS_NAMES_ORDERED) do
		if (someSettings["classes"][tempClassName] ~= nil) then
			table.insert(tempGroups, VUHDO_CLASS_IDS[tempClassName]);
		end
	end

	return tempGroups;
end



--
function VUHDO_getBuffVariants(aBuffName)
	local tempClassBuffs = VUHDO_CLASS_BUFFS[VUHDO_PLAYER_CLASS];
	local tempCategoryBuffs, tempBuffVariants, tempVariant;

	for _, tempCategoryBuffs in pairs(tempClassBuffs) do
		for _, tempBuffVariants in pairs(tempCategoryBuffs) do
			for _, tempVariant in pairs(tempBuffVariants) do
				if (aBuffName == tempVariant[1]) then
					return tempBuffVariants;
				end
			end
		end
	end

	return nil;
end


--
function VUHDO_getBuffCategory(aBuffName)
	local tempClassBuffs = VUHDO_CLASS_BUFFS[VUHDO_PLAYER_CLASS];
	local tempCategoryBuffs, tempBuffVariants, tempVariant, tempCategName;

	for tempCategName, tempCategoryBuffs in pairs(tempClassBuffs) do
		for _, tempBuffVariants in pairs(tempCategoryBuffs) do
			for _, tempVariant in pairs(tempBuffVariants) do
				if (aBuffName == tempVariant[1]) then
					return tempCategName;
				end
			end
		end
	end

	return nil;
end



--
function VUHDO_addBuffSwatch(aBuffPanel, aGroupName, someBuffVariants, aBuffTarget)
	local tempMaxVariant = VUHDO_getBuffVariantMaxTarget(someBuffVariants);
	local tempMaxTargetName = tempMaxVariant[1];
	local tempPostfix = tempMaxTargetName;
	local tempColor;

	if (aBuffTarget ~= nil) then
		tempPostfix = tempPostfix .. aBuffTarget;
	end

	local tempBuffSwatch = VUHDO_getOrCreateBuffSwatch("VuhDoBuffSwatch_" .. tempPostfix, aBuffPanel);
	tempBuffSwatch:SetAttribute("buff", someBuffVariants);
	tempBuffSwatch:SetAttribute("target", aBuffTarget);

	VUHDO_GLOBAL[tempBuffSwatch:GetName() .. "GroupLabelLabel"]:SetText(aGroupName);

	local tempIcon = VUHDO_GLOBAL[tempBuffSwatch:GetName() .. "BuffIconTexture"];
	if (VUHDO_BUFF_TARGET_CLASS == tempMaxVariant[2]) then
		VUHDO_GLOBAL[tempIcon:GetName() .. "Texture"]:SetTexture(VUHDO_BUFFS[tempMaxTargetName].icon);
		tempIcon:SetAlpha(0.5);
		tempIcon:Show();
	else
		tempIcon:Hide();
	end

	tempBuffSwatch:ClearAllPoints();
	tempBuffSwatch:SetPoint("TOPLEFT", aBuffPanel:GetName(), "TOPLEFT", VUHDO_IN_PANEL_X, -VUHDO_IN_PANEL_Y);

	tempColor = VUHDO_BUFF_SETTINGS["CONFIG"]["SWATCH_BORDER_COLOR"];
	tempBuffSwatch:SetBackdropBorderColor(tempColor.R, tempColor.G, tempColor.B, tempColor.O);
	tempBuffSwatch:Show();

	local tempButton = VUHDO_GLOBAL[tempBuffSwatch:GetName() .. "GlassButton"];
	if (tempButton:GetAttribute("unit") == nil) then
		VUHDO_setupAllBuffButtonsTo(tempButton, tempMaxTargetName, "player", tempMaxTargetName);
	end

	if (VUHDO_IN_PANEL_X > VUHDO_IN_PANEL_WIDTH) then
		VUHDO_IN_PANEL_WIDTH = VUHDO_IN_PANEL_X;
	end

	if (VUHDO_IN_PANEL_Y + tempBuffSwatch:GetHeight() > VUHDO_IN_PANEL_HEIGHT) then
		VUHDO_IN_PANEL_HEIGHT = VUHDO_IN_PANEL_Y + tempBuffSwatch:GetHeight();
	end

	if (VUHDO_IN_GRID_X > VUHDO_IN_GRID_MAX_X) then
		VUHDO_IN_GRID_MAX_X = VUHDO_IN_GRID_X;
	end

	VUHDO_IN_GRID_X = VUHDO_IN_GRID_X + 1;
	if (VUHDO_IN_GRID_X > VUHDO_BUFF_SETTINGS["CONFIG"]["SWATCH_MAX_ROWS"]) then
		VUHDO_IN_GRID_X = 1;
		VUHDO_IN_PANEL_X = 0;
		VUHDO_IN_PANEL_Y = VUHDO_IN_PANEL_Y + tempBuffSwatch:GetHeight();
	else
		VUHDO_IN_PANEL_X = VUHDO_IN_PANEL_X + tempBuffSwatch:GetWidth();
	end

	return tempBuffSwatch;
end



--
function VUHDO_addBuffPanel(aCategorySpec)
	local tempCategoryName = strsub(aCategorySpec, 3);
	local tempSettings = VUHDO_BUFF_SETTINGS[tempCategoryName];
	local tempClassBuffs = VUHDO_CLASS_BUFFS[VUHDO_PLAYER_CLASS];
	local tempCategBuffs = tempClassBuffs[aCategorySpec];
	local tempTestVariants = tempCategBuffs[1];
	local tempMaxVariant = VUHDO_getBuffVariantMaxTarget(tempTestVariants);
	local tempBuffTarget = tempMaxVariant[2];
	local tempBuffPanel, tempBuffSwatch;
	local tempIcon;
	local tempAddWidth;

	local tempLabelText;
	if (VUHDO_BUFF_TARGET_CLASS == tempBuffTarget or VUHDO_BUFF_TARGET_GROUP == tempBuffTarget) then
		tempLabelText = tempCategoryName;
	elseif (VUHDO_BUFF_SETTINGS[tempCategoryName].buff ~= nil) then
		tempLabelText = VUHDO_BUFF_SETTINGS[tempCategoryName].buff;
	else
		tempLabelText = tempMaxVariant[1];
	end

	--VUHDO_Msg("add buff panel for: " .. tempLabelText);
	tempBuffPanel = VUHDO_getOrCreateBuffPanel("VuhDoBuffPanel" .. tempLabelText);
	if (VUHDO_BUFF_PANEL_BASE_HEIGHT == nil) then
		VUHDO_BUFF_PANEL_BASE_HEIGHT = tempBuffPanel:GetHeight();
	end

	if (VUHDO_BUFFS[tempLabelText] ~= nil and VUHDO_BUFFS[tempLabelText].icon ~= nil) then
		tempIcon = VUHDO_BUFFS[tempLabelText].icon;
	else
		tempIcon = VUHDO_BUFFS[tempMaxVariant[1]].icon;
	end

	if (VUHDO_BUFF_SETTINGS["CONFIG"]["SHOW_LABEL"]) then
		getglobal(tempBuffPanel:GetName() .. "BuffNameLabelLabel"):SetText(tempLabelText);
		getglobal(tempBuffPanel:GetName() .. "BuffNameLabelLabel"):Show();
	else
		getglobal(tempBuffPanel:GetName() .. "BuffNameLabelLabel"):Hide();
	end
	getglobal(tempBuffPanel:GetName() .. "IconTextureTexture"):SetTexture(tempIcon);

	VUHDO_IN_PANEL_X = 0;
	VUHDO_IN_PANEL_Y = VUHDO_BUFF_PANEL_BASE_HEIGHT;
	VUHDO_IN_GRID_X = 1;
	VUHDO_IN_PANEL_WIDTH = 0;
	VUHDO_IN_PANEL_HEIGHT = 0;

	if (VUHDO_BUFF_TARGET_SINGLE == tempBuffTarget) then
		-- no additional infos needed
	elseif (VUHDO_BUFF_TARGET_GROUP == tempBuffTarget) then
		local tempGroups = VUHDO_getValidBuffGroups(tempSettings);
		local tempGroupNum;
		for _, tempGroupNum in ipairs(tempGroups) do
			if (VUHDO_BUFF_SETTINGS["CONFIG"]["SHOW_EMPTY"] or VUHDO_getNumGroupMembers(tempGroupNum) > 0) then
				tempBuffSwatch = VUHDO_addBuffSwatch(tempBuffPanel, VUHDO_HEADER_TEXTS[tempGroupNum], tempCategBuffs[1], "G" .. tempGroupNum);
			end
		end
	elseif (VUHDO_BUFF_TARGET_CLASS == tempBuffTarget) then
		local tempGroups = VUHDO_getValidBuffClasses(tempSettings);
		local tempGroupId;
		for _, tempGroupId in ipairs(tempGroups) do
			if (VUHDO_BUFF_SETTINGS["CONFIG"]["SHOW_EMPTY"] or VUHDO_getNumGroupMembers(tempGroupId) > 0) then
				local tempClassName = VUHDO_ID_CLASSES[tempGroupId];
				local tempClassText = VUHDO_HEADER_TEXTS[tempGroupId];
				local tempBuffName = tempSettings["classes"][tempClassName];
				local tempBuffVariants = VUHDO_getBuffVariants(tempBuffName);
				tempBuffSwatch = VUHDO_addBuffSwatch(tempBuffPanel, tempClassText, tempBuffVariants, "C" .. tempClassName);
			end
		end
	elseif (VUHDO_BUFF_TARGET_UNIQUE == tempBuffTarget) then
		tempBuffSwatch = VUHDO_addBuffSwatch(tempBuffPanel, tempSettings["name"], tempCategBuffs[1], "N" .. tempSettings["name"]);
	else
		local tempVariants = VUHDO_getBuffVariants(tempSettings["buff"]);
		if (tempVariants ~= nil) then
			tempBuffSwatch = VUHDO_addBuffSwatch(tempBuffPanel, VUHDO_I18N_PLAYER, VUHDO_getBuffVariants(tempSettings["buff"]), "S");
		end
	end

	if (tempBuffSwatch ~= nil) then
		tempBuffPanel:ClearAllPoints();
		tempBuffPanel:SetPoint("TOPLEFT", "VuhDoBuffWatchMainFrame", "TOPLEFT", VUHDO_PANEL_OFFSET_X, -VUHDO_PANEL_OFFSET_Y);
		tempBuffPanel:SetWidth(tempBuffSwatch:GetWidth() * VUHDO_IN_GRID_MAX_X);
		tempBuffPanel:SetHeight(VUHDO_IN_PANEL_HEIGHT);
		tempBuffPanel:Show();
	end

	return tempBuffPanel;
end



--
function VUHDO_addAllBuffPanels()
	local tempCategorySpec, tempCategoryName;
	local tempAllClassBuffs = VUHDO_CLASS_BUFFS[VUHDO_PLAYER_CLASS];
	local tempBuffPanel;
	local tempColPanels;

	VUHDO_PANEL_OFFSET_Y = VUHDO_BUFF_PANEL_GAP_TOP;
	VUHDO_PANEL_OFFSET_X = VUHDO_BUFF_PANEL_GAP_X;
	VUHDO_PANEL_HEIGHT = VUHDO_BUFF_PANEL_GAP_TOP;
	VUHDO_PANEL_WIDTH = VUHDO_BUFF_PANEL_GAP_X;
  VUHDO_IN_GRID_MAX_X = 0;

	tempColPanels = 0;
	local tempIndex = 0;

	for _, _ in pairs(tempAllClassBuffs) do
  	for tempCategorySpec, _ in pairs(tempAllClassBuffs) do
  		tempCategoryName = strsub(tempCategorySpec, 3);
  		local tempNumber = tonumber(strsub(tempCategorySpec, 1, 2));
  		local tempCategSettings = VUHDO_BUFF_SETTINGS[tempCategoryName];
			if (tempNumber == tempIndex + 1) then
  			tempIndex = tempIndex + 1;

    		if (tempCategSettings ~= nil and tempCategSettings.enabled) then

    			tempBuffPanel = VUHDO_addBuffPanel(tempCategorySpec);
    			tempColPanels = tempColPanels + 1;

    			VUHDO_PANEL_OFFSET_Y = VUHDO_PANEL_OFFSET_Y + VUHDO_IN_PANEL_HEIGHT;

    			if (VUHDO_PANEL_OFFSET_Y > VUHDO_PANEL_HEIGHT) then
    				VUHDO_PANEL_HEIGHT = VUHDO_PANEL_OFFSET_Y;
    			end

    			if (VUHDO_PANEL_OFFSET_X > VUHDO_PANEL_WIDTH) then
    				VUHDO_PANEL_WIDTH = VUHDO_PANEL_OFFSET_X;
    			end

    			if (tempColPanels >= VUHDO_BUFF_SETTINGS["CONFIG"]["PANEL_MAX_BUFFS"]) then
    				VUHDO_PANEL_OFFSET_Y = VUHDO_BUFF_PANEL_GAP_TOP;
    				VUHDO_PANEL_OFFSET_X = VUHDO_PANEL_OFFSET_X + tempBuffPanel:GetWidth();
   					VUHDO_IN_GRID_MAX_X = 0;

    				tempColPanels = 0;
    			end
    		end

			end
  	end
  end

	if (tempBuffPanel ~= nil) then
		VUHDO_PANEL_WIDTH = VUHDO_PANEL_WIDTH + tempBuffPanel:GetWidth();
	end


	return tempBuffPanel;
end




--
function VUHDO_reloadBuffPanel()
	if (not VUHDO_BUFF_SETTINGS["CONFIG"].SHOW) then
		if (VuhDoBuffWatchMainFrame ~= nil) then
			VuhDoBuffWatchMainFrame:Hide();
		end
		return;
	end

	VUHDO_resetAllBuffPanels();

	local tempAllClassBuffs = VUHDO_CLASS_BUFFS[VUHDO_PLAYER_CLASS];
	if (tempAllClassBuffs == nil) then
		return;
	end

	CreateFrame("Frame", "VuhDoBuffWatchMainFrame", UIParent, "VuhDoBuffWatchMainFrameTemplate");
	local tempBuffPanel = VUHDO_addAllBuffPanels();

	if (VUHDO_PANEL_HEIGHT < 10) then
		VUHDO_PANEL_HEIGHT = 24;
		VUHDO_PANEL_WIDTH = 150;
	end

	VuhDoBuffWatchMainFrame:ClearAllPoints();
	tempPosition = VUHDO_BUFF_SETTINGS["CONFIG"]["POSITION"];
	VuhDoBuffWatchMainFrame:SetPoint(tempPosition.point, "UIParent", tempPosition.relativePoint, tempPosition.x, tempPosition.y);
	VuhDoBuffWatchMainFrame:SetWidth(VUHDO_PANEL_WIDTH + VUHDO_BUFF_PANEL_GAP_X);
	VuhDoBuffWatchMainFrame:SetHeight(VUHDO_PANEL_HEIGHT + VUHDO_BUFF_PANEL_GAP_TOP);


	local tempColor = VUHDO_BUFF_SETTINGS["CONFIG"]["PANEL_BG_COLOR"];
	VuhDoBuffWatchMainFrame:SetBackdropColor(tempColor.R, tempColor.G, tempColor.B, tempColor.O);
	tempColor = VUHDO_BUFF_SETTINGS["CONFIG"]["PANEL_BORDER_COLOR"];
	VuhDoBuffWatchMainFrame:SetBackdropBorderColor(tempColor.R, tempColor.G, tempColor.B, tempColor.O);
	VuhDoBuffWatchMainFrame:SetScale(VUHDO_BUFF_SETTINGS["CONFIG"]["SCALE"]);
	VuhDoBuffWatchMainFrame:Show();
end



--
function VUHDO_isBuffGroupEmpty(aTargetCode)
	local tempCode = strsub(aTargetCode, 1, 1);

	if ("G" == tempCode) then
		local tempGroupNum = tonumber(strsub(aTargetCode, 2));
		return VUHDO_GROUPS[tempGroupNum] == nil or table.getn(VUHDO_GROUPS[tempGroupNum]) == 0;
	elseif ("C" == tempCode) then
		local tempClassId = tonumber(VUHDO_CLASS_IDS[strsub(aTargetCode, 2)]);
		return VUHDO_GROUPS[tempClassId] == nil or table.getn(VUHDO_GROUPS[tempClassId]) == 0;
	else
		return false;
	end
end



--
function VUHDO_getMissingBuffs(someBuffVariants, someUnits)
	local tempConfig = VUHDO_BUFF_SETTINGS["CONFIG"];
	local tempUnit;
	local tempCnt;
	local tempBuffName, tempTexture, tempDuration, tempRest;
	local tempMaxVariant = VUHDO_getBuffVariantMaxTarget(someBuffVariants);
	local tempSingleVariant = VUHDO_getBuffVariantSingleTarget(someBuffVariants);
	local tempMissingGroup = { };
	local tempLowGroup = { };
	local tempOkayGroup = { };
	local tempGoodTarget = nil;
	local tempFound;
	local tempLowestRest = nil;
	local tempLowestUnit = nil;
	local tempIsTotemActive;
	local tempTotemNum, tempTotemFound, tempStart;

	tempTotemFound = false;
	for _, tempUnit in pairs(someUnits) do

		tempFound = false;
		for tempCnt = 1, 9999 do
			if (VUHDO_BUFF_TARGET_TOTEM == tempMaxVariant[2]) then
				tempTotemFound = false;
				for tempTotemNum = 1, 4 do
					tempIsTotemActive, tempBuffName, tempStart, tempDuration, tempTexture = GetTotemInfo(tempTotemNum);

					if (tempIsTotemActive and tempTexture == VUHDO_BUFFS[tempMaxVariant[1]].icon) then
						tempTotemFound = true;
						tempRest = tempDuration - (GetTime() - tempStart);
						if (tempRest < 0) then
							tempRest = 0;
						end
						break;
					end
				end
			else
				tempBuffName, _, tempTexture, _, tempDuration, tempRest = UnitBuff(tempUnit, tempCnt, false);
				if (tempBuffName == nil) then
					break;
				end
			end

			if (tempRest == nil) then
				tempRest = 0;
			end

			if (tempDuration == nil) then
				tempDuration = 0;
			end

			if (tempTexture == VUHDO_BUFFS[tempMaxVariant[1]].icon
				or tempTexture == VUHDO_BUFFS[tempSingleVariant[1]].icon) then
				tempFound = true;

					if ((tempRest < (tempConfig["REBUFF_MIN_MINUTES"] * 60)
					and tempDuration > (tempConfig["REBUFF_MIN_MINUTES"] * 60 * 1.5))
					or (tempRest / tempDuration) < (tempConfig["REBUFF_AT_PERCENT"] / 100)) then
						if (VUHDO_isInSameZone(tempUnit)) then
							table.insert(tempLowGroup, tempUnit);
						end
					else
						table.insert(tempOkayGroup, tempUnit);
					end

					if (tempLowestRest == nil or tempRest < tempLowestRest) then
						tempLowestRest = tempRest;
						tempLowestUnit = tempUnit;
					end
			end

			if (VUHDO_BUFF_TARGET_TOTEM == tempMaxVariant[2]) then
				break;
			end
		end


		if (UnitIsConnected(tempUnit) and not UnitIsDeadOrGhost(tempUnit)) then
			if (not tempFound) then
				if (VUHDO_isInSameZone(tempUnit)) then
					table.insert(tempMissingGroup, tempUnit);
					tempLowestUnit = tempUnit;
				end
			end
			if (VUHDO_BUFF_TARGET_HOSTILE == tempMaxVariant[2]) then
				tempGoodTarget = "playertarget";
			elseif (VUHDO_BUFF_TARGET_UNIQUE == tempMaxVariant[2] or UnitInRange(tempUnit)) then
				tempGoodTarget = tempUnit;
			end

		end
	end

	return tempMissingGroup, tempLowGroup, tempGoodTarget, tempLowestRest, tempLowestUnit, tempOkayGroup;
end



--
function VUHDO_getMissingBuffsForCode(aTargetCode, someBuffVariants)
	local tempCode = strsub(aTargetCode, 1, 1);
	local tempDestGroup;

	if ("G" == tempCode) then
		local tempGroupNum = tonumber(strsub(aTargetCode, 2));
		tempDestGroup = VUHDO_GROUPS[tempGroupNum];
	elseif ("C" == tempCode) then
		local tempClassId = VUHDO_CLASS_IDS[strsub(aTargetCode, 2)];

		if (VUHDO_GROUPS[tempClassId] == nil) then
			VUHDO_GROUPS[tempClassId] = { };
		else
		 tempDestGroup = VUHDO_GROUPS[tempClassId];
		end
	elseif ("N" == tempCode) then
		tempDestGroup = { VUHDO_RAID_NAMES[strsub(aTargetCode, 2)] };
	else
		local tempMaxVariant = VUHDO_getBuffVariantMaxTarget(someBuffVariants);
		local tempMaxTarget = tempMaxVariant[2];

		if (VUHDO_BUFF_TARGET_OWN_GROUP == tempMaxTarget) then
			local tempPlayerGroup = 1;

			if (UnitInRaid("player")) then
				local tempId = VUHDO_PLAYER_RAID_ID;
				if (tempId ~= nil and UnitExists(tempId)) then
					_, _, tempPlayerGroup, _, _, _, _, _ = GetRaidRosterInfo(VUHDO_getUnitNo(tempId));
				end
			end

			if (VUHDO_GROUPS[tempPlayerGroup] == nil) then
				VUHDO_GROUPS[tempPlayerGroup] = { };
			end
			tempDestGroup = VUHDO_GROUPS[tempPlayerGroup];
		else
			-- If self, totem or aura we only care if buff isn't on player
			tempDestGroup = { "player" };
		end
	end

	return VUHDO_getMissingBuffs(someBuffVariants, tempDestGroup);
end



--
function VUHDO_setBuffSwatchColor(aSwatch, aColorInfo)
	local tempConfig = VUHDO_BUFF_SETTINGS["CONFIG"];
	local tempColor = VUHDO_copyColor(tempConfig["SWATCH_BG_COLOR"]);
	tempColor = VUHDO_getDiffColor(tempColor, aColorInfo);
	local tempOpacity, tempTextOpacity;

	if (tempColor.useOpacity) then
		tempOpacity = tempColor.O
		tempTextOpacity = tempColor.TO;
	else
		tempOpacity = 1;
		tempTextOpacity = 1;
	end

	if (tempColor.useBackground) then
		aSwatch:SetBackdropColor(tempColor.R, tempColor.G, tempColor.B, tempOpacity);
		local tempBorderColor = tempConfig["SWATCH_BORDER_COLOR"];
		--aSwatch:SetBackdropBorderColor(tempBorderColor.R, tempBorderColor.G, tempBorderColor.B, tempOpacity);
	elseif(tempColor.useOpacity) then
		aSwatch:SetAlpha(tempOpacity);
	end

	if (tempColor.useText) then
		local tempSwatchName = aSwatch:GetName();
		VUHDO_GLOBAL[tempSwatchName .. "MessageLabelLabel"]:SetTextColor(tempColor.TR, tempColor.TG, tempColor.TB, tempTextOpacity);
		VUHDO_GLOBAL[tempSwatchName .. "TimerLabelLabel"]:SetTextColor(tempColor.TR, tempColor.TG, tempColor.TB, tempTextOpacity);
		VUHDO_GLOBAL[tempSwatchName .. "CounterLabelLabel"]:SetTextColor(tempColor.TR, tempColor.TG, tempColor.TB, tempTextOpacity);
		tempColor = VUHDO_brightenTextColor(VUHDO_copyColor(aColorInfo), 1.2);
		VUHDO_GLOBAL[tempSwatchName .. "GroupLabelLabel"]:SetTextColor(tempColor.TR, tempColor.TG, tempColor.TB, tempTextOpacity);
	end
end



--
function VUHDO_setBuffSwatchInfo(aSwatchName, anInfoText)
	VUHDO_GLOBAL[aSwatchName .. "MessageLabelLabel"]:SetText(anInfoText);
end



--
function VUHDO_setBuffSwatchCount(aSwatchName, aText)
	VUHDO_GLOBAL[aSwatchName .. "CounterLabelLabel"]:SetText(aText);
end



--
function VUHDO_setBuffSwatchTimer(aSwatchName, aSecsNum)

	if (aSecsNum ~= nil) then
		local tempMinutes = floor(aSecsNum / 60);
		local tempSecs = floor(aSecsNum) - tempMinutes * 60;
		local tempSecsStr;

		if (tempSecs == 0) then
			tempSecsStr = "00";
		elseif (tempSecs < 10) then
			tempSecsStr = "0" .. tostring(tempSecs);
		else
			tempSecsStr = tostring(tempSecs);
		end
		VUHDO_GLOBAL[aSwatchName .. "TimerLabelLabel"]:SetText(tempMinutes .. ":" .. tempSecsStr);
	else
		VUHDO_GLOBAL[aSwatchName .. "TimerLabelLabel"]:SetText("");
	end

end



--
function VUHDO_updateBuffSwatch(aSwatch)
	local tempName = aSwatch:GetName();
	local tempVariants = aSwatch:GetAttribute("buff");
	local tempTargetCode = aSwatch:GetAttribute("target");
	local tempConfig = VUHDO_BUFF_SETTINGS["CONFIG"];
	local tempMissingGroup = { };
	local tempLowGroup = { };
	local tempOkayGroup = { };
	local tempGoodTarget = nil;
	local tempLowestRest = nil;
	local tempLowestUnit = nil;

	if (VUHDO_isBuffGroupEmpty(tempTargetCode)) then
		VUHDO_setBuffSwatchColor(aSwatch, tempConfig["SWATCH_EMPTY_GROUP"]);
		VUHDO_setBuffSwatchInfo(tempName, "N/A");
		VUHDO_setBuffSwatchCount(tempName, "0");
		VUHDO_setBuffSwatchTimer(tempName, 0);
	else
		local tempRefSpell = tempVariants[1][1];
		local tempCooldown, tempTotalCd = VUHDO_getSpellCooldown(tempRefSpell);

		if (tempCooldown > 0) then
			VUHDO_setBuffSwatchColor(aSwatch, tempConfig["SWATCH_COLOR_BUFF_COOLDOWN"]);
			VUHDO_setBuffSwatchInfo(tempName, "CD");
			VUHDO_setBuffSwatchCount(tempName, "");
			VUHDO_setBuffSwatchTimer(tempName, tempCooldown);
			if (tempTotalCd > 59) then
				VUHDO_BUFFS[tempRefSpell].wasOnCd = true;
			end
		else
			if (VUHDO_BUFFS[tempRefSpell].wasOnCd
			and VUHDO_BUFF_SETTINGS["CONFIG"]["HIGHLIGHT_COOLDOWN"]) then
				UIFrameFlash(aSwatch, 0.3, 0.3, 5, true, 0, 0.3);
				VUHDO_BUFFS[tempRefSpell].wasOnCd = false;
			end

			tempMissingGroup, tempLowGroup, tempGoodTarget, tempLowestRest, tempLowestUnit, tempOkayGroup
				= VUHDO_getMissingBuffsForCode(tempTargetCode, tempVariants);

			if (table.getn(tempMissingGroup) > 0) then
				VUHDO_setBuffSwatchColor(aSwatch, tempConfig["SWATCH_COLOR_BUFF_OUT"]);

				if (tempGoodTarget == nil) then
					VUHDO_setBuffSwatchInfo(tempName, "|cffff0000RNG|r");
				else
					VUHDO_setBuffSwatchInfo(tempName, "GO!");
				end

				VUHDO_setBuffSwatchCount(tempName, "" .. (table.getn(tempMissingGroup) + table.getn(tempLowGroup)));
				VUHDO_setBuffSwatchTimer(tempName, 0);

			elseif (table.getn(tempLowGroup) > 0) then
				VUHDO_setBuffSwatchColor(aSwatch, tempConfig["SWATCH_COLOR_BUFF_LOW"]);

				if (tempGoodTarget == nil) then
					VUHDO_setBuffSwatchInfo(tempName, "|cffff0000RNG|r");
				else
					VUHDO_setBuffSwatchInfo(tempName, "LOW");
				end

				VUHDO_setBuffSwatchCount(tempName, "" .. table.getn(tempLowGroup));
				VUHDO_setBuffSwatchTimer(tempName, tempLowestRest);
			else
				VUHDO_setBuffSwatchColor(aSwatch, tempConfig["SWATCH_COLOR_BUFF_OKAY"]);

				if (table.getn(tempOkayGroup) == 0) then
					VUHDO_setBuffSwatchInfo(tempName, "|cffff0000N/A|r");
				elseif (tempGoodTarget == nil) then
					VUHDO_setBuffSwatchInfo(tempName, "|cffff0000RNG|r");
				else
					VUHDO_setBuffSwatchInfo(tempName, "OK");
				end

				VUHDO_setBuffSwatchCount(tempName, table.getn(tempOkayGroup));
				if (tempLowestRest == 0) then
					VUHDO_setBuffSwatchTimer(tempName, nil);
				else
					VUHDO_setBuffSwatchTimer(tempName, tempLowestRest);
				end
			end
		end
	end

	aSwatch:SetAttribute("lowtarget", tempLowestUnit);
	aSwatch:SetAttribute("goodtarget", tempGoodTarget);
	aSwatch:SetAttribute("numlow", table.getn(tempLowGroup) + table.getn(tempMissingGroup));
end



--
function VUHDO_updateBuffPanel()
	if (not VUHDO_BUFF_SETTINGS["CONFIG"].SHOW) then
		return;
	end

	local tempAllSwatches = VUHDO_getAllBuffSwatches();
	local tempSwatch;

	for _, tempSwatch in pairs(tempAllSwatches) do
		VUHDO_updateBuffSwatch(tempSwatch);
	end
end
