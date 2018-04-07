VUHDO_GROUP_ORDER_IS_DRAGGING = false;
VUHDO_DRAG_PANEL = nil;
DESIGN_MISC_PANEL_NUM = nil;
local VUHDO_CURRENT_GROUPS_COMBO;
local VUHDO_CURRENT_GROUP_ID;



--
function VUHDO_getGrowthComboText(aGrowthName)
	if ("TOPLEFT" == aGrowthName) then
		return VUHDO_I18N_GT_DOWN;
	elseif ("TOPRIGHT" == aGrowthName) then
		return VUHDO_I18N_LT_DOWN;
	elseif ("BOTTOMLEFT" == aGrowthName) then
		return VUHDO_I18N_GT_UP;
	elseif ("BOTTOMRIGHT" == aGrowthName) then
		return VUHDO_I18N_LT_UP;
	end
end



--
function VUHDO_getSortComboText(aSortCriterion)
	if (VUHDO_SORT_RAID_NAME == aSortCriterion) then
		return VUHDO_I18N_NAME;
	elseif (VUHDO_SORT_RAID_MAX_HEALTH == aSortCriterion) then
		return VUHDO_I18N_MAX_HP;
	else
		return VUHDO_I18N_UNIT_ID;
	end
end



--
function VUHDO_configGrowToComboOnShow(aComboBox)
  local tempPanelNum = VUHDO_getComponentPanelNum(aComboBox);
	local tempGrowth = VUHDO_PANEL_SETUP[tempPanelNum]["POSITION"].growth;

	UIDropDownMenu_SetSelectedValue(aComboBox, tempGrowth);
	getglobal(aComboBox:GetName() .. "Text"):SetText(VUHDO_getGrowthComboText(tempGrowth));
end



--
function VUHDO_panelDesignGrowSelectionChanged(anEntry)
	local tempComboBox = anEntry.owner;
	local tempHealPanel = tempComboBox:GetParent():GetParent();
  local tempPanelNum = VUHDO_getComponentPanelNum(tempComboBox);
	VUHDO_PANEL_SETUP[tempPanelNum]["POSITION"].growth = anEntry.value;

	UIDropDownMenu_SetSelectedValue(tempComboBox, anEntry.value);
	getglobal(tempComboBox:GetName() .. "Text"):SetText(VUHDO_getGrowthComboText(anEntry.value));

	VUHDO_positionAllDesignPanels(tempHealPanel);
	VUHDO_savePanelCoords(tempHealPanel);
	VUHDO_redrawPanel(tempPanelNum);
end



--
function VUHDO_panelDesignColumnsSliderOnShow(aSliderKnob)
	local tempSlider = aSliderKnob:GetParent();
	local tempPanelNum = VUHDO_getComponentPanelNum(tempSlider);
	local tempSliderScale = getglobal(tempSlider:GetName() .. "Slider");

	if (VUHDO_PANEL_SETUP[tempPanelNum]["MODEL"].ordering == VUHDO_ORDERING_STRICT) then
		tempSliderScale:SetMinMaxValues(1, VUHDO_MAX_GROUPS_PER_PANEL);
		aSliderKnob:SetValue("" .. VUHDO_PANEL_SETUP[tempPanelNum]["SCALING"].maxColumnsWhenStructured);
	else
		tempSliderScale:SetMinMaxValues(1, 20);
		aSliderKnob:SetValue("" .. VUHDO_PANEL_SETUP[tempPanelNum]["SCALING"].maxRowsWhenLoose);
	end
end



--
function VUHDO_panelDesignColumnsSliderOnValueChanged(aSliderKnob)
	local tempPanel = aSliderKnob:GetParent():GetParent();

	if (not tempPanel:IsVisible()) then
		return;
	end

	local tempPanelNum = VUHDO_getComponentPanelNum(tempPanel);

	local tempHeader = getglobal(tempPanel:GetName() .. "NumColumnsLabelLabel");
	local tempValue = tonumber(aSliderKnob:GetValue());

	if (VUHDO_PANEL_SETUP[tempPanelNum]["MODEL"].ordering == VUHDO_ORDERING_STRICT) then
	  tempHeader:SetText(VUHDO_I18N_MAX_COLUMNS .. tempValue);
	else
	  tempHeader:SetText(VUHDO_I18N_MAX_ROWS .. tempValue);
	end
end



--
function VUHDO_panelDesignColumnsSliderOnMouseUp(aSliderKnob)
	local tempSlider = aSliderKnob:GetParent();
	local tempPanelNum = VUHDO_getComponentPanelNum(tempSlider);
	if (VUHDO_PANEL_SETUP[tempPanelNum]["MODEL"].ordering == VUHDO_ORDERING_STRICT) then
		VUHDO_PANEL_SETUP[tempPanelNum]["SCALING"].maxColumnsWhenStructured = tonumber(aSliderKnob:GetValue());
	else
		VUHDO_PANEL_SETUP[tempPanelNum]["SCALING"].maxRowsWhenLoose = tonumber(aSliderKnob:GetValue());
	end
	VUHDO_redrawAllPanels();
end



--
function VUHDO_panelDesignDeleteOnClick(aButton)
	local tempDesignPanel = aButton:GetParent();
	local tempPanelNum = VUHDO_getComponentPanelNum(tempDesignPanel);

	if (table.getn(VUHDO_PANEL_MODELS[tempPanelNum]) > 0) then
	  DESIGN_MISC_PANEL_NUM = VUHDO_getComponentPanelNum(tempDesignPanel);
	  VuhDoYesNoFrameText:SetText(VUHDO_I18N_CLEAR_PANELS_CONFIRM);
	  VuhDoYesNoFrame:SetAttribute("callback", VUHDO_yesNoDecidedClearPanel);
		VuhDoYesNoFrame:Show();
	else
		VUHDO_CONFIG_SHOW_RAID = false;
		VUHDO_rewritePanelModels();
		VUHDO_PANEL_SETUP[tempPanelNum]["MODEL"].groups = nil;
		VUHDO_initPanelModels();
		VUHDO_initDynamicPanelModels();
		VUHDO_redrawAllPanels();
		VuhDoDesignMainPanel:Hide();
		VuhDoDesignMainPanel:Show();
	end
end



--
function VUHDO_panelDesignAddModelOnClick(aButton)
	local tempDesignPanel = aButton:GetParent();
	local tempPanelNum = VUHDO_getComponentPanelNum(tempDesignPanel);

	if (table.getn(VUHDO_PANEL_MODELS[tempPanelNum]) >= VUHDO_MAX_GROUPS_PER_PANEL) then
		--@TODO Disable Button or something
		return;
	end;
	VUHDO_CONFIG_SHOW_RAID = false;
	VUHDO_initDynamicPanelModels();
	table.insert(VUHDO_PANEL_MODELS[tempPanelNum], VUHDO_ID_UNDEFINED);
	VUHDO_guessUndefinedEntries(tempPanelNum);
	VUHDO_redrawAllPanels();
	VuhDoDesignMainPanel:Hide();
	VuhDoDesignMainPanel:Show();

end



--
function VUHDO_panelSetupRemoveGroupOnClick(aPanel)
	local tempPanelNum, tempModelNum;

	tempPanelNum, tempModelNum = VUHDO_getComponentPanelNumModelNum(aPanel)
	VUHDO_removeFromModel(tempPanelNum, tempModelNum);
	VUHDO_PANEL_MODEL_GUESSED[tempPanelNum] = { };
	VUHDO_redrawAllPanels();
end



--
function VUHDO_panelSetupChooseGroupOnClick(aButton)
	local tempPanelNum, tempModelNum;
	local tempGroupOrderPanel = aButton:GetParent();
	tempPanelNum, tempModelNum = VUHDO_getComponentPanelNumModelNum(tempGroupOrderPanel);
	local tempGroupSelectPanel = VUHDO_getGroupSelectPanel(tempPanelNum, tempModelNum);

	tempGroupOrderPanel:Hide();
	tempGroupSelectPanel:Show();
end



--
function VUHDO_groupSelectOkayOnClick(aButton)
	local tempPanelNum, tempModelNum;
	local tempGroupSelectPanel = aButton:GetParent();
	tempPanelNum, tempModelNum = VUHDO_getComponentPanelNumModelNum(tempGroupSelectPanel);
	local tempGroupOrderPanel = VUHDO_getGroupOrderPanel(tempPanelNum, tempModelNum);

	tempGroupSelectPanel:Hide();
	VUHDO_redrawPanel(tempPanelNum);

	VUHDO_setGuessedModel(tempPanelNum, tempModelNum, false);
	VUHDO_guessUndefinedEntries(tempPanelNum);
	tempGroupOrderPanel:Show();
	VUHDO_redrawAllPanels();
end



--
function VUHDO_positionDesignPanel(aDesignPanel)
	local tempPanelNum = VUHDO_getComponentPanelNum(aDesignPanel);
	local tempGrowth = VUHDO_PANEL_SETUP[tempPanelNum]["POSITION"].growth;
	local tempAnchor;
	local tempResX;
	local tempHealPanel = aDesignPanel:GetParent();

	tempResX, _ = VUHDO_getVirtualScreenRes();

	if (tempGrowth == "TOPLEFT" or tempGrowth == "BOTTOMLEFT") then

		local tempLeftMost = tempHealPanel:GetLeft() - aDesignPanel:GetWidth();
		if (tempLeftMost < -10) then
			if (tempGrowth == "TOPLEFT") then
				tempGrowth = "TOPRIGHT";
			else
				tempGrowth = "BOTTOMRIGHT";
			end
		end

	elseif (tempGrowth == "TOPRIGHT" or tempGrowth == "BOTTOMPRIGHT") then

		local tempRightMost = tempHealPanel:GetRight() + aDesignPanel:GetWidth();
		if (tempRightMost > tempResX + 10) then
			if (tempGrowth == "TOPRIGHT") then
				tempGrowth = "TOPLEFT";
			else
				tempGrowth = "BOTTOMLEFT";
			end
		end

	end

	if (tempGrowth == "TOPLEFT") then
		tempAnchor = "TOPRIGHT";
	elseif (tempGrowth == "BOTTOMLEFT") then
		tempAnchor = "BOTTOMRIGHT";
	elseif (tempGrowth == "BOTTOMRIGHT") then
		tempAnchor = "BOTTOMLEFT";
	else
		tempAnchor = "TOPLEFT";
	end

	aDesignPanel:ClearAllPoints();
  aDesignPanel:SetPoint(tempAnchor, aDesignPanel:GetParent():GetName(), tempGrowth, 0, 0);
end



--
function VUHDO_positionAllDesignPanels(aHealPanel)
	VUHDO_positionDesignPanel(VUHDO_getDesignPanel(aHealPanel));
end



--
function VUHDO_designPanelOnShow(aDesignPanel)
	aDesignPanel:SetBackdropColor(0, 0, 0, 1);
	aDesignPanel:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	VUHDO_positionDesignPanel(aDesignPanel);
end



--
function VUHDO_PanelSetupGroupSelectOnShow(aGroupSelectPanel)
	aGroupSelectPanel:SetBackdropColor(0, 0, 0, 1);
	aGroupSelectPanel:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
end



--
function VUHDO_groupSelectTypeComboOnShow(aComboBox)
	local tempPanelNum, tempModelNum;
	tempPanelNum, tempModelNum = VUHDO_getComponentPanelNumModelNum(aComboBox:GetParent());

	local tempModelId = VUHDO_PANEL_MODELS[tempPanelNum][tempModelNum];
	local tempOkayButton = getglobal(aComboBox:GetParent():GetName() .. "OkayButton");

	if (tempModelId ~= VUHDO_ID_UNDEFINED) then
		tempOkayButton:Enable();
	else
		tempOkayButton:Disable();
	end

	local tempType = VUHDO_getModelType(tempModelId);
	UIDropDownMenu_SetSelectedValue(aComboBox, tempType);
	VUHDO_configFillGroupsCombo(aComboBox:GetParent(), tempModelId);

	local tempName = VUHDO_ID_TYPE_NAMES[tempType];
	getglobal(aComboBox:GetName() .. "Text"):SetText(tempName);
end



--
function VUHDO_groupSelectTypeOnSelectionChanged(anEntry)
	local tempText = VUHDO_ID_TYPE_NAMES[anEntry.value];
	local tempPanel = anEntry.owner:GetParent();
	local tempPanelNum, tempModelNum;

	UIDropDownMenu_SetSelectedID(anEntry.owner, anEntry:GetID(), 0);
	getglobal(anEntry.owner:GetName() .. "Text"):SetText(tempText);

	tempPanelNum, tempModelNum = VUHDO_getComponentPanelNumModelNum(tempPanel);

	local tempModelId;
	if (anEntry.value == VUHDO_ID_TYPE_GROUP) then
		 tempModelId = VUHDO_ID_GROUP_1;
	elseif (anEntry.value == VUHDO_ID_TYPE_CLASS) then
		tempModelId = VUHDO_ID_WARRIORS;
	else
		tempModelId = VUHDO_ID_PETS;
	end

	VUHDO_PANEL_MODELS[tempPanelNum][tempModelNum] = tempModelId;
	VUHDO_configFillGroupsCombo(tempPanel, tempModelId);

	local tempOkayButton = getglobal(tempPanel:GetName() .. "OkayButton");
	tempOkayButton:Enable();

end



--
function VUHDO_configGroupSelectButtonOnMouseDown(aButton)
	local tempPanelNum, tempModelNum;

	local tempComboBox = aButton:GetParent();
	tempPanelNum, tempModelNum = VUHDO_getComponentPanelNumModelNum(tempComboBox:GetParent());

	local tempModelId = VUHDO_PANEL_MODELS[tempPanelNum][tempModelNum];
	local tempType = VUHDO_getModelType(tempModelId);

	VUHDO_CURRENT_GROUPS_COMBO = tempComboBox;
	VUHDO_CURRENT_GROUP_TYPE_ID = tempType;
end



--
function VUHDO_groupSelectGroupOnSelectionChanged(anEntry)
	local tempPanelNum, tempModelNum;

	local tempGroupSelectPanel = anEntry.owner:GetParent();
	tempPanelNum, tempModelNum = VUHDO_getComponentPanelNumModelNum(tempGroupSelectPanel);

	VUHDO_configFillGroupsCombo(tempGroupSelectPanel, anEntry.value);
	VUHDO_PANEL_MODELS[tempPanelNum][tempModelNum] = anEntry.value;
end


--
function VUHDO_configInitGroupsCombo()
	local tempIndex, tempId;
	local tempName;
	local tempInfo;
	local tempType = VUHDO_getModelType(VUHDO_CURRENT_GROUP_ID);

	for tempIndex, tempId in ipairs(VUHDO_ID_TYPE_MEMBERS[tempType]) do
		tempName = VUHDO_HEADER_TEXTS[tempId];
		tempInfo = VUHDO_createComboBoxInfo(VUHDO_CURRENT_GROUPS_COMBO, tempName, tempId, VUHDO_CURRENT_GROUP_ID);
		tempInfo.func = function() VUHDO_groupSelectGroupOnSelectionChanged(this) end
		UIDropDownMenu_AddButton(tempInfo);
	end

	local tempText = VUHDO_HEADER_TEXTS[VUHDO_CURRENT_GROUP_ID];
	getglobal(VUHDO_CURRENT_GROUPS_COMBO:GetName() .. "Text"):SetText(tempText);
end




--
function VUHDO_refreshGroupsCombo(aGroupsCombo, aModelId)
	VUHDO_CURRENT_GROUPS_COMBO = aGroupsCombo;
	VUHDO_CURRENT_GROUP_ID = aModelId;

	UIDropDownMenu_Initialize(aGroupsCombo, VUHDO_configInitGroupsCombo);
end



--
function VUHDO_configFillGroupsCombo(aGroupSelectPanel, aModelId)
	local tempGroupsCombo = getglobal(aGroupSelectPanel:GetName() .. "ValueComboBox");

	UIDropDownMenu_ClearAll(tempGroupsCombo);
	VUHDO_refreshGroupsCombo(tempGroupsCombo, aModelId);
end



--
function VUHDO_PanelSetupGroupOrderOnShow(aGroupOrderPanel)
	VUHDO_PanelSetupGroupOrderSetStandard(aGroupOrderPanel);
end



--
function VUHDO_PanelSetupGroupOrderSetStandard(aPanel)
	aPanel:SetBackdropColor(0, 0, 0, 1);
	aPanel:SetBackdropBorderColor(0.5, 0.5, 0.5, 1);
	aPanel:SetToplevel(false);
	VUHDO_getGroupOrderLabel2(aPanel):SetText(VUHDO_I18N_ME);
end



--
function VUHDO_PanelSetupGroupOrderSetDragging(aPanel)
	local tempText;
	local tempPanelNum, tempModelNum;

	aPanel:SetBackdropColor(0, 0, 0, 1);
	aPanel:SetBackdropBorderColor(1, 0, 0, 1);
	aPanel:SetToplevel(true);
	tempPanelNum, tempModelNum = VUHDO_getComponentPanelNumModelNum(aPanel);
	tempText = VUHDO_getHeaderText(VUHDO_PANEL_MODELS[tempPanelNum][tempModelNum]);

	VUHDO_getGroupOrderLabel2(aPanel):SetText(tempText);
end



--
function VUHDO_panelSetupGroupDragOnMouseDown(aDragArea)
	local tempGroupPanel = aDragArea:GetParent();

	VUHDO_PanelSetupGroupOrderSetDragging(tempGroupPanel);
	tempGroupPanel:StartMoving();
	VUHDO_GROUP_ORDER_IS_DRAGGING = true;
	VUHDO_DRAG_PANEL = tempGroupPanel;
end



--
function VUHDO_panelSetupGroupDragOnMouseUp(aDragArea)
	local tempGroupPanel = aDragArea:GetParent();
	tempGroupPanel:StopMovingOrSizing();
	VUHDO_GROUP_ORDER_IS_DRAGGING = false;
	VUHDO_DRAG_PANEL = nil;
	VUHDO_PanelSetupGroupOrderSetStandard(tempGroupPanel);
	VUHDO_reorderGroupsAfterDragged(tempGroupPanel);
end



--
function VUHDO_panelDesignGroupedCheckButtonOnClick(aButton)
	local tempPanelNum = VUHDO_getComponentPanelNum(aButton);

	if (VUHDO_PANEL_SETUP[tempPanelNum]["MODEL"].ordering == VUHDO_ORDERING_STRICT) then
		VUHDO_PANEL_SETUP[tempPanelNum]["MODEL"].ordering = VUHDO_ORDERING_LOOSE;
	else
		VUHDO_PANEL_SETUP[tempPanelNum]["MODEL"].ordering = VUHDO_ORDERING_STRICT;
	end

	VUHDO_panelDesignGroupedCheckButtonOnShow(aButton);
	-- Redraw Slider:
	aButton:GetParent():Hide();
	aButton:GetParent():Show();
	-- Reload loose groups
	VUHDO_reloadUI();
end



--
function VUHDO_panelDesignGroupedCheckButtonOnShow(aButton)
	local tempPanelNum = VUHDO_getComponentPanelNum(aButton);

	if (VUHDO_PANEL_SETUP[tempPanelNum]["MODEL"].ordering == VUHDO_ORDERING_STRICT) then
		getglobal(aButton:GetParent():GetName() .. "ShowEmptyCheckButton"):Enable();
		getglobal(aButton:GetParent():GetName() .. "ShowEmptyLabelLabel"):SetTextColor(1, 0.82, 0, 1);
		aButton:SetChecked(true);
	else
		getglobal(aButton:GetParent():GetName() .. "ShowEmptyCheckButton"):Disable();
		getglobal(aButton:GetParent():GetName() .. "ShowEmptyLabelLabel"):SetTextColor(0.3, 0.3, 0.2, 1);
		aButton:SetChecked(false);
	end

end



--
function VUHDO_panelDesignMiscOnClick(aButton)
	if (VUHDO_getComponentPanelNum(aButton) == DESIGN_MISC_PANEL_NUM) then
		if (VuhDoFormButtonSize:IsVisible()) then
			VUHDO_formButtonSizeOkayOnClick(getglobal("VuhDoFormButtonSize"));
			DESIGN_MISC_PANEL_NUM = nil;
		elseif(VuhDoTooltipConfig:IsVisible()) then
			VUHDO_TooltipConfigOkayOnClick();
			DESIGN_MISC_PANEL_NUM = nil;
		end
	else
		DESIGN_MISC_PANEL_NUM = VUHDO_getComponentPanelNum(aButton);

		if (VuhDoFormButtonSize:IsVisible()) then
			VUHDO_panelDesignShowHealthOnClick(getglobal("VuhDoDesignMainPanelShowPanelRaidCheckButtonButton"));
			VuhDoFormButtonSize:Hide();
			VuhDoFormButtonSize:Show();
		elseif (VuhDoTooltipConfig:IsVisible()) then
			VuhDoTooltipConfig:Hide();
			VuhDoTooltipConfig:Show();
		else
			VuhDoFormButtonSize:Show();
		end
	end
	VUHDO_redrawAllPanels();
end



--
function VUHDO_panelDesignShowEmptyOnClick(aButton)
	local tempPanelNum = VUHDO_getComponentPanelNum(aButton);

	VUHDO_PANEL_SETUP[tempPanelNum]["SCALING"].ommitEmptyWhenStructured
		= not VUHDO_PANEL_SETUP[tempPanelNum]["SCALING"].ommitEmptyWhenStructured;

	local tempIsShowEmpty = not VUHDO_PANEL_SETUP[tempPanelNum]["SCALING"].ommitEmptyWhenStructured;
	aButton:SetChecked(tempIsShowEmpty);
	VUHDO_initDynamicPanelModels();
	VUHDO_redrawPanel(tempPanelNum);
end



--
function VUHDO_panelDesignShowEmptyOnShow(aButton)
	local tempPanelNum = VUHDO_getComponentPanelNum(aButton);
	local tempIsShowEmpty = not VUHDO_PANEL_SETUP[tempPanelNum]["SCALING"].ommitEmptyWhenStructured;
	aButton:SetChecked(tempIsShowEmpty);
end



--
function VUHDO_panelDesignSortByOnShow(aComboBox)
  local tempPanelNum = VUHDO_getComponentPanelNum(aComboBox);
	local tempSortCriterion = VUHDO_PANEL_SETUP[tempPanelNum]["MODEL"].sort;

	UIDropDownMenu_SetSelectedValue(aComboBox, tempSortCriterion);
	getglobal(aComboBox:GetName() .. "Text"):SetText(VUHDO_getSortComboText(tempSortCriterion));
end



--
function VUHDO_panelDesignSortBySelectionChanged(anEntry)
	local tempComboBox = anEntry.owner;
	local tempPanelNum = VUHDO_getComponentPanelNum(tempComboBox);

	UIDropDownMenu_SetSelectedValue(tempComboBox, anEntry.value);
	VUHDO_PANEL_SETUP[tempPanelNum]["MODEL"].sort = anEntry.value;
	VUHDO_redrawPanel(tempPanelNum);
end



function VUHDO_extendTextureOnClick(aTexture)
	local tempPanelNum = VUHDO_getComponentPanelNum(aTexture);
	VUHDO_DESIGN_PANEL_EXTENDED[tempPanelNum] = true;
	VUHDO_redrawPanel(tempPanelNum);
end



--
function VUHDO_unextendTextureOnClick(aTexture)
	local tempPanelNum = VUHDO_getComponentPanelNum(aTexture);
	VUHDO_DESIGN_PANEL_EXTENDED[tempPanelNum] = nil;
	VUHDO_redrawPanel(tempPanelNum);
end



--
function VUHDO_yesNoDecidedClearPanel(aDecision)
	if (VUHDO_YES == aDecision) then
		VUHDO_rewritePanelModels();
		VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["MODEL"].groups = { };
		VUHDO_initPanelModels();
		VUHDO_initDynamicPanelModels();
		VUHDO_redrawAllPanels();
		VuhDoDesignMainPanel:Hide();
		VuhDoDesignMainPanel:Show();
	end

	DESIGN_MISC_PANEL_NUM = nil;
end
