local VUHDO_CURRENT_COLOR_NAME = nil;
local VUHDO_CURRENT_IS_TEXT = nil;



function VUHDO_getColorForTexture(aTexture)
	local tempTextureName = aTexture:GetName();
	local tempColor;

	if (strfind(tempTextureName, "Magic")) then
		tempColor = "DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC;
	elseif (strfind(tempTextureName, "Curse")) then
		tempColor = "DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE;
	elseif (strfind(tempTextureName, "Desease")) then
		tempColor = "DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE;
	elseif (strfind(tempTextureName, "Poison")) then
		tempColor = "DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON;
	elseif (strfind(tempTextureName, "Offline")) then
		tempColor = "OFFLINE";
	elseif (strfind(tempTextureName, "Dead")) then
		tempColor = "DEAD";
	elseif (strfind(tempTextureName, "NoEmergency")) then
		tempColor = "NO_EMERGENCY";
	elseif (strfind(tempTextureName, "Emergency")) then
		tempColor = "EMERGENCY";
	elseif (strfind(tempTextureName, "Range")) then
		tempColor = "OUTRANGED";
	elseif (strfind(tempTextureName, "Irrelevant")) then
		tempColor = "IRRELEVANT";
	elseif (strfind(tempTextureName, "Incoming")) then
		tempColor = "INCOMING";
	elseif (strfind(tempTextureName, "Charmed")) then
		tempColor = "CHARMED";
	elseif (strfind(tempTextureName, "Aggro")) then
		tempColor = "AGGRO";
	end

	return tempColor;
end




--
function VUHDO_optionsBarColorOnShow(aPanel)
	local tempPanelName = aPanel:GetName();
	-- Debuffs
	local tempSubPanelName = tempPanelName .. "DebuffsPanel";
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "MagicTexture", "DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC);
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "CurseTexture", "DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE);
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "DeseaseTexture", "DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE);
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "PoisonTexture", "DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON);

	getglobal(tempSubPanelName .. "DiseaseTextColorCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].useText);
	getglobal(tempSubPanelName .. "DiseaseBackgroundCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].useBackground);
	getglobal(tempSubPanelName .. "PoisonTextColorCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].useText);
	getglobal(tempSubPanelName .. "PoisonBackgroundCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].useBackground);
	getglobal(tempSubPanelName .. "MagicTextColorCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].useText);
	getglobal(tempSubPanelName .. "MagicBackgroundCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].useBackground);
	getglobal(tempSubPanelName .. "CurseTextColorCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].useText);
	getglobal(tempSubPanelName .. "CurseBackgroundCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].useBackground);

	tempSubPanelName = tempPanelName .. "AnomaliesPanel";
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "OfflineTexture", "OFFLINE");
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "DeadTexture", "DEAD");
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "CharmedTexture", "CHARMED");
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "AggroTexture", "AGGRO");

	tempSubPanelName = tempPanelName .. "EmergencyModePanel";
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "NoEmergencyTexture", "NO_EMERGENCY");
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "EmergencyTexture", "EMERGENCY");

	-- Neutral Mode
	tempSubPanelName = tempPanelName .. "NeutralModePanel";
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "RangeTexture", "OUTRANGED");
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "IrrelevantTexture", "IRRELEVANT");
	VUHDO_setBarColorTextureColor(tempSubPanelName .. "IncomingTexture", "INCOMING");

	getglobal(tempSubPanelName .. "IncomingBackColorCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].useBackground);
	getglobal(tempSubPanelName .. "IncomingOpacityCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].useOpacity);
	getglobal(tempSubPanelName .. "IncomingTextColorCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].useText);
	getglobal(tempSubPanelName .. "IrrelevantBackColorCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].useBackground);
	getglobal(tempSubPanelName .. "IrrelevantOpacityCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].useOpacity);
	getglobal(tempSubPanelName .. "IrrelevantTextColorCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].useText);
	getglobal(tempSubPanelName .. "OutRangeBackColorCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].useBackground);
	getglobal(tempSubPanelName .. "OutRangeOpacityCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].useOpacity);
	getglobal(tempSubPanelName .. "OutRangeTextColorCheckButton"):SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].useText);

  VUHDO_GLOBAL[tempSubPanelName .. "VividCheckButton"]:SetChecked(VUHDO_PANEL_SETUP["BAR_COLORS"].neutralFalloff == VUHDO_GUI_BAR_COLOR_FALLOFF_VIVID);
end



--
function VUHDO_buttonColorColorpickerCallback(arg1, arg2, arg3)
	if (VUHDO_CURRENT_COLOR_NAME == nil) then
		return;
	end

	if (arg3 == nil) then
		local tempColor = VUHDO_PANEL_SETUP["BAR_COLORS"][VUHDO_CURRENT_COLOR_NAME];

		if (VUHDO_CURRENT_IS_TEXT) then
	  	tempColor.TR, tempColor.TG, tempColor.TB = ColorPickerFrame:GetColorRGB();
  		tempColor.TO = 1 - OpacitySliderFrame:GetValue();
  		tempColor.TR = VUHDO_roundColor(tempColor.TR);
  		tempColor.TG = VUHDO_roundColor(tempColor.TG);
  		tempColor.TB = VUHDO_roundColor(tempColor.TB);
  		tempColor.TO = VUHDO_roundColor(tempColor.TO);
		else
	  	tempColor.R, tempColor.G, tempColor.B = ColorPickerFrame:GetColorRGB();
  		tempColor.O = 1 - OpacitySliderFrame:GetValue();
  		tempColor.R = VUHDO_roundColor(tempColor.R);
  		tempColor.G = VUHDO_roundColor(tempColor.G);
  		tempColor.B = VUHDO_roundColor(tempColor.B);
  		tempColor.O = VUHDO_roundColor(tempColor.O);
		end

	  VUHDO_optionsBarColorOnShow(getglobal("VuhDoFormButtonColor"));
	  VUHDO_redrawAllPanels();

  end
end



--
function VUHDO_colorTextureOnClick(aTexture, aMouseButton)
	local tempIsText;
	local tempColorName;

	if ("LeftButton" == aMouseButton) then
		tempIsText = false;
	elseif("RightButton" == aMouseButton) then
		tempIsText = true;
	else
		return;
	end

	local tempColorName = VUHDO_getColorForTexture(aTexture);
	local tempColor = VUHDO_PANEL_SETUP["BAR_COLORS"][tempColorName];
	VUHDO_CURRENT_COLOR_NAME = tempColorName;
	VUHDO_CURRENT_IS_TEXT = tempIsText;

	local tempPanel = aTexture:GetParent():GetParent();

  ColorPickerFrame:ClearAllPoints();
  ColorPickerFrame:SetPoint("TOPLEFT", tempPanel:GetName(), "TOPRIGHT", 0, 0);
  ColorPickerFrame.func = function() VUHDO_buttonColorColorpickerCallback(arg1, arg2, arg3); end;
  ColorPickerFrame.hasOpacity = true;

  if (tempIsText and tempColor.TR ~= nil) then
  	ColorPickerFrame:SetColorRGB(tempColor.TR, tempColor.TG, tempColor.TB);
		ColorPickerFrame.opacity = 1 - tempColor.TO;
  	OpacitySliderFrame:SetValue(1 - tempColor.TO);
	else
  	ColorPickerFrame:SetColorRGB(tempColor.R, tempColor.G, tempColor.B);
		ColorPickerFrame.opacity = 1 - tempColor.O;
  	OpacitySliderFrame:SetValue(1 - tempColor.O);
	end

	ColorPickerFrame:Show();
end



--
function VUHDO_formButtonColorOkayOnClick()
	VuhDoFormButtonColor:Hide();
	ColorPickerFrame:Hide();
end



--
--
function VuhDoButtonColorOnMouseDown(aPanel)
	aPanel:StartMoving();
end



--
function VuhDoButtonColorOnMouseUp(aPanel)
	aPanel:StopMovingOrSizing();
end



--
function VUHDO_formButtonColorDiseaseBackgroundColorOnClick(aCheckButton)
  VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].useBackground = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorDiseaseTextColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].useText = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorMagicBackgroundColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].useBackground = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorMagicTextColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].useText = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorCurseBackgroundColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].useBackground = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorCurseTextColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].useText = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorPoisonBackgroundColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].useBackground = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorPoisonTextColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].useText = aCheckButton:GetChecked();
	VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end





--
function VUHDO_formButtonColorIncomingTextColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].useText = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorIncomingBackColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].useBackground = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorIncomingOpacityOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].useOpacity = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorIrrelevantTextColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].useText = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorIrrelevantBackColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].useBackground = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorIrrelevantOpacityOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].useOpacity = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorOutRangeTextColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].useText = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorOutRangeBackColorOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].useBackground = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorOutRangeOpacityOnClick(aCheckButton)
	VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].useOpacity = aCheckButton:GetChecked();
  VUHDO_optionsBarColorOnShow(VUHDO_getMainPanel(aCheckButton));
end



--
function VUHDO_formButtonColorVividOnClick(aCheckButton)
	if (aCheckButton:GetChecked()) then
		VUHDO_PANEL_SETUP["BAR_COLORS"].neutralFalloff = VUHDO_GUI_BAR_COLOR_FALLOFF_VIVID;
	else
		VUHDO_PANEL_SETUP["BAR_COLORS"].neutralFalloff = VUHDO_GUI_BAR_COLOR_FALLOFF_CALM;
	end
end
