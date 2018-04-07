VUHDO_IS_PANEL_CONFIG = false;
VUHDO_CONFIG_SHOW_RAID = true;
VUHDO_DESIGN_PANEL_EXTENDED = { };

local VUHDO_DRAG_MAX_DISTANCE = 60;

VUHDO_PANEL_MODEL_GUESSED = { };



--
function VUHDO_isConfigPanelShowing()
	return VUHDO_IS_PANEL_CONFIG and not VUHDO_CONFIG_SHOW_RAID;
end



--
function VUHDO_setGuessedModel(aPanelNum, aSlotNum, aValue)
	if (VUHDO_PANEL_MODEL_GUESSED[aPanelNum] == nil) then
		VUHDO_PANEL_MODEL_GUESSED[aPanelNum] = { };
	end

	VUHDO_PANEL_MODEL_GUESSED[aPanelNum][aSlotNum] = aValue;
end



--
function VUHDO_getGuessedModel(aPanelNum, aSlotNum)
	if (VUHDO_PANEL_MODEL_GUESSED[aPanelNum] == nil) then
		return false;
	end

	if (VUHDO_PANEL_MODEL_GUESSED[aPanelNum][aSlotNum] == nil) then
		return false;
	end 
	
	return VUHDO_PANEL_MODEL_GUESSED[aPanelNum][aSlotNum];
end



--
function VUHDO_positionAllGroupConfigPanels(aPanelNum)
	local tempModelArray = VUHDO_PANEL_MODELS[aPanelNum];
	local tempCnt;
	local tempXPos, tempYPos;
	local tempPanel;
	local tempModel;
	local tempIsShowOrder;
	local tempAnzModels;
	local tempScale = VUHDO_getHealButtonWidth(aPanelNum) / VUHDO_getGroupOrderPanel(aPanelNum, 1):GetWidth();

	if (tempModelArray == nil) then
		return;
	end

  local tempParentPanel = VUHDO_getActionPanel(aPanelNum);
	tempAnzModels = table.getn(tempModelArray);

  for tempCnt = 1, tempAnzModels do
  	VUHDO_getGroupOrderPanel(aPanelNum, tempCnt):SetScale(tempScale);
  	VUHDO_getGroupSelectPanel(aPanelNum, tempCnt):SetScale(tempScale);
  	
		tempXPos, tempYPos = VUHDO_getHealButtonPos(tempCnt, 1, aPanelNum);

		 tempModel = VUHDO_PANEL_MODELS[aPanelNum][tempCnt];
		 tempIsShowOrder = (tempModel ~= VUHDO_ID_UNDEFINED) 
		 	and not VUHDO_getGuessedModel(aPanelNum, tempCnt);

		 tempPanel = VUHDO_getGroupOrderPanel(aPanelNum, tempCnt);
		 tempPanel:ClearAllPoints();
     tempPanel:SetPoint("TOPLEFT", tempParentPanel:GetName(), "TOPLEFT", tempXPos / tempScale, -tempYPos / tempScale);
     if (tempIsShowOrder) then
       tempPanel:Hide();
       tempPanel:Show();
     else
       tempPanel:Hide();
     end

     tempPanel = VUHDO_getGroupSelectPanel(aPanelNum, tempCnt);
		 tempPanel:ClearAllPoints();
     tempPanel:SetPoint("TOPLEFT", tempParentPanel:GetName(), "TOPLEFT", tempXPos / tempScale, -tempYPos / tempScale);
     if (not tempIsShowOrder) then
       tempPanel:Hide();
       tempPanel:Show();
     else
       tempPanel:Hide();
     end

     VUHDO_getConfigOrderBarLeft(aPanelNum, tempCnt):Hide();
     VUHDO_getConfigOrderBarRight(aPanelNum, tempCnt):Hide();
  end

  for tempCnt = tempAnzModels + 1, VUHDO_MAX_GROUPS_PER_PANEL do
		 tempPanel = VUHDO_getGroupOrderPanel(aPanelNum, tempCnt);
     tempPanel:Hide();
     tempPanel = VUHDO_getGroupSelectPanel(aPanelNum, tempCnt);
     tempPanel:Hide();
  end
end



--
function VUHDO_clearUndefinedModelEntries()
	local tempModelArray;
	local tempKeyArray;
	local tempCnt;
	local tempModelId;

	for tempKeyArray, tempModelArray in pairs(VUHDO_PANEL_MODELS) do
		for tempCnt = VUHDO_MAX_GROUPS_PER_PANEL, 1, -1 do
			tempModelId = tempModelArray[tempCnt];
			
			if (tempModelId == VUHDO_ID_UNDEFINED) then
				table.remove(tempModelArray, tempCnt);
			end
		end
	end
	
	for tempKeyArray, tempModelArray in pairs(VUHDO_PANEL_MODELS) do
		if (tempModelArray == nil or table.getn(tempModelArray) == 0) then
			VUHDO_PANEL_MODELS[tempKeyArray] = nil;
		end
	end
	
end



--
function VUHDO_startPanelConfig()
	VUHDO_DESIGN_PANEL_EXTENDED = { };
	VUHDO_IS_PANEL_CONFIG = true;
	VUHDO_CONFIG_SHOW_RAID = true;
	VuhDoDesignMainPanel:Show();
	VUHDO_initDynamicPanelModels();
	VUHDO_redrawAllPanels();
end



--
function VUHDO_stopPanelConfig()
	VuhDoFormButtonColor:Hide();
	VuhDoFormButtonSize:Hide();
	VuhDoDesignMainPanel:Hide();

	VUHDO_PANEL_MODEL_GUESSED = { };

	VUHDO_clearUndefinedModelEntries();
	VUHDO_redrawAllPanels();
	VUHDO_IS_PANEL_CONFIG = false;
	VUHDO_initDynamicPanelModels();
	VUHDO_redrawAllPanels();
	VUHDO_rewritePanelModels();
end



--
function VUHDO_determineDistance(aXPos, aYPos, anotherXPos, anotherYPos)
	local tempDeltaX, tempDeltaY;
	tempDeltaX = aXPos - anotherXPos;
	tempDeltaY = aYPos - anotherYPos;

	local tempDistance = sqrt(tempDeltaX * tempDeltaX + tempDeltaY * tempDeltaY);

	return tempDistance;
end



--
function VUHDO_GetDragTargetSweetY(aDraggedPanel, aDragTargetPanel)
	local tempDragSweetY = aDraggedPanel:GetTop() * aDraggedPanel:GetScale() - (aDraggedPanel:GetHeight() * aDraggedPanel:GetScale() / 2);

	local tempTargetSweetY;
	if (tempDragSweetY > aDragTargetPanel:GetTop() * aDragTargetPanel:GetScale()) then
		tempTargetSweetY = aDragTargetPanel:GetTop() * aDragTargetPanel:GetScale();
	elseif (tempDragSweetY < aDragTargetPanel:GetBottom() * aDragTargetPanel:GetScale()) then
		tempTargetSweetY = aDragTargetPanel:GetBottom() * aDragTargetPanel:GetScale();
	else
		tempTargetSweetY = tempDragSweetY;
	end

	return tempTargetSweetY;
end



--
function VUHDO_determineDragDistance(aDraggedPanel, aDragTargetPanel, anIsLeftOf)
	local tempDragSweetX, tempDragSweetY;
	local tempTargetSweetX, tempTargetSweetY;
	local tempDistance;

	tempDragSweetX = aDraggedPanel:GetLeft() * aDraggedPanel:GetScale() + (aDraggedPanel:GetWidth() * aDraggedPanel:GetScale() / 2);
	tempDragSweetY = aDraggedPanel:GetTop() * aDraggedPanel:GetScale() - (aDraggedPanel:GetHeight() * aDraggedPanel:GetScale() / 2);

	if (anIsLeftOf) then
		tempTargetSweetX = aDragTargetPanel:GetLeft() * aDragTargetPanel:GetScale();
	else
		tempTargetSweetX = aDragTargetPanel:GetRight() * aDragTargetPanel:GetScale();
	end

	tempTargetSweetY = VUHDO_GetDragTargetSweetY(aDraggedPanel, aDragTargetPanel);

	tempDistance = VUHDO_determineDistance(tempDragSweetX, tempDragSweetY, tempTargetSweetX, tempTargetSweetY);
	return tempDistance;
end



--
function VUHDO_refreshDragTargetBars(aPanelNum, anOrderPanelNum, anIsLeft, aDraggedPanel)
	local tempPanelNum, tempOrderNum;
	local tempLeftBarOrderNum = nil;
	local tempRightBarOrderNum = nil;
	local tempBarLeft, tempBarRight;

	if (anOrderPanelNum ~= nil) then
		if (anIsLeft) then
			tempLeftBarOrderNum = anOrderPanelNum;

			if (anOrderPanelNum > 1) then
				tempRightBarOrderNum = anOrderPanelNum - 1;
			end
		else
			tempRightBarOrderNum = anOrderPanelNum;

			if (VUHDO_PANEL_MODELS[aPanelNum] ~= nil
				and anOrderPanelNum < table.getn(VUHDO_PANEL_MODELS[aPanelNum])) then
				tempLeftBarOrderNum = anOrderPanelNum + 1;
			end
		end
	end

	for tempPanelNum = 1, VUHDO_MAX_PANELS do
		for tempOrderNum = 1, VUHDO_MAX_GROUPS_PER_PANEL do
			tempBarLeft = VUHDO_getConfigOrderBarLeft(tempPanelNum, tempOrderNum);
			tempBarRight = VUHDO_getConfigOrderBarRight(tempPanelNum, tempOrderNum);

			if (aPanelNum == tempPanelNum) then
				if (tempLeftBarOrderNum ~= nil
					and tempLeftBarOrderNum == tempOrderNum
					and tempBarLeft:GetParent() ~= aDraggedPanel) then
					tempBarLeft:Show();
				else
					tempBarLeft:Hide();
				end

				if (tempRightBarOrderNum ~= nil
					and tempRightBarOrderNum == tempOrderNum
					and tempBarLeft:GetParent() ~= aDraggedPanel) then
					tempBarRight:Show();
				else
					tempBarRight:Hide();
				end
			else
				tempBarLeft:Hide();
				tempBarRight:Hide();
			end
		end
	end

end



--
function VUHDO_determineDragTarget(aDraggedPanel)
	local tempPanelNum, tempConfigNum;
	local tempOrderPanel;
	local tempCurrentDistance, tempLowestDistance;
	local tempLowPanelNum, tempLowOrderNum;
	local tempIsLeft;
	local tempMaxOrderPanels;
	local tempPanel;

  tempLowestDistance = 999999;
	for tempPanelNum = 1, VUHDO_MAX_PANELS do
		tempPanel = VUHDO_getActionPanel(tempPanelNum);
		if (tempPanel:IsVisible()) then
			tempMaxOrderPanels = table.getn(VUHDO_PANEL_MODELS[tempPanelNum]);
  		for tempConfigNum = 1, tempMaxOrderPanels do
  			tempOrderPanel = VUHDO_getGroupOrderPanel(tempPanelNum, tempConfigNum);

  			if (tempOrderPanel ~= aDraggedPanel) then

  				tempCurrentDistance = VUHDO_determineDragDistance(aDraggedPanel, tempOrderPanel, true);
  				if (tempCurrentDistance < tempLowestDistance) then
  					tempLowestDistance = tempCurrentDistance;
  					tempLowPanelNum = tempPanelNum;
  					tempLowOrderNum = tempConfigNum;
  					tempIsLeft = true;
  				end

  				tempCurrentDistance = VUHDO_determineDragDistance(aDraggedPanel, tempOrderPanel, false);
  				if (tempCurrentDistance < tempLowestDistance) then
  					tempLowestDistance = tempCurrentDistance;
  					tempLowPanelNum = tempPanelNum;
  					tempLowOrderNum = tempConfigNum;
  					tempIsLeft = false;
  				end
  			end
  		end
  		-- Test for dragging into an empty Panel
  		if (tempMaxOrderPanels == 0) then
  			
  			local tempPanelX = tempPanel:GetLeft() + (tempPanel:GetWidth() / 2);
  			local tempPanelY = tempPanel:GetTop() - (tempPanel:GetHeight()  / 2);
  			local tempDragX = aDraggedPanel:GetLeft() * aDraggedPanel:GetScale() + (aDraggedPanel:GetWidth() * aDraggedPanel:GetScale() / 2);
  			local tempDragY = aDraggedPanel:GetTop() * aDraggedPanel:GetScale() - (aDraggedPanel:GetHeight() * aDraggedPanel:GetScale() / 2);
  			tempCurrentDistance = VUHDO_determineDistance(tempPanelX, tempPanelY, tempDragX, tempDragY);

  			if (tempCurrentDistance < tempLowestDistance) then
  				tempLowestDistance = tempCurrentDistance;
  				tempLowPanelNum = tempPanelNum;
  				tempLowOrderNum = 1;
  				tempIsLeft = true;
  			end
  		end
		end
	end

	if (tempLowestDistance > VUHDO_DRAG_MAX_DISTANCE) then
		return nil, nil, nil;
	else
	  return tempLowPanelNum, tempLowOrderNum, tempIsLeft;
	end
end



--
function VUHDO_refreshDragTarget(aDraggedPanel)
	local tempPanelNum, tempOrderNum, tempIsLeft;

	tempPanelNum, tempOrderNum, tempIsLeft = VUHDO_determineDragTarget(aDraggedPanel);
	VUHDO_refreshDragTargetBars(tempPanelNum, tempOrderNum, tempIsLeft, aDraggedPanel);
end



--
function VUHDO_reorderGroupsAfterDragged(aDraggedPanel)
	local tempPanelNum, tempOrderNum, tempIsLeft;
	local tempSourcePanelNum, tempSourceGroupOrderNum;

	tempPanelNum, tempOrderNum, tempIsLeft = VUHDO_determineDragTarget(aDraggedPanel);

	if (tempOrderNum ~= nil) then
		tempSourcePanelNum, tempSourceGroupOrderNum = VUHDO_getComponentPanelNumModelNum(aDraggedPanel);
		local tempModelId = VUHDO_PANEL_MODELS[tempSourcePanelNum][tempSourceGroupOrderNum];
		VUHDO_removeFromModel(tempSourcePanelNum, tempSourceGroupOrderNum);

		if (tempSourcePanelNum == tempPanelNum and tempSourceGroupOrderNum < tempOrderNum and tempOrderNum > 1) then
			tempOrderNum = tempOrderNum - 1;
		end

		VUHDO_insertIntoModel(tempPanelNum, tempOrderNum, tempIsLeft, tempModelId);
		VUHDO_PANEL_MODEL_GUESSED[tempPanelNum] = { };
	end

	VUHDO_redrawAllPanels();
end



--
function VUHDO_guessModelIdForType(aPanelNum, aType)
	local tempCheckId, tempModelId;
	local tempTypeMembers = VUHDO_ID_TYPE_MEMBERS[aType];
	local tempModels = VUHDO_PANEL_MODELS[aPanelNum];
	local tempIsUsed;
	
	for _, tempCheckId in ipairs(tempTypeMembers) do
		tempIsUsed = false;
		for _, tempModelId in pairs(tempModels) do
			if (tempCheckId == tempModelId) then
				tempIsUsed = true;
				break;
			end
		end
		
		if (not tempIsUsed) then
			return tempCheckId;
		end
	end
	
	return nil;
end



--
function VUHDO_guessUndefinedEntries(aPanelNum)
	local tempModelId;
	local tempModelType;
	local tempTupel;
	local tempIndex;
	local tempGuessId;
	
	local tempTypeCount = {
		[VUHDO_ID_TYPE_GROUP] = { VUHDO_ID_TYPE_GROUP, 0 },
		[VUHDO_ID_TYPE_CLASS] = { VUHDO_ID_TYPE_CLASS, 0 },
		[VUHDO_ID_TYPE_SPECIAL] = { VUHDO_ID_TYPE_SPECIAL, 0 }
	};
	
	local tempSortIdByCount = { };
	
	for tempIndex, tempModelId in ipairs(VUHDO_PANEL_MODELS[aPanelNum]) do
		tempModelType = VUHDO_getModelType(tempModelId);
		
		if (tempTypeCount[tempModelType] ~= nil and not VUHDO_getGuessedModel(aPanelNum, tempIndex)) then
			tempTypeCount[tempModelType][2] = tempTypeCount[tempModelType][2] + 1;
		else
			VUHDO_PANEL_MODELS[aPanelNum][tempIndex] = VUHDO_ID_TYPE_UNDEFINED;
		end		
	end
	
	table.sort(tempTypeCount, 
		function(aTupel, anotherTupel)
			return aTupel[2] > anotherTupel[2];
		end
	);
	
	for tempIndex, tempModelId in ipairs(VUHDO_PANEL_MODELS[aPanelNum]) do
		if (tempModelId == VUHDO_ID_TYPE_UNDEFINED) then
			for _, tempTupel in ipairs(tempTypeCount) do
				if (tempTupel[2] == 0) then
					return;
				end
				
				tempGuessId = VUHDO_guessModelIdForType(aPanelNum, tempTupel[1]);
				if (tempGuessId ~= nil) then
					--VUHDO_Msg("Guessing Panel#".. aPanelNum .. " Slot#" .. tempIndex .. " to be ID:" .. tempGuessId);
					VUHDO_PANEL_MODELS[aPanelNum][tempIndex] = tempGuessId;
					VUHDO_setGuessedModel(aPanelNum, tempIndex, true);
					break;
				end
			end
		end
	end
end
