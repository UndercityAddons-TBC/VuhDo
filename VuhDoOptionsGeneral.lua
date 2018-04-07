


--
function VUHDO_optionsGeneralOkayClicked(aPanel)
	local tempComboName;
	local tempSliderName;
	local tempButtonName;

	local tempPanelName = aPanel:GetName();

	----- MODE -----
	local tempModeName = getglobal(tempPanelName .. "ModePanel"):GetName();
	-- Mode
	tempComboName = getglobal(tempModeName .. "ModeComboBox"):GetName();
	VUHDO_CONFIG["MODE"] = tonumber(UIDropDownMenu_GetSelectedValue(getglobal(tempComboName)));
	-- Trigger level slider
	tempSliderName = getglobal(tempModeName .. "ModeTriggerLevelSlider"):GetName();
	VUHDO_CONFIG["EMERGENCY_TRIGGER"] = tonumber(getglobal(tempSliderName .. "Slider"):GetValue());
	-- Max. Emergencies slider
	tempSliderName = getglobal(tempModeName .. "ModeMaxEmergenciesSlider"):GetName();
	VUHDO_CONFIG["MAX_EMERGENCIES"] = tonumber(getglobal(tempSliderName .. "Slider"):GetValue());
	-- Show incoming
	tempButtonName = getglobal(tempModeName .. "ShowIncomingCheckButton"):GetName();
	VUHDO_CONFIG["SHOW_INCOMING"] = getglobal(tempButtonName):GetChecked();
	-- Show own incoming
	tempButtonName = getglobal(tempModeName .. "ShowOwnIncHealCheckButton"):GetName();
	VUHDO_CONFIG["SHOW_OWN_INCOMING"] = getglobal(tempButtonName):GetChecked();
	-- show overheal
	tempButtonName = getglobal(tempModeName .. "ShowOverhealCheckButton"):GetName();
	VUHDO_CONFIG["SHOW_OVERHEAL"] = getglobal(tempButtonName):GetChecked();


	----- RANGE -----
	local tempRangeName = getglobal(tempPanelName .. "CheckRangePanel"):GetName();
	-- Check range check box
	tempButtonName = getglobal(tempRangeName .. "CheckRangeCheckButton"):GetName();
	VUHDO_CONFIG["RANGE_CHECK"] = getglobal(tempButtonName):GetChecked();
	-- Pessimistic check box
	tempButtonName = getglobal(tempRangeName .. "PessimisticCheckButton"):GetName();
	VUHDO_CONFIG["RANGE_PESSIMISTIC"] = getglobal(tempButtonName):GetChecked();

	local tempSpellName = getglobal(tempRangeName .. "RangeBySpellEditBox"):GetText();
	if (VUHDO_isSpellValid(tempSpellName)) then
		VUHDO_CONFIG["RANGE_SPELL"] = tempSpellName;
	else
		VUHDO_CONFIG["RANGE_SPELL"] = nil;
		VUHDO_CONFIG["RANGE_PESSIMISTIC"] = true;
	end

	-- Range interval slider
	tempSliderName = getglobal(tempRangeName .. "CheckRangeIntervalSlider"):GetName();
	VUHDO_CONFIG["RANGE_CHECK_DELAY"] = tonumber(getglobal(tempSliderName .. "Slider"):GetValue());

	----- DEBUFFS -----
	local tempDetectName = getglobal(tempPanelName .. "DetectPanel"):GetName();
	-- detect check box
	tempButtonName = getglobal(tempDetectName .. "DetectDebuffsCheckButton"):GetName();
	VUHDO_CONFIG["DETECT_DEBUFFS"] = getglobal(tempButtonName):GetChecked();
	-- removable only
	tempButtonName = getglobal(tempDetectName .. "DetectRemovableOnlyCheckButton"):GetName();
	VUHDO_CONFIG["DETECT_DEBUFFS_REMOVABLE_ONLY"] = getglobal(tempButtonName):GetChecked();
	-- by class
	tempButtonName = getglobal(tempDetectName .. "IgnoreByClassCheckButton"):GetName();
	VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_BY_CLASS"] = getglobal(tempButtonName):GetChecked();
	-- by movement
	tempButtonName = getglobal(tempDetectName .. "IgnoreMovementImpairingCheckButton"):GetName();
	VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_MOVEMENT"] = getglobal(tempButtonName):GetChecked();
	-- duration
	tempButtonName = getglobal(tempDetectName .. "IgnoreByDurationCheckButton"):GetName();
	VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_DURATION"] = getglobal(tempButtonName):GetChecked();
	-- harmless
	tempButtonName = getglobal(tempDetectName .. "IgnoreNonHarmfulCheckButton"):GetName();
	VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_NO_HARM"] = getglobal(tempButtonName):GetChecked();


	----- SMART CAST -----
	local tempSmartName = getglobal(tempPanelName .. "SmartCastPanel"):GetName();
	-- smart cast
	tempButtonName = getglobal(tempSmartName .. "SmartCastCheckButton"):GetName();
	VUHDO_CONFIG["SMARTCAST"] = getglobal(tempButtonName):GetChecked();
	-- cleanse
	tempButtonName = getglobal(tempSmartName .. "SmartCastCleanseCheckButton"):GetName();
	VUHDO_CONFIG["SMARTCAST_CLEANSE"] = getglobal(tempButtonName):GetChecked();
	-- heal
	tempButtonName = getglobal(tempSmartName .. "SmartCastHealCheckButton"):GetName();
	VUHDO_CONFIG["SMARTCAST_HEAL"] = getglobal(tempButtonName):GetChecked();
	-- auto select spell
	tempButtonName = getglobal(tempSmartName .. "SmartCastAllSpellsCheckButton"):GetName();
	VUHDO_CONFIG["SMARTCAST_AUTO_HEAL_SPELL"] = getglobal(tempButtonName):GetChecked();
	-- resurrect
	tempButtonName = getglobal(tempSmartName .. "SmartCastResurrectCheckButton"):GetName();
	VUHDO_CONFIG["SMARTCAST_RESURRECT"] = getglobal(tempButtonName):GetChecked();


	---- OTHER ----
	-- avoid pvp
	tempButtonName = getglobal(tempPanelName .. "AvoidPvPCheckButton"):GetName();
	VUHDO_CONFIG["AVOID_PVP"] = getglobal(tempButtonName):GetChecked();
	-- detect aggro
	tempButtonName = getglobal(tempPanelName .. "DetectAggroCheckButton"):GetName();
	VUHDO_CONFIG["DETECT_AGGRO"] = getglobal(tempButtonName):GetChecked();
	-- parse combatlog
	tempButtonName = getglobal(tempPanelName .. "ParseCombatLogCheckButton"):GetName();
	VUHDO_CONFIG["PARSE_COMBAT_LOG"] = getglobal(tempButtonName):GetChecked();

	VuhDoOptionsGeneral:Hide();
	VUHDO_redrawAllPanels();
end



--
function VUHDO_optionsGeneralCancelClicked(aPanel)
	VuhDoOptionsGeneral:Hide();
end



--
function VUHDO_optionsGeneralEnterPressed(aPanel)
	VUHDO_optionsGeneralOkayClicked(aPanel);
end



--
function VUHDO_optionsGeneralEscPressed(aPanel)
	VUHDO_optionsGeneralCancelClicked(aPanel);
end



--
function VUHDO_optionsGeneralOnShow(aPanel)
	local tempComboName;
	local tempSliderName;
	local tempButtonName;

	local tempPanelName = aPanel:GetName();

	----- MODE -----
	local tempModeName = getglobal(tempPanelName .. "ModePanel"):GetName();
	-- Mode
	tempComboName = getglobal(tempModeName .. "ModeComboBox"):GetName();
	UIDropDownMenu_SetSelectedValue(getglobal(tempComboName), VUHDO_CONFIG["MODE"], 0);
	getglobal(tempComboName .. "Text"):SetText(VUHDO_getModeName(VUHDO_CONFIG["MODE"]));
	VUHDO_setEmergencySliderEnabled(VUHDO_CONFIG["MODE"] ~= VUHDO_MODE_NEUTRAL);
	-- Trigger level
	tempSliderName = getglobal(tempModeName .. "ModeTriggerLevelSlider"):GetName();
	getglobal(tempSliderName .. "Slider"):SetValue(VUHDO_CONFIG["EMERGENCY_TRIGGER"]);
	getglobal(tempSliderName .. "SliderTitle"):SetText(VUHDO_I18N_RELVEVANCE .. ": " .. VUHDO_CONFIG["EMERGENCY_TRIGGER"] .. "%");
	-- Max. Emergencies
	tempSliderName = getglobal(tempModeName .. "ModeMaxEmergenciesSlider"):GetName();
	getglobal(tempSliderName .. "Slider"):SetValue(VUHDO_CONFIG["MAX_EMERGENCIES"]);
	getglobal(tempSliderName .. "SliderTitle"):SetText(VUHDO_I18N_MAX_EMERGENCIES .. ": " .. VUHDO_CONFIG["MAX_EMERGENCIES"]);
	-- incoming
	tempButtonName = getglobal(tempModeName .. "ShowIncomingCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["SHOW_INCOMING"]);
	-- own inc heal
	tempButtonName = getglobal(tempModeName .. "ShowOwnIncHealCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["SHOW_OWN_INCOMING"]);
	-- overheal
	tempButtonName = getglobal(tempModeName .. "ShowOverhealCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["SHOW_OVERHEAL"]);


	----- RANGE -----
	local tempRangeName = getglobal(tempPanelName .. "CheckRangePanel"):GetName();
	-- Check range check box
	tempButtonName = getglobal(tempRangeName .. "CheckRangeCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["RANGE_CHECK"]);
	-- Pessimistic check box
	tempButtonName = getglobal(tempRangeName .. "PessimisticCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["RANGE_PESSIMISTIC"]);
	tempButtonName = getglobal(tempRangeName .. "RangeBySpellCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(not VUHDO_CONFIG["RANGE_PESSIMISTIC"]);

	tempButtonName = getglobal(tempRangeName .. "RangeBySpellEditBox"):GetName();
	if (VUHDO_CONFIG["RANGE_SPELL"] ~= nil) then
		getglobal(tempButtonName):SetText(VUHDO_CONFIG["RANGE_SPELL"]);
	else
		getglobal(tempButtonName):SetText("");
	end
	-- Range interval slider
	tempSliderName = getglobal(tempRangeName .. "CheckRangeIntervalSlider"):GetName();
	getglobal(tempSliderName .. "Slider"):SetValue(VUHDO_CONFIG["RANGE_CHECK_DELAY"]);
	getglobal(tempSliderName .. "SliderTitle"):SetText(VUHDO_I18N_EVERY .. VUHDO_CONFIG["RANGE_CHECK_DELAY"] .. VUHDO_I18N_MSECS);
	VUHDO_setRangeCheckEnabled(VUHDO_CONFIG["RANGE_CHECK"]);

	----- DEBUFFS -----
	local tempDetectName = getglobal(tempPanelName .. "DetectPanel"):GetName();
	-- detect check box
	tempButtonName = getglobal(tempDetectName .. "DetectDebuffsCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["DETECT_DEBUFFS"]);
	-- removable only
	tempButtonName = getglobal(tempDetectName .. "DetectRemovableOnlyCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["DETECT_DEBUFFS_REMOVABLE_ONLY"]);
	-- by class
	tempButtonName = getglobal(tempDetectName .. "IgnoreByClassCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_BY_CLASS"]);
	-- by movement
	tempButtonName = getglobal(tempDetectName .. "IgnoreMovementImpairingCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_MOVEMENT"]);
	-- duration
	tempButtonName = getglobal(tempDetectName .. "IgnoreByDurationCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_DURATION"]);
	-- harmless
	tempButtonName = getglobal(tempDetectName .. "IgnoreNonHarmfulCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_NO_HARM"]);
	VUHDO_setDebuffsEnabled(VUHDO_CONFIG["DETECT_DEBUFFS"])


	----- SMART CAST -----
	local tempSmartName = getglobal(tempPanelName .. "SmartCastPanel"):GetName();
	VUHDO_setSmartCastEnabled(VUHDO_CONFIG["SMARTCAST"]);

	-- smart cast
	tempButtonName = getglobal(tempSmartName .. "SmartCastCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["SMARTCAST"]);
	-- cleanse
	tempButtonName = getglobal(tempSmartName .. "SmartCastCleanseCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["SMARTCAST_CLEANSE"]);
	-- heal
	tempButtonName = getglobal(tempSmartName .. "SmartCastHealCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["SMARTCAST_HEAL"]);
	-- auto select spell
	tempButtonName = getglobal(tempSmartName .. "SmartCastAllSpellsCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["SMARTCAST_AUTO_HEAL_SPELL"]);
	VUHDO_setDownscaleEnabled(VUHDO_CONFIG["SMARTCAST_HEAL"]);
	-- resurrect
	tempButtonName = getglobal(tempSmartName .. "SmartCastResurrectCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["SMARTCAST_RESURRECT"]);


	---- OTHER ----
	-- avoid pvp
	tempButtonName = getglobal(tempPanelName .. "AvoidPvPCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["AVOID_PVP"]);
	-- detect aggro
	tempButtonName = getglobal(tempPanelName .. "DetectAggroCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["DETECT_AGGRO"]);
	-- parse combatlog
	tempButtonName = getglobal(tempPanelName .. "ParseCombatLogCheckButton"):GetName();
	getglobal(tempButtonName):SetChecked(VUHDO_CONFIG["PARSE_COMBAT_LOG"]);
end



--
function VUHDO_checkRangeIntervalSliderOnValueChanged(aSliderKnob)
	local tempSliderName = aSliderKnob:GetParent():GetName();
	getglobal(tempSliderName .. "SliderTitle"):SetText(VUHDO_I18N_EVERY .. tonumber(aSliderKnob:GetValue()) .. VUHDO_I18N_MSECS);
end



--
function VUHDO_maxEmergenciesSliderOnValueChanged(aSliderKnob)
	local tempSliderName = aSliderKnob:GetParent():GetName();
	getglobal(tempSliderName .. "SliderTitle"):SetText(VUHDO_I18N_MAX_EMERGENCIES .. ": " .. tonumber(aSliderKnob:GetValue()));
end



--
function VUHDO_triggerLevelSliderOnValueChanged(aSliderKnob)
	local tempSliderName = aSliderKnob:GetParent():GetName();
	getglobal(tempSliderName .. "SliderTitle"):SetText(VUHDO_I18N_RELVEVANCE .. ": " .. tonumber(aSliderKnob:GetValue()) .. "%");
end



--
function VUHDO_setEmergencySliderEnabled(anIsEnabled)
	local tempPanelName = "VuhDoOptionsGeneral";
	local tempModeName = getglobal(tempPanelName .. "ModePanel"):GetName();
	local tempSliderLabel = getglobal(tempModeName .. "ModeMaxEmergenciesSliderSliderTitle");

	VUHDO_enableLabel(tempSliderLabel, anIsEnabled);
end



--
function VUHDO_setRangeCheckEnabled(anIsEnabled)
	local tempPanelName = "VuhDoOptionsGeneral";
	local tempRangeName = getglobal(tempPanelName .. "CheckRangePanel"):GetName();

	VUHDO_enableCheckButton(getglobal(tempRangeName .. "PessimisticCheckButton"), anIsEnabled);
	VUHDO_enableCheckButton(getglobal(tempRangeName .. "RangeBySpellCheckButton"), anIsEnabled);
	VUHDO_enableLabel(getglobal(tempRangeName .. "CheckRangeIntervalSliderSliderTitle"), anIsEnabled);
end



--
function VUHDO_setDebuffsEnabled(anIsEnabled)
	local tempPanelName = "VuhDoOptionsGeneral";
	local tempDetectName = getglobal(tempPanelName .. "DetectPanel"):GetName();
	VUHDO_enableCheckButton(getglobal(tempDetectName .. "DetectRemovableOnlyCheckButton"), anIsEnabled);
	VUHDO_enableCheckButton(getglobal(tempDetectName .. "IgnoreByClassCheckButton"), anIsEnabled);
	VUHDO_enableCheckButton(getglobal(tempDetectName .. "IgnoreMovementImpairingCheckButton"), anIsEnabled);
	VUHDO_enableCheckButton(getglobal(tempDetectName .. "IgnoreByDurationCheckButton"), anIsEnabled);
	VUHDO_enableCheckButton(getglobal(tempDetectName .. "IgnoreNonHarmfulCheckButton"), anIsEnabled);
end



--
function VUHDO_setSmartCastEnabled(anIsEnabled)
	local tempPanelName = "VuhDoOptionsGeneral";
	local tempSmartName = getglobal(tempPanelName .. "SmartCastPanel"):GetName();
	VUHDO_enableCheckButton(getglobal(tempSmartName .. "SmartCastCleanseCheckButton"), anIsEnabled);
	VUHDO_enableCheckButton(getglobal(tempSmartName .. "SmartCastHealCheckButton"), anIsEnabled);
	VUHDO_enableCheckButton(getglobal(tempSmartName .. "SmartCastAllSpellsCheckButton"), anIsEnabled);
	VUHDO_enableCheckButton(getglobal(tempSmartName .. "SmartCastResurrectCheckButton"), anIsEnabled);
end



--
function VUHDO_setDownscaleEnabled(anIsEnabled)
	local tempPanelName = "VuhDoOptionsGeneral";
	local tempSmartName = getglobal(tempPanelName .. "SmartCastPanel"):GetName();
	VUHDO_enableCheckButton(getglobal(tempSmartName .. "SmartCastAllSpellsCheckButton"), anIsEnabled);
end



--
function VUHDO_modeComboOnValueChanged(anEntry)
	local tempComboBox = anEntry.owner;
	local tempSelected = tonumber(UIDropDownMenu_GetSelectedValue(tempComboBox));

	if (tempSelected == VUHDO_MODE_NEUTRAL) then
		VUHDO_setEmergencySliderEnabled(false);
	else
		VUHDO_setEmergencySliderEnabled(true);
	end
end



--
function VUHDO_checkRangeOnClick(aCheckButton)
	VUHDO_setRangeCheckEnabled(aCheckButton:GetChecked());
end



--
function VUHDO_detectDebuffsOnClick(aCheckButton)
	VUHDO_setDebuffsEnabled(aCheckButton:GetChecked());
end



--
function VUHDO_smartCastOnClick(aCheckButton)
	VUHDO_setSmartCastEnabled(aCheckButton:GetChecked());
end



--
function VUHDO_downscaleOnClick(aCheckButton)
	VUHDO_setDownscaleEnabled(aCheckButton:GetChecked());
end



--
function VUHDO_optionsGeneralOnTextChanged(anEditBox)
	if (VUHDO_isSpellValid(anEditBox:GetText())) then
		anEditBox:SetTextColor(0, 1, 0, 1);
	else
		anEditBox:SetTextColor(1, 0, 0, 1);
	end
end



--
function VUHDO_pessimisticOnClick(aButton)
	aButton:SetChecked(true);
	getglobal(aButton:GetParent():GetName() .. "RangeBySpellCheckButton"):SetChecked(false);
end



--
function VUHDO_bySpellOnClick(aButton)
	aButton:SetChecked(true);
	getglobal(aButton:GetParent():GetName() .. "PessimisticCheckButton"):SetChecked(false);
end



--
function VUHDO_optionsGeneralOnMouseDown(aPanel)
	aPanel:StartMoving();
end



--
function VUHDO_optionsGeneralOnMouseUp(aPanel)
	aPanel:StopMovingOrSizing();
end
