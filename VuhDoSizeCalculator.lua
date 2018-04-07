--
function VUHDO_getHeaderTotalHeight(aPanelNum)
	if (VUHDO_isTableHeadersShowing(aPanelNum)) then
			local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];
			return tempBarScaling.headerHeight + tempBarScaling.headerSpacing;
	else
		return 0;
	end
end



--
function VUHDO_determineGridColumn(aPlaceNum, aPanelNum, aRowNum)
	local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];
	local tempOffset, tempReminder, tempFrag;

	if (VUHDO_isLooseOrderingShowing(aPanelNum)) then
		tempOffset = aRowNum - 1;
		tempFrag = math.floor(tempOffset / tempBarScaling.maxRowsWhenLoose);
		return tempFrag + 1;
	else
		tempOffset = aPlaceNum - 1;
		tempFrag = math.floor(tempOffset / tempBarScaling.maxColumnsWhenStructured);
		tempReminder = tempOffset - (tempFrag * tempBarScaling.maxColumnsWhenStructured);
		return tempReminder + 1;
	end
end



--
function VUHDO_determineGridRow(aPlaceNum, aPanelNum)
	local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];
	local tempOffset, tempReminder;

	tempOffset = aPlaceNum - 1;

	return math.floor(tempOffset / tempBarScaling.maxColumnsWhenStructured) + 1;
end



--
function VUHDO_determineGridRowMaxBars(aRowNum, aPanelNum)
	local tempPanelModel = VUHDO_PANEL_DYN_MODELS[aPanelNum];
	local tempIdentifier;
	local tempRow;
	local tempGroup;
	local tempPlaceNum = 1;
	local tempAktBars, tempMaxBars;

	tempMaxBars = 0;
	for _, tempIdentifier in ipairs(tempPanelModel) do
		tempRow = VUHDO_determineGridRow(tempPlaceNum, aPanelNum);

		if (tempRow == aRowNum) then
			tempGroup = VUHDO_getGroupMembers(tempIdentifier);
			tempAktBars = table.getn(tempGroup);
			if (tempAktBars > tempMaxBars) then
				tempMaxBars = tempAktBars;
			end
		end

		tempPlaceNum = tempPlaceNum + 1;
	end

	return tempMaxBars;
end



--
function VUHDO_determineLastRow(aPanelNum)
	return ceil(table.getn(VUHDO_PANEL_DYN_MODELS[aPanelNum])
		/ VUHDO_PANEL_SETUP[aPanelNum]["SCALING"].maxColumnsWhenStructured);
end



--
function VUHDO_getRowHeight(aRowNum, aPanelNum)
	local tempHeight;
	local tempMaxBarsInRow;
	local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];

	tempHeight = VUHDO_getHeaderTotalHeight(aPanelNum);

	if (VUHDO_isConfigPanelShowing()) then
		local tempConfigPanel = VUHDO_getGroupOrderPanel(aPanelNum, 1);

		return tempHeight + tempConfigPanel:GetHeight() * tempConfigPanel:GetScale();
	else
	  tempMaxBarsInRow = VUHDO_determineGridRowMaxBars(aRowNum, aPanelNum);
		tempHeight = tempHeight + tempBarScaling.barHeight * tempMaxBarsInRow;

   	if (tempMaxBarsInRow > 0) then
		  tempHeight = tempHeight + tempBarScaling.rowSpacing * (tempMaxBarsInRow - 1);
	  end
	end

	if (aRowNum < VUHDO_determineLastRow(aPanelNum)) then
		tempHeight = tempHeight + tempBarScaling.headerSpacing; -- @TODO @UGLY eigenen Abstand definieren
	end

	return tempHeight;
end



--
function VUHDO_getRowPos(aPlaceNum, aPanelNum)
	local tempCnt;
	local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];
	local tempRowNum;

	local tempYPos = tempBarScaling.borderGapY;

	-- When ordering loose all rows start from the very top
	if (VUHDO_isLooseOrderingShowing(aPanelNum)) then
		return tempYPos;
	end

	tempRowNum = VUHDO_determineGridRow(aPlaceNum, aPanelNum);
	for tempCnt = 1, tempRowNum - 1 do
		tempYPos = tempYPos + VUHDO_getRowHeight(tempCnt, aPanelNum);
	end

	return tempYPos;
end



function VUHDO_getHealButtonWidth(aPanelNum)
	local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];
	return tempBarScaling.barWidth + VUHDO_getTargetBarWidth(aPanelNum);
end



--
function VUHDO_getBarWidth(aPanelNum)
	--if (VUHDO_isConfigPanelShowing()) then
	--	local tempConfigPanel = VUHDO_getGroupOrderPanel(aPanelNum, 1);
	--	return tempConfigPanel:GetWidth();
  --else
  	return VUHDO_getHealButtonWidth(aPanelNum);
	--end
end



--
function VUHDO_getTargetBarWidth(aPanelNum)
	local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];

	if (not tempBarScaling.showTarget) then
		return 0;
	end

	return tempBarScaling.targetSpacing + tempBarScaling.targetWidth;
end



--
function VUHDO_getColumnPos(aPlaceNum, aPanelNum, aRowNo)
	local tempXPos;
	local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];
	local tempGridColumNo = VUHDO_determineGridColumn(aPlaceNum, aPanelNum, aRowNo);

	local tempColSpacing = VUHDO_getBarWidth(aPanelNum) + tempBarScaling.columnSpacing;

	tempXPos = tempBarScaling.borderGapX;
	tempXPos = tempXPos + (tempGridColumNo - 1) * tempColSpacing;

	return tempXPos;
end



--
function VUHDO_getHeaderPos(aHeaderPlace, aPanelNum)
	local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];

	return VUHDO_getColumnPos(aHeaderPlace, aPanelNum), VUHDO_getRowPos(aHeaderPlace, aPanelNum);
end



--
function VUHDO_getRowOffset(aRowNo, aPanelNum)
	local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];
	local tempRowStep = tempBarScaling.barHeight + tempBarScaling.rowSpacing;

	local tempRowNo = aRowNo;
	if (VUHDO_isLooseOrderingShowing(aPanelNum)) then
		local tempMaxRows = tempBarScaling.maxRowsWhenLoose;
		local tempOffset = tempRowNo - 1;
		local tempFrag = math.floor((tempOffset) / tempMaxRows);
		tempRowNo = (tempOffset - tempFrag * tempMaxRows) + 1;
	end

	return VUHDO_getHeaderTotalHeight(aPanelNum) + (tempRowNo - 1) * tempRowStep;
end



--
function VUHDO_getHealButtonPos(aPlaceNum, aRowNo, aPanelNum)
	local tempXPos = VUHDO_getColumnPos(aPlaceNum, aPanelNum, aRowNo);
	local tempYPos = VUHDO_getRowPos(aPlaceNum, aPanelNum);
	tempYPos = tempYPos + VUHDO_getRowOffset(aRowNo, aPanelNum);

	return tempXPos, tempYPos;
end



--
function VUHDO_getHealPanelWidth(aPanelNum)
	local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];
	local tempAnzColumns;
	local tempAnzPlaces;

	if (VUHDO_isLooseOrderingShowing(aPanelNum)) then
		tempAnzPlaces = table.getn(VUHDO_getPanelUnits(aPanelNum));
		tempAnzColumns = math.floor((tempAnzPlaces - 1) / tempBarScaling.maxRowsWhenLoose) + 1;
	else
		tempAnzPlaces = table.getn(VUHDO_PANEL_DYN_MODELS[aPanelNum]);
		if (tempAnzPlaces < tempBarScaling.maxColumnsWhenStructured) then
			tempAnzColumns = tempAnzPlaces;
		else
			tempAnzColumns = tempBarScaling.maxColumnsWhenStructured;
		end
	end

	if (tempAnzColumns < 1) then
		tempAnzColumns = 1;
	end

	local tempWidth = tempBarScaling.borderGapX * 2;
	tempWidth = tempWidth + tempAnzColumns * VUHDO_getBarWidth(aPanelNum);
	tempWidth = tempWidth + (tempAnzColumns - 1) * tempBarScaling.columnSpacing;

	return tempWidth;
end



--
function VUHDO_getHealPanelHeight(aPanelNum)
	local tempBarScaling = VUHDO_PANEL_SETUP[aPanelNum]["SCALING"];
	if (VUHDO_isLooseOrderingShowing(aPanelNum)) then
		local tempAnzPlaces = table.getn(VUHDO_getPanelUnits(aPanelNum));
		local tempRows;
		if (tempAnzPlaces > tempBarScaling.maxRowsWhenLoose) then
			tempRows = tempBarScaling.maxRowsWhenLoose;
		else
			tempRows = tempAnzPlaces;
		end

		local tempHeight = VUHDO_getHeaderTotalHeight(aPanelNum);
		tempHeight = tempHeight + tempBarScaling.borderGapY * 2;
		tempHeight = tempHeight + tempRows * tempBarScaling.barHeight;
		tempHeight = tempHeight + (tempRows - 1) * tempBarScaling.rowSpacing;
		return tempHeight;
	else
 		local tempLastPlace = table.getn(VUHDO_PANEL_DYN_MODELS[aPanelNum]);
 		local _, tempLastHeaderY = VUHDO_getHeaderPos(tempLastPlace, aPanelNum);
 		local tempLastRowHeight =  VUHDO_getRowHeight(VUHDO_determineGridRow(tempLastPlace, aPanelNum), aPanelNum);
 		return tempLastHeaderY + tempLastRowHeight + tempBarScaling.borderGapY;
	end
end



