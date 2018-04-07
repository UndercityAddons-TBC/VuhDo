VUHDO_DEFAULT_MODELS = {

 { VUHDO_ID_MAINTANKS },
 { VUHDO_ID_GROUP_1, VUHDO_ID_GROUP_2, VUHDO_ID_GROUP_3, VUHDO_ID_GROUP_4, VUHDO_ID_GROUP_5, VUHDO_ID_GROUP_6, VUHDO_ID_GROUP_7, VUHDO_ID_GROUP_8 },
 { VUHDO_ID_PETS },
 { VUHDO_ID_MAINASSIST }

};


VUHDO_DEFAULT_RANGE_SPELLS = {
	["WARRIOR"] = nil,
	["ROGUE"] = nil,
	["HUNTER"] = nil,
	["PALADIN"] = VUHDO_I18N_HOLY_LIGHT,
	["MAGE"] = nil,
	["WARLOCK"] = nil,
	["SHAMAN"] = VUHDO_I18N_HEALING_WAVE,
	["DRUID"] = VUHDO_I18N_HEALING_TOUCH,
	["PRIEST"] = VUHDO_I18N_LESSER_HEAL,
	["DEATH KNIGHT"] = nil,
}


VUHDO_DEFAULT_SPELL_ASSIGNMENT = {
		["1"] = {"", "1", "target"},
		["2"] = {"", "2", "assist"},
		["3"] = {"", "3", "focus"},
		["4"] = {"", "4", "menu"},
		["5"] = {"", "5", "menu"},

		["alt1"] = {"alt-", "1", ""},
		["alt2"] = {"alt-", "2", ""},
		["alt3"] = {"alt-", "3", ""},
		["alt4"] = {"alt-", "4", ""},
		["alt5"] = {"alt-", "5", ""},

		["ctrl1"] = {"ctrl-", "1", ""},
		["ctrl2"] = {"ctrl-", "2", ""},
		["ctrl3"] = {"ctrl-", "3", ""},
		["ctrl4"] = {"ctrl-", "4", ""},
		["ctrl5"] = {"ctrl-", "5", ""},

		["shift1"] = {"shift-", "1", ""},
		["shift2"] = {"shift-", "2", ""},
		["shift3"] = {"shift-", "3", ""},
		["shift4"] = {"shift-", "4", ""},
		["shift5"] = {"shift-", "5", ""},

		["altctrl1"] = {"alt-ctrl-", "1", ""},
		["altctrl2"] = {"alt-ctrl-", "2", ""},
		["altctrl3"] = {"alt-ctrl-", "3", ""},
		["altctrl4"] = {"alt-ctrl-", "4", ""},
		["altctrl5"] = {"alt-ctrl-", "5", ""},

		["altshift1"] = {"alt-shift-", "1", ""},
		["altshift2"] = {"alt-shift-", "2", ""},
		["altshift3"] = {"alt-shift-", "3", ""},
		["altshift4"] = {"alt-shift-", "4", ""},
		["altshift5"] = {"alt-shift-", "5", ""},

		["ctrlshift1"] = {"ctrl-shift-", "1", ""},
		["ctrlshift2"] = {"ctrl-shift-", "2", ""},
		["ctrlshift3"] = {"ctrl-shift-", "3", ""},
		["ctrlshift4"] = {"ctrl-shift-", "4", ""},
		["ctrlshift5"] = {"ctrl-shift-", "5", ""},

		["altctrlshift1"] = {"alt-ctrl-shift-", "1", ""},
		["altctrlshift2"] = {"alt-ctrl-shift-", "2", ""},
		["altctrlshift3"] = {"alt-ctrl-shift-", "3", ""},
		["altctrlshift4"] = {"alt-ctrl-shift-", "4", ""},
		["altctrlshift5"] = {"alt-ctrl-shift-", "5", ""}
};



VUHDO_CLASS_DEFAULT_SPELL_ASSIGNMENT = {
	["PALADIN"] = {
		["1"] = {"", "1", VUHDO_I18N_FLASH_OF_LIGHT},
		["2"] = {"", "2", VUHDO_I18N_PALA_CLEANSE},
		["3"] = {"", "3", "menu"},
		["4"] = {"", "4", VUHDO_I18N_DIVINE_FAVOR},
		["5"] = {"", "5", VUHDO_I18N_DIVINE_ILLUMINATION},

		["alt1"] = {"alt-", "1", "target"},
		["alt2"] = {"alt-", "2", VUHDO_I18N_BLESSING_OF_PROTECTION},
		["alt4"] = {"alt-", "4", VUHDO_I18N_DIVINE_INTERVENTION},
		["alt5"] = {"alt-", "5", VUHDO_I18N_DIVINE_INTERVENTION},

		["ctrl1"] = {"ctrl-", "1", VUHDO_I18N_HOLY_LIGHT},
		["ctrl2"] = {"ctrl-", "2", VUHDO_getQualifiedSpellName(VUHDO_I18N_HOLY_LIGHT, 1)},
		["ctrl4"] = {"ctrl-", "4", VUHDO_I18N_DIVINE_INTERVENTION},
		["ctrl5"] = {"ctrl-", "5", VUHDO_I18N_DIVINE_INTERVENTION},

		["shift1"] = {"shift-", "1", VUHDO_I18N_HOLY_SHOCK},
		["shift2"] = {"shift-", "2", VUHDO_I18N_LAY_ON_HANDS},
		["shift4"] = {"shift-", "4", VUHDO_I18N_DIVINE_INTERVENTION},
		["shift5"] = {"shift-", "5", VUHDO_I18N_DIVINE_INTERVENTION},
	},

	["SHAMAN"] = {
		["1"] = {"", "1", VUHDO_I18N_LESSER_HEALING_WAVE},
		["2"] = {"", "2", VUHDO_I18N_CHAIN_HEAL},
		["3"] = {"", "3", "menu"},

		["alt1"] = {"alt-", "1", VUHDO_I18N_EARTH_SHIELD},
		["alt2"] = {"alt-", "2", VUHDO_I18N_GIFT_OF_THE_NAARU},
		["alt3"] = {"alt-", "3", "menu"},

		["ctrl1"] = {"ctrl-", "1", "target"},
		["ctrl2"] = {"ctrl-", "2", "target"},
		["ctrl3"] = {"ctrl-", "3", "menu"},

		["ctrlshift1"] = {"ctrl-shift-", "1", VUHDO_I18N_CURE_POISON},
		["ctrlshift2"] = {"ctrl-shift-", "2", VUHDO_I18N_CURE_DISEASE},

		["shift1"] = {"shift-", "1", VUHDO_I18N_HEALING_WAVE},
		["shift2"] = {"shift-", "2", VUHDO_getQualifiedSpellName(VUHDO_I18N_CHAIN_HEAL, 3)},
		["shift3"] = {"shift-", "3", "menu" },

		["altctrl1"] = {"alt-ctrl-", "1", VUHDO_I18N_CURE_PURGE},
		["altctrl2"] = {"alt-ctrl-", "2", VUHDO_I18N_CURE_PURGE},
	},

	["PRIEST"] = {
		["1"] = {"", "1", VUHDO_I18N_FLASH_HEAL},
		["2"] = {"", "2", VUHDO_I18N_GREATER_HEAL},
		["3"] = {"", "3", VUHDO_I18N_DESPERATE_PRAYER},
		["4"] = {"", "4", VUHDO_I18N_RENEW},
		["5"] = {"", "5", VUHDO_I18N_BINDING_HEAL},

		["alt1"] = {"alt-", "1", "target"},
		["alt2"] = {"alt-", "2", "focus"},
		["alt3"] = {"alt-", "3", VUHDO_I18N_POWERWORD_SHIELD},
		["alt4"] = {"alt-", "4", VUHDO_I18N_POWERWORD_SHIELD},
		["alt5"] = {"alt-", "5", VUHDO_I18N_POWERWORD_SHIELD},

		["ctrl1"] = {"ctrl-", "1", VUHDO_I18N_PRAYER_OF_HEALING},
		["ctrl2"] = {"ctrl-", "2", VUHDO_I18N_CIRCLE_OF_HEALING},
		["ctrl3"] = {"ctrl-", "3", "menu"},
		["ctrl4"] = {"ctrl-", "4", VUHDO_I18N_PRAYER_OF_MENDING},
		["ctrl5"] = {"ctrl-", "5", VUHDO_I18N_PRAYER_OF_MENDING},

		["shift1"] = {"shift-", "1", VUHDO_I18N_ABOLISH_DISEASE},
		["shift2"] = {"shift-", "2", VUHDO_I18N_DISPEL_MAGIC},
		["shift3"] = {"shift-", "3", "menu"},
		["shift4"] = {"shift-", "4", ""},
		["shift5"] = {"shift-", "5", ""},
	},

	["DRUID"] = {
		["1"] = {"", "1", VUHDO_I18N_HEALING_TOUCH},
		["2"] = {"", "2", VUHDO_I18N_REJUVENATION},
		["3"] = {"", "3", "menu"},
		["4"] = {"", "4", VUHDO_I18N_INNERVATE},
		["5"] = {"", "5", VUHDO_I18N_INNERVATE},

		["alt1"] = {"alt-", "1", "target"},
		["alt2"] = {"alt-", "2", "focus"},
		["alt3"] = {"alt-", "3", "menu"},
		["alt4"] = {"alt-", "4", ""},
		["alt5"] = {"alt-", "5", ""},

		["ctrl1"] = {"ctrl-", "1", VUHDO_I18N_REGROWTH},
		["ctrl2"] = {"ctrl-", "2", VUHDO_I18N_LIFEBLOOM},
		["ctrl3"] = {"ctrl-", "3", ""},
		["ctrl4"] = {"ctrl-", "4", VUHDO_I18N_TRANQUILITY},
		["ctrl5"] = {"ctrl-", "5", VUHDO_I18N_TRANQUILITY},

		["shift1"] = {"shift-", "1", VUHDO_I18N_ABOLISH_POISON},
		["shift2"] = {"shift-", "2", VUHDO_I18N_REMOVE_CURSE},
		["shift3"] = {"shift-", "3", ""},
		["shift4"] = {"shift-", "4", ""},
		["shift5"] = {"shift-", "5", ""},
	}
};



--
function VUHDO_assignDefaultSpells()
	local tempClass;

	_, tempClass = UnitClass("player");

	VUHDO_SPELL_ASSIGNMENTS = VUHDO_DEFAULT_SPELL_ASSIGNMENT;

	if (VUHDO_CLASS_DEFAULT_SPELL_ASSIGNMENT[tempClass] ~= nil) then
		VUHDO_SPELL_ASSIGNMENTS = VUHDO_CLASS_DEFAULT_SPELL_ASSIGNMENT[tempClass];
		local tempKey, tempValue;

		for tempKey, tempValue in pairs(VUHDO_DEFAULT_SPELL_ASSIGNMENT) do
			if (VUHDO_SPELL_ASSIGNMENTS[tempKey] == nil) then
				VUHDO_SPELL_ASSIGNMENTS[tempKey] = tempValue;
			end
		end
	end
end



--
function VUHDO_loadDefaultConfig()
	local tempClass;
	 _, tempClass = UnitClass("player");

	if (VUHDO_CONFIG ~= nil and VUHDO_getVersion(VUHDO_CONFIG) < VUHDO_VERSION_CONFIG) then
		VUHDO_CONFIG = nil;
		VUHDO_Msg("Your general config has been reset due to changed compatibility!", 1, 0.4, 0.4);
	end


	if (VUHDO_CONFIG == nil) then
		VUHDO_CONFIG = { ["VERSION"] = VUHDO_VERSION_CONFIG };

		VUHDO_CONFIG["SHOW_PANELS"] = true;
		VUHDO_CONFIG["LOCK_PANELS"] = false;
		VUHDO_CONFIG["SHOW_MONITOR"] = false;
		VUHDO_CONFIG["SHOW_MINIMAP"] = true;

		VUHDO_CONFIG["MODE"] = VUHDO_MODE_NEUTRAL;
		VUHDO_CONFIG["EMERGENCY_TRIGGER"] = 100;
		VUHDO_CONFIG["MAX_EMERGENCIES"] = 5;
		VUHDO_CONFIG["SHOW_INCOMING"] = true;
		VUHDO_CONFIG["SHOW_OVERHEAL"] = true;
		VUHDO_CONFIG["SHOW_OWN_INCOMING"] = true;

		VUHDO_CONFIG["RANGE_CHECK"] = true;

		if (VUHDO_DEFAULT_RANGE_SPELLS[tempClass] == nil) then
			VUHDO_CONFIG["RANGE_SPELL"] = nil;
			VUHDO_CONFIG["RANGE_PESSIMISTIC"] = true;
		else
			VUHDO_CONFIG["RANGE_SPELL"] = VUHDO_DEFAULT_RANGE_SPELLS[tempClass];
			VUHDO_CONFIG["RANGE_PESSIMISTIC"] = false;
		end
		VUHDO_CONFIG["RANGE_CHECK_DELAY"] = 100;

		VUHDO_CONFIG["DETECT_DEBUFFS"] = true;
		VUHDO_CONFIG["DEBUFF_SOUND"] = nil;
		VUHDO_CONFIG["DEBUFF_WARNING"] = false;
		VUHDO_CONFIG["DETECT_DEBUFFS_REMOVABLE_ONLY"] = true;
		VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_BY_CLASS"] = true;
		VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_NO_HARM"] = true;
		VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_MOVEMENT"] = true;
		VUHDO_CONFIG["DETECT_DEBUFFS_IGNORE_DURATION"] = true;

		VUHDO_CONFIG["SMARTCAST"] = true;
		VUHDO_CONFIG["SMARTCAST_RESURRECT"] = true;
		VUHDO_CONFIG["SMARTCAST_CLEANSE"] = true;
		VUHDO_CONFIG["SMARTCAST_HEAL"] = true;
		VUHDO_CONFIG["SMARTCAST_AUTO_HEAL_SPELL"] = false;

		VUHDO_CONFIG["DETECT_AGGRO"] = true;
		VUHDO_CONFIG["AVOID_PVP"] = true;
		VUHDO_CONFIG["PARSE_COMBAT_LOG"] = true;
	end
end



--
function VUHDO_loadDefaultPanelSetup()
	local tempPanelNum;
	local tempAktPanel;

	if (VUHDO_PANEL_SETUP ~= nil and VUHDO_getVersion(VUHDO_PANEL_SETUP) < VUHDO_VERSION_PANELS) then
		VUHDO_PANEL_SETUP = nil;
		VUHDO_Msg("Your panel settings have been reset due to compatibility issues!", 1, 0.4, 0.4);
	end

	if (VUHDO_PANEL_SETUP == nil) then
		VUHDO_PANEL_SETUP = { ["VERSION"] = VUHDO_VERSION_PANELS };
	end

	if (VUHDO_PANEL_SETUP["BAR_COLORS"] == nil) then
		VUHDO_PANEL_SETUP["BAR_COLORS"] = { };

		VUHDO_PANEL_SETUP["BAR_COLORS"].neutralFalloff = VUHDO_GUI_BAR_COLOR_FALLOFF_VIVID;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"] =  { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].R = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].G = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].B = 0.4;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].O = 0.5;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].TR = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].TG = 0.82;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].TB = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].TO = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].useText = false;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].useBackground = false;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["IRRELEVANT"].useOpacity = true;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"] = { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].R = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].G = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].B = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].O = 0.33;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].TR = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].TG = 0.82;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].TB = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].TO = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].useText = false;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].useBackground = false;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["INCOMING"].useOpacity = true;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"] = { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"].R = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"].G = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"].B = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"].O = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"].TR = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"].TG = 0.82;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"].TB = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"].TO = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"].useText = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"].useBackground = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["EMERGENCY"].useOpacity = true;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"] = { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"].R = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"].G = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"].B = 0.4;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"].O = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"].TR = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"].TG = 0.82;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"].TB = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"].TO = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"].useText = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"].useBackground = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["NO_EMERGENCY"].useOpacity = true;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["OFFLINE"] = { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OFFLINE"].R = 0.298;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OFFLINE"].G = 0.298;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OFFLINE"].B = 0.298;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OFFLINE"].O = 0.21;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OFFLINE"].TR = 0.576;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OFFLINE"].TG = 0.576;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OFFLINE"].TB = 0.576;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OFFLINE"].TO = 0.58;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OFFLINE"].useText = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OFFLINE"].useBackground = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OFFLINE"].useOpacity = true;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEAD"] = { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEAD"].R = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEAD"].G = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEAD"].B = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEAD"].O = 0.25;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEAD"].TR = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEAD"].TG = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEAD"].TB = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEAD"].TO = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEAD"].useText = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEAD"].useBackground = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEAD"].useOpacity = true;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"] = { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].R = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].G = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].B = 0.2;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].O = 0.5;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].TR = 0.5;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].TG = 0.41;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].TB = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].TO = 0.7;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].useText = false;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].useBackground = false;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["OUTRANGED"].useOpacity = true;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_NONE] =  { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_NONE].useText = false;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_NONE].useBackground = false;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_NONE].useOpacity = false;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON] = { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].R = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].G = 0.592;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].B = 0.8;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].O = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].TR = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].TG = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].TB = 0.686;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].TO = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].useText = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].useBackground = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_POISON].useOpacity = true;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE] = { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].R = 0.8;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].G = 0.4;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].B = 0.4;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].O = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].TR = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].TG = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].TB = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].TO = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].useText = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].useBackground = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_DISEASE].useOpacity = true;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE] = { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].R = 0.7;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].G = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].B = 0.7;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].O = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].TR = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].GG = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].TB = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].TO = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].useText = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].useBackground = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CURSE].useOpacity = true;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC] = { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].R = 0.4;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].G = 0.4;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].B = 0.8;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].O = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].TR = 0.329;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].TG = 0.957;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].TB = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].TO = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].useText = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].useBackground = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_MAGIC].useOpacity = true;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CHARMED] =  { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CHARMED].useText = false;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CHARMED].useBackground = false;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["DEBUFF" .. VUHDO_DEBUFF_TYPE_CHARMED].useOpacity = false;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"] = { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"].R = 0.51;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"].G = 0.082;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"].B = 0.263;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"].O = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"].TR = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"].TG = 0.31;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"].TB = 0.31;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"].TO = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"].useText = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"].useBackground = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["CHARMED"].useOpacity = true;

		VUHDO_PANEL_SETUP["BAR_COLORS"]["AGGRO"] = { };
		VUHDO_PANEL_SETUP["BAR_COLORS"]["AGGRO"].R = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["AGGRO"].G = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["AGGRO"].B = 0;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["AGGRO"].O = 1;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["AGGRO"].useText = false;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["AGGRO"].useBackground = true;
		VUHDO_PANEL_SETUP["BAR_COLORS"]["AGGRO"].useOpacity = true;
	end

	for tempPanelNum = 1, VUHDO_MAX_PANELS do
		if (VUHDO_PANEL_SETUP[tempPanelNum] == nil) then
			VUHDO_PANEL_SETUP[tempPanelNum] = { };
		end

		tempAktPanel = VUHDO_PANEL_SETUP[tempPanelNum];

		if (tempAktPanel["POSITION"] == nil) then
			tempAktPanel["POSITION"] = { };
			tempAktPanel["POSITION"].x = 100 + 30 * tempPanelNum;
			tempAktPanel["POSITION"].y = 668 - 30 * tempPanelNum;
			tempAktPanel["POSITION"].relativePoint = "BOTTOMLEFT";
			tempAktPanel["POSITION"].orientation = "TOPLEFT";
			tempAktPanel["POSITION"].growth = "TOPLEFT";
			tempAktPanel["POSITION"].width = 200;
			tempAktPanel["POSITION"].height = 200;
			tempAktPanel["POSITION"].scale = 1;
		end

		if (tempAktPanel["MODEL"] == nil) then
			tempAktPanel["MODEL"] = { };
			tempAktPanel["MODEL"].ordering = VUHDO_ORDERING_STRICT;
			tempAktPanel["MODEL"].groups = VUHDO_DEFAULT_MODELS[tempPanelNum];
			tempAktPanel["MODEL"].sort = VUHDO_SORT_RAID_MAX_HEALTH;
		end

		if (tempAktPanel["SCALING"] == nil) then
			tempAktPanel["SCALING"] = {};
	  	tempAktPanel["SCALING"].columnSpacing = 5;
 			tempAktPanel["SCALING"].rowSpacing = 2;

			tempAktPanel["SCALING"].borderGapX = 5;
			tempAktPanel["SCALING"].borderGapY = 5;

			tempAktPanel["SCALING"].showManaBars = false;
			tempAktPanel["SCALING"].manaBarHeight = 4;

			tempAktPanel["SCALING"].showHeaders = true;
			tempAktPanel["SCALING"].headerHeight = 20;
			tempAktPanel["SCALING"].headerWidth = 50;
			tempAktPanel["SCALING"].headerSpacing = 5;

			tempAktPanel["SCALING"].maxColumnsWhenStructured = 4;
			tempAktPanel["SCALING"].maxRowsWhenLoose = 6;
			tempAktPanel["SCALING"].ommitEmptyWhenStructured = false;

			tempAktPanel["SCALING"].showTarget = false;
			tempAktPanel["SCALING"].targetSpacing = 3;
			tempAktPanel["SCALING"].targetWidth = 30;

			if (VUHDO_DEFAULT_MODELS[tempPanelNum] ~= nil and VUHDO_ID_MAINTANKS == VUHDO_DEFAULT_MODELS[tempPanelNum][1]) then
  			tempAktPanel["SCALING"].barWidth = 100;
	  		tempAktPanel["SCALING"].barHeight = 26;
				tempAktPanel["SCALING"].showTarget = true;
			else
  			tempAktPanel["SCALING"].barWidth = 65;
	  		tempAktPanel["SCALING"].barHeight = 18;

				if (VUHDO_DEFAULT_MODELS[tempPanelNum] ~= nil and VUHDO_ID_PETS == VUHDO_DEFAULT_MODELS[tempPanelNum][1]) then
					tempAktPanel["MODEL"].ordering = VUHDO_ORDERING_LOOSE;
				elseif (VUHDO_DEFAULT_MODELS[tempPanelNum] ~= nil and VUHDO_ID_MAINASSIST == VUHDO_DEFAULT_MODELS[tempPanelNum][1]) then
					tempAktPanel["SCALING"].showTarget = true;
				else
					tempAktPanel["SCALING"].ommitEmptyWhenStructured = true;
				end
 			end
		end

		if (tempAktPanel["PANEL_COLOR"] == nil) then
			tempAktPanel["PANEL_COLOR"] = { };

			tempAktPanel["PANEL_COLOR"].barTexture = "15";

			tempAktPanel["PANEL_COLOR"]["BACK"] = { };
			tempAktPanel["PANEL_COLOR"]["BACK"].R = 0;
			tempAktPanel["PANEL_COLOR"]["BACK"].G = 0;
			tempAktPanel["PANEL_COLOR"]["BACK"].B = 0;
			tempAktPanel["PANEL_COLOR"]["BACK"].O = 0.4;

			tempAktPanel["PANEL_COLOR"]["BORDER"] = { };
			tempAktPanel["PANEL_COLOR"]["BORDER"].R = 0;
			tempAktPanel["PANEL_COLOR"]["BORDER"].G = 0;
			tempAktPanel["PANEL_COLOR"]["BORDER"].B = 0;
			tempAktPanel["PANEL_COLOR"]["BORDER"].O = 0.46;

			tempAktPanel["PANEL_COLOR"]["TEXT"] = { };
			tempAktPanel["PANEL_COLOR"]["TEXT"].TR = 1;
			tempAktPanel["PANEL_COLOR"]["TEXT"].TG = 0.82;
			tempAktPanel["PANEL_COLOR"]["TEXT"].TB = 0;
			tempAktPanel["PANEL_COLOR"]["TEXT"].TO = 1;
			tempAktPanel["PANEL_COLOR"]["TEXT"].R = 0;
			tempAktPanel["PANEL_COLOR"]["TEXT"].G = 0;
			tempAktPanel["PANEL_COLOR"]["TEXT"].B = 0;
			tempAktPanel["PANEL_COLOR"]["TEXT"].O = 0.5;
			tempAktPanel["PANEL_COLOR"]["TEXT"].useText = true;
			tempAktPanel["PANEL_COLOR"]["TEXT"].useBackground = true;
			tempAktPanel["PANEL_COLOR"]["TEXT"].useOpacity = true;
			if (VUHDO_DEFAULT_MODELS[tempPanelNum] ~= nil and VUHDO_ID_MAINTANKS == VUHDO_DEFAULT_MODELS[tempPanelNum][1]) then
				tempAktPanel["PANEL_COLOR"]["TEXT"].textSize = 11;
			else
				tempAktPanel["PANEL_COLOR"]["TEXT"].textSize = 9;
			end

			tempAktPanel["PANEL_COLOR"]["HEADER"] = { };
			tempAktPanel["PANEL_COLOR"]["HEADER"].R = 0.6;
			tempAktPanel["PANEL_COLOR"]["HEADER"].G = 0.514;
			tempAktPanel["PANEL_COLOR"]["HEADER"].B = 0.082;
			tempAktPanel["PANEL_COLOR"]["HEADER"].O = 0.6;
			tempAktPanel["PANEL_COLOR"]["HEADER"].TR = 1;
			tempAktPanel["PANEL_COLOR"]["HEADER"].TG = 0.859;
			tempAktPanel["PANEL_COLOR"]["HEADER"].TB = 0.38;
			tempAktPanel["PANEL_COLOR"]["HEADER"].TO = 1;
			tempAktPanel["PANEL_COLOR"]["HEADER"].useText = true;
			tempAktPanel["PANEL_COLOR"]["HEADER"].barTexture = 6;
			tempAktPanel["PANEL_COLOR"]["HEADER"].textSize = 11;

			tempAktPanel["PANEL_COLOR"].classColorsName = false;
			tempAktPanel["PANEL_COLOR"].classColorsHeader = false;
		end

		if (tempAktPanel["TOOLTIP"] == nil) then
			tempAktPanel["TOOLTIP"] = { };
			tempAktPanel["TOOLTIP"].show = true;
			tempAktPanel["TOOLTIP"].position = VUHDO_TOOLTIP_POS_STANDARD;
			tempAktPanel["TOOLTIP"].inFight = false;
			tempAktPanel["TOOLTIP"].x = 100;
			tempAktPanel["TOOLTIP"].y = -100;
			tempAktPanel["TOOLTIP"].point = "TOPLEFT";
			tempAktPanel["TOOLTIP"].relativePoint = "TOPLEFT";
			tempAktPanel["TOOLTIP"].mode = VUHDO_TOOLTIP_MODE_VERBOSE;
			tempAktPanel["TOOLTIP"]["SCALE"] = 1;


			tempAktPanel["TOOLTIP"]["BACKGROUND"] = { };
			tempAktPanel["TOOLTIP"]["BACKGROUND"].R = 0;
			tempAktPanel["TOOLTIP"]["BACKGROUND"].G = 0;
			tempAktPanel["TOOLTIP"]["BACKGROUND"].B = 0;
			tempAktPanel["TOOLTIP"]["BACKGROUND"].O = 1;

			tempAktPanel["TOOLTIP"]["BORDER"] = { };
			tempAktPanel["TOOLTIP"]["BORDER"].R = 0;
			tempAktPanel["TOOLTIP"]["BORDER"].G = 0;
			tempAktPanel["TOOLTIP"]["BORDER"].B = 0;
			tempAktPanel["TOOLTIP"]["BORDER"].O = 1;
		end
	end
end



--
function VUHDO_initProfiles()
	if (VUHDO_PROFILES ~= nil and VUHDO_getVersion(VUHDO_PROFILES) < VUHDO_VERSION_PROFILES) then
		VUHDO_PROFILES = nil;
		VUHDO_Msg("Your profiles have been reset due to changed compatibility!", 1, 0.4, 0.4);
	end


	if (VUHDO_PROFILES == nil) then
		VUHDO_PROFILES = { ["VERSION"] = VUHDO_VERSION_PROFILES };

		VUHDO_PROFILES["NAME_CURRENT"] = VUHDO_DEFAULT_PROFILE;
		VUHDO_PROFILES["NAME_RAID"] = nil;
		VUHDO_PROFILES["NAME_BG"] = nil;
		VUHDO_PROFILES["NAME_PARTY"] = nil;
		VUHDO_PROFILES["NAME_SOLO"] = nil;

		VUHDO_PROFILES["DATA"] = { };

		VUHDO_PROFILES["DATA"][VUHDO_DEFAULT_PROFILE] = {
			["CONFIG"] = VUHDO_deepCopyTable(VUHDO_CONFIG),
			["PANELS"] = VUHDO_deepCopyTable(VUHDO_PANEL_SETUP),
		};
	end
end



VUHDO_DEFAULT_BUFF_CONFIG = {
	["SHOW"] = true,
	["SHOW_LABEL"] = false,
	["SHOW_EMPTY"] = false,
	["REFRESH_SECS"] = 0.5,
	["POSITION"] = {
		["x"] = 100,
		["y"] = -100,
		["point"] = "TOPLEFT",
		["relativePoint"] = "TOPLEFT",
	},
	["SCALE"] = 1,
	["SWATCH_MAX_ROWS"] = 2,
	["PANEL_MAX_BUFFS"] = 5,
	["AT_LEAST_MISSING"] = 2,
	["PANEL_BG_COLOR"] = {
		["R"] = 0, ["G"] = 0,	["B"] = 0, ["O"] = 0.5,
		["useText"] = false, ["useBackground"] = true, ["useOpacity"] = false,
	},
	["PANEL_BORDER_COLOR"] = {
		["R"] = 0, ["G"] = 0,	["B"] = 0, ["O"] = 0.5,
		["useText"] = false, ["useBackground"] = true, ["useOpacity"] = false,
	},
	["SWATCH_BG_COLOR"] = {
		["R"] = 0, ["G"] = 0,	["B"] = 0, ["O"] = 1,
		["useText"] = false, ["useBackground"] = true, ["useOpacity"] = false,
	},
	["SWATCH_BORDER_COLOR"] = {
		["R"] = 0.8, ["G"] = 0.8,	["B"] = 0.8, ["O"] = 0,
		["useText"] = false, ["useBackground"] = true, ["useOpacity"] = false,
	},
	["GROUP_SPELL_VERSION"] = "smart",
	["REBUFF_AT_PERCENT"] = 25,
	["REBUFF_MIN_MINUTES"] = 10,
	["HIGHLIGHT_COOLDOWN"] = true,

	["SWATCH_COLOR_BUFF_OKAY"] = {
		["R"] = 0, ["G"] = 0,	["B"] = 0,
		["TR"] = 0, ["TG"] = 0.8,	["TB"] = 0,
		["O"] = 1, ["TO"] = 1,
		["useText"] = true, ["useBackground"] = true, ["useOpacity"] = true,
	},
	["SWATCH_COLOR_BUFF_LOW"] = {
		["R"] = 0, ["G"] = 0,	["B"] = 0,
		["TR"] = 1.0, ["TG"] = 0.7,	["TB"] = 0,
		["O"] = 1, ["TO"] = 1,
		["useText"] = true, ["useBackground"] = true, ["useOpacity"] = true,
	},
	["SWATCH_COLOR_BUFF_OUT"] = {
		["R"] = 0, ["G"] = 0,	["B"] = 0,
		["TR"] = 0.8, ["TG"] = 0,	["TB"] = 0,
		["O"] = 1, ["TO"] = 1,
		["useText"] = true, ["useBackground"] = true, ["useOpacity"] = true,
	},
	["SWATCH_COLOR_BUFF_COOLDOWN"] = {
		["R"] = 0.3, ["G"] = 0.3,	["B"] = 0.3,
		["TR"] = 0.6, ["TG"] = 0.6,	["TB"] = 0.6,
		["O"] = 1, ["TO"] = 1,
		["useText"] = true, ["useBackground"] = true, ["useOpacity"] = true,
	},
	["SWATCH_COLOR_OUT_RANGE"] = {
		["R"] = 0, ["G"] = 0,	["B"] = 0,
		["TR"] = 0, ["TG"] = 0,	["TB"] = 0,
		["O"] = 0.5, ["TO"] = 0.5,
		["useText"] = true, ["useBackground"] = true, ["useOpacity"] = true,
	},
	["SWATCH_EMPTY_GROUP"] = {
		["R"] = 0, ["G"] = 0,	["B"] = 0,
		["TR"] = 0.8, ["TG"] = 0.8,	["TB"] = 0.8,
		["O"] = 0.5, ["TO"] = 0.6,
		["useText"] = true, ["useBackground"] = true, ["useOpacity"] = true,
	},
}

