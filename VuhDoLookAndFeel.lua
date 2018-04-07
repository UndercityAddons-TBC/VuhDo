local VUHDO_ACTIVE_LABEL_COLOR = {
	["TR"] = 0.6,
	["TG"] = 0.6,
	["TB"] = 1,
	["TO"] = 1,
};


local VUHDO_NORMAL_LABEL_COLOR = {
	["TR"] = 0.4,
	["TG"] = 0.4,
	["TB"] = 1,
	["TO"] = 1,
};



--
function VUHDO_lnfCheckButtonClicked(aCheckButton)
	local tempName = aCheckButton:GetName();
	local tempCheckMark = VUHDO_GLOBAL[tempName .. "TextureCheckMark"];

	if (aCheckButton:GetChecked()) then
		tempCheckMark:Show();
	else
		tempCheckMark:Hide();
	end
end



--
function VUHDO_lnfCheckButtonOnEnter(aCheckButton)
	local tempName = aCheckButton:GetName();
	VUHDO_GLOBAL[tempName .. "TextureActiveSwatch"]:Show();
	VUHDO_GLOBAL[tempName .. "Label"]:SetTextColor(
		VUHDO_ACTIVE_LABEL_COLOR.TR,
		VUHDO_ACTIVE_LABEL_COLOR.TG,
		VUHDO_ACTIVE_LABEL_COLOR.TB,
		VUHDO_ACTIVE_LABEL_COLOR.TO
	);
end



--
function VUHDO_lnfCheckButtonOnLeave(aCheckButton)
	local tempName = aCheckButton:GetName();
	VUHDO_GLOBAL[tempName .. "TextureActiveSwatch"]:Hide();
	VUHDO_GLOBAL[tempName .. "Label"]:SetTextColor(
		VUHDO_NORMAL_LABEL_COLOR.TR,
		VUHDO_NORMAL_LABEL_COLOR.TG,
		VUHDO_NORMAL_LABEL_COLOR.TB,
		VUHDO_NORMAL_LABEL_COLOR.TO
	);
end