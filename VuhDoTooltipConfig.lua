local VUHDO_CURRENT_COLOR_NAME = nil;


function VUHDO_tooltipTextureOnClick(aButton)
	local tempPanelNum = VUHDO_getComponentPanelNum(aButton);

	if (DESIGN_MISC_PANEL_NUM == tempPanelNum and VuhDoTooltipConfig:IsVisible()) then
		DESIGN_MISC_PANEL_NUM = nil;
		VuhDoTooltipConfig:Hide();
	else
		DESIGN_MISC_PANEL_NUM = VUHDO_getComponentPanelNum(aButton);
		VuhDoTooltipConfig:Show();
	end

	VUHDO_redrawAllPanels();
end



--
function VUHDO_tooltipConfigApplyAllOnClick()
	VuhDoYesNoFrameText:SetText(VUHDO_I18N_APPLY_TO_ALL_QUESTION);
	VuhDoYesNoFrame:SetAttribute("callback", VUHDO_yesNoDecidedApplyTooltipAll);
	VuhDoYesNoFrame:Show();
end



--
function VUHDO_yesNoDecidedApplyTooltipAll(aDecision)
	if (VUHDO_YES == aDecision) then
		local tempCnt;
		for tempCnt = 1, VUHDO_MAX_PANELS do
			if (DESIGN_MISC_PANEL_NUM ~= tempCnt) then
				VUHDO_PANEL_SETUP[tempCnt]["TOOLTIP"] = VUHDO_deepCopyTable(VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["TOOLTIP"]);
			end
		end

		VUHDO_redrawAllPanels();
	end
end



--
function VUHDO_TooltipConfigOkayOnClick()
	VuhDoTooltipConfig:Hide();
	ColorPickerFrame:Hide();
	VuhDoTooltip:Hide();
	DESIGN_MISC_PANEL_NUM = nil;
	VUHDO_redrawAllPanels();
end



--
function VUHDO_setAllPositionButtons(aPanelName)
	local tempPosition;
	local tempSetPosition = VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["TOOLTIP"].position;

	for _, tempPosition in pairs(VUHDO_TOOLTIP_POSITIONS) do
		getglobal(aPanelName .. "PositionPanelPosCheckButton" .. tempPosition):SetChecked(tempSetPosition == tempPosition);
	end
end



--
function VUHDO_ToolTipConfigPosCheckButtonOnClick(aCheckButton)
	local tempButtonNum = VUHDO_getNumbersFromString(aCheckButton:GetName(), 1)[1];
	VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["TOOLTIP"].position = tonumber(tempButtonNum);
	VUHDO_setAllPositionButtons("VuhDoTooltipConfig");
	VUHDO_demoTooltip(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_tooltipConfigOnShow(aPanel)
	local tempPanelNum = DESIGN_MISC_PANEL_NUM;
	local tempConfig = VUHDO_PANEL_SETUP[tempPanelNum]["TOOLTIP"];
	VuhDoFormButtonSize:Hide();
	local tempPanelName = aPanel:GetName();
	getglobal(tempPanelName .. "EnableCheckButton"):SetChecked(tempConfig.show);
	getglobal(tempPanelName .. "InFightCheckButton"):SetChecked(tempConfig.inFight);

	local tempScale = tempConfig["SCALE"];
	getglobal(tempPanelName .. "ColorPanelScaleSliderSlider"):SetValue(tempScale);

	VUHDO_setAllPositionButtons(tempPanelName);
	VUHDO_demoTooltip(tempPanelNum);
end



--
function VUHDO_tooltipConfigOnMouseDown(aPanel)
	aPanel:StartMoving();
end



--
function VUHDO_tooltipConfigOnMouseUp(aPanel)
	aPanel:StopMovingOrSizing();
end



--
function VUHDO_ToolTipConfigEnableCheckButtonOnClick(aCheckButton)
	VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["TOOLTIP"].show = aCheckButton:GetChecked();
	VuhDoTooltip:Hide();
	VUHDO_demoTooltip(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_ToolTipConfigInFightCheckButtonOnClick(aCheckButton)
	VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["TOOLTIP"].inFight = aCheckButton:GetChecked()
end



--
function VuhDoTooltipOnMouseDown(aTooltip)
	if (VUHDO_IS_PANEL_CONFIG and VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["TOOLTIP"].position == VUHDO_TOOLTIP_POS_FIX) then
		VUHDO_REFRESH_TOOLTIP_TIMER = 0;
		aTooltip:StartMoving();
	end
end



--
function VuhDoTooltipOnMouseUp(aTooltip)
	aTooltip:StopMovingOrSizing();

	local tempSetup;
	local tempConfig;
	local tempX, tempY, tempRelative, tempOrientation;

	tempPosition = VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["TOOLTIP"];
	tempOrientation, _, tempRelative, tempX, tempY = aTooltip:GetPoint(0);

	tempPosition.x = VUHDO_roundCoords(tempX);
	tempPosition.y = VUHDO_roundCoords(tempY);
	tempPosition.point = tempOrientation;
	tempPosition.relativePoint = tempRelative;

	VUHDO_REFRESH_TOOLTIP_TIMER = VUHDO_REFRESH_TOOLTIP_DELAY;
end



--
function VUHDO_tooltipConfigColorpickerCallback(arg1, arg2, arg3)
	if (VUHDO_CURRENT_COLOR_NAME == nil) then
		return;
	end

	if (arg3 == nil) then
		local tempColor = VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["TOOLTIP"][VUHDO_CURRENT_COLOR_NAME];
	  tempColor.R, tempColor.G, tempColor.B = ColorPickerFrame:GetColorRGB();
  	tempColor.O = 1 - OpacitySliderFrame:GetValue();
  	tempColor.R = VUHDO_roundColor(tempColor.R);
  	tempColor.G = VUHDO_roundColor(tempColor.G);
  	tempColor.B = VUHDO_roundColor(tempColor.B);
  	tempColor.O = VUHDO_roundColor(tempColor.O);

		VuhDoTooltipConfig:Hide();
		VuhDoTooltipConfig:Show();
  	VUHDO_redrawAllPanels();
	end
end



--
function VUHDO_tooltipConfigColorTextureOnClick(aTexture, aMouseButton)
	local tempPanel = aTexture:GetParent():GetParent();
	local tempName = tempPanel:GetName();
	local tempColor;

	local tempConfig = VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["TOOLTIP"];
	if (strfind(aTexture:GetName(), "BackColor")) then
		VUHDO_CURRENT_COLOR_NAME = "BACKGROUND";
		tempColor = tempConfig["BACKGROUND"];
	elseif (strfind(aTexture:GetName(), "BorderColor")) then
		VUHDO_CURRENT_COLOR_NAME = "BORDER";
		tempColor = tempConfig["BORDER"];
	end

	--VUHDO_CURRENT_COLOR_NAME = tempColor;

  ColorPickerFrame:ClearAllPoints();
  ColorPickerFrame:SetPoint("TOPLEFT", tempPanel:GetName(), "TOPRIGHT", 0, 0);
  ColorPickerFrame.func = function() VUHDO_tooltipConfigColorpickerCallback(arg1, arg2, arg3); end;
  ColorPickerFrame.hasOpacity = true;

  ColorPickerFrame:SetColorRGB(tempColor.R, tempColor.G, tempColor.B);
	ColorPickerFrame.opacity = 1 - tempColor.O;
  OpacitySliderFrame:SetValue(1 - tempColor.O);

	ColorPickerFrame:Show();
end



--
function VUHDO_tooltipConfigColorTextureOnShow(aTexture)
	local tempName = aTexture:GetName();
	local tempTexture = getglobal(aTexture:GetName() .. "Texture");
	local tempConfig = VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["TOOLTIP"];
	local tempColor;

	if (strfind(tempName, "BackColor")) then
		tempColor = tempConfig["BACKGROUND"];
		getglobal(aTexture:GetName() .. "NameLabelLabel"):SetText(VUHDO_I18N_BACKGROUND);
	elseif (strfind(tempName, "BorderColor")) then
		tempColor = tempConfig["BORDER"];
		getglobal(aTexture:GetName() .. "NameLabelLabel"):SetText(VUHDO_I18N_BORDER);
	end

	tempTexture:SetVertexColor(tempColor.R, tempColor.G, tempColor.B, tempColor.O);
end




--
function VUHDO_tooltipScaleSliderOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

  local tempValue = tonumber(aSliderKnob:GetValue());
	VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["TOOLTIP"]["SCALE"] = tempValue;
	VuhDoTooltip:SetScale(tempValue);
	VUHDO_initTooltip();
end