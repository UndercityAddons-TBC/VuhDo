local VUHDO_CURR_PROFILE = nil;
local VUHDO_CURRENT_COMBO = nil;



--
function VUHDO_saveProfileCancelOnClick(aButton)
	VuhDoFormProfileSave:Hide();
end



--
function VUHDO_saveProfileSaveCallback(aDecision)
	if (VUHDO_YES == aDecision) then
		VUHDO_slashCmd("save " .. VUHDO_CURR_PROFILE);

		local tempPanelName = "VuhDoFormProfileSaveAutoEnablePanel";
		local tempChecked;

		tempChecked = getglobal(tempPanelName .. "RaidCheckButton"):GetChecked();
		if (tempChecked) then
			VUHDO_PROFILES["NAME_RAID"] = VUHDO_CURR_PROFILE;
		elseif (VUHDO_CURR_PROFILE == VUHDO_PROFILES["NAME_RAID"]) then
			VUHDO_PROFILES["NAME_RAID"] = nil;
		end

		tempChecked = getglobal(tempPanelName .. "BgCheckButton"):GetChecked();
		if (tempChecked) then
			VUHDO_PROFILES["NAME_BG"] = VUHDO_CURR_PROFILE;
		elseif (VUHDO_CURR_PROFILE == VUHDO_PROFILES["NAME_BG"]) then
			VUHDO_PROFILES["NAME_BG"] = nil;
		end

		tempChecked = getglobal(tempPanelName .. "PartyCheckButton"):GetChecked();
		if (tempChecked) then
			VUHDO_PROFILES["NAME_PARTY"] = VUHDO_CURR_PROFILE;
		elseif (VUHDO_CURR_PROFILE == VUHDO_PROFILES["NAME_PARTY"]) then
			VUHDO_PROFILES["NAME_PARTY"] = nil;
		end

		tempChecked = getglobal(tempPanelName .. "SoloCheckButton"):GetChecked();
		if (tempChecked) then
			VUHDO_PROFILES["NAME_SOLO"] = VUHDO_CURR_PROFILE;
		elseif (VUHDO_CURR_PROFILE == VUHDO_PROFILES["NAME_SOLO"]) then
			VUHDO_PROFILES["NAME_SOLO"] = nil;
		end

		VuhDoFormProfileSave:Hide();
	end
end



--
function VUHDO_saveProfileSaveOnClick(aButton)
	if (VUHDO_PROFILES["DATA"][VUHDO_CURR_PROFILE] ~= nil) then
		VuhDoYesNoFrameText:SetText("Overwrite profile " .. VUHDO_CURR_PROFILE .. "?");
		VuhDoYesNoFrame:SetAttribute("callback", VUHDO_saveProfileSaveCallback);
		VuhDoYesNoFrame:Show();
	else
		VUHDO_saveProfileSaveCallback(VUHDO_YES);
	end
end



--
function VUHDO_saveProfileNewProfileOnTextChange(anEditBox)
	local tempName = strtrim(anEditBox:GetText());

	if (tempName ~= "") then
		if (VUHDO_PROFILES["DATA"][tempName] == nil) then
			getglobal("VuhDoFormProfileSaveOverwriteComboBoxText"):SetText("-- Select --");
		else
			getglobal("VuhDoFormProfileSaveOverwriteComboBoxText"):SetText(tempName);
		end
	end

	VUHDO_formProfileSaveSetupCheckButtonsFor(tempName);
end



--
function VUHDO_formButtonSaveComboOnSelectionChanged(anEntry)
	local tempComboBox = anEntry.owner;
	local tempPanel = tempComboBox:GetParent();
	getglobal(tempComboBox:GetName() .. "Text"):SetText(anEntry.value);
	getglobal(tempPanel:GetName() .. "NewProfileEditBox"):SetText(anEntry.value);
	VUHDO_formProfileSaveSetupCheckButtonsFor(anEntry.value);
end



--
function VUHDO_formSaveProfileInitGroupsCombo()
	local tempName, tempInfo;

	for tempName, _ in pairs(VUHDO_PROFILES["DATA"]) do
		tempInfo = VUHDO_createComboBoxInfo(VUHDO_CURRENT_COMBO, tempName, tempName, VUHDO_PROFILES["NAME_CURRENT"]);
		tempInfo.func = function() VUHDO_formButtonSaveComboOnSelectionChanged(this) end
		UIDropDownMenu_AddButton(tempInfo);
	end
end



--
function VUHDO_formSaveProfileComboOnLoad(aComboBox)
	local tempName;
	
	VUHDO_CURRENT_COMBO = aComboBox;

	UIDropDownMenu_ClearAll(aComboBox);
	UIDropDownMenu_Initialize(aComboBox, VUHDO_formSaveProfileInitGroupsCombo);

	if (VUHDO_PROFILES["NAME_CURRENT"] == nil) then
		getglobal(aComboBox:GetName() .. "Text"):SetText("-- Select --");
	else
		getglobal(aComboBox:GetName() .. "Text"):SetText(VUHDO_PROFILES["NAME_CURRENT"]);
	end
end



--
function VUHDO_formProfileSaveSetupCheckButtonsFor(aProfile)
	local tempPanelName = "VuhDoFormProfileSaveAutoEnablePanel";
	getglobal(tempPanelName .. "RaidCheckButton"):SetChecked(aProfile == VUHDO_PROFILES["NAME_RAID"]);
	getglobal(tempPanelName .. "BgCheckButton"):SetChecked(aProfile == VUHDO_PROFILES["NAME_BG"]);
	getglobal(tempPanelName .. "PartyCheckButton"):SetChecked(aProfile == VUHDO_PROFILES["NAME_PARTY"]);
	getglobal(tempPanelName .. "SoloCheckButton"):SetChecked(aProfile == VUHDO_PROFILES["NAME_SOLO"]);

	if (aProfile ~= nil and aProfile ~= "") then
		VUHDO_CURR_PROFILE = strtrim(aProfile);
		VuhDoFormProfileSaveSaveButton:Enable();
	else
		VUHDO_CURR_PROFILE = nil;
		VuhDoFormProfileSaveSaveButton:Disable();
	end
end



--
function VUHDO_formProfileSaveOnShow(aPanel)
	VUHDO_formProfileSaveSetupCheckButtonsFor(VUHDO_PROFILES["NAME_CURRENT"]);
	if (VUHDO_PROFILES["NAME_CURRENT"] ~= nil) then
		getglobal(aPanel:GetName() .. "NewProfileEditBox"):SetText(VUHDO_PROFILES["NAME_CURRENT"]);
	else
		getglobal(aPanel:GetName() .. "NewProfileEditBox"):SetText("");
	end
end



--
function VUHDO_formProfileSaveOnMouseDown(aPanel, aMouseButton)
	aPanel:StartMoving();
end



--
function VUHDO_formProfileSaveOnMouseUp(aPanel, aMouseButton)
	aPanel:StopMovingOrSizing();
end
