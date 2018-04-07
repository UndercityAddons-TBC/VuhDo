-- Lazy loading caches
local VUHDO_ACTION_PANELS = { };
local VUHDO_HEALTH_BAR = { };
local VUHDO_HEAL_BUTTON = { };
local VUHDO_BAR_TEXT = { };
local VUHDO_HEADER = { };
local VUHDO_HEADER_TEXT = { };
local VUHDO_GROUP_ORDER_PANELS = { };
local VUHDO_GROUP_SELECT_PANELS = { };
local VUHDO_GROUP_ORDER_BARS_LEFT = { };
local VUHDO_GROUP_ORDER_BARS_RIGHT = { };
local VUHDO_PANEL_NUM_LABELS = { };
local VUHDO_PANEL_TEXTS_2 = { };
local VUHDO_DESIGN_PANELS = { };
local VUHDO_EXTEND_TEXTURES = { };
local VUHDO_CONFIG_CLOSE_TEXTURES = { };
local VUHDO_RAID_TARGET_TEXTURES = { };
local VUHDO_RAID_TARGET_TEXTURES_FRAMES = { };
local VUHDO_TARGET_BUTTONS = { };
local VUHDO_MISC_BUTTONS = { };
local VUHDO_TOOLTIP_TEXTURES = { };
local VUHDO_BUFF_SWATCHES = { };
local VUHDO_BUFF_PANELS = { };


--
function VUHDO_getTooltipTexture(aPanel)
	local tempIndex = aPanel:GetName();

	if (VUHDO_TOOLTIP_TEXTURES[tempIndex] == nil) then
		VUHDO_TOOLTIP_TEXTURES[tempIndex] = VUHDO_GLOBAL[tempIndex .. "TooltipTexture"];
	end

	return VUHDO_TOOLTIP_TEXTURES[tempIndex];
end



--
function VUHDO_getConfigCloseTexture(aPanel)
	local tempIndex = aPanel:GetName();

	if (VUHDO_CONFIG_CLOSE_TEXTURES[tempIndex] == nil) then
		VUHDO_CONFIG_CLOSE_TEXTURES[tempIndex] = VUHDO_GLOBAL[tempIndex .. "DoneTexture"];
	end

	return VUHDO_CONFIG_CLOSE_TEXTURES[tempIndex];
end



--
function VUHDO_getRaidTargetTexture(aTargetBar)
	local tempIndex = aTargetBar:GetName();

	if (VUHDO_RAID_TARGET_TEXTURES[tempIndex] == nil) then
		VUHDO_RAID_TARGET_TEXTURES[tempIndex] = VUHDO_GLOBAL[tempIndex .. "TargetTexture"];
	end

	return VUHDO_RAID_TARGET_TEXTURES[tempIndex];
end



--
function VUHDO_getRaidTargetTextureFrame(aTargetBar)
	local tempIndex = aTargetBar:GetName();

	if (VUHDO_RAID_TARGET_TEXTURES_FRAMES[tempIndex] == nil) then
		VUHDO_RAID_TARGET_TEXTURES_FRAMES[tempIndex] = VUHDO_GLOBAL[tempIndex .. "Target"];
	end

	return VUHDO_RAID_TARGET_TEXTURES_FRAMES[tempIndex];
end



--
function VUHDO_getMiscButton(aPanel)
	local tempIndex = aPanel:GetName();

	if (VUHDO_MISC_BUTTONS[tempIndex] == nil) then
		VUHDO_MISC_BUTTONS[tempIndex] = VUHDO_GLOBAL[tempIndex .. "MiscButton"];
	end

	return VUHDO_MISC_BUTTONS[tempIndex];
end



--
function VUHDO_getPanelExtendTexture(aHealPanel)
	local tempIndex = aHealPanel:GetName();

	if (VUHDO_EXTEND_TEXTURES[tempIndex] == nil) then
		VUHDO_EXTEND_TEXTURES[tempIndex] = VUHDO_GLOBAL[tempIndex .. "ExtendTexture"];
	end

	return VUHDO_EXTEND_TEXTURES[tempIndex];
end



--
function VUHDO_getDesignPanel(aHealPanel)
	local tempIndex = aHealPanel:GetName();

	if (VUHDO_DESIGN_PANELS[tempIndex] == nil) then
		VUHDO_DESIGN_PANELS[tempIndex] = VUHDO_GLOBAL[tempIndex .. "DesignPanel"];
	end

	return VUHDO_DESIGN_PANELS[tempIndex];
end



--
function VUHDO_getGroupOrderLabel2(aGroupOrderPanel)
	local tempIndex = aGroupOrderPanel:GetName();

  if (VUHDO_PANEL_TEXTS_2[tempIndex] == nil) then
  	VUHDO_PANEL_TEXTS_2[tempIndex] = VUHDO_GLOBAL[aGroupOrderPanel:GetName() .. "DragLabel2Label"];
  end

  return VUHDO_PANEL_TEXTS_2[tempIndex];
end



--
function VUHDO_getPanelNumLabel(aPanel, aPanelNum)
	if (VUHDO_PANEL_NUM_LABELS[aPanelNum] == nil) then
		VUHDO_PANEL_NUM_LABELS[aPanelNum] = VUHDO_GLOBAL[aPanel:GetName() .. "GroupNoLabelLabel"];
	end

	return VUHDO_PANEL_NUM_LABELS[aPanelNum];
end



--
function VUHDO_getConfigOrderBarRight(aPanelNum, anOrderNum)
	local tempIndex = aPanelNum * 100 + anOrderNum;
	if (VUHDO_GROUP_ORDER_BARS_RIGHT[tempIndex] == nil) then
		local tempPanel = VUHDO_getGroupOrderPanel(aPanelNum, anOrderNum);
		VUHDO_GROUP_ORDER_BARS_RIGHT[tempIndex] = VUHDO_GLOBAL[tempPanel:GetName() .. "InsertTextureRight"];
	end

	return VUHDO_GROUP_ORDER_BARS_RIGHT[tempIndex];
end



--
function VUHDO_getConfigOrderBarLeft(aPanelNum, anOrderNum)
	local tempIndex = aPanelNum * 100 + anOrderNum;
	if (VUHDO_GROUP_ORDER_BARS_LEFT[tempIndex] == nil) then
		local tempPanel = VUHDO_getGroupOrderPanel(aPanelNum, anOrderNum);
		VUHDO_GROUP_ORDER_BARS_LEFT[tempIndex] = VUHDO_GLOBAL[tempPanel:GetName() .. "InsertTextureLeft"];
	end

	return VUHDO_GROUP_ORDER_BARS_LEFT[tempIndex];
end



--
function VUHDO_getGroupOrderPanel(aParentPanelNum, aPanelNum)
	local tempIndex = aParentPanelNum * 100 + aPanelNum;

  if (VUHDO_GROUP_ORDER_PANELS[tempIndex] == nil) then
  	VUHDO_GROUP_ORDER_PANELS[tempIndex] = VUHDO_GLOBAL["VuhDoAction" .. aParentPanelNum .. "GroupOrderPanel" .. aPanelNum];
  end

  return VUHDO_GROUP_ORDER_PANELS[tempIndex];
end



--
function VUHDO_getGroupSelectPanel(aParentPanelNum, aPanelNum)
	local tempIndex = aParentPanelNum * 100 + aPanelNum;

  if (VUHDO_GROUP_SELECT_PANELS[tempIndex] == nil) then
  	VUHDO_GROUP_SELECT_PANELS[tempIndex] = VUHDO_GLOBAL["VuhDoAction" .. aParentPanelNum .. "GroupSelectPanel" .. aPanelNum];
  end

  return VUHDO_GROUP_SELECT_PANELS[tempIndex];
end



--
function VUHDO_getActionPanel(aPanelNum)
  if (VUHDO_ACTION_PANELS[aPanelNum] == nil) then
  	VUHDO_ACTION_PANELS[aPanelNum] = VUHDO_GLOBAL["VuhDoAction" .. aPanelNum];
  end

  return VUHDO_ACTION_PANELS[aPanelNum];
end



-- Returns the Bar-Object appropriate for given Button-Object
function VUHDO_getHealthBar(aButton, aBarNumber)
	local tempName;
	if (aBarNumber == 5) then
		tempName = aButton:GetName() .. "TargetBar";
	else
		tempName = aButton:GetName() .. "Bar";
	end

	if (aBarNumber ~= nil) then
		tempName = tempName .. aBarNumber;
	end

  if (VUHDO_HEALTH_BAR[tempName] == nil) then
  	VUHDO_HEALTH_BAR[tempName] = VUHDO_GLOBAL[tempName];
  end

  return VUHDO_HEALTH_BAR[tempName];
end



--
function VUHDO_getTargetButton(aButton)
	local tempIndex = aButton:GetName();
	if (VUHDO_TARGET_BUTTONS[tempIndex] == nil) then
		VUHDO_TARGET_BUTTONS[tempIndex] = VUHDO_GLOBAL[tempIndex .. "Target"];
	end

	return VUHDO_TARGET_BUTTONS[tempIndex];
end



-- Returns the Button Object for given unit number
function VUHDO_getHealButton(aButtonNum, aPanelNum)
	local tempIndex = aPanelNum * 100 + aButtonNum;

	if (VUHDO_HEAL_BUTTON[tempIndex] == nil) then
		VUHDO_HEAL_BUTTON[tempIndex] = VUHDO_GLOBAL["VuhDoAction" .. aPanelNum .. "HealUnit" .. aButtonNum];
	end

	return VUHDO_HEAL_BUTTON[tempIndex];
end



--
function VUHDO_getBarText(aBar, anIsTargetIcon)
	local tempIndex = aBar:GetName();

	if (anIsTargetIcon) then
		tempIndex = tempIndex .. "TT";
	end

	if (VUHDO_BAR_TEXT[tempIndex] == nil) then
		if (anIsTargetIcon) then
			--VUHDO_BAR_TEXT[tempIndex] = VUHDO_GLOBAL[aBar:GetName() .. "Text"];
			VUHDO_BAR_TEXT[tempIndex] = VUHDO_GLOBAL[aBar:GetName() .. "TargetText"];
		else
			VUHDO_BAR_TEXT[tempIndex] = VUHDO_GLOBAL[aBar:GetName() .. "Text"];
		end
	end

  return VUHDO_BAR_TEXT[tempIndex];
end




--
function VUHDO_getHeader(aHeaderNo, aPanelNum)
	local tempIndex = aPanelNum * 100 + aHeaderNo;

	if (VUHDO_HEADER[tempIndex] == nil) then
		VUHDO_HEADER[tempIndex] = VUHDO_GLOBAL["VuhDoAction" .. aPanelNum .. "Header" .. aHeaderNo];
	end

  return VUHDO_HEADER[tempIndex];
end



--
function VUHDO_getHeaderTextId(aHeader)
	local tempIndex = aHeader:GetName();
	if (VUHDO_HEADER_TEXT[tempIndex] == nil) then
		VUHDO_HEADER_TEXT[tempIndex] = VUHDO_GLOBAL[tempIndex .. "BarText"];
	end

	return VUHDO_HEADER_TEXT[tempIndex];
end



--
function VUHDO_getResizeKnob(aPanel)
	return VUHDO_GLOBAL[aPanel:GetName() .. "ResizeKnob"];
end



--
function VUHDO_getOrCreateBuffSwatch(aName, aParent)
	if (VUHDO_BUFF_SWATCHES[aName] == nil) then
		VUHDO_BUFF_SWATCHES[aName] = CreateFrame("Frame", aName, aParent, "VuhDoBuffSwatchPanelTemplate");
	end

	return VUHDO_BUFF_SWATCHES[aName];
end



--
function VUHDO_getOrCreateBuffPanel(aName)
	if (VUHDO_BUFF_PANELS[aName] == nil) then
		VUHDO_BUFF_PANELS[aName] = CreateFrame("Frame", aName, VuhDoBuffWatchMainFrame, "VuhDoBuffWatchBuffTemplate");
	end

	return VUHDO_BUFF_PANELS[aName];
end



--
function VUHDO_resetAllBuffPanels()
	local tempPanel;

	for _, tempPanel in pairs(VUHDO_BUFF_SWATCHES) do
		tempPanel:Hide();
		tempPanel:ClearAllPoints();
	end

	for _, tempPanel in pairs(VUHDO_BUFF_PANELS) do
		tempPanel:Hide();
		tempPanel:ClearAllPoints();
	end
end



--
function VUHDO_getAllBuffSwatches()
	return VUHDO_BUFF_SWATCHES;
end