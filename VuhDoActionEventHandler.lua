local VUHDO_IS_SMART_CAST = false;
VUHDO_MOVE_PANEL = nil;



--
function VuhDoActionOnEnter(aButton)
	VUHDO_showTooltip(aButton);
end



--
function VuhDoActionOnLeave(aButton)
	VUHDO_hideTooltip();
end



local VUHDO_DROPDOWN_UNIT;
function VUHDO_PlayerFrameDropDown_Initialize()
	UnitPopup_ShowMenu(PlayerFrameDropDown, "SELF", VUHDO_DROPDOWN_UNIT:GetAttribute("unit"));
end




--
function VuhDoActionPreClick(aButton, aMouseButton)
	local tempModifier = "";
	if (IsAltKeyDown()) then
		tempModifier = tempModifier .. "alt";
	end

	if (IsControlKeyDown()) then
		tempModifier = tempModifier .. "ctrl";
	end

	if (IsShiftKeyDown()) then
		tempModifier = tempModifier .. "shift";
	end

	local tempSuffix = SecureButton_GetButtonSuffix(aMouseButton);

	local tempKey = VUHDO_SPELL_ASSIGNMENTS[tempModifier .. tempSuffix];

	if (VUHDO_IS_PANEL_CONFIG or (tempKey ~= nil and strlower(tempKey[3]) == "menu")) then
		VUHDO_disableActions(aButton);
		VUHDO_setMenuUnit(aButton);
		ToggleDropDownMenu(1, nil, VuhDoPlayerTargetDropDown, aButton:GetName(), 0, -5);
		VUHDO_IS_SMART_CAST = true;
	elseif (tempKey ~= nil and strlower(tempKey[3]) == "tell") then
		ChatFrame_SendTell(VUHDO_RAID[aButton:GetAttribute("unit")].name);
	else
		VUHDO_IS_SMART_CAST = VUHDO_setupSmartCast(aButton);
	end
end



--
function VuhDoActionPostClick(aButton, aMouseButton)
	if (VUHDO_IS_SMART_CAST) then
		VUHDO_setupAllHealButtonAttributes(aButton, nil, false, false);
		VUHDO_IS_SMART_CAST = false;
	end
end



function VuhDoActionOnShow(anInstance)
	--VUHDO_Msg("ActionOnShow");
end



function VuhDoActionOnHide(this)
	--VUHDO_Msg("ActionOnHide");
end



function VuhDoActionOnMouseDown(aPanel, aMouseButton)
	VUHDO_startMoving(aPanel);
end



--
function VuhDoActionOnUpdate()
	VUHDO_stopMoving();
end



function VuhDoActionOnDragStart(aPanel)
	VUHDO_startMoving(aPanel);
end



---
function VUHDO_startMoving(aPanel)
	if (VuhDoFormButtonSize:IsVisible()) then
		VUHDO_formButtonSizeOkayOnClick(getglobal("VuhDoFormButtonSize"));
		DESIGN_MISC_PANEL_NUM = VUHDO_getComponentPanelNum(aPanel);
		VuhDoFormButtonSize:Hide();
		VuhDoFormButtonSize:Show();
		VUHDO_redrawAllPanels();
	elseif (VuhDoTooltipConfig:IsVisible()) then
		VUHDO_TooltipConfigOkayOnClick();
		DESIGN_MISC_PANEL_NUM = VUHDO_getComponentPanelNum(aPanel);
		VuhDoTooltipConfig:Hide();
		VuhDoTooltipConfig:Show();
		VUHDO_redrawAllPanels();
  elseif (VUHDO_mayMoveHealPanels() and IsMouseButtonDown(1)) then
  	VUHDO_MOVE_PANEL = aPanel;
		local tempOrientation, _, tempRelative, tempX, tempY = aPanel:GetPoint(0);
  	VuhdoActionAlias:ClearAllPoints();
  	VuhdoActionAlias:SetPoint(tempOrientation, "UIParent", tempRelative, tempX, tempY);
  	VuhdoActionAlias:SetWidth(aPanel:GetWidth());
  	VuhdoActionAlias:SetHeight(aPanel:GetHeight());
  	aPanel:Hide();
  	VuhdoActionAlias:Show();
  	VuhdoActionAlias:StartMoving();
  end
end



---
function VUHDO_stopMoving()
  if (not IsMouseButtonDown(1) and VUHDO_MOVE_PANEL ~= nil and VUHDO_mayMoveHealPanels()) then
		VuhdoActionAlias:StopMovingOrSizing();
		local tempOrientation, _, tempRelative, tempX, tempY = VuhdoActionAlias:GetPoint(0);
  	VUHDO_MOVE_PANEL:ClearAllPoints();
  	VUHDO_MOVE_PANEL:SetPoint(tempOrientation, "UIParent", tempRelative, tempX, tempY);
  	VuhdoActionAlias:Hide();
  	VUHDO_MOVE_PANEL:Show();

		VUHDO_savePanelCoords(VUHDO_MOVE_PANEL);
  	VUHDO_MOVE_PANEL = nil;
  	VUHDO_redrawAllPanels();
		--VUHDO_positionAllDesignPanels(VUHDO_MOVE_PANEL);
	end
end



--
function VUHDO_startAliasMoving(aPanel)
end



--
function VUHDO_stopAliasMoving(aPanel)
end



---
function VUHDO_actionChildOnMouseDown(aChild)
	VUHDO_startMoving(aChild:GetParent());
end



---
function VUHDO_actionChildOnMouseUp(aChild)
	VUHDO_stopMoving(aChild:GetParent());
end



---------------------------------------

function VUHDO_savePanelCoords(aPanel)
	local tempPanelNum;
	local tempSetup;
	local tempPosition;
	local tempX, tempY, tempRelative, tempOrientation;

	tempPanelNum = VUHDO_getPanelNum(aPanel);
	tempSetup = VUHDO_PANEL_SETUP[tempPanelNum];
	tempPosition = tempSetup["POSITION"];
	tempOrientation, _, tempRelative, tempX, tempY = aPanel:GetPoint(0);

	tempPosition.x = VUHDO_roundCoords(tempX);
	tempPosition.y = VUHDO_roundCoords(tempY);
	tempPosition.relativePoint = tempRelative;
	tempPosition.orientation = tempOrientation;
	tempPosition.width = VUHDO_roundCoords(aPanel:GetWidth());
	tempPosition.height = VUHDO_roundCoords(aPanel:GetHeight());
end



