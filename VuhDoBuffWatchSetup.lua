


local VUHDO_BUFF_PANEL_X, VUHDO_BUFF_PANEL_Y;
local VUHDO_BUFF_PANEL_WIDTH;
local VUHDO_BUFF_PANEL_HEIGHT;
local VUHDO_PANEL_INSET_X = 12;
local VUHDO_PANEL_INSET_Y = 30;
local VUHDO_PANEL_MAX_HEIGHT = 350;

local BUFF_PANEL_BASE_HEIGHT = nil;



--
function VUHDO_buffSetupOnMouseDown(aPanel)
	aPanel:StartMoving();
end



--
function VUHDO_buffSetupOnMouseUp(aPanel)
	aPanel:StopMovingOrSizing();
end



--
function VUHDO_buffGroupNoneOnClick(aButton)
	local tempGeneric = aButton:GetParent();
	local tempCnt;
	for tempCnt = 1,8 do
		getglobal(tempGeneric:GetName() .. "GroupCheckButton" .. tempCnt):SetChecked(false);
	end
end



--
function VUHDO_buffGroupAllOnClick(aButton)
	local tempGeneric = aButton:GetParent();
	local tempCnt;
	for tempCnt = 1,8 do
		getglobal(tempGeneric:GetName() .. "GroupCheckButton" .. tempCnt):SetChecked(true);
	end
end



--
function VUHDO_getGenericPanel(aCategoryName)
	return getglobal("VuhDoBuffSetupPanel" .. aCategoryName .. "GenericPanel");
end



--
function VUHDO_getBuffPanelCheckBox(aCategoryName)
	return getglobal("VuhDoBuffSetupPanel" .. aCategoryName .. "EnableCheckButton");
end



--
function VUHDO_buffSetupCancelOnClick(aButton)
	VuhDoBuffSetupMainFrame:Hide();
end



--
function VUHDO_buffSetupOkayOnClick(aButton)
	local tempCategories = VUHDO_CLASS_BUFFS[VUHDO_PLAYER_CLASS];
	local tempCategoryName, tempCategoryBuffs;
	local tempGenericPanel;
	for tempCategoryName, tempCategoryBuffs in pairs(tempCategories) do
		local tempNameStr = strsub(tempCategoryName, 3);
		local tempSettings = VUHDO_BUFF_SETTINGS[tempNameStr];
		tempGenericPanel = VUHDO_getGenericPanel(tempNameStr);
		if (tempSettings ~= nil) then
			tempSettings["enabled"] = VUHDO_getBuffPanelCheckBox(tempNameStr):GetChecked();
		end

		if (tempGenericPanel ~= nil) then
			local tempMaxVariant = VUHDO_getBuffVariantMaxTarget(tempCategoryBuffs[1]);
			local tempBuffTarget = tempMaxVariant[2];

    	if (VUHDO_BUFF_TARGET_SINGLE == tempBuffTarget) then
    		-- no additional infos needed
    	elseif (VUHDO_BUFF_TARGET_GROUP == tempBuffTarget) then
    		local tempCnt;
    		local tempCheckBox;

    		for tempCnt = 1,8 do
    			tempCheckBox = getglobal(tempGenericPanel:GetName() .. "GroupCheckButton" .. tempCnt);
    			tempSettings["groups"][tempCnt] = tempCheckBox:GetChecked();
    		end

    	elseif (VUHDO_BUFF_TARGET_CLASS == tempBuffTarget) then
    			tempSettings["classes"] = {
    				["WARRIOR"] = UIDropDownMenu_GetSelectedValue(getglobal(tempGenericPanel:GetName() .. "WarriorsCombo")),
    				["ROGUE"] = UIDropDownMenu_GetSelectedValue(getglobal(tempGenericPanel:GetName() .. "RoguesCombo")),
    				["HUNTER"] = UIDropDownMenu_GetSelectedValue(getglobal(tempGenericPanel:GetName() .. "HuntersCombo")),
    				["PALADIN"] = UIDropDownMenu_GetSelectedValue(getglobal(tempGenericPanel:GetName() .. "PaladinsCombo")),
    				["MAGE"] = UIDropDownMenu_GetSelectedValue(getglobal(tempGenericPanel:GetName() .. "MagesCombo")),
    				["WARLOCK"] = UIDropDownMenu_GetSelectedValue(getglobal(tempGenericPanel:GetName() .. "WarlocksCombo")),
    				["SHAMAN"] = UIDropDownMenu_GetSelectedValue(getglobal(tempGenericPanel:GetName() .. "ShamansCombo")),
    				["DRUID"] = UIDropDownMenu_GetSelectedValue(getglobal(tempGenericPanel:GetName() .. "DruidsCombo")),
    				["PRIEST"] = UIDropDownMenu_GetSelectedValue(getglobal(tempGenericPanel:GetName() .. "PriestsCombo")),
    				["DEATH KNIGHT"] = UIDropDownMenu_GetSelectedValue(getglobal(tempGenericPanel:GetName() .. "DeathKnightsCombo"))
    			};
    	elseif (VUHDO_BUFF_TARGET_UNIQUE == tempBuffTarget) then
				local tempEditBox = getglobal(tempGenericPanel:GetName() .. "PlayerNameEditBox");
				tempSettings["name"] = tempEditBox:GetText();
    	else -- Aura, Totem, own group, self
    		if (table.getn(tempCategoryBuffs) > 1) then
    			local tempCombo = getglobal(tempGenericPanel:GetName() .. "DedicatedComboBox");
    			tempSettings["buff"] = UIDropDownMenu_GetSelectedValue(tempCombo);
    		end
    	end
		end
	end

	VuhDoBuffSetupMainFrame:Hide();
	VUHDO_reloadUI();
end



--
function VUHDO_buffOptionsOnClick(aButton)
	VUHDO_toggleMenu(VuhDoBuffWatchOptions);
end



--
function VUHDO_buffSetupNewRowCheck(aWidth)
	if (VUHDO_BUFF_PANEL_Y > VUHDO_BUFF_PANEL_HEIGHT) then
		VUHDO_BUFF_PANEL_HEIGHT = VUHDO_BUFF_PANEL_Y;
	end

	if (VUHDO_BUFF_PANEL_Y > VUHDO_PANEL_MAX_HEIGHT) then
		VUHDO_BUFF_PANEL_X = VUHDO_BUFF_PANEL_X +  aWidth;
		VUHDO_BUFF_PANEL_Y = VUHDO_PANEL_INSET_Y;
	end

	if (VUHDO_BUFF_PANEL_X > VUHDO_BUFF_PANEL_WIDTH) then
		VUHDO_BUFF_PANEL_WIDTH = VUHDO_BUFF_PANEL_X;
	end

end


--
function VUHDO_buffEnableCheckButtonOnClick(aCheckButton)
	VUHDO_setBuffPanelEnabled(aCheckButton:GetParent(), aCheckButton:GetChecked());
end



--
function VUHDO_playerNameOnTextChanged(anEditBox)
	if (VUHDO_RAID_NAMES[anEditBox:GetText()] ~= nil) then
		anEditBox:SetTextColor(0, 1, 0, 1);
	else
		anEditBox:SetTextColor(1, 0, 0, 1);
	end
end



--
function VUHDO_getBuffVariantMaxTarget(someVariants)
	local tempMaxVariant = nil;

	for _, tempBuffInfo in pairs(someVariants) do
		if (VUHDO_GROUPS_BUFFS[tempBuffInfo[2]] ~= nil) then
			return tempBuffInfo;
		else
			tempMaxVariant = tempBuffInfo;
		end
	end

	return tempMaxVariant;
end



--
function VUHDO_getBuffVariantSingleTarget(someVariants)
	local tempBuff;

	for _, tempBuffInfo in pairs(someVariants) do
		if (VUHDO_GROUPS_BUFFS[tempBuffInfo[2]] == nil) then
			return tempBuffInfo;
		else
			tempBuff = tempBuffInfo;
		end
	end

	return tempBuff;
end



--
function VUHDO_addGenericBuffFrame(aBuffVariant, aFrameTemplateName, aCategoryName, someCategoryBuffs)
	local tempBuffPanel, tempGenericFrame;

	-- main panel
	local tempFrameName = "VuhDoBuffSetupPanel" .. aCategoryName;
	tempBuffPanel = getglobal(tempFrameName);
	if (tempBuffPanel == nil) then
		tempBuffPanel = CreateFrame("Frame", tempFrameName, VuhDoBuffSetupMainFrame, "VuhDoBuffSetupPanelTemplate");
		BUFF_PANEL_BASE_HEIGHT = tempBuffPanel:GetHeight();
	end

	getglobal(tempBuffPanel:GetName() .. "BuffNameLabelLabel"):SetText(aCategoryName);
	getglobal(tempBuffPanel:GetName() .. "BuffTextureTexture"):SetTexture(VUHDO_BUFFS[aBuffVariant[1]].icon);
	local tempInFrameY = BUFF_PANEL_BASE_HEIGHT;

	if (aFrameTemplateName ~= nil) then
		tempGenericFrame = getglobal(tempFrameName .. "GenericPanel");
		if (tempGenericFrame == nil) then
			tempGenericFrame = CreateFrame("Frame", "$parentGenericPanel", tempBuffPanel, aFrameTemplateName);
		end
		tempGenericFrame:ClearAllPoints();
		tempGenericFrame:SetPoint("TOPLEFT", tempBuffPanel:GetName(), "TOPLEFT", 0, -tempInFrameY);
		tempInFrameY = tempInFrameY + tempGenericFrame:GetHeight() + 5;
	end

	tempBuffPanel:ClearAllPoints();
	tempBuffPanel:SetPoint("TOPLEFT", "VuhDoBuffSetupMainFrame", "TOPLEFT", VUHDO_BUFF_PANEL_X, -VUHDO_BUFF_PANEL_Y);
	tempBuffPanel:SetHeight(tempInFrameY);
	tempBuffPanel:Show();

	VUHDO_BUFF_PANEL_Y = VUHDO_BUFF_PANEL_Y + tempInFrameY;

	VUHDO_buffSetupNewRowCheck(tempBuffPanel:GetWidth());
	return tempBuffPanel, tempGenericFrame;
end



--
function VUHDO_setBuffPanelEnabled(aPanel, anIsEnabled)
	local tempLabel = getglobal(aPanel:GetName() .. "BuffNameLabelLabel");

	aPanel:SetBackdropColor(0, 0, 0, 1);

	if (anIsEnabled) then
		tempLabel:SetTextColor(VUHDO_VALUE_COLOR.TR, VUHDO_VALUE_COLOR.TG, VUHDO_VALUE_COLOR.TB, 1);
	else
		tempLabel:SetTextColor(VUHDO_INDEX_COLOR.TR, VUHDO_INDEX_COLOR.TG, VUHDO_INDEX_COLOR.TB, 0.5);
	end
end



--
function VUHDO_setupStaticBuffPanel(aCategoryName, aBuffPanel)
	local tempBuffSettings;

	if (VUHDO_BUFF_SETTINGS[aCategoryName] == nil) then
		VUHDO_BUFF_SETTINGS[aCategoryName] = { ["enabled"] = true };
	end

	tempBuffSettings = VUHDO_BUFF_SETTINGS[aCategoryName];

	local tempEnableCheckButton = getglobal(aBuffPanel:GetName() .. "EnableCheckButton");
	tempEnableCheckButton:SetChecked(tempBuffSettings.enabled);

	VUHDO_setBuffPanelEnabled(aBuffPanel, tempBuffSettings.enabled);
end



--
function VUHDO_buffNameAvail(aBuffName)
	if (VUHDO_BUFFS[aBuffName] ~= nil and VUHDO_BUFFS[aBuffName].present) then
		return aBuffName;
	else
		return nil;
	end
end


--
function VUHDO_getAllBuffNamesAvail(someCategoryBuffs)
	local tempBuffNames = { };
	local tempVariants, tempMaxVariant, tempName;

	for _, tempVariants in ipairs(someCategoryBuffs) do
		local tempMaxVariant = VUHDO_getBuffVariantSingleTarget(tempVariants);
		tempName = tempMaxVariant[1];
		if (VUHDO_BUFFS[tempName].present) then
			table.insert(tempBuffNames, tempName);
		end
	end

	return tempBuffNames;
end



--
function VUHDO_setBuffBoxIcon(aGenericPanel, aTexture)
	local tempTexture = getglobal(aGenericPanel:GetParent():GetName() .. "BuffTextureTexture");
	tempTexture:SetTexture(aTexture);
end



--
function VUHDO_buffComboOnValueChanged(anInfo)
	VUHDO_setBuffBoxIcon(anInfo.owner:GetParent(), VUHDO_BUFFS[anInfo.value].icon);
end



--
function VUHDO_addBuffsToCombo(aComboBox, someBuffNames, aSelectedValue)

	local tempComboInitFunction =	function()
		local tempBuffName;

		for _, tempBuffName in ipairs(someBuffNames) do
			local tempInfo = { };
			tempInfo.value = tempBuffName;

			tempInfo.owner = aComboBox;
			tempInfo.text = tempBuffName;
			tempInfo.func =	function()
				UIDropDownMenu_SetSelectedValue(aComboBox, tempBuffName);
				VUHDO_buffComboOnValueChanged(tempInfo);
			end

			UIDropDownMenu_AddButton(tempInfo);
		end
	end

	UIDropDownMenu_Initialize(aComboBox, tempComboInitFunction);
	UIDropDownMenu_SetSelectedValue(aComboBox, aSelectedValue);
end



--
function VUHDO_setupGenericBuffPanel(aBuffVariant, aGenericPanel, someCategoryBuffs, aCategoryName)
	local tempBuffTarget = aBuffVariant[2];
	local tempSettings = VUHDO_BUFF_SETTINGS[aCategoryName];

	if (VUHDO_BUFF_TARGET_SINGLE == tempBuffTarget) then
		-- no additional infos needed
	elseif (VUHDO_BUFF_TARGET_GROUP == tempBuffTarget) then
		if (tempSettings["groups"] == nil) then
			tempSettings["groups"] = { true, true, true, true, true, true, true, true };
		end
		local tempCnt;
		local tempCheckBox;

		for tempCnt = 1,8 do
			tempCheckBox = getglobal(aGenericPanel:GetName() .. "GroupCheckButton" .. tempCnt);
			tempCheckBox:SetChecked(tempSettings["groups"][tempCnt]);
		end

	elseif (VUHDO_BUFF_TARGET_CLASS == tempBuffTarget) then
		local tempClassBuffs = VUHDO_getAllBuffNamesAvail(someCategoryBuffs);

		if (tempSettings["classes"] == nil) then
			tempSettings["classes"] = {
				["WARRIOR"] = VUHDO_buffNameAvail(tempClassBuffs[1]),
				["ROGUE"] = VUHDO_buffNameAvail(tempClassBuffs[1]),
				["HUNTER"] = VUHDO_buffNameAvail(tempClassBuffs[1]),
				["PALADIN"] = VUHDO_buffNameAvail(tempClassBuffs[1]),
				["MAGE"] = VUHDO_buffNameAvail(tempClassBuffs[1]),
				["WARLOCK"] = VUHDO_buffNameAvail(tempClassBuffs[1]),
				["SHAMAN"] = VUHDO_buffNameAvail(tempClassBuffs[1]),
				["DRUID"] = VUHDO_buffNameAvail(tempClassBuffs[1]),
				["PRIEST"] = VUHDO_buffNameAvail(tempClassBuffs[1]),
				["DEATH KNIGHT"] = VUHDO_buffNameAvail(tempClassBuffs[1])
			};
		end

		local tempClassSettings = tempSettings["classes"];

		VUHDO_addBuffsToCombo(getglobal(aGenericPanel:GetName() .. "WarriorsCombo"), tempClassBuffs, tempClassSettings["WARRIOR"]);
		VUHDO_addBuffsToCombo(getglobal(aGenericPanel:GetName() .. "DeathKnightsCombo"), tempClassBuffs, tempClassSettings["DEATH KNIGHT"]);
		VUHDO_addBuffsToCombo(getglobal(aGenericPanel:GetName() .. "DruidsCombo"), tempClassBuffs, tempClassSettings["DRUID"]);
		VUHDO_addBuffsToCombo(getglobal(aGenericPanel:GetName() .. "PriestsCombo"), tempClassBuffs, tempClassSettings["PRIEST"]);
		VUHDO_addBuffsToCombo(getglobal(aGenericPanel:GetName() .. "ShamansCombo"), tempClassBuffs, tempClassSettings["SHAMAN"]);
		VUHDO_addBuffsToCombo(getglobal(aGenericPanel:GetName() .. "PaladinsCombo"), tempClassBuffs, tempClassSettings["PALADIN"]);
		VUHDO_addBuffsToCombo(getglobal(aGenericPanel:GetName() .. "WarlocksCombo"), tempClassBuffs, tempClassSettings["WARLOCK"]);
		VUHDO_addBuffsToCombo(getglobal(aGenericPanel:GetName() .. "MagesCombo"), tempClassBuffs, tempClassSettings["MAGE"]);
		VUHDO_addBuffsToCombo(getglobal(aGenericPanel:GetName() .. "HuntersCombo"), tempClassBuffs, tempClassSettings["HUNTER"]);
		VUHDO_addBuffsToCombo(getglobal(aGenericPanel:GetName() .. "RoguesCombo"), tempClassBuffs, tempClassSettings["ROGUE"]);

	elseif (VUHDO_BUFF_TARGET_UNIQUE == tempBuffTarget) then
		if (tempSettings["name"] == nil) then
			tempSettings["name"] = VUHDO_PLAYER_NAME;
		end

		local tempEditBox = getglobal(aGenericPanel:GetName() .. "PlayerNameEditBox");
		tempEditBox:SetText(tempSettings["name"]);
	else -- Aura, Totem, own group, self
			if (tempSettings["buff"] == nil) then
				tempSettings["buff"] = VUHDO_buffNameAvail(aBuffVariant[1]);
			end
		if (table.getn(someCategoryBuffs) > 1) then
			local tempCategBuffNames = VUHDO_getAllBuffNamesAvail(someCategoryBuffs);
			local tempCombo = getglobal(aGenericPanel:GetName() .. "DedicatedComboBox");
			VUHDO_addBuffsToCombo(tempCombo, tempCategBuffNames, tempSettings["buff"]);
			VUHDO_setBuffBoxIcon(aGenericPanel, UIDropDownMenu_GetSelectedValue(tempCombo));
		end
	end
end



--
function VUHDO_buildBuffSetupGenericPanel(aCategoryName, someCategoryBuffs)
	local tempAllVariants;
	local tempMaxVariant;
	local tempMaxTarget;
	local tempBuffPanel
	local tempGenericPanel;
	local tempPanelTemplate;

	tempMaxVariant = VUHDO_getBuffVariantMaxTarget(someCategoryBuffs[1]);

	if (VUHDO_BUFFS[tempMaxVariant[1]].present) then
		tempMaxTarget = tempMaxVariant[2];

		if (VUHDO_BUFF_TARGET_SINGLE == tempMaxTarget) then
			-- Do nothing: single target buffs will only be alerted, when cooldown is off, but aren't auto-buffable
			--VUHDO_Msg(aCategoryName .. " = Single");
			return nil, nil;
		elseif (VUHDO_BUFF_TARGET_GROUP == tempMaxTarget) then
			-- add groups panel
			--VUHDO_Msg(aCategoryName .. " = Group");
			tempPanelTemplate = "VuhDoBuffSetupGroupPanelTemplate";
		elseif (VUHDO_BUFF_TARGET_CLASS == tempMaxTarget) then
			-- add classes panel
			--VUHDO_Msg(aCategoryName .. " = Class");
			tempPanelTemplate = "VuhDoBuffSetupClassTargetPanelTemplate";
		elseif (VUHDO_BUFF_TARGET_UNIQUE == tempMaxTarget) then
			-- add player name panel
			--VUHDO_Msg(aCategoryName .. " = Unique");
			tempPanelTemplate = "VuhDoBuffSetupUniqueSingleTargetPanelTemplate";
		else -- Aura, Totem, own group, self
			-- If more than one mutual exclusive
			if (table.getn(someCategoryBuffs) > 1) then
				-- add Combo-Box having all spells
				--VUHDO_Msg(aCategoryName .. " = dedicated, choice");
				tempPanelTemplate = "VuhDoBuffSetupDedicatedPanelTemplate";
			else
				-- add basic panel only (only en-/disable)
				--VUHDO_Msg(aCategoryName .. " = dedicated, single");
				tempPanelTemplate = nil;
			end
		end

		tempBuffPanel, tempGenericPanel = VUHDO_addGenericBuffFrame(tempMaxVariant, tempPanelTemplate, aCategoryName);
		VUHDO_setupStaticBuffPanel(aCategoryName, tempBuffPanel);
		VUHDO_setupGenericBuffPanel(tempMaxVariant, tempGenericPanel, someCategoryBuffs, aCategoryName);

		return tempBuffPanel, tempGenericPanel;
	else
		return nil, nil;
	end
end



--
function VUHDO_buildAllBuffSetupGenerericPanel()
	local tempAllBuffs = VUHDO_CLASS_BUFFS[VUHDO_PLAYER_CLASS];
	local tempCategoryName, tempAllCategoryBuffs;
	local tempBuffPanel = nil;
	local tempCurPanel;
	local tempIndex;

	VUHDO_BUFF_PANEL_X = VUHDO_PANEL_INSET_X;
	VUHDO_BUFF_PANEL_Y = VUHDO_PANEL_INSET_Y;
	VUHDO_BUFF_PANEL_WIDTH = 0;
	VUHDO_BUFF_PANEL_HEIGHT = 0;

	local tempFrameName = "VuhDoBuffSetupMainFrame";
	if (getglobal(tempFrameName) == nil) then
		CreateFrame("Frame", tempFrameName, UIParent, "VuhDoBuffSetupMainFrameTemplate");
	end

	if (tempAllBuffs == nil) then
		VUHDO_Msg("There are no buffs defined for your class!");
		return;
	end

	tempIndex = 0;

	for _, _ in pairs(tempAllBuffs) do
		for tempCategoryName, tempAllCategoryBuffs in pairs(tempAllBuffs) do
			local tempNumber = tonumber(strsub(tempCategoryName, 1, 2));

			if (tempNumber == tempIndex + 1) then
				tempIndex = tempIndex + 1;
				local tempName = strsub(tempCategoryName, 3);
				tempCurPanel, _ = VUHDO_buildBuffSetupGenericPanel(tempName, tempAllCategoryBuffs);
				if (tempBuffPanel == nil) then
					tempBuffPanel = tempCurPanel;
				end
			end
		end
	end

	if (tempBuffPanel == nil) then
		VUHDO_Msg("You don't know any configurable buffs!");
		return;
	end

	local tempControlPanel = getglobal("VuhDoBuffSetupControlPanel");
	if (tempControlPanel == nil) then
		tempControlPanel = CreateFrame("Frame", "VuhDoBuffSetupControlPanel", VuhDoBuffSetupMainFrame, "VuhDoBuffSetupControlPanelTemplate");
	end

	if (VUHDO_BUFF_PANEL_Y + tempControlPanel:GetHeight() > VUHDO_BUFF_PANEL_HEIGHT) then
		VUHDO_BUFF_PANEL_HEIGHT = VUHDO_BUFF_PANEL_Y + tempControlPanel:GetHeight();
	else
		VUHDO_BUFF_PANEL_Y = VUHDO_BUFF_PANEL_HEIGHT - tempControlPanel:GetHeight();
	end

	tempControlPanel:ClearAllPoints();
	tempControlPanel:SetPoint("TOPLEFT", "VuhDoBuffSetupMainFrame", "TOPLEFT", VUHDO_BUFF_PANEL_X, -VUHDO_BUFF_PANEL_Y);

	VuhDoBuffSetupMainFrame:SetHeight(VUHDO_BUFF_PANEL_HEIGHT + VUHDO_PANEL_INSET_X);
	VuhDoBuffSetupMainFrame:SetWidth(VUHDO_BUFF_PANEL_WIDTH + tempBuffPanel:GetWidth() + VUHDO_PANEL_INSET_X);
	VuhDoBuffSetupMainFrame:ClearAllPoints();
	VuhDoBuffSetupMainFrame:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
	VuhDoBuffSetupMainFrame:Show();
end
