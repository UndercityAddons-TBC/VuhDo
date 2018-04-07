local VUHDO_CURRENT_COMBO;


--
function VUHDO_loadProfile(aProfileName)
	VUHDO_slashCmd("load " .. aProfileName);
end



--
function VUHDO_loadProfileRaidOnClick(aButton)
	VUHDO_loadProfile(VUHDO_PROFILES["NAME_RAID"]);
	VuhDoFormProfileLoad:Hide();
end



--
function VUHDO_loadProfileBgOnClick(aButton)
	VUHDO_loadProfile(VUHDO_PROFILES["NAME_BG"]);
	VuhDoFormProfileLoad:Hide();
end



--
function VUHDO_loadProfilePartyOnClick(aButton)
	VUHDO_loadProfile(VUHDO_PROFILES["NAME_PARTY"]);
	VuhDoFormProfileLoad:Hide();
end



--
function VUHDO_loadProfileSoloOnClick(aButton)
	VUHDO_loadProfile(VUHDO_PROFILES["NAME_SOLO"]);
	VuhDoFormProfileLoad:Hide();
end



--
function VUHDO_yesNoDecidedDeleteProfile(aDecision)
	if (VUHDO_YES == aDecision) then
		local tempName = VuhDoFormProfileLoadSelectCustomComboBoxText:GetText();
		VUHDO_PROFILES["DATA"][tempName] = nil;

		if (VUHDO_PROFILES["NAME_RAID"] == tempName) then
			VUHDO_PROFILES["NAME_RAID"] = nil;
		end

		if (VUHDO_PROFILES["NAME_BG"] == tempName) then
			VUHDO_PROFILES["NAME_BG"] = nil;
		end

		if (VUHDO_PROFILES["NAME_PARTY"] == tempName) then
			VUHDO_PROFILES["NAME_PARTY"] = nil;
		end

		if (VUHDO_PROFILES["NAME_SOLO"] == tempName) then
			VUHDO_PROFILES["NAME_SOLO"] = nil;
		end


		if (tempName == VUHDO_PROFILES["NAME_CURRENT"])	then
			VUHDO_PROFILES["NAME_CURRENT"] = nil;
			for tempName, _ in pairs(VUHDO_PROFILES["DATA"]) do
				VUHDO_PROFILES["NAME_CURRENT"] = tempName;
				break;
			end
		end

		VuhDoFormProfileLoad:Hide();
		VuhDoFormProfileLoad:Show();
	end

end



--
function VUHDO_loadProfileDeleteOnClick(aButton)
	local tempName = VuhDoFormProfileLoadSelectCustomComboBoxText:GetText();
	VuhDoYesNoFrameText:SetText("Delete profile " .. tempName .. "?");
	VuhDoYesNoFrame:SetAttribute("callback", VUHDO_yesNoDecidedDeleteProfile);
	VuhDoYesNoFrame:Show();
end



--
function VUHDO_loadProfileLoadOnClick(aButton)
	local tempName = VuhDoFormProfileLoadSelectCustomComboBoxText:GetText();
	VUHDO_loadProfile(tempName);
	VuhDoFormProfileLoad:Hide();
end



--
function VUHDO_loadProfileCancelOnClick(aButton)
	VuhDoFormProfileLoad:Hide();
end



--
function VUHDO_loadProfileEnableLoadDelete(aName)
	if (VUHDO_PROFILES["DATA"][aName] ~= nil) then
		VuhDoFormProfileLoadDeleteButton:Enable();
		VuhDoFormProfileLoadLoadButton:Enable();
	else
		VuhDoFormProfileLoadDeleteButton:Disable();
		VuhDoFormProfileLoadLoadButton:Disable();
	end
end




--
function VUHDO_formButtonLoadComboOnSelectionChanged(anEntry)
	local tempComboBox = anEntry.owner;
	getglobal(tempComboBox:GetName() .. "Text"):SetText(anEntry.value);
	VUHDO_loadProfileEnableLoadDelete(anEntry.value);
end



--
function VUHDO_formLoadProfileInitGroupsCombo()
	local tempName, tempInfo;

	for tempName, _ in pairs(VUHDO_PROFILES["DATA"]) do
		tempInfo = VUHDO_createComboBoxInfo(VUHDO_CURRENT_COMBO, tempName, tempName, VUHDO_PROFILES["NAME_CURRENT"]);
		tempInfo.func = function() VUHDO_formButtonLoadComboOnSelectionChanged(this) end
		UIDropDownMenu_AddButton(tempInfo);
	end
end



--
function VUHDO_formLoadProfileComboOnLoad(aComboBox)
	local tempName;

	VUHDO_CURRENT_COMBO = aComboBox;

	UIDropDownMenu_ClearAll(aComboBox);
	UIDropDownMenu_Initialize(aComboBox, VUHDO_formLoadProfileInitGroupsCombo);

	if (VUHDO_PROFILES["NAME_CURRENT"] == nil) then
		getglobal(aComboBox:GetName() .. "Text"):SetText("-- Select --");
	else
		getglobal(aComboBox:GetName() .. "Text"):SetText(VUHDO_PROFILES["NAME_CURRENT"]);
	end

	VUHDO_loadProfileEnableLoadDelete(VUHDO_PROFILES["NAME_CURRENT"]);
end



--
function VUHDO_formProfileLoadOnShow(aPanel)
	local tempPanelName = aPanel:GetName() .. "LoadDefaultPanel";

	if (VUHDO_PROFILES["NAME_RAID"] ~= nil) then
		getglobal(tempPanelName .. "RaidButton"):Enable();
	else
		getglobal(tempPanelName .. "RaidButton"):Disable();
	end

	if (VUHDO_PROFILES["NAME_BG"] ~= nil) then
		getglobal(tempPanelName .. "BgButton"):Enable();
	else
		getglobal(tempPanelName .. "BgButton"):Disable();
	end

	if (VUHDO_PROFILES["NAME_PARTY"] ~= nil) then
		getglobal(tempPanelName .. "PartyButton"):Enable();
	else
		getglobal(tempPanelName .. "PartyButton"):Disable();
	end

	if (VUHDO_PROFILES["NAME_SOLO"] ~= nil) then
		getglobal(tempPanelName .. "SoloButton"):Enable();
	else
		getglobal(tempPanelName .. "SoloButton"):Disable();
	end
end



--
function VUHDO_formProfileLoadOnMouseDown(aPanel, aMouseButton)
	aPanel:StartMoving();
end



--
function VUHDO_formProfileLoadOnMouseUp(aPanel, aMouseButton)
	aPanel:StopMovingOrSizing();
end
