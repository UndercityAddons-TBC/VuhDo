local VUHDO_VARIABLES_LOADED = false;

local VUHDO_UPDATE_RANGE_TIMER = 1;
local VUHDO_REFRESH_DRAG_DELAY = 0.05;
local VUHDO_REFRESH_DRAG_TIMER = VUHDO_REFRESH_DRAG_DELAY;
local VUHDO_CUSTOMIZE_TIMER = 0;
local VUHDO_LOST_CONTROL = false;
local VUHDO_RELOAD_AFTER_BATTLE = false;
local VUHDO_RELOAD_UI_TIMER = 0;

local VUHDO_LAG_MS = 0;
local VUHDO_RELOAD_LAG_DELAY = 1;
local VUHDO_RELOAD_LAG_TIMER = VUHDO_RELOAD_LAG_DELAY

VUHDO_REFRESH_TOOLTIP_DELAY = 0.5;
VUHDO_REFRESH_TOOLTIP_TIMER = VUHDO_REFRESH_TOOLTIP_DELAY;

VUHDO_REFRESH_BUFFS_TIMER = 0;


VUHDO_CONFIG = nil;
VUHDO_PANEL_SETUP = nil;
VUHDO_SPELL_ASSIGNMENTS = nil;
VUHDO_IN_FIGHT = false;
VUHDO_IS_RELOADING = false;

VUHDO_RELOAD_RAID_TIMER = 0
VUHDO_MAINTANK_NAMES = { };
VUHDO_RESSING_NAMES = { };


--@TESTING
local VUHDO_IS_UPDATING = false;
local VUHDO_LAST_TIME_NO_UPDATE = GetTime();
local VUHDO_EVENT_COUNT = 0;
local VUHDO_LAST_TIME_NO_EVENT = GetTime();
--


--
function VUHDO_OnLoad(anInstance)
  anInstance:RegisterEvent("VARIABLES_LOADED");
  anInstance:RegisterEvent("PLAYER_ENTERING_WORLD");
  --anInstance:RegisterEvent("PLAYER_LEAVING_WORLD");
  anInstance:RegisterEvent("UNIT_HEALTH");
  anInstance:RegisterEvent("UNIT_MAXHEALTH");
	anInstance:RegisterEvent("UNIT_AURA");
	anInstance:RegisterEvent("UNIT_TARGET");

	anInstance:RegisterEvent("PLAYER_REGEN_ENABLED");
	anInstance:RegisterEvent("PLAYER_REGEN_DISABLED");

	anInstance:RegisterEvent("RAID_ROSTER_UPDATE");
  anInstance:RegisterEvent("PARTY_MEMBERS_CHANGED");
  anInstance:RegisterEvent("UNIT_PET");
  anInstance:RegisterEvent("CHAT_MSG_ADDON");
  anInstance:RegisterEvent("RAID_TARGET_UPDATE");
  anInstance:RegisterEvent("LEARNED_SPELL_IN_TAB");

	anInstance:RegisterEvent("UNIT_DISPLAYPOWER");
	--anInstance:RegisterEvent("UNIT_ENERGY");
	--anInstance:RegisterEvent("UNIT_MAXENERGY");
	anInstance:RegisterEvent("UNIT_MANA");
	anInstance:RegisterEvent("UNIT_MAXMANA");
	--anInstance:RegisterEvent("UNIT_RAGE");
	--anInstance:RegisterEvent("UNIT_MAXRAGE");
	--anInstance:RegisterEvent("UNIT_HAPPINESS");
	--anInstance:RegisterEvent("UNIT_MAXHAPPINESS");
	--anInstance:RegisterEvent("UNIT_FOCUS");
	--anInstance:RegisterEvent("UNIT_MAXFOCUS");

	anInstance:RegisterEvent("UNIT_SPELLCAST_STOP");
	anInstance:RegisterEvent("UNIT_SPELLCAST_FAILED");
	anInstance:RegisterEvent("UNIT_SPELLCAST_SENT");
	anInstance:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");

  SLASH_VUHDO1 = "/vuhdo";
  SLASH_VUHDO2 = "/vd";
  SlashCmdList["VUHDO"] = function(msg)
  	VUHDO_slashCmd(msg);
  end

	VUHDO_Msg("VuhDo v".. VUHDO_VERSION .. ". by Iza@Gilneas (use /vd)");
end



--
function VUHDO_convertMainTanks()
	local tempIndex, tempName;

	VUHDO_MAINTANKS = { };
	for tempIndex, tempName in pairs(VUHDO_MAINTANK_NAMES) do
		VUHDO_MAINTANKS[tempIndex] = VUHDO_getUnitFromName(tempName);
	end
end



--
local VUHDO_LOAD_PROFILE_TIMER;
function VUHDO_countdownProfile(aProfileName, aProfileText)
	VuhDoYesNoFrameText:SetText("Style " .. aProfileText .. " detected\nActivate profile \"" .. aProfileText .. "\" in 5 secs.");
	VuhDoYesNoFrame:SetAttribute("callback", VUHDO_yesNoActivateProfileCallback);
	VuhDoYesNoFrame:Show();

	VUHDO_LOAD_PROFILE_TIMER = 5;
end



--
local VUHDO_CUR_PROFILE_TYPE = VUHDO_PROFILE_TYPE_UNDEFINED;
function VUHDO_checkProfileChange()
	local tempNewType;

	if (UnitInRaid("player")) then
		if (VUHDO_isInBattleground()) then
			tempNewType = VUHDO_PROFILE_TYPE_BG;
		else
			tempNewType = VUHDO_PROFILE_TYPE_RAID;
		end
	else
		if (GetNumPartyMembers() > 1) then
			tempNewType = VUHDO_PROFILE_TYPE_PARTY;
		else
			tempNewType = VUHDO_PROFILE_TYPE_SOLO;
		end
	end

	-- Profile already active?
	if (VUHDO_CUR_PROFILE_TYPE == tempNewType) then
		return;
	end

	-- No profile selected for party type?
	if (tempNewType == VUHDO_PROFILE_TYPE_BG) then
		if (VUHDO_PROFILES["NAME_BG"] ~= nil) then
			VUHDO_countdownProfile(VUHDO_PROFILES["NAME_BG"], "Battleground");
		else
			return;
		end
	elseif (tempNewType == VUHDO_PROFILE_TYPE_RAID and VUHDO_PROFILES["NAME_RAID"] == nil) then
		if (VUHDO_PROFILES["NAME_RAID"] ~= nil) then
			VUHDO_countdownProfile(VUHDO_PROFILES["NAME_RAID"], "Raid");
		else
			return;
		end
	elseif (tempNewType == VUHDO_PROFILE_TYPE_PARTY and VUHDO_PROFILES["NAME_PARTY"] == nil) then
		if (VUHDO_PROFILES["NAME_PARTY"] ~= nil) then
			VUHDO_countdownProfile(VUHDO_PROFILES["NAME_PARTY"], "Party");
		else
			return;
		end
	elseif (tempNewType == VUHDO_PROFILE_TYPE_SOLO and VUHDO_PROFILES["NAME_SOLO"] == nil) then
		if (VUHDO_PROFILES["NAME_SOLO"] ~= nil) then
			VUHDO_countdownProfile(VUHDO_PROFILES["NAME_SOLO"], "Solo");
		else
			return;
		end
	end
end



--
function VUHDO_handleEvent(anInstance, anEvent, anArg1, anArg2, anArg3, anArg4, anArg5, anArg6, anArg7, anArg8, anArg9, anArg10, anArg11, anArg12)

	if ("COMBAT_LOG_EVENT_UNFILTERED" == anEvent) then
		VUHDO_parseCombatLogEvent(anArg1, anArg2, anArg3, anArg4, anArg5, anArg6, anArg7, anArg8, anArg9, anArg10, anArg11, anArg12);
	elseif ("UNIT_HEALTH" == anEvent) then
		local tempInfo = VUHDO_RAID[anArg1];
		if (tempInfo ~= nil) then
			if (GetTime() <= VUHDO_LAG_MS + tempInfo.clTimestamp) then
				--VUHDO_Msg("Voided health event");
				return;
			end

			VUHDO_updateHealth(anArg1, VUHDO_UPDATE_HEALTH);
			VUHDO_sortRaidTable();
		end
	elseif ("UNIT_MAXHEALTH" == anEvent) then
		VUHDO_updateHealth(anArg1, VUHDO_UPDATE_HEALTH_MAX);
		VUHDO_sortRaidTable();
	elseif ("UNIT_AURA" == anEvent) then
		VUHDO_updateHealth(anArg1, VUHDO_UPDATE_DEBUFF);
	elseif ("UNIT_TARGET" == anEvent) then
		VUHDO_updateHealth(anArg1, VUHDO_UPDATE_TARGET);
	elseif ("UNIT_DISPLAYPOWER" == anEvent) then
		VUHDO_setHealth(anArg1, VUHDO_UPDATE_POWER, tonumber(UnitPowerType(anArg1)));
		VUHDO_updateHealth(anArg1, VUHDO_UPDATE_POWER_MAX, tonumber(UnitPowerType(anArg1)));
	--elseif ("UNIT_ENERGY" == anEvent) then
	--	VUHDO_updateHealth(anArg1, VUHDO_UPDATE_POWER, VUHDO_UNIT_POWER_ENERGY);
	--elseif ("UNIT_MAXENERGY" == anEvent) then
	--	VUHDO_updateHealth(anArg1, VUHDO_UPDATE_POWER_MAX, VUHDO_UNIT_POWER_ENERGY);
	elseif ("UNIT_MANA" == anEvent) then
		VUHDO_updateHealth(anArg1, VUHDO_UPDATE_POWER, VUHDO_UNIT_POWER_MANA);
	elseif ("UNIT_MAXMANA" == anEvent) then
		VUHDO_updateHealth(anArg1, VUHDO_UPDATE_POWER_MAX, VUHDO_UNIT_POWER_MANA);
	--elseif ("UNIT_RAGE" == anEvent) then
	--	VUHDO_updateHealth(anArg1, VUHDO_UPDATE_POWER, VUHDO_UNIT_POWER_RAGE);
	--elseif ("UNIT_MAXRAGE" == anEvent) then
	--	VUHDO_updateHealth(anArg1, VUHDO_UPDATE_POWER_MAX, VUHDO_UNIT_POWER_RAGE);
	--elseif ("UNIT_HAPPINESS" == anEvent) then
	--	VUHDO_updateHealth(anArg1, VUHDO_UPDATE_POWER, VUHDO_UNIT_POWER_HAPPINESS);
	--elseif ("UNIT_MAXHAPPINESS" == anEvent) then
	--	VUHDO_updateHealth(anArg1, VUHDO_UPDATE_POWER_MAX, VUHDO_UNIT_POWER_HAPPINESS);
	--elseif ("UNIT_FOCUS" == anEvent) then
	--	VUHDO_updateHealth(anArg1, VUHDO_UPDATE_POWER, VUHDO_UNIT_POWER_FOCUS);
	--elseif ("UNIT_MAXFOCUS" == anEvent) then
	--	VUHDO_updateHealth(anArg1, VUHDO_UPDATE_POWER_MAX, VUHDO_UNIT_POWER_FOCUS);
	elseif ("UNIT_PET" == anEvent) then
		if (VUHDO_RELOAD_RAID_TIMER <= 0) then
			VUHDO_RELOAD_RAID_TIMER = VUHDO_RELOAD_RAID_DELAY;
		end
	elseif ("RAID_TARGET_UPDATE" == anEvent) then
		VUHDO_CUSTOMIZE_TIMER = 0.1;
	elseif ("PARTY_MEMBERS_CHANGED" == anEvent
		   or "RAID_ROSTER_UPDATE" == anEvent) then
		VUHDO_RELOAD_RAID_TIMER = VUHDO_RELOAD_RAID_DELAY;
		--VUHDO_checkProfileChange();
	elseif ("PLAYER_ENTERING_WORLD" == anEvent) then
  	VUHDO_initPanelModels();
		VUHDO_clearUndefinedModelEntries();
		VUHDO_initFromSpellbook();
		VUHDO_initBuffsFromSpellBook();

		VUHDO_RELOAD_UI_TIMER = VUHDO_RELOAD_RAID_DELAY;

	elseif ("LEARNED_SPELL_IN_TAB" == anEvent) then
		VUHDO_BUFF_SETTINGS = {};
		VUHDO_Msg("You've learned a new spell, your buff settings have been reset!", 1, 0.4, 0.4);
		VUHDO_initFromSpellbook();
		VUHDO_initBuffsFromSpellBook();
		VUHDO_reloadBuffPanel();

	elseif ("VARIABLES_LOADED" == anEvent) then
		VUHDO_loadVariables();
	elseif ("PLAYER_REGEN_ENABLED" == anEvent) then
		VUHDO_IN_FIGHT = false;
		if (VUHDO_RELOAD_RAID_TIMER <= 0) then
			VUHDO_RELOAD_RAID_TIMER = VUHDO_RELOAD_RAID_DELAY_QUICK;
		end
	elseif ("PLAYER_REGEN_DISABLED" == anEvent) then
		VUHDO_IN_FIGHT = true;
	elseif ("CHAT_MSG_ADDON" == anEvent) then
		VUHDO_parseAddonMessage(anArg1, anArg2, anArg3, anArg4);
	elseif ("UNIT_SPELLCAST_STOP" == anEvent
			or "UNIT_SPELLCAST_FAILED" == anEvent) then
		VUHDO_spellcastStop(anArg1);
	elseif ("UNIT_SPELLCAST_SENT" == anEvent) then
		VUHDO_spellcastSent(anArg1, anArg2, anArg3, anArg4);
	else
		VUHDO_Msg("Error: Unexpected event: " .. anEvent, 1, 0.4, 0.4);
	end
end



--
function VUHDO_OnEvent(anInstance, anEvent, anArg1, anArg2, anArg3, anArg4, anArg5, anArg6, anArg7, anArg8, anArg9, anArg10, anArg11, anArg12)
	VUHDO_EVENT_COUNT = VUHDO_EVENT_COUNT + 1;

	VUHDO_handleEvent(anInstance, anEvent, anArg1, anArg2, anArg3, anArg4, anArg5, anArg6, anArg7, anArg8, anArg9, anArg10, anArg11, anArg12);

	VUHDO_EVENT_COUNT = VUHDO_EVENT_COUNT - 1;

	if (VUHDO_EVENT_COUNT < 0) then
		VUHDO_EVENT_COUNT = 0;
	end

	if (VUHDO_EVENT_COUNT == 0) then
		VUHDO_LAST_TIME_NO_EVENT = GetTime();
	end
end



--
function VUHDO_slashCmd(aCommand)

	local tempParsedTexts = VUHDO_textParse(aCommand);
	local tempCommandWord = strlower(tempParsedTexts[1]);

	if (strfind(tempCommandWord, "abo")) then
		VUHDO_toggleMenu(VuhDoOptionsMain);

	elseif (strfind(tempCommandWord, "gen")) then
		VUHDO_toggleMenu(VuhDoOptionsGeneral);

	elseif (strfind(tempCommandWord, "spe"))then
		VUHDO_toggleMenu(VuhDoOptionsSpell);

	elseif (strfind(tempCommandWord, "col"))then
		VUHDO_toggleMenu(VuhDoFormButtonColor);

	elseif (strfind(tempCommandWord, "pan") or strfind(tempCommandWord, "opt")) then
		if (VUHDO_IS_PANEL_CONFIG) then
			VUHDO_stopPanelConfig();
		else
			VUHDO_startPanelConfig();
		end

	elseif (strfind(tempCommandWord, "buf"))then
		if (VuhDoBuffSetupMainFrame == nil or not VuhDoBuffSetupMainFrame:IsVisible()) then
			VUHDO_buildAllBuffSetupGenerericPanel();
		else
			VuhDoBuffSetupMainFrame:Hide();
		end

	elseif (strfind(tempCommandWord, "res")) then
		local tempPanelNum;
		for tempPanelNum = 1, VUHDO_MAX_PANELS do
			VUHDO_PANEL_SETUP[tempPanelNum]["POSITION"] = nil;
		end
		VUHDO_loadDefaultPanelSetup();
		VUHDO_redrawAllPanels();
		VUHDO_Msg(VUHDO_I18N_PANELS_RESET);

	elseif (strfind(tempCommandWord, "lock")) then
		VUHDO_CONFIG["LOCK_PANELS"] = not VUHDO_CONFIG["LOCK_PANELS"];
		local tempMessage = VUHDO_I18N_LOCK_PANELS_PRE;
		if (VUHDO_CONFIG["LOCK_PANELS"]) then
			tempMessage = tempMessage .. VUHDO_I18N_LOCK_PANELS_LOCKED;
		else
			tempMessage = tempMessage .. VUHDO_I18N_LOCK_PANELS_UNLOCKED;
		end
		VUHDO_Msg(tempMessage);

	elseif (strfind(tempCommandWord, "show")) then
		VUHDO_CONFIG["SHOW_PANELS"] = true;
		VUHDO_redrawAllPanels();
		VUHDO_Msg(VUHDO_I18N_PANELS_SHOWN);

	elseif (strfind(tempCommandWord, "hide")) then
		VUHDO_CONFIG["SHOW_PANELS"] = false;
		VUHDO_redrawAllPanels();
		VUHDO_Msg(VUHDO_I18N_PANELS_HIDDEN);

	elseif (strfind(tempCommandWord, "toggle")) then
		VUHDO_CONFIG["SHOW_PANELS"] = not VUHDO_CONFIG["SHOW_PANELS"];
		if (VUHDO_CONFIG["SHOW_PANELS"]) then
			VUHDO_Msg(VUHDO_I18N_PANELS_SHOWN);
		else
			VUHDO_Msg(VUHDO_I18N_PANELS_HIDDEN);
		end
		VUHDO_redrawAllPanels();

	elseif (strfind(tempCommandWord, "load")) then
		local tempName = VUHDO_appendAllStrings(tempParsedTexts, 2);
		if (tempName ~= nil and tempName ~= "") then
			if (VUHDO_PROFILES["DATA"][tempName] ~= nil) then
				VUHDO_PROFILES["NAME_CURRENT"] = tempName;
				local tempData = VUHDO_PROFILES["DATA"][tempName];
				VUHDO_CONFIG = VUHDO_deepCopyTable(tempData["CONFIG"]);
				VUHDO_PANEL_SETUP = VUHDO_deepCopyTable(tempData["PANELS"]);
				VUHDO_reloadUI();
				VUHDO_Msg(VUHDO_I18N_PROFILE_ENABLED_1 .. tempName .. VUHDO_I18N_PROFILE_ENABLED_2);
			else
				VUHDO_Msg(VUHDO_I18N_PROFILE_NO_EXIST_1 .. tempName .. VUHDO_I18N_PROFILE_NO_EXIST_2, 1, 0.4, 0.4);
			end
		else
			VUHDO_toggleMenu(VuhDoFormProfileLoad);
		end

	elseif (strfind(tempCommandWord, "save")) then
		if (tempParsedTexts[2] ~= nil and tempParsedTexts[2] ~= "") then

			local tempName = VUHDO_appendAllStrings(tempParsedTexts, 2);

			VUHDO_PROFILES["DATA"][tempName] = {
				["CONFIG"] = VUHDO_deepCopyTable(VUHDO_CONFIG),
				["PANELS"] = VUHDO_deepCopyTable(VUHDO_PANEL_SETUP),
			};

			VUHDO_PROFILES["NAME_CURRENT"] = tempName;
			VUHDO_Msg(VUHDO_I18N_SAVED_PROFILE_AS .. "|cffffe566" .. tempName .. "|r");
		else
			VUHDO_toggleMenu(VuhDoFormProfileSave);
		end

	elseif (strfind(tempCommandWord, "cast") or strfind(tempCommandWord, "mt")) then
		VUHDO_ctraBroadCastMaintanks();
		VUHDO_Msg(VUHDO_I18N_MTS_BROADCASTED);

	elseif (strfind(tempCommandWord, "mm")
		or strfind(tempCommandWord, "map")) then

		VUHDO_CONFIG["SHOW_MINIMAP"] = not VUHDO_CONFIG["SHOW_MINIMAP"];
		VUHDO_initShowMinimap();
		local tempMessage = VUHDO_I18N_MM_ICON;
		if (VUHDO_CONFIG["SHOW_MINIMAP"]) then
			tempMessage = tempMessage .. VUHDO_I18N_CHAT_SHOWN;
		else
			tempMessage = tempMessage .. VUHDO_I18N_CHAT_HIDDEN;
		end

		VUHDO_Msg(tempMessage);

	elseif (aCommand == "?"
		or strfind(tempCommandWord, "help")
		or aCommand == "") then
		local tempLines = VUHDO_splitString(VUHDO_I18N_COMMAND_LIST, "§");
		local tempCurLine;
		for _, tempCurLine in ipairs(tempLines) do
			VUHDO_MsgC(tempCurLine);
		end
	else
		VUHDO_Msg(VUHDO_I18N_BAD_COMMAND, 1, 0.4, 0.4);
	end

	VUHDO_reloadUI();
end



--
function VUHDO_loadSpellArray()
	if (VUHDO_SPELL_ASSIGNMENTS ~= nil) then
		return;
	end

	VUHDO_assignDefaultSpells();
end



--
function VUHDO_playerTargetDropdownOnLoad()
	UIDropDownMenu_Initialize(VuhDoPlayerTargetDropDown, VUHDO_playerTargetDropDown_Initialize, "MENU", 1);
end



--
local VUHDO_menuUnit = nil;
function VUHDO_setMenuUnit(aButton)
	VUHDO_menuUnit = aButton:GetAttribute("unit");
end



--
function VUHDO_ptBuffSelected(aName, aCategName)
	VUHDO_Msg("Buff |cffffe566" .. aCategName .. "|r has been assigned to |cffffe566" .. aName .. "|r");
	VUHDO_BUFF_SETTINGS[aCategName].name = aName;
	VUHDO_reloadBuffPanel();
end



--
function VUHDO_playerTargetDropDown_Initialize(aLevel)
	local tempInfo;

	if (VUHDO_menuUnit == nil or VUHDO_RAID[VUHDO_menuUnit] == nil) then
		return
	end

	local tempName = VUHDO_RAID[VUHDO_menuUnit].name;

	if (aLevel > 1) then
		local tempUniqueBuffs = VUHDO_getAllUniqueSpells();
		local tempBuffName;

		for _, tempBuffName in pairs(tempUniqueBuffs) do
			local tempCategory = strsub(VUHDO_getBuffCategory(tempBuffName), 3);
			tempInfo = UIDropDownMenu_CreateInfo();
			tempInfo.text = tempBuffName;
			tempInfo.arg1 = tempName;
			tempInfo.arg2 = tempCategory;
			tempInfo.icon = VUHDO_BUFFS[tempBuffName].icon;
			tempInfo.func = VUHDO_ptBuffSelected;
			tempInfo.checked = VUHDO_BUFF_SETTINGS[tempCategory].name == tempName;
			tempInfo.level = 2;
			UIDropDownMenu_AddButton(tempInfo, 2);
		end

		return;
	end


	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = VUHDO_I18N_ROLE;
	tempInfo.text = tempInfo.text .. " (" .. tempName .. ")";

	tempInfo.isTitle = true;
	UIDropDownMenu_AddButton(tempInfo);

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = VUHDO_I18N_MAIN_ASSIST;
	if (VUHDO_menuUnit ~= nil and VUHDO_RAID[VUHDO_menuUnit] ~= nil) then
		tempInfo.checked = VUHDO_PLAYER_TARGETS[tempName] ~= nil;
	else
		tempInfo.checked = false;
	end
	tempInfo.arg1 = VUHDO_menuUnit;
	tempInfo.func = VUHDO_playerTargetItemSelected;
	UIDropDownMenu_AddButton(tempInfo);

	if (VUHDO_getPlayerRank() >= 1) then
		tempInfo = UIDropDownMenu_CreateInfo();
		tempInfo.text = "";
		tempInfo.isTitle = true;
		UIDropDownMenu_AddButton(tempInfo);

		local tempCnt;
		for tempCnt = 1, VUHDO_MAX_MTS do
			tempInfo = UIDropDownMenu_CreateInfo();
			tempInfo.text = "MT #" .. tempCnt;

			tempInfo.checked = VUHDO_MAINTANK_NAMES[tempCnt] == tempName;
			tempInfo.arg1 = tempCnt;
			tempInfo.arg2 = VUHDO_menuUnit;
			tempInfo.func = VUHDO_mainTankItemSelected;

			if (tempInfo.checked) then
				tempInfo.text = tempInfo.text .. " (" .. VUHDO_MAINTANK_NAMES[tempCnt] .. ")";
				tempInfo.textR = 1;
				tempInfo.textG = 0.898;
				tempInfo.textB = 0.4;
			elseif (VUHDO_MAINTANK_NAMES[tempCnt] == nil) then
				tempInfo.textR = 0.4;
				tempInfo.textG = 1;
				tempInfo.textB = 0.4;
			else
				tempInfo.text = tempInfo.text .. " (" .. VUHDO_MAINTANK_NAMES[tempCnt] .. ")";
				tempInfo.textR = 1;
				tempInfo.textG = 0.7;
				tempInfo.textB = 0.2;
			end

			UIDropDownMenu_AddButton(tempInfo);
		end
	end

	if (table.getn(VUHDO_getAllUniqueSpells()) > 0) then
		tempInfo = UIDropDownMenu_CreateInfo();
		tempInfo.text = "";
		tempInfo.isTitle = true;
		UIDropDownMenu_AddButton(tempInfo);

		tempInfo = UIDropDownMenu_CreateInfo();
		tempInfo.text = VUHDO_I18N_SET_BUFF;
		tempInfo.hasArrow = true;
		UIDropDownMenu_AddButton(tempInfo);
	end
end



--
function VUHDO_playerTargetItemSelected(aUnit)
	local tempName = VUHDO_RAID[aUnit].name;
	if (VUHDO_PLAYER_TARGETS[tempName] ~= nil) then
		VUHDO_PLAYER_TARGETS[tempName] = nil;
	else
		VUHDO_PLAYER_TARGETS[tempName] = true;
	end

	-- Reload assist group also
	VUHDO_reloadUI();
end



--
function VUHDO_mainTankItemSelected(aMtPos, aUnit)
	local tempName = VUHDO_RAID[aUnit].name;

	-- remove Maintankt?
	if (VUHDO_MAINTANK_NAMES[aMtPos] == tempName) then
		VUHDO_sendCtraMessage("R " .. tempName);
	else
		if (VUHDO_MAINTANK_NAMES[aMtPos] ~= nil) then
			VUHDO_sendCtraMessage("R " .. VUHDO_MAINTANK_NAMES[aMtPos]);
		end

		VUHDO_sendCtraMessage("SET " .. aMtPos .. " " .. tempName);
	end

	VUHDO_reloadUI();
end



--
function VUHDO_minimapLeftClick()
	VUHDO_slashCmd("panels");
end



--
function VUHDO_minimapDropdownOnLoad()
	UIDropDownMenu_Initialize(VuhDoMinimapDropDown, VUHDO_miniMapDropDown_Initialize, "MENU", 1);
end




--
function VUHDO_minimapRightClick()
	ToggleDropDownMenu(1, nil, VuhDoMinimapDropDown, "VuhDoMinimapButton", 0, -5);
end



--
function VUHDO_mmProfileSelected(aProfile)
	VUHDO_slashCmd("load " .. aProfile);
end



--
function VUHDO_miniMapDropDown_Initialize(aLevel)
	local tempIndex, tempMenuItem;
	local tempInfo;

	if (VUHDO_CONFIG == nil) then
		return;
	end

	if (aLevel > 1) then
		local tempName;

		for tempName, _ in pairs(VUHDO_PROFILES["DATA"]) do
			tempInfo = UIDropDownMenu_CreateInfo();
			tempInfo.text = tempName;
			tempInfo.arg1 = tempName;
			tempInfo.func = VUHDO_mmProfileSelected;
			tempInfo.checked = VUHDO_PROFILES["NAME_CURRENT"] == tempName;
			tempInfo.level = 2;
			UIDropDownMenu_AddButton(tempInfo, 2);
		end
		return;
	end

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = VUHDO_I18N_VUHDO_OPTIONS;
	tempInfo.isTitle = true;
	UIDropDownMenu_AddButton(tempInfo);

	for tempIndex, tempMenuItem in ipairs(VUHDO_MINIMAP_DROPDOWN) do
		tempInfo = UIDropDownMenu_CreateInfo();
		tempInfo.text = tempMenuItem.text;
		tempInfo.checked = nil;
		tempInfo.func = VUHDO_minimapItemSelected;
		tempInfo.icon = tempMenuItem.icon;
		tempInfo.arg1 = "" .. tempIndex;
		tempInfo.tCoordLeft = 0;
		tempInfo.tCoordRight = 1;
		tempInfo.tCoordTop = 0;
		tempInfo.tCoordBottom = 1;
		UIDropDownMenu_AddButton(tempInfo);
	end

	if (VUHDO_getPlayerRank() >= 1) then
		tempInfo = UIDropDownMenu_CreateInfo();
		tempInfo.text = "";
		tempInfo.isTitle = true;
		UIDropDownMenu_AddButton(tempInfo);

		tempInfo = UIDropDownMenu_CreateInfo();
		tempInfo.text = VUHDO_I18N_BROADCAST_MTS;
		tempInfo.checked = nil;
		tempInfo.func = VUHDO_minimapItemSelected;
		tempInfo.arg1 = "BROAD";
		UIDropDownMenu_AddButton(tempInfo);
	end

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = "";
	tempInfo.isTitle = true;
	UIDropDownMenu_AddButton(tempInfo);

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = VUHDO_I18N_LOAD_PROFILE;
	tempInfo.hasArrow = true;
	UIDropDownMenu_AddButton(tempInfo);

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = VUHDO_I18N_SAVE_PROFILE_AS;
	tempInfo.func = VUHDO_minimapItemSelected;
	tempInfo.arg1 = "SAVE";

	UIDropDownMenu_AddButton(tempInfo);

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = "";
	tempInfo.isTitle = true;
	UIDropDownMenu_AddButton(tempInfo);

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = VUHDO_I18N_TOGGLES;
	tempInfo.isTitle = true;
	UIDropDownMenu_AddButton(tempInfo);

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = VUHDO_I18N_LOCK_PANELS;
	tempInfo.keepShownOnClick = true;
	tempInfo.arg1 = "LOCK";
	tempInfo.func = VUHDO_minimapItemSelected;
	tempInfo.checked = VUHDO_CONFIG["LOCK_PANELS"];
	UIDropDownMenu_AddButton(tempInfo);

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = VUHDO_I18N_SHOW_PANELS;
	tempInfo.keepShownOnClick = true;
	tempInfo.arg1 = "SHOW";
	tempInfo.func = VUHDO_minimapItemSelected;
	tempInfo.checked = VUHDO_CONFIG["SHOW_PANELS"];
	UIDropDownMenu_AddButton(tempInfo);

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = VUHDO_I18N_SHOW_BUFF_WATCH;
	tempInfo.keepShownOnClick = true;
	tempInfo.arg1 = "BUFF";
	tempInfo.func = VUHDO_minimapItemSelected;
	tempInfo.checked = VUHDO_BUFF_SETTINGS["CONFIG"]["SHOW"];
	UIDropDownMenu_AddButton(tempInfo);

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = VUHDO_I18N_MM_BUTTON;
	tempInfo.keepShownOnClick = true;
	tempInfo.arg1 = "MINIMAP";
	tempInfo.func = VUHDO_minimapItemSelected;
	tempInfo.checked = VUHDO_CONFIG["SHOW_MINIMAP"];
	UIDropDownMenu_AddButton(tempInfo);

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = "";
	tempInfo.isTitle = true;
	UIDropDownMenu_AddButton(tempInfo);


	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = VUHDO_I18N_ABOUT;
	tempInfo.func = VUHDO_minimapItemSelected;
	tempInfo.arg1 = "ABOUT";
	UIDropDownMenu_AddButton(tempInfo);

	tempInfo = UIDropDownMenu_CreateInfo();
	tempInfo.text = VUHDO_I18N_CLOSE;
	UIDropDownMenu_AddButton(tempInfo);
end



--
function VUHDO_minimapItemSelected(anId)
	if ("LOCK" == anId) then
		VUHDO_slashCmd("lock");
	elseif ("MINIMAP" == anId) then
		VUHDO_slashCmd("minimap");
	elseif ("SHOW" == anId) then
		VUHDO_slashCmd("toggle");
	elseif ("SAVE" == anId) then
		VUHDO_slashCmd("save");
	elseif ("BROAD" == anId) then
		VUHDO_slashCmd("cast");
	elseif ("BUFF" == anId) then
		VUHDO_BUFF_SETTINGS["CONFIG"]["SHOW"] = not VUHDO_BUFF_SETTINGS["CONFIG"]["SHOW"];
		VUHDO_reloadBuffPanel();
	elseif ("1" == anId) then
		VUHDO_slashCmd("spells");
	elseif ("2" == anId) then
		VUHDO_slashCmd("panels");
	elseif ("3" == anId) then
		VUHDO_slashCmd("general");
	elseif ("4" == anId) then
		VUHDO_slashCmd("colors");
	elseif ("5" == anId) then
		VUHDO_slashCmd("buffs");
	elseif ("ABOUT" == anId) then
		VUHDO_slashCmd("about");
	end
end



--
function VUHDO_initMinimap()
  if (VUHDO_MM_SETTINGS == nil) then
  	VUHDO_MM_SETTINGS = { };
  end

  MyMinimapButton:Create("VuhDo", VUHDO_MM_SETTINGS, VUHDO_MM_LAYOUT);
  MyMinimapButton:SetLeftClick("VuhDo", VUHDO_minimapLeftClick);
  MyMinimapButton:SetRightClick("VuhDo", VUHDO_minimapRightClick);
  VUHDO_initShowMinimap();
end



function VUHDO_initShowMinimap()
	if (VUHDO_CONFIG["SHOW_MINIMAP"]) then
		VuhDoMinimapButton:Show();
	else
		VuhDoMinimapButton:Hide();
	end
end



--
function VUHDO_loadVariables()
	_, VUHDO_PLAYER_CLASS = UnitClass("player");
	VUHDO_PLAYER_NAME = UnitName("player");

  VUHDO_loadSpellArray();
	VUHDO_loadDefaultPanelSetup();
	VUHDO_initBuffSettings();
	VUHDO_loadDefaultConfig();
	VUHDO_initProfiles();
	VUHDO_initMinimap();

	VUHDO_VARIABLES_LOADED = true;
end



--
function VUHDO_yesNoOnShow()
	SetPortraitTexture(getglobal("VuhDoYesNoFramePortrait"), "player");
end



--
function VUHDO_OnUpdate(anInstance, aTimeDelta)
	if (not VUHDO_VARIABLES_LOADED) then
		return;
	end

	if (VUHDO_IS_UPDATING) then
		if (VUHDO_LAST_TIME_NO_UPDATE + 0.5 > GetTime()) then
			--VUHDO_Msg("Concurrent updates voided!", 1, 0.4, 0.4);
			return;
		end
	end

	if (VUHDO_LAST_TIME_NO_EVENT + 0.5 < GetTime()) then
		VUHDO_LAST_TIME_NO_EVENT = GetTime();
		VUHDO_EVENT_COUNT = 0;
	end

	if (VUHDO_EVENT_COUNT > 0) then
		--VUHDO_Msg("Concurrent event while updating!", 1, 0.4, 0.4);
		return;
	end

	VUHDO_IS_UPDATING = true;

	if (VUHDO_RELOAD_AFTER_BATTLE and not VUHDO_isInFight()) then
		VUHDO_RELOAD_AFTER_BATTLE = false;

		if (VUHDO_RELOAD_RAID_TIMER <= 0) then
			VUHDO_RELOAD_RAID_TIMER = VUHDO_RELOAD_RAID_DELAY_QUICK;
		end
	end

	-- Reload raid roster?
	if (VUHDO_RELOAD_RAID_TIMER > 0 and not VUHDO_isConfigPanelShowing()) then
		VUHDO_RELOAD_RAID_TIMER = VUHDO_RELOAD_RAID_TIMER - aTimeDelta;
		if (VUHDO_RELOAD_RAID_TIMER <= 0) then

			if (VUHDO_IS_RELOADING) then
				VUHDO_RELOAD_RAID_TIMER = VUHDO_RELOAD_RAID_DELAY_QUICK;
			else
				if (VUHDO_isInFight()) then
					VUHDO_RELOAD_AFTER_BATTLE = true;

					VUHDO_IS_RELOADING = true;
					VUHDO_reloadRaidMembers();
					VUHDO_IS_RELOADING = false;

					VUHDO_CUSTOMIZE_TIMER = aTimeDelta - 0.001;
				else
					VUHDO_refreshUI();
				end
			end
		end
	end

	-- reload UI?
	if (VUHDO_RELOAD_UI_TIMER > 0) then
		VUHDO_RELOAD_UI_TIMER = VUHDO_RELOAD_UI_TIMER - aTimeDelta;
		if (VUHDO_RELOAD_UI_TIMER <= 0) then
			if (VUHDO_IS_RELOADING) then
				VUHDO_RELOAD_UI_TIMER = VUHDO_RELOAD_RAID_DELAY_QUICK;
			else
				VUHDO_reloadUI();
			end
		end
	end

	-- refresh range/charmed/aggro?
	if (VUHDO_UPDATE_RANGE_TIMER > 0) then
		VUHDO_UPDATE_RANGE_TIMER = VUHDO_UPDATE_RANGE_TIMER - aTimeDelta;
		if (VUHDO_UPDATE_RANGE_TIMER <= 0) then
			VUHDO_updateRange();
			VUHDO_updateAllCharmed();
			VUHDO_updateAllAggro();

			VUHDO_UPDATE_RANGE_TIMER = VUHDO_CONFIG["RANGE_CHECK_DELAY"] / 1000;
			VUHDO_sortRaidTable();

			-- Reload after player gained control
			if (not HasFullControl()) then
				VUHDO_LOST_CONTROL = true;
			else
				if (VUHDO_LOST_CONTROL) then
					if (VUHDO_RELOAD_RAID_TIMER <= 0) then
						VUHDO_RELOAD_RAID_TIMER = VUHDO_RELOAD_RAID_DELAY_QUICK;
					end
					VUHDO_LOST_CONTROL = false;
				end
			end
		end
	end

	-- track dragged panel coords
	if (VUHDO_DRAG_PANEL ~= nil) then
		VUHDO_REFRESH_DRAG_TIMER = VUHDO_REFRESH_DRAG_TIMER - aTimeDelta;
		if (VUHDO_REFRESH_DRAG_TIMER <= 0) then
			VUHDO_REFRESH_DRAG_TIMER = VUHDO_REFRESH_DRAG_DELAY;
			VUHDO_refreshDragTarget(VUHDO_DRAG_PANEL);
		end
	end

	-- Set Button colors without repositioning
	if (VUHDO_CUSTOMIZE_TIMER > 0) then
		VUHDO_CUSTOMIZE_TIMER = VUHDO_CUSTOMIZE_TIMER - aTimeDelta;
		if (VUHDO_CUSTOMIZE_TIMER <= 0) then
			VUHDO_customizeAllPanels();
		end
	end

	-- Refresh Tooltip
	if (VuhDoTooltip:IsVisible() and VUHDO_REFRESH_TOOLTIP_TIMER > 0) then
		VUHDO_REFRESH_TOOLTIP_TIMER = VUHDO_REFRESH_TOOLTIP_TIMER - aTimeDelta;
		if (VUHDO_REFRESH_TOOLTIP_TIMER <= 0) then
			VUHDO_REFRESH_TOOLTIP_TIMER = VUHDO_REFRESH_TOOLTIP_DELAY;
			VUHDO_updateTooltip();
		end
	end

	-- Refresh server lag
	if (VUHDO_RELOAD_LAG_TIMER > 0) then
		VUHDO_RELOAD_LAG_TIMER = VUHDO_RELOAD_LAG_TIMER - aTimeDelta;
		if (VUHDO_RELOAD_LAG_TIMER <= 0) then
			local tempLegSecs;
			_, _, tempLegSecs = GetNetStats();
			VUHDO_LAG_MS = tempLegSecs / 800;
			VUHDO_RELOAD_LAG_TIMER = VUHDO_RELOAD_LAG_DELAY;
		end
	end

	if (VUHDO_REFRESH_BUFFS_TIMER >= 0) then
		VUHDO_REFRESH_BUFFS_TIMER = VUHDO_REFRESH_BUFFS_TIMER - aTimeDelta;
		if (VUHDO_REFRESH_BUFFS_TIMER <= 0) then
			VUHDO_updateBuffPanel()
			VUHDO_REFRESH_BUFFS_TIMER = VUHDO_BUFF_SETTINGS["CONFIG"]["REFRESH_SECS"];
		end
	end

end
