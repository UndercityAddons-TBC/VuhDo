
VUHDO_TOOLTIP_POS_FIX = 1;
VUHDO_TOOLTIP_POS_STANDARD = 2;
VUHDO_TOOLTIP_POS_MOUSE = 3;
VUHDO_TOOLTIP_POS_LEFT = 50;
VUHDO_TOOLTIP_POS_LEFT_UP = 51;
VUHDO_TOOLTIP_POS_LEFT_DOWN = 52;
VUHDO_TOOLTIP_POS_RIGHT = 60;
VUHDO_TOOLTIP_POS_RIGHT_UP = 61;
VUHDO_TOOLTIP_POS_RIGHT_DOWN = 62;
VUHDO_TOOLTIP_POS_UP = 70;
VUHDO_TOOLTIP_POS_UP_LEFT = 71;
VUHDO_TOOLTIP_POS_UP_RIGHT = 72;
VUHDO_TOOLTIP_POS_DOWN = 80;
VUHDO_TOOLTIP_POS_DOWN_LEFT = 81;
VUHDO_TOOLTIP_POS_DOWN_RIGHT = 82;


VUHDO_TOOLTIP_POSITIONS = {
	VUHDO_TOOLTIP_POS_FIX,
	VUHDO_TOOLTIP_POS_STANDARD,
	VUHDO_TOOLTIP_POS_MOUSE,
	VUHDO_TOOLTIP_POS_LEFT,
	VUHDO_TOOLTIP_POS_LEFT_UP,
	VUHDO_TOOLTIP_POS_LEFT_DOWN,
	VUHDO_TOOLTIP_POS_RIGHT,
	VUHDO_TOOLTIP_POS_RIGHT_UP,
	VUHDO_TOOLTIP_POS_RIGHT_DOWN,
	VUHDO_TOOLTIP_POS_UP,
	VUHDO_TOOLTIP_POS_UP_LEFT,
	VUHDO_TOOLTIP_POS_UP_RIGHT,
	VUHDO_TOOLTIP_POS_DOWN,
	VUHDO_TOOLTIP_POS_DOWN_LEFT,
	VUHDO_TOOLTIP_POS_DOWN_RIGHT,
};


VUHDO_TOOLTIP_MODE_VERBOSE = 1;


local VUHDO_TOOLTIP_MAX_LINES = 10;
local VUHDO_TOOLTIP_AKT_LINE_LEFT = 1;
local VUHDO_TOOLTIP_AKT_LINE_RIGHT = 1;

local VUHDO_TEXT_SIZE_LEFT = { };


local VUHDO_TT_UNIT = nil;
local VUHDO_TT_PANEL_NUM = nil;


--
function VUHDO_clearTooltipLines()
	local tempCnt;

	for tempCnt = 1, VUHDO_TOOLTIP_MAX_LINES do
		getglobal("VuhDoTooltipTextR" .. tempCnt):Hide();
		getglobal("VuhDoTooltipTextL" .. tempCnt):Hide();
	end

  VUHDO_TOOLTIP_AKT_LINE_LEFT = 1;
	VUHDO_TOOLTIP_AKT_LINE_RIGHT = 1;
	VUHDO_TEXT_SIZE_LEFT = { };
end



--
function VUHDO_initTooltip()
	local aPanel = VUHDO_getActionPanel(VUHDO_TT_PANEL_NUM);
	local aConfig = VUHDO_PANEL_SETUP[VUHDO_TT_PANEL_NUM]["TOOLTIP"];


	local tempPanelName = aPanel:GetName();

	if (aConfig["SCALE"] == nil) then
		aConfig["SCALE"] = 1;
	end

	VuhDoTooltip:SetScale(aConfig["SCALE"]);

	VuhDoTooltip:SetBackdropColor(
		aConfig["BACKGROUND"].R,
		aConfig["BACKGROUND"].G,
		aConfig["BACKGROUND"].B,
		aConfig["BACKGROUND"].O
	);

	VuhDoTooltip:SetBackdropBorderColor(
		aConfig["BORDER"].R,
		aConfig["BORDER"].G,
		aConfig["BORDER"].B,
		aConfig["BORDER"].O
	);

	VuhDoTooltip:ClearAllPoints();

	if (VUHDO_TOOLTIP_POS_FIX == aConfig.position) then
	  VuhDoTooltip:SetPoint(aConfig.point, "UIParent", aConfig.relativePoint, aConfig.x, aConfig.y);
	elseif (VUHDO_TOOLTIP_POS_MOUSE == aConfig.position) then
		local tempX, tempY;
		tempX, tempY = VUHDO_getMouseCoords();
	  VuhDoTooltip:SetPoint("TOPLEFT", "UIParent", "BOTTOMLEFT", tempX + 16, tempY - 16);
	elseif (VUHDO_TOOLTIP_POS_LEFT == aConfig.position) then
	  VuhDoTooltip:SetPoint("RIGHT", tempPanelName, "LEFT", 0, 0);
	elseif (VUHDO_TOOLTIP_POS_LEFT_UP == aConfig.position) then
	  VuhDoTooltip:SetPoint("TOPRIGHT", tempPanelName, "TOPLEFT", 0, 0);
	elseif (VUHDO_TOOLTIP_POS_LEFT_DOWN == aConfig.position) then
	  VuhDoTooltip:SetPoint("BOTTOMRIGHT", tempPanelName, "BOTTOMLEFT", 0, 0);
	elseif (VUHDO_TOOLTIP_POS_RIGHT == aConfig.position) then
	  VuhDoTooltip:SetPoint("LEFT", tempPanelName, "RIGHT", 0, 0);
	elseif (VUHDO_TOOLTIP_POS_RIGHT_UP == aConfig.position) then
	  VuhDoTooltip:SetPoint("TOPLEFT", tempPanelName, "TOPRIGHT", 0, 0);
	elseif (VUHDO_TOOLTIP_POS_RIGHT_DOWN == aConfig.position) then
	  VuhDoTooltip:SetPoint("BOTTOMLEFT", tempPanelName, "BOTTOMRIGHT", 0, 0);
	elseif (VUHDO_TOOLTIP_POS_UP == aConfig.position) then
	  VuhDoTooltip:SetPoint("BOTTOM", tempPanelName, "TOP", 0, 0);
	elseif (VUHDO_TOOLTIP_POS_UP_LEFT == aConfig.position) then
	  VuhDoTooltip:SetPoint("BOTTOMLEFT", tempPanelName, "TOPLEFT", 0, 0);
	elseif (VUHDO_TOOLTIP_POS_UP_RIGHT == aConfig.position) then
	  VuhDoTooltip:SetPoint("BOTTOMRIGHT", tempPanelName, "TOPRIGHT", 0, 0);
	elseif (VUHDO_TOOLTIP_POS_DOWN == aConfig.position) then
	  VuhDoTooltip:SetPoint("TOP", tempPanelName, "BOTTOM", 0, 0);
	elseif (VUHDO_TOOLTIP_POS_DOWN_LEFT == aConfig.position) then
	  VuhDoTooltip:SetPoint("TOPLEFT", tempPanelName, "BOTTOMLEFT", 0, 0);
	elseif (VUHDO_TOOLTIP_POS_DOWN_RIGHT == aConfig.position) then
	  VuhDoTooltip:SetPoint("TOPRIGHT", tempPanelName, "BOTTOMRIGHT", 0, 0);
	else -- VUHDO_TOOLTIP_POS_STANDARD
		GameTooltip:Hide();
		VuhDoTooltip:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -CONTAINER_OFFSET_X - 13, CONTAINER_OFFSET_Y);
	end

	if (VUHDO_TOOLTIP_POS_MOUSE == aConfig.position) then
		VUHDO_REFRESH_TOOLTIP_DELAY = 0.01;
	else
		VUHDO_REFRESH_TOOLTIP_DELAY = 0.5;
	end
end



--
function VUHDO_finishTooltip()
	VuhDoTooltip:SetWidth(200);

	local tempHeight = 28;
	local tempTextHeight;
	for _, tempTextHeight in pairs(VUHDO_TEXT_SIZE_LEFT) do
		tempHeight = tempHeight + tempTextHeight;
	end

	VuhDoTooltip:SetHeight(tempHeight);
  VuhDoTooltip:Show();
end



--
function VUHDO_updateTooltip()
	local tempUnit = VUHDO_TT_UNIT;
	local tempInfo = VUHDO_RAID[tempUnit];

	VUHDO_initTooltip();
	VUHDO_clearTooltipLines();

	-- Name
	local tempClassColor = VUHDO_getClassColor(tempInfo);
	if (tempClassColor == nil) then
		tempClassColor = VUHDO_PANEL_SETUP[VUHDO_TT_PANEL_NUM]["PANEL_COLOR"]["TEXT"];
	end

	VUHDO_addTooltipLineLeft(tempInfo.name, tempClassColor, 13);
	VUHDO_addTooltipLineRight("");

	-- Level, Klasse, Rasse
	local tempLevel = UnitLevel(tempUnit);
	if (tempLevel == nil) then
		tempLevel = "";
	end

	local tempClass = UnitClass(tempUnit);
	if (tempClass == nil) then
		tempClass = "";
	end

	VUHDO_addTooltipLineLeft(VUHDO_I18N_TT_LEVEL .. tempLevel .. " " .. tempClass, tempClassColor, 9);

	local tempRace = UnitRace(tempUnit);
	if (tempRace == nil) then
		tempRace = UnitCreatureType(tempUnit);
	end

	if (tempRace ~= nil) then
		VUHDO_addTooltipLineRight(tempRace, tempClassColor, 9);
	end

	-- Position
	if (UnitInRaid("player")) then
		local tempZone;
		local tempIndex = VUHDO_getUnitNo(tempUnit);
		_, _, _, _, _, _, tempZone, _, _ = GetRaidRosterInfo(tempIndex);

		VUHDO_addTooltipLineLeft(VUHDO_I18N_TT_POSITION);
		VUHDO_addTooltipLineRight(tempZone, VUHDO_VALUE_COLOR);
	end


	local tempLeftText = " ";
	if (UnitIsGhost(tempUnit)) then
		tempLeftText = VUHDO_I18N_TT_GHOST;
	elseif (UnitIsDead(tempUnit)) then
		tempLeftText = VUHDO_I18N_TT_DEAD;
	end

	local tempRightText = " ";
	if (UnitIsAFK(tempUnit)) then
		tempRightText = VUHDO_I18N_TT_AFK;
	elseif(UnitIsDND(tempUnit)) then
		tempRightText = VUHDO_I18N_TT_DND;
	end

	if (tempLeftText ~= " " or tempRightText ~= " ") then
		VUHDO_addTooltipLineLeft(tempLeftText, VUHDO_VALUE_COLOR);
		VUHDO_addTooltipLineRight(tempRightText, VUHDO_VALUE_COLOR);
	end

	tempLeftText = VUHDO_I18N_TT_LIFE .. tempInfo.health .. "/" .. tempInfo.healthmax;
	tempRightText = "";
	if (UnitPowerType(tempUnit) == VUHDO_UNIT_POWER_MANA) then
		tempRightText = VUHDO_I18N_TT_MANA .. tempInfo.power .. "/" .. tempInfo.powermax;
	end
	VUHDO_addTooltipLineLeft(tempLeftText, VUHDO_VALUE_COLOR, 8);
	VUHDO_addTooltipLineRight(tempRightText, VUHDO_VALUE_COLOR, 8);

	VUHDO_finishTooltip();
end



--
function VUHDO_showTooltip(aButton)
	local tempPanelNum = VUHDO_getComponentPanelNum(aButton);
	local tempTipConfig = VUHDO_PANEL_SETUP[tempPanelNum]["TOOLTIP"];

	if (not tempTipConfig.show
		or VUHDO_IS_PANEL_CONFIG
		or (VUHDO_isInFight() and not tempTipConfig.inFight)) then
		return;
	end

	--local tempUnit = VUHDO_BUTTON_UNIT[aButton:GetName()];
	local tempUnit = aButton:GetAttribute("unit");
	local tempInfo = VUHDO_RAID[tempUnit];

	if (tempUnit == nil or tempInfo == nil) then
		-- Must not happen
		return;
	end

	VUHDO_TT_UNIT = tempUnit;
	VUHDO_TT_PANEL_NUM = tempPanelNum;
  VUHDO_updateTooltip();
end



--
function VUHDO_demoTooltip(aPanelNum)
	local tempTipConfig = VUHDO_PANEL_SETUP[aPanelNum]["TOOLTIP"];

	if (not tempTipConfig.show) then
		return;
	end

	--local tempUnit = VUHDO_BUTTON_UNIT[aButton:GetName()];
	local tempUnit = VUHDO_getPlayerRaidUnit();
	local tempInfo = VUHDO_RAID[tempUnit];

	if (tempUnit == nil or tempInfo == nil) then
		-- Must not happen
		return;
	end

	VUHDO_TT_UNIT = tempUnit;
	VUHDO_TT_PANEL_NUM = aPanelNum;
  VUHDO_updateTooltip();
end



--
function VUHDO_hideTooltip()
	if (not VUHDO_IS_PANEL_CONFIG) then
		VuhDoTooltip:Hide();
	end
end



--
function VUHDO_setTooltipLine(aText, anIsLeft, aLineNum, aColorInfo, aTextSize)
	local tempText;

	if (anIsLeft) then
		tempText = getglobal("VuhDoTooltipTextL" .. aLineNum);
	else
		tempText = getglobal("VuhDoTooltipTextR" .. aLineNum);
	end

	tempText:SetText(aText);

	if (aColorInfo ~= nil) then
		tempText:SetTextColor(aColorInfo.TR, aColorInfo.TG, aColorInfo.TB, 1);
	end

	if (aTextSize ~= nil) then
		tempText:SetFont(GameFontNormal:GetFont(), aTextSize);
		tempText:SetShadowColor(0, 0, 0, 1);
		tempText:SetShadowOffset(1, -0.5);
	end

	if (anIsLeft) then
		_, VUHDO_TEXT_SIZE_LEFT[aLineNum] = tempText:GetFont();
	else
		tempText:SetHeight(VUHDO_TEXT_SIZE_LEFT[aLineNum]);
	end

	tempText:Show();
end



--
function VUHDO_addTooltipLineLeft(aText, aColorInfo, aTextSize)
	VUHDO_setTooltipLine(aText, true, VUHDO_TOOLTIP_AKT_LINE_LEFT, aColorInfo, aTextSize)
	VUHDO_TOOLTIP_AKT_LINE_LEFT = VUHDO_TOOLTIP_AKT_LINE_LEFT + 1;
end



--
function VUHDO_addTooltipLineRight(aText, aColorInfo, aTextSize)
	VUHDO_setTooltipLine(aText, false, VUHDO_TOOLTIP_AKT_LINE_RIGHT, aColorInfo, aTextSize)
  VUHDO_TOOLTIP_AKT_LINE_RIGHT = VUHDO_TOOLTIP_AKT_LINE_RIGHT + 1;
end
