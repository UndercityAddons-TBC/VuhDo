function VUHDO_actionDesignChildOnMouseDown(aHeader)
	VUHDO_startDesignMoving(aHeader:GetParent());
end



--
function VUHDO_actionDesignChildOnMouseUp(aHeader)
	VUHDO_stopDesignMoving(aHeader:GetParent());
end



--
function VUHDO_startDesignMoving(aPanel)
  aPanel:StartMoving();
end



---
function VUHDO_stopDesignMoving(aPanel)
	aPanel:StopMovingOrSizing();
end



--
function VUHDO_panelConfigDoneOnClick()
 	VUHDO_stopPanelConfig();
end



--
function VUHDO_panelConfigNewPanelOnClick()
	local tempCnt;
	for tempCnt = 1, VUHDO_MAX_PANELS do
		if (VUHDO_PANEL_MODELS[tempCnt] == nil) then
			VUHDO_CONFIG_SHOW_RAID = false;
			VUHDO_PANEL_MODELS[tempCnt] = { };
			VUHDO_initDynamicPanelModels();
			VUHDO_redrawAllPanels();
			VuhDoDesignMainPanel:Hide();
			VuhDoDesignMainPanel:Show();
			break;
		end
	end
end



--
function VUHDO_panelDesignMainColorsOnClick()
	VUHDO_toggleMenu(VuhDoFormButtonColor);
end



--
function VUHDO_panelDesignMainSpellsOnClick()
	VUHDO_toggleMenu(VuhDoOptionsSpell);
end



--
function VUHDO_panelDesignMainGeneralOnClick()
	VUHDO_toggleMenu(VuhDoOptionsGeneral);
end



--
function VUHDO_panelDesignShowDesignPanelsOnShow(aCheckButton)
	aCheckButton:SetChecked(not VUHDO_CONFIG_SHOW_RAID);
end



--
function VUHDO_panelDesignShowHealthOnShow(aCheckButton)
	aCheckButton:SetChecked(VUHDO_CONFIG_SHOW_RAID);
end



--
function VUHDO_panelDesignShowDesignPanelsOnClick(aCheckButton)
  VUHDO_CONFIG_SHOW_RAID = false;
  VUHDO_panelDesignShowDesignPanelsOnShow(aCheckButton);
  VUHDO_panelDesignShowHealthOnShow(getglobal(aCheckButton:GetParent():GetName() .. "RaidCheckButtonButton"));
	VUHDO_initDynamicPanelModels();
  VUHDO_redrawAllPanels();
end



--
function VUHDO_panelDesignShowHealthOnClick(aCheckButton)
  VUHDO_CONFIG_SHOW_RAID = true;
  VUHDO_panelDesignShowDesignPanelsOnShow(getglobal(aCheckButton:GetParent():GetName() .. "DesignPanelsCheckButton"));
  VUHDO_panelDesignShowHealthOnShow(aCheckButton);
	VUHDO_clearUndefinedModelEntries();
  VUHDO_reloadUI();
end



--
function VUHDO_panelDesignLoadSetupOnClick(aButton)
	VuhDoFormProfileLoad:Show();
end



--
function VUHDO_panelDesignSaveSetupOnClick(aButton)
	VuhDoFormProfileSave:Show();
end
