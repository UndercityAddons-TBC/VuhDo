


function VUHDO_mayMoveHealPanels()
  if (VUHDO_IS_PANEL_CONFIG) then
  	return true;
  end

  return not VUHDO_CONFIG["LOCK_PANELS"];
end



--
function VUHDO_isTableHeadersShowing(aPanelNum)
	if (VUHDO_isLooseOrderingShowing(aPanelNum)) then
		return false;
	end

  return VUHDO_PANEL_SETUP[aPanelNum]["SCALING"].showHeaders;
end



--
function VUHDO_isConfigPanelShowing()
	return VUHDO_IS_PANEL_CONFIG and not VUHDO_CONFIG_SHOW_RAID;
end



--
function VUHDO_getComponentPanelNum(aComponent)
	local tempNumbers = VUHDO_getNumbersFromString(aComponent:GetName(), 1);
	return tonumber(tempNumbers[1]);
end



--
function VUHDO_getComponentPanelNumModelNum(aComponent)
	local tempNumbers = VUHDO_getNumbersFromString(aComponent:GetName(), 2);
	return tonumber(tempNumbers[1]), tonumber(tempNumbers[2]);
end



--
function VUHDO_roundCoords(aCoord)
	return floor(aCoord * 10 + 0.5) / 10;
end



--
function VUHDO_roundColor(aColor)
	return floor(aColor * 1000 + 0.5) / 1000;
end



--
function VUHDO_getUiParent()
	return UIParent;
end



--
function VUHDO_getMainPanel(aComponent)
	while (aComponent:GetParent():GetName() ~= "UIParent") do
		aComponent = aComponent:GetParent();
	end

	return aComponent;
end



--
function VUHDO_getVirtualScreenRes()
	local tempUi = VUHDO_getUiParent();
	return floor(tempUi:GetWidth() + 0.5), floor(tempUi:GetHeight() + 0.5);
end



--
function VUHDO_getAnchorCoords(aPanel, anOrientation)
	local tempX, tempY;

	if (anOrientation == "TOPRIGHT") then
		tempX = aPanel:GetRight();
		tempY = aPanel:GetTop();
	elseif (anOrientation == "BOTTOMLEFT") then
		tempX = aPanel:GetLeft();
		tempY = aPanel:GetBottom();
	elseif (anOrientation == "BOTTOMRIGHT") then
		tempX = aPanel:GetRight();
		tempY = aPanel:GetBottom();
	else -- TOPLEFT
		tempX = aPanel:GetLeft();
		tempY = aPanel:GetTop();
	end

	return VUHDO_roundCoords(tempX), VUHDO_roundCoords(tempY);
end



--
function VUHDO_createComboBoxInfo(aComboBox, aText, aValue, aCheckedValue)
	local tempInfo = {};

	tempInfo.text = aText;
	tempInfo.value = aValue;
	tempInfo.func = nil;
	tempInfo.owner = aComboBox;
	if (aValue == aCheckedValue) then
		tempInfo.checked = true;
	else
		tempInfo.checked = nil;
	end
	tempInfo.icon = nil;

	return tempInfo;
end



--
function VUHDO_isLooseOrderingShowing(aPanelNum)
	if (VUHDO_PANEL_SETUP[aPanelNum]["MODEL"].ordering == VUHDO_ORDERING_STRICT) then
		return false;
	end

	if (VUHDO_IS_PANEL_CONFIG and not VUHDO_CONFIG_SHOW_RAID) then
  	return false;
  end

	return true;
end



---
function VUHDO_toggleMenu(aPanel)
	if (aPanel:IsShown()) then
		aPanel:Hide();
	else
		aPanel:Show();
	end
end



--
function VUHDO_getPanelNum(aPanel)
	local tempPanelName = aPanel:GetName();

	if (tonumber(string.sub(tempPanelName, -2, -1)) ~= nil) then
		return tonumber(string.sub(tempPanelName, -2));
	elseif (tonumber(string.sub(tempPanelName, -1)) ~= nil) then
		return tonumber(string.sub(tempPanelName, -1));
	else
		return 1;
	end
end



--
function VUHDO_getClassColor(anInfo)
	return VUHDO_CLASS_COLORS[VUHDO_CLASS_IDS[anInfo.class]];
end


--
function VUHDO_getClassColorByModelId(aModelId)
	return VUHDO_CLASS_COLORS[aModelId];
end


--
function VUHDO_getModeName(aMode)
	if (VUHDO_MODE_NEUTRAL == aMode) then
		return "Neutral / Healbot";
	elseif (VUHDO_MODE_EMERGENCY_PERC == aMode) then
		return "Emergency HP %";
	elseif (VUHDO_MODE_EMERGENCY_MOST_MISSING == aMode) then
		return "Emerg. HP most missing";
	else --VUHDO_MODE_EMERGENCY_LEAST_LEFT
		return "Emerg. HP least left";
	end
end



--
function VUHDO_enableLabel(aLabel, anIsEnabled)
	if (anIsEnabled) then
		aLabel:SetTextColor(1, 0.82, 0, 1);
	else
	  aLabel:SetTextColor(0.2, 0.15, 0, 1);
	end
end



--
function VUHDO_enableCheckButton(aCheckButton, anIsEnabled)
	if (anIsEnabled) then
		aCheckButton:Enable();
	else
		aCheckButton:Disable();
	end

	VUHDO_enableLabel(getglobal(aCheckButton:GetName() .. "Text"), anIsEnabled);
end



--
function VUHDO_getColorDefName(aColorDef)
	local tempColor;

	if ("DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC == aColorDef) then
		tempColor = VUHDO_I18N_DEBUFF3;
	elseif ("DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE == aColorDef) then
		tempColor = VUHDO_I18N_DEBUFF4;
	elseif ( "DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE == aColorDef) then
		tempColor = VUHDO_I18N_DEBUFF2;
	elseif ("DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON == aColorDef) then
		tempColor = VUHDO_I18N_DEBUFF1;
	elseif ("OFFLINE" == aColorDef) then
		tempColor = VUHDO_I18N_OFFLINE;
	elseif ("DEAD" == aColorDef) then
		tempColor = VUHDO_I18N_DEAD;
	elseif ("NO_EMERGENCY" == aColorDef) then
		tempColor = VUHDO_I18N_NO_EMERGENCY;
	elseif ("EMERGENCY" == aColorDef) then
		tempColor = VUHDO_I18N_EMERGENCY;
	elseif ("OUTRANGED" == aColorDef) then
		tempColor = VUHDO_I18N_OUTRANGED;
	elseif ("IRRELEVANT" == aColorDef) then
		tempColor = VUHDO_I18N_IRRELEVANT;
	elseif ("INCOMING" == aColorDef) then
		tempColor = VUHDO_I18N_INCOMING;
	elseif ("CHARMED" == aColorDef) then
		tempColor = VUHDO_I18N_CHARMED;
	elseif ("AGGRO" == aColorDef) then
		tempColor = VUHDO_I18N_AGGRO;
	end

	return tempColor;
end



--
function VUHDO_setBarColorTextureColor(aTextureName, aColorDef)
	local tempTexture = getglobal(aTextureName .. "Texture");
	local tempBaseColor = VUHDO_copyColor(VUHDO_STANDARD_TEXTURE_COLOR);
	local tempColor = VUHDO_PANEL_SETUP["BAR_COLORS"][aColorDef];

	tempColor = VUHDO_getDiffColor(tempBaseColor, tempColor);
	tempTexture:SetVertexColor(tempColor.R, tempColor.G, tempColor.B, tempColor.O);

	local tempLabel = getglobal(aTextureName .. "NameLabelLabel");
	tempLabel:SetText(VUHDO_getColorDefName(aColorDef));
	tempLabel:SetTextColor(tempColor.TR, tempColor.TG, tempColor.TB, tempColor.TO);
end



--
function VUHDO_getManaBarHeight(aPanelNum)
	if (VUHDO_PANEL_SETUP[aPanelNum]["SCALING"].showManaBars) then
		return VUHDO_PANEL_SETUP[aPanelNum]["SCALING"].manaBarHeight;
	else
		return 0;
	end
end



--
function VUHDO_getHealthBarHeight(aPanelNum)
	return VUHDO_PANEL_SETUP[aPanelNum]["SCALING"].barHeight -  VUHDO_getManaBarHeight(aPanelNum);
end



--
function VUHDO_setTextColorSize(aFontInstance, aColorInfo, aTextSize)
	aFontInstance:SetTextColor(aColorInfo.TR, aColorInfo.TG, aColorInfo.TB, aColorInfo.TO);

	local tempFontHeight;
	_, tempFontHeight, _ = aFontInstance:GetFont();


	aTextSize = tonumber(aTextSize);
	if (aTextSize ~= nil and floor(tempFontHeight + 0.5) ~= aTextSize) then
		aFontInstance:SetFont(GameFontNormal:GetFont(), aTextSize);
		aFontInstance:SetShadowColor(0, 0, 0, 1);
		aFontInstance:SetShadowOffset(1, -0.5);
	end
end



--
function VUHDO_setTextColor(aFontInstance, aColorInfo, anIsUseClassColors, anInfo, aDefaultColorInfo)
	local tempColor;

	if (aColorInfo.useText) then
		tempColor = aColorInfo;
	elseif(anIsUseClassColors) then
		tempColor = VUHDO_getClassColor(anInfo);
	else
		tempColor = aDefaultColorInfo;
	end

	if (tempColor == nil) then
		tempColor = aDefaultColorInfo;
	end

	VUHDO_setTextColorSize(aFontInstance, tempColor, aDefaultColorInfo.textSize);
end



--
function VUHDO_setStatusBarColor(aStatusBar, aColorInfo)
	local tempOpacity;

	if (aColorInfo.useOpacity) then
		tempOpacity = aColorInfo.O;
	else
		tempOpacity = aStatusBar:GetAlpha();
	end

	if (aColorInfo.useBackground) then
		aStatusBar:SetStatusBarColor(aColorInfo.R, aColorInfo.G, aColorInfo.B, tempOpacity);
	else
		aStatusBar:SetAlpha(tempOpacity);
	end
end



--
function VUHDO_getDiffColor(aBaseColor, aModColor)
	local tempDestColor;

	tempDestColor = aBaseColor;

	if (aModColor.useText) then
		tempDestColor.TR = aModColor.TR;
		tempDestColor.TG = aModColor.TG;
		tempDestColor.TB = aModColor.TB;
		tempDestColor.TO = aModColor.TO;
		tempDestColor.useText = true;
	end

	if (aModColor.useBackground) then
		tempDestColor.R = aModColor.R;
		tempDestColor.G = aModColor.G;
		tempDestColor.B = aModColor.B;
		tempDestColor.useBackground = true;
	end

	if (aModColor.useOpacity) then
		tempDestColor.O = aModColor.O;
		tempDestColor.TO = aModColor.TO;
		tempDestColor.useOpacity = true;
	end

	return tempDestColor;
end



--
function VUHDO_copyColor(aColorInfo)
	local tempColorInfo = { };

	tempColorInfo["R"] = aColorInfo.R;
	tempColorInfo["G"] = aColorInfo.G;
	tempColorInfo["B"] = aColorInfo.B;
	tempColorInfo["O"] = aColorInfo.O;

	tempColorInfo["TR"] = aColorInfo.TR;
	tempColorInfo["TG"] = aColorInfo.TG;
	tempColorInfo["TB"] = aColorInfo.TB;
	tempColorInfo["TO"] = aColorInfo.TO;

	tempColorInfo["useBackground"] = aColorInfo.useBackground;
	tempColorInfo["useText"] = aColorInfo.useText;
	tempColorInfo["useOpacity"] = aColorInfo.useOpacity;

	return tempColorInfo;
end



--
function VUHDO_brightenColor(aColorInfo, aFactor)
	local tempColor = aColorInfo;
	local tempSummand = aFactor - 1;
	tempColor.R = aColorInfo.R + tempSummand;
	tempColor.G = aColorInfo.G + tempSummand;
	tempColor.B = aColorInfo.B + tempSummand;

	return tempColor;
end



--
function VUHDO_brightenTextColor(aColorInfo, aFactor)
	local tempColor = aColorInfo;
	local tempSummand = aFactor - 1;
	tempColor.TR = aColorInfo.TR + tempSummand;
	tempColor.TG = aColorInfo.TG + tempSummand;
	tempColor.TB = aColorInfo.TB + tempSummand;

	return tempColor;
end



--
function VUHDO_setRaidTargetIconTexture(aTexture, anIndex)
	local tempLeft, tempRight, tempTop, tempBottom;
	local tempTexturesPerRow = VUHDO_RAID_TARGET_ICON_DIMENSION / VUHDO_RAID_TARGET_TEXTURE_DIMENSION;

	anIndex = anIndex - 1;
	tempLeft = mod(anIndex , VUHDO_RAID_TARGET_TEXTURE_COLUMNS) * tempTexturesPerRow;
	tempRight = tempLeft + tempTexturesPerRow;
	tempTop = floor(anIndex / VUHDO_RAID_TARGET_TEXTURE_ROWS) * tempTexturesPerRow;
	tempBottom = tempTop + tempTexturesPerRow;
	aTexture:SetTexCoord(tempLeft, tempRight, tempTop, tempBottom);
end



--
function VUHDO_getUnitNameShort(aUnit, aLength)
  local tempName = UnitName(aUnit);
  local tempMaxChars = floor(aLength / 5);
	if (tempName ~= nil) then
		if (strlen(tempName) > tempMaxChars) then
			tempName = strsub(tempName, 1, tempMaxChars);
		end
	end

  return tempName;
end



--
function VUHDO_getMouseCoords()
	local tempX, tempY;

	tempX, tempY = GetCursorPosition();
	tempX = tempX / UIParent:GetEffectiveScale();
	tempY = tempY / UIParent:GetEffectiveScale();

	return tempX, tempY;
end
