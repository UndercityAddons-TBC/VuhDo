local VUHDO_currentCheckKey = nil;
local VUHDO_editSpellsBuffer = { };

local VUHDO_CHECK_KEYS = {
	"altctrlshift",
	"altctrl",
	"altshift",
	"ctrlshift",
	"alt",
	"ctrl",
	"shift",
};



--
function VUHDO_SpellOptionsCancelClicked(aPanel)
	VuhDoOptionsSpell:Hide();
end



--
function VUHDO_SpellOptionsOkayClicked(aPanel)
  VUHDO_saveCurrentEditValuesToBuffer();
	VUHDO_saveEditBufferToConfig();
	VUHDO_redrawAllPanels();

	VuhDoOptionsSpell:Hide();

end



--
function VUHDO_optionsSpellEnterPressed(aPanel)
	VUHDO_SpellOptionsOkayClicked(aPanel);
end



--
function VUHDO_optionsSpellEscPressed(aPanel)
	VUHDO_SpellOptionsCancelClicked(aPanel);
end



--
function VUHDO_uncheckAllButtons()
  VuhDoModifierNoneCheckButton:SetChecked(false);

  VuhdoModifierAltCheckButton:SetChecked(false);
  VuhDoModifierAltCtrlCheckButton:SetChecked(false);
  VuhDoModifierAltShiftCheckButton:SetChecked(false);
  VuhDoModifierAltCtrlShiftCheckButton:SetChecked(false);

  VuhDoModifierCtrlCheckButton:SetChecked(false);
  VuhdoModifierCtrlShiftCheckButton:SetChecked(false);

  VuhDoModifierShiftCheckButton:SetChecked(false);
end



--
function VUHDO_saveEditBufferToConfig()
	local tempKey, tempValue;
	VUHDO_SPELL_ASSIGNMENTS = {};

	for tempKey, tempValue in pairs(VUHDO_editSpellsBuffer) do
		local tempValue1 = tempValue[1];
		local tempValue2 = tempValue[2];
		local tempValue3 = tempValue[3];

		local tempNewValue = {
			tempValue1,
			tempValue2,
			tempValue3,
		};
		VUHDO_SPELL_ASSIGNMENTS[tempKey] = tempNewValue;
	end
end



--
function 	VUHDO_initEditSpellsBuffer()
	local tempKey, tempValue;
	VUHDO_editSpellsBuffer = {};

	for tempKey, tempValue in pairs(VUHDO_SPELL_ASSIGNMENTS) do
		local tempValue1 = tempValue[1];
		local tempValue2 = tempValue[2];
		local tempValue3 = tempValue[3];

		local tempNewValue = {
			tempValue1,
			tempValue2,
			tempValue3,
		};

		VUHDO_editSpellsBuffer[tempKey] = tempNewValue;
	end
end



--
function VUHDO_optionsSpellGetEditor(aButtonNum)
	return getglobal("VuhDoButton" .. aButtonNum .. "Edit");
end



--
function VUHDO_optionsSpellLoadEditLines()
	local tempAktAction;
	local tempCnt;
	local tempAktEditor;

	for tempCnt = 1, 5 do
		tempAktEditor = VUHDO_optionsSpellGetEditor(tempCnt);
		tempArrayKey = VUHDO_currentCheckKey .. tempCnt;
		tempAktAction = VUHDO_editSpellsBuffer[tempArrayKey][3];

		tempAktEditor:SetText(tempAktAction);
	end

end



--
function VUHDO_optionsSpellsOnShow()
	VUHDO_uncheckAllButtons();
  VuhDoModifierNoneCheckButton:SetChecked(true);
  VUHDO_currentCheckKey = "";

  VUHDO_initEditSpellsBuffer();
  VUHDO_optionsSpellLoadEditLines();
end



--
function VUHDO_optionsSpellGetCheckKey(aButtonName)
	local tempCurrentKey;
	local tempLowerName = strlower(aButtonName);

	for _, tempCurrentKey in ipairs(VUHDO_CHECK_KEYS) do
		if (string.find(tempLowerName, tempCurrentKey) ~= nil) then
			return tempCurrentKey;
		end
	end

	return "";
end



--
function VUHDO_saveCurrentEditValuesToBuffer()
	local tempCnt;
	local tempArrayKey;
	local tempAktEditor;

	for tempCnt = 1, 5 do
		tempArrayKey = VUHDO_currentCheckKey .. tempCnt;
		tempAktEditor = VUHDO_optionsSpellGetEditor(tempCnt);

		VUHDO_editSpellsBuffer[tempArrayKey][3] = tempAktEditor:GetText();
	end

end



--
function VUHDO_optionsSpellCheckButtonClicked(aButton)

	local tempButtonName;

	VUHDO_saveCurrentEditValuesToBuffer();
	tempButtonName = aButton:GetName();
	VUHDO_currentCheckKey = VUHDO_optionsSpellGetCheckKey(tempButtonName);
	VUHDO_uncheckAllButtons();
	aButton:SetChecked(true);

	VUHDO_optionsSpellLoadEditLines();
end



--
function VUHDO_isActionValid(anActionName)
	local tempActionLowerName;

	if (anActionName == nil or "" == anActionName) then
		return true;
	end

	tempActionLowerName = strlower(anActionName);

  if (VUHDO_SPELL_KEY_ASSIST == tempActionLowerName
   or VUHDO_SPELL_KEY_FOCUS == tempActionLowerName
   or VUHDO_SPELL_KEY_MENU == tempActionLowerName
   or VUHDO_SPELL_KEY_TELL == tempActionLowerName
	 or VUHDO_SPELL_KEY_TARGET == tempActionLowerName) then
	 	return true;
	end

	tempMacroId = VUHDO_getMacroId(anActionName);
	if (tempMacroId ~= 0) then
		return true;
	end

	tempSpellId = VUHDO_getSpellId(anActionName);
	if (tempSpellId ~= nil) then
		return true;
	end

	if (IsUsableItem(anActionName)) then
		return true;
	end

	return false;
end



--
local VUHDO_IS_AUTO_TEXT = false;
function VUHDO_optionsSpellOnTextChanged(anEditBox)
	if (VUHDO_IS_AUTO_TEXT) then
		return;
	end

	VUHDO_IS_AUTO_TEXT = true;
	anEditBox:SetText(VUHDO_trimSpellName(anEditBox:GetText()));
	VUHDO_IS_AUTO_TEXT = false;

	if (VUHDO_isActionValid(anEditBox:GetText())) then
		anEditBox:SetTextColor(0, 1, 0, 1);
	else
		anEditBox:SetTextColor(1, 0, 0, 1);
	end
end
