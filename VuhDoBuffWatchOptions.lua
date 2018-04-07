local VUHDO_CURRENT_COLOR_NAME = nil;
local VUHDO_CURRENT_IS_TEXT = nil;



--
function VUHDO_buffOptionsOkayOnClick()
	VuhDoBuffWatchOptions:Hide();
end



--
function VUHDO_minutesRemainingBuffSliderValueChanged(aSliderKnob)
	if (VUHDO_BUFF_SETTINGS == nil or VUHDO_BUFF_SETTINGS["CONFIG"] == nil) then
		return;
	end

	local tempSliderName = aSliderKnob:GetParent():GetName();
	local tempValue = tonumber(aSliderKnob:GetValue());
	VUHDO_GLOBAL[tempSliderName .. "SliderTitle"]:SetText(VUHDO_I18N_MINUTES_REMAINING .. ": " .. tempValue);
	VUHDO_BUFF_SETTINGS["CONFIG"]["REBUFF_MIN_MINUTES"] = tempValue;
end



--
function VUHDO_percentRemainingBuffSliderValueChanged(aSliderKnob)
	if (VUHDO_BUFF_SETTINGS == nil or VUHDO_BUFF_SETTINGS["CONFIG"] == nil) then
		return;
	end

	local tempSliderName = aSliderKnob:GetParent():GetName();
	local tempValue = tonumber(aSliderKnob:GetValue());
	VUHDO_GLOBAL[tempSliderName .. "SliderTitle"]:SetText(VUHDO_I18N_PERCENT_REMAINING .. ": " .. tempValue);
	VUHDO_BUFF_SETTINGS["CONFIG"]["REBUFF_AT_PERCENT"] = tempValue;
end



--
function VUHDO_goupBuffAlwaysOnClick(aCheckButton)
	VUHDO_BUFF_SETTINGS["CONFIG"]["GROUP_SPELL_VERSION"] = "always";
	VUHDO_GLOBAL[aCheckButton:GetParent():GetName() .. "AlwaysCheckButton"]:SetChecked(true);
	VUHDO_GLOBAL[aCheckButton:GetParent():GetName() .. "NeverCheckButton"]:SetChecked(false);
	VUHDO_GLOBAL[aCheckButton:GetParent():GetName() .. "SmartCheckButton"]:SetChecked(false);
end



--
function VUHDO_goupBuffSmartOnClick(aCheckButton)
	VUHDO_BUFF_SETTINGS["CONFIG"]["GROUP_SPELL_VERSION"] = "smart";
	VUHDO_GLOBAL[aCheckButton:GetParent():GetName() .. "AlwaysCheckButton"]:SetChecked(false);
	VUHDO_GLOBAL[aCheckButton:GetParent():GetName() .. "NeverCheckButton"]:SetChecked(false);
	VUHDO_GLOBAL[aCheckButton:GetParent():GetName() .. "SmartCheckButton"]:SetChecked(true);
end



--
function VUHDO_goupBuffNeverOnClick(aCheckButton)
	VUHDO_BUFF_SETTINGS["CONFIG"]["GROUP_SPELL_VERSION"] = "never";
	VUHDO_GLOBAL[aCheckButton:GetParent():GetName() .. "AlwaysCheckButton"]:SetChecked(false);
	VUHDO_GLOBAL[aCheckButton:GetParent():GetName() .. "NeverCheckButton"]:SetChecked(true);
	VUHDO_GLOBAL[aCheckButton:GetParent():GetName() .. "SmartCheckButton"]:SetChecked(false);
end



--
function VUHDO_refreshBuffSliderValueChanged(aSliderKnob)
	if (VUHDO_BUFF_SETTINGS == nil or VUHDO_BUFF_SETTINGS["CONFIG"] == nil) then
		return;
	end

	local tempSliderName = aSliderKnob:GetParent():GetName();
	local tempValue = floor(tonumber(aSliderKnob:GetValue()) * 10) / 10;
	VUHDO_GLOBAL[tempSliderName .. "SliderTitle"]:SetText(VUHDO_I18N_REFRESH_EVERY .. ": " .. tempValue .. VUHDO_I18N_SECS);
	VUHDO_BUFF_SETTINGS["CONFIG"]["REFRESH_SECS"] = tempValue;
end



--
function VUHDO_smartAtLeastValueChanged(aSliderKnob)
	if (VUHDO_BUFF_SETTINGS == nil or VUHDO_BUFF_SETTINGS["CONFIG"] == nil) then
		return;
	end

	local tempSliderName = aSliderKnob:GetParent():GetName();
	local tempValue = tonumber(aSliderKnob:GetValue());
	VUHDO_GLOBAL[tempSliderName .. "SliderTitle"]:SetText(VUHDO_I18N_AT_LEAST_MISSING .. ": " .. tempValue);
	VUHDO_BUFF_SETTINGS["CONFIG"]["AT_LEAST_MISSING"] = tempValue;
end



--
function VUHDO_scaleBuffSliderValueChanged(aSliderKnob)
	if (VUHDO_BUFF_SETTINGS == nil or VUHDO_BUFF_SETTINGS["CONFIG"] == nil) then
		return;
	end

	local tempSliderName = aSliderKnob:GetParent():GetName();
	local tempValue = floor(tonumber(aSliderKnob:GetValue()) * 100) / 100;
	VUHDO_GLOBAL[tempSliderName .. "SliderTitle"]:SetText(VUHDO_I18N_SCALE .. ": " .. tempValue);
	VUHDO_BUFF_SETTINGS["CONFIG"]["SCALE"] = tempValue;
	VUHDO_reloadBuffPanel();
end



--
function VUHDO_maxSwatchesBuffSliderValueChanged(aSliderKnob)
	if (VUHDO_BUFF_SETTINGS == nil or VUHDO_BUFF_SETTINGS["CONFIG"] == nil) then
		return;
	end

	local tempSliderName = aSliderKnob:GetParent():GetName();
	local tempValue = tonumber(aSliderKnob:GetValue());
	VUHDO_GLOBAL[tempSliderName .. "SliderTitle"]:SetText(VUHDO_I18N_MAX_SWATCHES_PER_LINE .. ": " .. tempValue);
	VUHDO_BUFF_SETTINGS["CONFIG"]["SWATCH_MAX_ROWS"] = tempValue;
	VUHDO_reloadBuffPanel();
end



--
function VUHDO_maxBuffsBuffSliderValueChanged(aSliderKnob)
	if (VUHDO_BUFF_SETTINGS == nil or VUHDO_BUFF_SETTINGS["CONFIG"] == nil) then
		return;
	end

	local tempSliderName = aSliderKnob:GetParent():GetName();
	local tempValue = tonumber(aSliderKnob:GetValue());
	VUHDO_GLOBAL[tempSliderName .. "SliderTitle"]:SetText(VUHDO_I18N_MAX_BUFFS_PER_COLUMN .. ": " .. tempValue);
	VUHDO_BUFF_SETTINGS["CONFIG"]["PANEL_MAX_BUFFS"] = tempValue;
	VUHDO_reloadBuffPanel();
end



--
function VUHDO_buffOptionsOnMouseDown(aPanel)
	aPanel:StartMoving();
end



--
function VUHDO_buffOptionsOnMouseUp(aPanel)
	aPanel:StopMovingOrSizing();
end



--
function VUHDO_showBuffWatchOnClick(aCheckButton)
	VUHDO_BUFF_SETTINGS["CONFIG"]["SHOW"] = aCheckButton:GetChecked();
	VUHDO_reloadBuffPanel();
end



--
function VUHDO_flashBuffCooldownOnClick(aCheckButton)
	VUHDO_BUFF_SETTINGS["CONFIG"]["HIGHLIGHT_COOLDOWN"] = aCheckButton:GetChecked();
end



--
function VUHDO_showBuffWatchEmptyGroupsOnClick(aCheckButton)
	VUHDO_BUFF_SETTINGS["CONFIG"]["SHOW_EMPTY"] = aCheckButton:GetChecked();
	VUHDO_reloadBuffPanel();
end



--
function VUHDO_showBuffWatchBuffNamesOnClick(aCheckButton)
	VUHDO_BUFF_SETTINGS["CONFIG"]["SHOW_LABEL"] = aCheckButton:GetChecked();
	VUHDO_reloadBuffPanel();
end


--
function VUHDO_getBuffColorText(aTexture)
	local tempName = aTexture:GetName();
	local tempConfig = VUHDO_BUFF_SETTINGS["CONFIG"];
	local tempColorName;

	if (strfind(tempName, "PanelColor")) then
		tempColorName = "PANEL_BG_COLOR";
		tempText = VUHDO_I18N_BUFF_PANEL_BG;
	elseif (strfind(tempName, "PanelBorder")) then
		tempColorName = "PANEL_BORDER_COLOR";
		tempText = VUHDO_I18N_BUFF_PANEL_BORDER;
	elseif (strfind(tempName, "SwatchBorder")) then
		tempColorName = "SWATCH_BORDER_COLOR";
		tempText = VUHDO_I18N_BUFF_SWATCH_BORDER;
	elseif (strfind(tempName, "SwatchBackground")) then
		tempColorName = "SWATCH_BG_COLOR";
		tempText = VUHDO_I18N_BUFF_SWATCH_BG;
	elseif (strfind(tempName, "BuffLowTexture")) then
		tempColorName = "SWATCH_COLOR_BUFF_LOW";
		tempText = VUHDO_I18N_BUFF_LOW;
	elseif (strfind(tempName, "BuffCooldown")) then
		tempColorName = "SWATCH_COLOR_BUFF_COOLDOWN";
		tempText = VUHDO_I18N_BUFF_CD;
	elseif (strfind(tempName, "BuffMissing")) then
		tempColorName = "SWATCH_COLOR_BUFF_OUT";
		tempText = VUHDO_I18N_BUFF_MISSING;
	elseif (strfind(tempName, "EmptyGroup")) then
		tempColorName = "SWATCH_EMPTY_GROUP";
		tempText = VUHDO_I18N_BUFF_EMPTY_GROUP;
	elseif (strfind(tempName, "OutOfRange")) then
		tempColorName = "SWATCH_COLOR_OUT_RANGE";
		tempText = VUHDO_I18N_BUFF_OOR;
	elseif (strfind(tempName, "BuffOkayTexture")) then
		tempColorName = "SWATCH_COLOR_BUFF_OKAY";
		tempText = VUHDO_I18N_BUFF_OKAY;
	end

	tempColor = tempConfig[tempColorName];

	return tempColor, tempText, tempColorName;
end



--
function VUHDO_buffColorColorpickerCallback(arg1, arg2, arg3)
	if (VUHDO_CURRENT_COLOR_NAME == nil) then
		return;
	end

	if (arg3 == nil) then
		local tempColor = VUHDO_BUFF_SETTINGS["CONFIG"][VUHDO_CURRENT_COLOR_NAME];

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

	  VuhDoBuffWatchOptions:Hide();
	  VuhDoBuffWatchOptions:Show();
  end
end



--
function VUHDO_buffColorTextureOnClick(aTexture, aMouseButton)

	local tempIsText;

	if ("LeftButton" == aMouseButton) then
		tempIsText = false;
	elseif("RightButton" == aMouseButton) then
		tempIsText = true;
	else
		return;
	end

	local tempColor, _, tempColorName = VUHDO_getBuffColorText(aTexture);

	VUHDO_CURRENT_COLOR_NAME = tempColorName;

	local tempPanel = aTexture:GetParent():GetParent();

  ColorPickerFrame:ClearAllPoints();
  ColorPickerFrame:SetPoint("CENTER", tempPanel:GetName(), "CENTER", 0, 0);
  ColorPickerFrame.func = function() VUHDO_buffColorColorpickerCallback(arg1, arg2, arg3); end;
  ColorPickerFrame.hasOpacity = true;

  if (tempIsText and tempColor.TR ~= nil) then
  	ColorPickerFrame:SetColorRGB(tempColor.TR, tempColor.TG, tempColor.TB);
		ColorPickerFrame.opacity = 1 - tempColor.TO;
  	OpacitySliderFrame:SetValue(1 - tempColor.TO);
		VUHDO_CURRENT_IS_TEXT = true;
	else
  	ColorPickerFrame:SetColorRGB(tempColor.R, tempColor.G, tempColor.B);
		ColorPickerFrame.opacity = 1 - tempColor.O;
  	OpacitySliderFrame:SetValue(1 - tempColor.O);
		VUHDO_CURRENT_IS_TEXT = false;
	end

	ColorPickerFrame:Show();
end



--
function VUHDO_buffColorTextureOnShow(aTexture)
	local tempName = aTexture:GetName();
	local tempColor, tempText = VUHDO_getBuffColorText(aTexture);

	VUHDO_GLOBAL[tempName .. "NameLabelLabel"]:SetText(tempText);
	if (tempColor.TR ~= nil) then
		VUHDO_GLOBAL[tempName .. "NameLabelLabel"]:SetTextColor(tempColor.TR, tempColor.TG, tempColor.TB, tempColor.TO);
	end

	VUHDO_GLOBAL[tempName .. "Texture"]:SetVertexColor(tempColor.R, tempColor.G, tempColor.B, tempColor.O);
end



--
function VUHDO_buffOptionsOnShow(aPanel)
	local tempPanelName = aPanel:GetName();
	local tempConfig = VUHDO_BUFF_SETTINGS["CONFIG"];
	local tempSubPanelName;

	-- show
	VUHDO_GLOBAL[tempPanelName .. "ShowCheckButton"]:SetChecked(tempConfig["SHOW"]);
	VUHDO_GLOBAL[tempPanelName .. "ShowEmptyCheckButton"]:SetChecked(tempConfig["SHOW_EMPTY"]);
	VUHDO_GLOBAL[tempPanelName .. "ShowBuffNamesCheckButton"]:SetChecked(tempConfig["SHOW_LABEL"]);
	VUHDO_GLOBAL[tempPanelName .. "RefreshSliderSlider"]:SetValue(tempConfig["REFRESH_SECS"]);
	VUHDO_GLOBAL[tempPanelName .. "RefreshSlider"]:Show();

	-- size panel
	tempSubPanelName = tempPanelName .. "SizePanel";
	VUHDO_GLOBAL[tempSubPanelName .. "ScaleSliderSlider"]:SetValue(tempConfig["SCALE"]);
	VUHDO_GLOBAL[tempSubPanelName .. "ScaleSlider"]:Show();
	VUHDO_GLOBAL[tempSubPanelName .. "MaxSwatchesSliderSlider"]:SetValue(tempConfig["SWATCH_MAX_ROWS"]);
	VUHDO_GLOBAL[tempSubPanelName .. "MaxSwatchesSlider"]:Show();
	VUHDO_GLOBAL[tempSubPanelName .. "MaxBuffsSliderSlider"]:SetValue(tempConfig["PANEL_MAX_BUFFS"]);
	VUHDO_GLOBAL[tempSubPanelName .. "MaxBuffsSlider"]:Show();
	VUHDO_GLOBAL[tempSubPanelName .. "FlashCooldownCheckButton"]:SetChecked(tempConfig["HIGHLIGHT_COOLDOWN"]);

	-- use group version panel
	tempSubPanelName = tempPanelName .. "UseGroupVersionPanel";
	VUHDO_GLOBAL[tempSubPanelName .. "AlwaysCheckButton"]:SetChecked(tempConfig["GROUP_SPELL_VERSION"] == "always");
	VUHDO_GLOBAL[tempSubPanelName .. "SmartCheckButton"]:SetChecked(tempConfig["GROUP_SPELL_VERSION"] == "smart");
	VUHDO_GLOBAL[tempSubPanelName .. "NeverCheckButton"]:SetChecked(tempConfig["GROUP_SPELL_VERSION"] == "never");
	VUHDO_GLOBAL[tempSubPanelName .. "SmartAtLeastSliderSlider"]:SetValue(tempConfig["AT_LEAST_MISSING"]);
	VUHDO_GLOBAL[tempSubPanelName .. "SmartAtLeastSlider"]:Show();

	-- indicate rebuff panel
	tempSubPanelName = tempPanelName .. "IndicateRebuffPanel";
	VUHDO_GLOBAL[tempSubPanelName .. "MinutesSliderSlider"]:SetValue(tempConfig["REBUFF_MIN_MINUTES"]);
	VUHDO_GLOBAL[tempSubPanelName .. "MinutesSlider"]:Show();
	VUHDO_GLOBAL[tempSubPanelName .. "PercentSliderSlider"]:SetValue(tempConfig["REBUFF_AT_PERCENT"]);
	VUHDO_GLOBAL[tempSubPanelName .. "PercentSlider"]:Show();
end;
