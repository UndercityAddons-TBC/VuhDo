VUHDO_INDEX_COLOR = {
	["TR"] = 1,
	["TG"] = 0.7,
	["TB"] = 0.2,
};

VUHDO_VALUE_COLOR = {
	["TR"] = 1,
	["TG"] = 0.898,
	["TB"] = 0.4,
};


-- Group Model Header Texts
VUHDO_HEADER_TEXTS = {
	[VUHDO_ID_UNDEFINED] = "undefined",

	[VUHDO_ID_GROUP_1] = VUHDO_I18N_GROUP .. " 1",
	[VUHDO_ID_GROUP_2] = VUHDO_I18N_GROUP .. " 2",
	[VUHDO_ID_GROUP_3] = VUHDO_I18N_GROUP .. " 3",
	[VUHDO_ID_GROUP_4] = VUHDO_I18N_GROUP .. " 4",
	[VUHDO_ID_GROUP_5] = VUHDO_I18N_GROUP .. " 5",
	[VUHDO_ID_GROUP_6] = VUHDO_I18N_GROUP .. " 6",
	[VUHDO_ID_GROUP_7] = VUHDO_I18N_GROUP .. " 7",
	[VUHDO_ID_GROUP_8] = VUHDO_I18N_GROUP .. " 8",

	[VUHDO_ID_WARRIORS] = VUHDO_I18N_WARRIORS,
	[VUHDO_ID_ROGUES] = VUHDO_I18N_ROGUES,
	[VUHDO_ID_HUNTERS] = VUHDO_I18N_HUNTERS,
	[VUHDO_ID_PALADINS] = VUHDO_I18N_PALADINS,
	[VUHDO_ID_MAGES] = VUHDO_I18N_MAGES,
	[VUHDO_ID_WARLOCKS] = VUHDO_I18N_WARLOCKS,
	[VUHDO_ID_SHAMANS] = VUHDO_I18N_SHAMANS,
	[VUHDO_ID_DRUIDS] = VUHDO_I18N_DRUIDS,
	[VUHDO_ID_PRIESTS] = VUHDO_I18N_PRIESTS,
	[VUHDO_ID_DEATH_KNIGHT] = VUHDO_I18N_DEATH_KNIGHT,

	[VUHDO_ID_PETS] = VUHDO_I18N_PETS,
	[VUHDO_ID_MAINTANKS] = VUHDO_I18N_MAINTANKS,
	[VUHDO_ID_MAINASSIST] = VUHDO_I18N_MAINASSISTS,
--	[VUHDO_ID_MELEES] = VUHDO_I18N_MELEES,
--	[VUHDO_ID_HEALERS] = VUHDO_I18N_HEALERS,
--	[VUHDO_ID_RANGED] = VUHDO_I18N_RANGED
};



VUHDO_IMAGE_PATH = "Interface\\AddOns\\VuhDo\\Images\\";
VUHDO_BAR_TEXTURE_PREFIX = "bar";
VUHDO_TEXTURE_SPEC = VUHDO_IMAGE_PATH .. VUHDO_BAR_TEXTURE_PREFIX;



VUHDO_TEXTURE_NAMES = {
	VUHDO_TEXTURE_1,
	VUHDO_TEXTURE_2,
	VUHDO_TEXTURE_3,
	VUHDO_TEXTURE_4,
	VUHDO_TEXTURE_5,
	VUHDO_TEXTURE_6,
	VUHDO_TEXTURE_7,
	VUHDO_TEXTURE_8,
	VUHDO_TEXTURE_9,
	VUHDO_TEXTURE_10,
	VUHDO_TEXTURE_11,
	VUHDO_TEXTURE_12,
	VUHDO_TEXTURE_13,
	VUHDO_TEXTURE_14,
	VUHDO_TEXTURE_15,
	VUHDO_TEXTURE_16,
	VUHDO_TEXTURE_17,
	VUHDO_TEXTURE_18,
}



--	[VUHDO_ID_DRUIDS] = "ff 7d 0a",
--	[VUHDO_ID_HUNTERS] = "ab d4 73",
--	[VUHDO_ID_MAGES] = "69 cc f0",
--	[VUHDO_ID_PALADINS] = "f5 8c ba",
--	[VUHDO_ID_PRIESTS] = "ff ff ff",
--	[VUHDO_ID_ROGUES] = "ff f5 69",
--	[VUHDO_ID_SHAMANS] = "24 59 ff",
--	[VUHDO_ID_WARLOCKS] = "94 82 ca",
--	[VUHDO_ID_WARRIORS] = "c7 9c 6e"
VUHDO_CLASS_COLORS = {
	[VUHDO_ID_DRUIDS] =       { ["TR"] = 1,    ["TG"] = 0.49, ["TB"] = 0.04, ["TO"] = 1 },
	[VUHDO_ID_HUNTERS] =      { ["TR"] = 0.67, ["TG"] = 0.83, ["TB"] = 0.45, ["TO"] = 1 },
	[VUHDO_ID_MAGES] =        { ["TR"] = 0.41, ["TG"] = 0.8,  ["TB"] = 0.94, ["TO"] = 1 },
	[VUHDO_ID_PALADINS] =     { ["TR"] = 0.96, ["TG"] = 0.55, ["TB"] = 0.73, ["TO"] = 1 },
	[VUHDO_ID_PRIESTS] =      { ["TR"] = 1,    ["TG"] = 1,    ["TB"] = 1,    ["TO"] = 1 },
	[VUHDO_ID_ROGUES] =       { ["TR"] = 1,    ["TG"] = 0.96, ["TB"] = 0.41, ["TO"] = 1 },
	[VUHDO_ID_SHAMANS] =      { ["TR"] = 0.14, ["TG"] = 0.35, ["TB"] = 1,    ["TO"] = 1 },
	[VUHDO_ID_WARLOCKS] =     { ["TR"] = 0.58, ["TG"] = 0.51, ["TB"] = 0.79, ["TO"] = 1 },
	[VUHDO_ID_WARRIORS] =     { ["TR"] = 0.78, ["TG"] = 0.61, ["TB"] = 0.43, ["TO"] = 1 },
	[VUHDO_ID_DEATH_KNIGHT] = { ["TR"] = 0.78, ["TG"] = 0.61, ["TB"] = 0.43, ["TO"] = 1 },
};



--VUHDO_POWER_TYPE_COLORS = {
--	[VUHDO_UNIT_POWER_MANA] = { ["R"] = 0, ["G"] = 0, ["B"] = 1 },
--	[VUHDO_UNIT_POWER_RAGE] = { ["R"] = 0.8, ["G"] = 0.2, ["B"] = 0.2 },
--	[VUHDO_UNIT_POWER_FOCUS] = { ["R"] = 0.8, ["G"] = 0.2, ["B"] = 0.2 },
--	[VUHDO_UNIT_POWER_ENERGY] = { ["R"] = 1, ["G"] = 1, ["B"] = 0 },
--	[VUHDO_UNIT_POWER_HAPPINESS] = { ["R"] = 0.8, ["G"] = 0.2, ["B"] = 0.2 },
--};



VUHDO_POWER_TYPE_COLORS = {
	[VUHDO_UNIT_POWER_MANA] = { ["R"] = 0, ["G"] = 0, ["B"] = 1, ["O"] = 1 },
	[VUHDO_UNIT_POWER_RAGE] = { ["R"] = 0.8, ["G"] = 0.2, ["B"] = 0.2, ["O"] = 0 },
	[VUHDO_UNIT_POWER_FOCUS] = { ["R"] = 0.8, ["G"] = 0.2, ["B"] = 0.2, ["O"] = 0 },
	[VUHDO_UNIT_POWER_ENERGY] = { ["R"] = 1, ["G"] = 1, ["B"] = 0, ["O"] = 0 },
	[VUHDO_UNIT_POWER_HAPPINESS] = { ["R"] = 0.8, ["G"] = 0.2, ["B"] = 0.2, ["O"] = 0 },
	[VUHDO_UNIT_POWER_RUNE] = { ["R"] = 0.8, ["G"] = 0.2, ["B"] = 0.2, ["O"] = 0 },
};



VUHDO_STANDARD_TEXTURE_COLOR = {
	["R"]  = 1, ["G"]  = 1, ["B"]  = 1, ["O"]  = 1, ["useBackground"] = true, ["useOpacity"] = true,
	["TR"] = 1, ["TG"] = 1, ["TB"] = 1, ["TO"] = 1, ["useText"] = true
};


-- For initializing the minimap
VUHDO_MM_LAYOUT = {
  icon = "interface\\characterframe\\temporaryportrait-female-draenei",
  drag = "CIRCLE",
  left = nil,
  right = nil,
  tooltip = VUHDO_I18N_MM_TOOLTIP,
  enabled = true
}



VUHDO_MINIMAP_DROPDOWN = {
	{ ["text"] = VUHDO_I18N_SPELL_SETTINGS },
	{ ["text"] = VUHDO_I18N_PANEL_SETUP },
	{ ["text"] = VUHDO_I18N_GENEREAL_SETTING },
	{ ["text"] = VUHDO_I18N_BAR_COLORS },
	{ ["text"] = VUHDO_I18N_BUFFS },
};


VUHDO_RAID_TARGET_ICON_DIMENSION = 64;
VUHDO_RAID_TARGET_TEXTURE_DIMENSION = 256;
VUHDO_RAID_TARGET_TEXTURE_COLUMNS = 4;
VUHDO_RAID_TARGET_TEXTURE_ROWS = 4;
