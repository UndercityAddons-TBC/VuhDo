local VUHDO_CURRENT_COLOR = nil;
local VUHDO_CURRENT_IS_TEXT = nil;



--
function VuhDoButtonSizeOnMouseDown(aPanel)
	aPanel:StartMoving();
end



--
function VuhDoButtonSizeOnMouseUp(aPanel)
	aPanel:StopMovingOrSizing();
end


--
function VUHDO_formButtonSizeShowManaOnClick(aButton)
	VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].showManaBars = not VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].showManaBars;
	aButton:SetChecked(VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].showManaBars);
	VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_formButtonSizeClassColorsOnClick(aCheckButton)
	VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["PANEL_COLOR"].classColorsName = aCheckButton:GetChecked();
	VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_formButtonSizeHeaderClassColorsOnClick(aCheckButton)
	VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["PANEL_COLOR"].classColorsHeader = aCheckButton:GetChecked();
	VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_buttonSizeManaHeightOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_buttonSizeManaHeightOnMouseUp(aSliderKnob);
end



--
function VUHDO_buttonSizeManaHeightOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].manaBarHeight = VUHDO_roundCoords(tempValue);
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_buttonSizeHGapOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_buttonSizeHGapOnMouseUp(aSliderKnob);
end



--
function VUHDO_buttonSizeHGapOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].borderGapX = VUHDO_roundCoords(tempValue);
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_buttonSizeVGapOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_buttonSizeVGapOnMouseUp(aSliderKnob);
end



--
function VUHDO_buttonSizeVGapOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].borderGapY = VUHDO_roundCoords(tempValue);
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_buttonSizeHSpacingOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_buttonSizeHSpacingOnMouseUp(aSliderKnob);
end



--
function VUHDO_buttonSizeHSpacingOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].columnSpacing = VUHDO_roundCoords(tempValue);
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_buttonSizeVSpacingOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end
	VUHDO_buttonSizeVSpacingOnMouseUp(aSliderKnob)
end



--
function VUHDO_buttonSizeVSpacingOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].rowSpacing = VUHDO_roundCoords(tempValue);
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_buttonSizeButtonHeightOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_buttonSizeButtonHeightOnMouseUp(aSliderKnob);
end



--
function VUHDO_buttonSizeButtonHeightOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].barHeight = VUHDO_roundCoords(tempValue);
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_buttonSizeButtonWidthOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_buttonSizeButtonWidthOnMouseUp(aSliderKnob);
end



--
function VUHDO_buttonSizeButtonWidthOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].barWidth = VUHDO_roundCoords(tempValue);
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_getFormButtonSizeTextureText(aTexture)
	local tempTextureName = aTexture:GetName();
	local tempTexture = getglobal(aTexture:GetName() .. "Texture");
	local tempLabelLabel = getglobal(aTexture:GetName() .. "NameLabelLabel");
	local tempColors = VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["PANEL_COLOR"];

	local tempText;
	local tempColor;

	if (strfind(tempTextureName, "BorderColor")) then
		tempColor = tempColors["BORDER"];
		tempText = VUHDO_I18N_BORDER;
	elseif (strfind(tempTextureName, "TextColor")) then
		--tempTexture:SetVertexColor(0, 1, 0, 1);
		tempColor = tempColors["TEXT"];
		tempText = VUHDO_I18N_BARS_BG;
	elseif (strfind(tempTextureName, "BackgroundColor")) then
		tempColor = tempColors["BACK"];
		tempText = VUHDO_I18N_BACKGROUND;
	elseif (strfind(tempTextureName, "HeaderColor")) then
		tempColor = tempColors["HEADER"];
		tempText = VUHDO_I18N_HEADERS;
	end

	return tempText, tempColor;
end



--
function VUHDO_colorTextureSizeOnShow(aTexture)
	local tempTexture = getglobal(aTexture:GetName() .. "Texture");
	local tempText;
	local tempColor;

	local tempTextureName = aTexture:GetName();

	if (strfind(tempTextureName, "Header") == nil) then
		tempTexture:SetTexture(VUHDO_TEXTURE_SPEC .. VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["PANEL_COLOR"].barTexture);
	else
		tempTexture:SetTexture(VUHDO_TEXTURE_SPEC .. VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["PANEL_COLOR"]["HEADER"].barTexture);
	end

	tempLabel = getglobal(aTexture:GetName() .. "NameLabel");
	tempLabel:SetWidth(aTexture:GetWidth());
	tempLabel:SetHeight(aTexture:GetHeight());

	local tempLabelLabel = getglobal(aTexture:GetName() .. "NameLabelLabel");

	tempText, tempColor = VUHDO_getFormButtonSizeTextureText(aTexture);
	tempLabelLabel:SetText(tempText);

	if (tempColor ~= nil) then
		if (tempColor.R ~= nil) then
			tempTexture:SetVertexColor(tempColor.R, tempColor.G, tempColor.B, tempColor.O);
		end

		if (tempColor.TR ~= nil) then
			tempLabelLabel:SetTextColor(tempColor.TR, tempColor.TG, tempColor.TB, tempColor.TO);
		end
	end
end



--
function VUHDO_panelSizeOnSelectionChanged(anEntry)
	VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["PANEL_COLOR"].barTexture = anEntry.value;
	VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
	anEntry.owner:GetParent():Hide();
	anEntry.owner:GetParent():Show();
end



--
function VUHDO_formButtonSizeOnShow(aPanel)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VuhDoTooltipConfig:Hide();

	local tempScaling = VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"];
	local tempColor = VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["PANEL_COLOR"];
	local tempPanelName = aPanel:GetName();
	local tempSubPanelName;
	local tempSliderName;
	local tempComboName;

	-- Titel
	getglobal(tempPanelName .. "TitleString"):SetText("Config Panel #" .. DESIGN_MISC_PANEL_NUM);

	-- Header Panel
	tempSubPanelName = tempPanelName .. "HeaderPanel";
	getglobal(tempSubPanelName .. "HeaderCheckButton"):SetChecked(tempScaling.showHeaders);

	getglobal(tempSubPanelName .. "HeaderClassColorsCheckButton"):SetChecked(tempColor.classColorsHeader);

	tempSliderName = tempSubPanelName .. "HeaderWidthSizeSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempScaling.headerWidth);

	tempSliderName = tempSubPanelName .. "HeaderFontSizeSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempColor["HEADER"].textSize);

	tempSliderName = tempSubPanelName .. "HeaderTextureSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tonumber(tempColor["HEADER"].barTexture));

	tempSliderName = tempSubPanelName .. "HeaderHeightSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempScaling.headerHeight);

	tempSliderName = tempSubPanelName .. "HeaderSpacingSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempScaling.headerSpacing);

	-- General-Fenster
	tempSubPanelName = tempPanelName .. "BarsPanel";

	tempSliderName = tempSubPanelName .. "FontSizeSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempColor["TEXT"].textSize);

	getglobal(tempSubPanelName .. "ClassColorsBarCheckButton"):SetChecked(tempColor.classColorsName);

	-- Texture-Combo
	tempComboName = tempPanelName .. "ButtonTextureComboBox";
	UIDropDownMenu_SetSelectedValue(getglobal(tempComboName), tonumber(tempColor.barTexture));
	getglobal(tempComboName .. "Text"):SetText(VUHDO_TEXTURE_NAMES[tonumber(tempColor.barTexture)]);

	-- Slider
	tempSliderName = tempPanelName .. "ButtonHeightSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempScaling.barHeight);

	tempSliderName = tempPanelName .. "ButtonVGapSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempScaling.borderGapY);

	tempSliderName = tempPanelName .. "ButtonVSpacingSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempScaling.rowSpacing);


	tempSliderName = tempPanelName .. "ButtonWidthSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempScaling.barWidth);

	tempSliderName = tempPanelName .. "ButtonHGapSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempScaling.borderGapX);

	tempSliderName = tempPanelName .. "ButtonHSpacingSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempScaling.columnSpacing);

	getglobal(tempPanelName .. "TargetsCheckButton"):SetChecked(tempScaling.showTarget);

	tempSliderName = tempPanelName .. "TargetWidthSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempScaling.targetWidth);

	tempSliderName = tempPanelName .. "TargetSpacingSlider";
	getglobal(tempSliderName .. "Slider"):SetValue(tempScaling.targetSpacing);


	-- Mana-Fenster
	local tempSubPanelName = tempPanelName .. "ManaBarPanel";
	getglobal(tempSubPanelName .. "ManaBarCheckButton"):SetChecked(tempScaling.showManaBars);
	getglobal(tempSubPanelName .. "ManaBarHeightSliderSlider"):SetValue(tempScaling.manaBarHeight);
end



--
function VUHDO_formButtonSizeShowHeadersOnClick(aCheckButton)
	VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].showHeaders = aCheckButton:GetChecked();
	VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_formButtonSizeOkayOnClick(aPanel)
	DESIGN_MISC_PANEL_NUM = nil;
	aPanel:Hide();
	VUHDO_redrawAllPanels();
end



--
function VUHDO_buttonSizeColorpickerCallback(arg1, arg2, arg3)
	if (VUHDO_CURRENT_COLOR == nil) then
		return;
	end

	if (arg3 == nil) then
		if (VUHDO_CURRENT_IS_TEXT) then
	  	VUHDO_CURRENT_COLOR.TR, VUHDO_CURRENT_COLOR.TG, VUHDO_CURRENT_COLOR.TB = ColorPickerFrame:GetColorRGB();
  		VUHDO_CURRENT_COLOR.TO = 1 - OpacitySliderFrame:GetValue();
  		VUHDO_CURRENT_COLOR.TR = VUHDO_roundColor(VUHDO_CURRENT_COLOR.TR);
  		VUHDO_CURRENT_COLOR.TG = VUHDO_roundColor(VUHDO_CURRENT_COLOR.TG);
  		VUHDO_CURRENT_COLOR.TB = VUHDO_roundColor(VUHDO_CURRENT_COLOR.TB);
  		VUHDO_CURRENT_COLOR.TO = VUHDO_roundColor(VUHDO_CURRENT_COLOR.TO);

		else
	  	VUHDO_CURRENT_COLOR.R, VUHDO_CURRENT_COLOR.G, VUHDO_CURRENT_COLOR.B = ColorPickerFrame:GetColorRGB();
  		VUHDO_CURRENT_COLOR.O = 1 - OpacitySliderFrame:GetValue();
  		VUHDO_CURRENT_COLOR.R = VUHDO_roundColor(VUHDO_CURRENT_COLOR.R);
  		VUHDO_CURRENT_COLOR.G = VUHDO_roundColor(VUHDO_CURRENT_COLOR.G);
  		VUHDO_CURRENT_COLOR.B = VUHDO_roundColor(VUHDO_CURRENT_COLOR.B);
  		VUHDO_CURRENT_COLOR.O = VUHDO_roundColor(VUHDO_CURRENT_COLOR.O);
		end

	  getglobal("VuhDoFormButtonSize"):Hide();
	  getglobal("VuhDoFormButtonSize"):Show();
	  VUHDO_redrawAllPanels();
  end


end



--       VUHDO_colorTextureSizeOnClick
function VUHDO_colorTextureSizeOnClick(aTexture, aMouseButton)
	local _, tempColor = VUHDO_getFormButtonSizeTextureText(aTexture);
	local tempR, tempG, tempB, tempO;

	if ("LeftButton" == aMouseButton and tempColor.R == nil) then
		aMouseButton = "RightButton";
	elseif ("RightButton" == aMouseButton and tempColor.TR == nil) then
		aMouseButton = "LeftButton";
	end

	VUHDO_CURRENT_COLOR = tempColor;

	if ("LeftButton" == aMouseButton) then
		VUHDO_CURRENT_IS_TEXT = false;
		tempR = tempColor.R;
		tempG = tempColor.G;
		tempB = tempColor.B;
		tempO = tempColor.O;
	elseif ("RightButton" == aMouseButton) then
		VUHDO_CURRENT_IS_TEXT = true;
		tempR = tempColor.TR;
		tempG = tempColor.TG;
		tempB = tempColor.TB;
		tempO = tempColor.TO;
	else
		return;
	end


	--VUHDO_Msg("Col: " .. tempR .. "/" .. tempG .. "/" .. tempB .. "/" .. tempO)	;

	local tempPanel = VUHDO_getMainPanel(aTexture);

 	ColorPickerFrame:ClearAllPoints();
 	ColorPickerFrame:SetPoint("TOPLEFT", tempPanel:GetName(), "TOPRIGHT", 0, 0);
 	ColorPickerFrame.func = function() VUHDO_buttonSizeColorpickerCallback(arg1, arg2, arg3); end;
 	ColorPickerFrame.hasOpacity = true;
 	ColorPickerFrame:SetColorRGB(tempR, tempG, tempB);
	ColorPickerFrame.opacity = 1 - tempO;
 	OpacitySliderFrame:SetValue(1 - tempO);
	ColorPickerFrame:Show();
end



--
function VUHDO_buttonSizeHeaderWidthOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_buttonSizeHeaderWidthOnMouseUp(aSliderKnob);
end



--
function VUHDO_buttonSizeHeaderWidthOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].headerWidth = tempValue;
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_buttonSizeHeaderFontSizeOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_buttonSizeHeaderFontSizeOnMouseUp(aSliderKnob);
end



--
function VUHDO_buttonSizeHeaderFontSizeOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["PANEL_COLOR"]["HEADER"].textSize = tempValue;
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_buttonSizeFontSizeOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_buttonSizeFontSizeOnMouseUp(aSliderKnob);
end



--
function VUHDO_buttonSizeFontSizeOnMouseUp(aSliderKnob)
	local tempValue = tonumber(aSliderKnob:GetValue());
	VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["PANEL_COLOR"]["TEXT"].textSize = tempValue;
	VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_buttonSizeHeaderTextureOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_buttonSizeHeaderTextureOnMouseUp(aSliderKnob);
end



--
function VUHDO_buttonSizeHeaderTextureOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["PANEL_COLOR"]["HEADER"].barTexture = tempValue;
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_buttonSizeHeaderHeightOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_buttonSizeHeaderHeightOnMouseUp(aSliderKnob);
end



--
function VUHDO_buttonSizeHeaderHeightOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].headerHeight = tempValue;
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_buttonSizeHeaderSpacingOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_buttonSizeHeaderSpacingOnMouseUp(aSliderKnob);
end



--
function VUHDO_buttonSizeHeaderSpacingOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].headerSpacing = tempValue;
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_formButtonSizeApplyAllOnClick()
	VuhDoYesNoFrameText:SetText("Overwrite all settings\nin current PROFILE?");
	VuhDoYesNoFrame:SetAttribute("callback", VUHDO_yesNoDecidedApplySizeAll);
	VuhDoYesNoFrame:Show();
end



--
function VUHDO_yesNoDecidedApplySizeAll(aDecision)
	if (VUHDO_YES == aDecision) then
		local tempCnt;
		for tempCnt = 1, VUHDO_MAX_PANELS do
			if (DESIGN_MISC_PANEL_NUM ~= tempCnt) then
				VUHDO_PANEL_SETUP[tempCnt]["SCALING"] = VUHDO_deepCopyTable(VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"]);
				VUHDO_PANEL_SETUP[tempCnt]["PANEL_COLOR"] = VUHDO_deepCopyTable(VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["PANEL_COLOR"]);
			end
		end

		VUHDO_redrawAllPanels();
	end
end



--
function VUHDO_TargetWidthSliderOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_TargetWidthSliderOnMouseUp(aSliderKnob);
end



--
function VUHDO_TargetWidthSliderOnMouseUp(aSliderKnob)
	local tempValue = tonumber(aSliderKnob:GetValue());
	VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].targetWidth = tempValue;
	VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_TargetSpacingSliderOnValueChanged(aSliderKnob)
	if (DESIGN_MISC_PANEL_NUM == nil) then
		return;
	end

	VUHDO_TargetSpacingSliderOnMouseUp(aSliderKnob);
end



--
function VUHDO_TargetSpacingSliderOnMouseUp(aSliderKnob)
	  local tempValue = tonumber(aSliderKnob:GetValue());
	  VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].targetSpacing = tempValue;
	  VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end



--
function VUHDO_formButtonSizeShowTargetsOnClick(aCheckButton)
	VUHDO_PANEL_SETUP[DESIGN_MISC_PANEL_NUM]["SCALING"].showTarget = aCheckButton:GetChecked();
	VUHDO_redrawPanel(DESIGN_MISC_PANEL_NUM);
end
