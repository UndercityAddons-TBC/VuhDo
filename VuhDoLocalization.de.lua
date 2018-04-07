if (GetLocale() ~= "deDE") then
	return;
end

-- Ä = \195\132
-- Ö = \195\150
-- Ü = \195\156
-- ß = \195\159
-- ä = \195\164
-- ö = \195\182
-- ü = \195\188

-- @EXACT = true: Translation has to be the exact(!) match in the clients language,
--                beacause it carries technical semantics
-- @EXACT = false: Translation can be done freely, because text is only descriptive


-- Class Names
-- @EXACT = false
VUHDO_I18N_WARRIORS="Krieger"
VUHDO_I18N_ROGUES = "Schurken";
VUHDO_I18N_HUNTERS = "J\195\164ger";
VUHDO_I18N_PALADINS = "Paladine";
VUHDO_I18N_MAGES = "Magier";
VUHDO_I18N_WARLOCKS = "Hexenmeister";
VUHDO_I18N_SHAMANS = "Schamanen";
VUHDO_I18N_DRUIDS = "Druiden";
VUHDO_I18N_PRIESTS = "Priester";
VUHDO_I18N_DEATH_KNIGHT = "Todesritter";


-- Group Model Names
-- @EXACT = false
VUHDO_I18N_GROUP = "Gruppe";


-- Special Model Names
-- @EXACT = false
VUHDO_I18N_PETS = "Begleiter";
VUHDO_I18N_MAINTANKS = "Main Tanks";
VUHDO_I18N_MAINASSISTS = "Zielgeber";
--VUHDO_I18N_MELEES = "Nahk\195\164mpfer";
--VUHDO_I18N_RANGED = "Fernk\195\164mpfer";
--VUHDO_I18N_HEALERS = "Heiler";



-- General Labels
-- @EXACT = false
VUHDO_I18N_OKAY = "Okay";
VUHDO_I18N_CANCEL = "Abbruch";
VUHDO_I18N_VUHDO = "VuhDo";
VUHDO_I18N_SETUP = "Setup";
VUHDO_I18N_LOAD = "Laden";
VUHDO_I18N_SAVE = "Speichern";
VUHDO_I18N_SHOW = "Anzeigen";
VUHDO_I18N_BARS = "Balken"
VUHDO_I18N_DONE = "Fertig";
VUHDO_I18N_COLOR = "Farbe";
VUHDO_I18N_COLORS = "Farben";
VUHDO_I18N_SPELLS = "Zauber";
VUHDO_I18N_GENERAL_SHORT = "Allgem.";
VUHDO_I18N_RAID = "Schlachtzug";
VUHDO_I18N_BATTLEGROUND = "Schlachtfeld";
VUHDO_I18N_PARTY = "Gruppe";
VUHDO_I18N_SOLO = "Solo";
VUHDO_I18N_DELETE = "L\195\182schen";
VUHDO_I18N_CUSTOM = "Eigene";
VUHDO_I18N_MOUSE = "Maus";
VUHDO_I18N_STANDARD = "Standard";
VUHDO_I18N_POSITION = "Position";
VUHDO_I18N_APPLY_TO_ALL_PANELS = "f\195\188r alle Panels";
VUHDO_I18N_SCALE = "Gr\195\182\195\159e";
VUHDO_I18N_ENABLE = "Aktiviert";
VUHDO_I18N_APPLY_TO_ALL_QUESTION = "Auf alle Fenster des aktiven\nProfils anwenden?";
VUHDO_I18N_BORDER = "Rahmen";
VUHDO_I18N_BACKGROUND = "Hintergrund";
VUHDO_I18N_CLASS = "Klasse";
VUHDO_I18N_BUFFS = "Buffs";
VUHDO_I18N_UNDEFINED = "<n/v>";
VUHDO_I18N_PLAYER = "Spieler";


-- VuhDoOptionsGeneral.lua
-- @EXACT = false
VUHDO_I18N_PARSE_COMBAT_LOG = "Combat-Log auswerten";
VUHDO_I18N_CLEANSE = "Reinigen";
VUHDO_I18N_DOWNSCALE_HEAL = "Spruchrang Heilung";
VUHDO_I18N_AUTO_HEAL_SPELL = "Auto-Spruchwahl";
VUHDO_I18N_RESURRECT = "Wiederbeleben";
VUHDO_I18N_SMART_CAST_OO_COMBAT = "Smarte Spruchwahl out of combat";
VUHDO_I18N_DETECT_DEBUFFS = "Debuffs pr\195\188fen";
VUHDO_I18N_IGNORE_IRRELEVANT = "Ignoriere bedeutungslose ...";
VUHDO_I18N_BY_CLASS = "... f\195\188r Klasse";
VUHDO_I18N_MOVEMENT_IMPAIRING = "... Bewegungs einschr.";
VUHDO_I18N_BY_DURATION = "... geringe Dauer";
VUHDO_I18N_BY_NON_HARMFUL = "... unsch\195\164dliche";
VUHDO_I18N_REMOVABLE_ONLY = "nur entfernbare";
VUHDO_I18N_CHECK_RANGE = "Reichweite pr\195\188fen"
VUHDO_I18N_ESTIMATE = "Sch\195\164tze";
VUHOD_I18N_BY_SPELL = "Spruch:";
VUHDO_I18N_EVERY_MSEC = "Alle {1] Millisekunden";
VUHDO_I18N_SHOW_INC = "Eing. Heilung";
VUHDO_I18N_SHOW_OWN_HEAL = "auch eigene";
VUHDO_I18N_SHOW_OVERHEAL = "\195\156berheilung";
VUHDO_I18N_OPERATION_MODE = "Anzeigemodus";
VUHDO_I18N_MODE = "Modus";
VUHDO_I18N_MAX_EMERGENCIES = "max. # Notf\195\164lle";
VUHDO_I18N_RELVEVANCE = "irrelevant bei \195\188ber";
VUHDO_I18N_DETECT_AGGRO = "Aggro pr\195\188fen";
VUHDO_I18N_GENERAL_OPTIONS_TITLE = "VuhDo - Allgemeine Einstellungen";
VUHDO_I18N_NEUTRAL_HEALBOT = "Neutral / Healbot";
VUHDO_I18N_EMERGENCY_PERCENT = "Notfall - HP %";
VUHDO_I18N_EMERGENCY_MOST_MISSING = "Notfall - Meiste HP fehlend";
VUHDO_I18N_EMERGENCY_LEAST_LEFT = "Notfall - Wenigste HP \195\188brig";
VUHDO_I18N_EVERY = "Alle ";
VUHDO_I18N_MSECS = " sec/1000";



-- VuhDoFormButtonColor.lua
-- @EXACT = false
-- Color Swatches
VUHDO_I18N_IRRELEVANT = "Irrelevant";
VUHDO_I18N_INCOMING = "Heilung eing.";
VUHDO_I18N_EMERGENCY = "Notfall";
VUHDO_I18N_NO_EMERGENCY = "Kein Notfall";
VUHDO_I18N_OFFLINE = "Offline";
VUHDO_I18N_DEAD = "Tot";
VUHDO_I18N_OUTRANGED = "Ausser Reichw.";
VUHDO_I18N_DEBUFF1 = "Gift";
VUHDO_I18N_DEBUFF2 = "Krankheit";
VUHDO_I18N_DEBUFF3 = "Magie";
VUHDO_I18N_DEBUFF4 = "Fluch";
VUHDO_I18N_CHARMED = "Verf\195\188hrung";
VUHDO_I18N_AGGRO = "Aggrobalken";
-- Labels
VUHDO_I18N_TEXT = "Text";
VUHDO_I18N_DEBUFFS = "Debuffs";
VUHDO_I18N_BACKG = "Hintrg.";
VUHDO_I18N_ANOMALIES = "Anomalien";
VUHDO_I18N_EMGERG_MODE = "Notfallmodus";
VUHDO_I18N_NEUTRAL_MODE = "Neutral-Modus";
VUHDO_I18N_OPACITY = "Opazit\195\164t";
VUHDO_I18N_VIVID = "dynam.";
VUHDO_I18N_BAR_COLORING = "VuhDo - Balkenfarben";
VUHDO_I18N_LEFT_BACK_RIGHT_TEXT = "Linksklick: |cffffffffHintergrund|r, Rechtsklick: |cffffffffText|r";



-- VuhDoFormButtonSize.lua
-- @EXACT = false
VUHDO_I18N_PANEL_NUM = "Panel #";
VUHDO_I18N_PANEL = "Panel";
VUHDO_I18N_SPACING = "Abstand";
VUHDO_I18N_GAP = "Rand";
VUHDO_I18N_BAR_HEIGHT = "Balkenh\195\182he";
VUHDO_I18N_TARGETS = "Ziele";
VUHDO_I18N_TARGET_WIDTH = "Breite Ziele";
VUHDO_I18N_BAR_TEXTURE = "Balken-Textur";
VUHDO_I18N_MANA = "Mana";
VUHDO_I18N_HEIGHT = "H\195\182he";
VUHDO_I18N_BAR_WIDTH = "Balkenbreite";
VUHDO_I18N_CLASS_COLORS = "Klassenfarben";
VUHDO_I18N_FONT_SIZE = "Textgr\195\182\195\159e";
VUHDO_I18N_WIDTH = "Breite";
VUHDO_I18N_TEXTURE = "Textur";
VUHDO_I18N_HEADERS = "Titel";
VUHDO_I18N_CLASS_COL = "Klassenf.";
-- Texure names
VUHDO_TEXTURE_1 = "1. Rauten";
VUHDO_TEXTURE_2 = "2. Wirbel";
VUHDO_TEXTURE_3 = "3. R\195\182hre, dunkel";
VUHDO_TEXTURE_4 = "4. Konkav, dunkel";
VUHDO_TEXTURE_5 = "5. R\195\182hre, hell";
VUHDO_TEXTURE_6 = "6. Flach";
VUHDO_TEXTURE_7 = "7. Konkav, hell";
VUHDO_TEXTURE_8 = "8. Konvex";
VUHDO_TEXTURE_9 = "9. Gewebe";
VUHDO_TEXTURE_10 = "10. Hochglanz";
VUHDO_TEXTURE_11 = "11. Diagonalen";
VUHDO_TEXTURE_12 = "12. Zebra";
VUHDO_TEXTURE_13 = "13. Marmor";
VUHDO_TEXTURE_14 = "14. Moderne Kunst";
VUHDO_TEXTURE_15 = "15. Poliertes Holz";
VUHDO_TEXTURE_16 = "16. Eben";
VUHDO_TEXTURE_17 = "17. Minimalist";
VUHDO_TEXTURE_18 = "18. Aluminium";
--
VUHDO_I18N_BARS_BG = "Balken";



-- VuhDoDesignMainPanel.lua
-- @EXACT = false
VUHDO_I18N_MODEL = "Modell";
VUHDO_I18N_NEW_PANEL = "Neues Panel";
VUHDO_I18N_PANEL_DESIGN = "Panel Design";



-- VuhDoFormProfileLoad.lua
-- @EXACT = false
VUHDO_I18N_LOAD_PROFILE_TITLE = "Profil Laden";
VUHDO_I18N_LOAD_DEFAULT_FOR = "Standardprofil laden f\195\188r...";
VUHDO_I18N_SELECT_CUSTOM = "Gespeichertes Profil";
VUHDO_I18N_AUTO_ENABLE_IN = "Automatisch aktivieren in...";



-- VuhDoFormProfileSave.lua
-- @EXACT = false
VUHDO_I18N_SAVE_PROFILE_TITLE = "Profil speichern";
VUHDO_I18N_OR_OVERWRITE_EXISTING = "oder bestehendes \195\188berschreiben:";
VUHDO_I18N_NEW_PROFILE_NAME = "Neuer Profilname:";



-- VuhDoOptionsSpell.lua
-- @EXACT = false
VUHDO_I18N_CTRL_SHIFT = "Strg-Shift";
VUHDO_I18N_KEY_MODIFIES = "Modifikationstaste";
VUHDO_I18N_KEY_NONE = "keine";
VUHDO_I18N_ALT = "Alt";
VUHDO_I18N_CTRL = "Strg";
VUHDO_I18N_SHIFT = "Umschalt";
VUHDO_I18N_ALT_CTRL = "Alt-Strg";
VUHDO_I18N_ALT_SHIFT = "Alt-Umschalt";
VUHDO_I18N_ALT_CTRL_SHIFT = "Alt-Strg-Umschalt";
VUHDO_I18N_LEFT_BUTTON = "Linke Taste";
VUHDO_I18N_RIGHT_BUTTON = "Rechte Taste";
VUHDO_I18N_MIDDLE_BUTTON = "Mittlere Taste";
VUHDO_I18N_BUTTON_4 = "Taste 4";
VUHDO_I18N_BUTTON_5 = "Taste 5";
VUHDO_I18N_SPELL_SETTINGS_TITLE = "VuhDo - Einstellungen Zauber";



-- VuhDoTooltipConfig.lua
-- @EXACT = false
VUHDO_I18N_TOOLTIP_TITLE = "VuhDo - Tooltips";
VUHDO_I18N_AROUND_PANEL = "Um Panel";
VUHDO_I18N_SHOW_IN_FIGHT = "auch im Kampf";



-- VuhDoTooltip.lua
-- @EXACT = false
VUHDO_I18N_TT_POSITION = "|cffffb233Position:|r";
VUHDO_I18N_TT_GHOST = "<GEIST>";
VUHDO_I18N_TT_DEAD = "<TOT>";
VUHDO_I18N_TT_AFK = "<AFK>";
VUHDO_I18N_TT_DND = "<DND>";
VUHDO_I18N_TT_LIFE = "|cffffb233Leben:|r ";
VUHDO_I18N_TT_MANA = "|cffffb233Mana:|r ";
VUHDO_I18N_TT_LEVEL = "Level ";


-- VuhDoPanel.lua
-- @EXACT = false
VUHDO_I18N_CHOOSE = "Auswahl";
VUHDO_I18N_DRAG = "Zieh";
VUHDO_I18N_REMOVE = "Entf.";
VUHDO_I18N_ME = "mich!";
VUHDO_I18N_TYPE = "Typ";
VUHDO_I18N_VALUE = "Wert";
VUHDO_I18N_GROW_TO = "Wachsen";
VUHDO_I18N_GROUPED = "ordnen";
VUHDO_I18N_SHOW_EMPTY = "leer zeigen";
VUHDO_I18N_GROW = "wachsen";
VUHDO_I18N_ADD_MODEL = "Modell neu";
VUHDO_I18N_CLEAR = "L\195\182schen";
VUHDO_I18N_SORT_BY = "Sortierung";
VUHDO_I18N_MISC = "Sonst.";
VUHDO_I18N_SPECIAL = "Spezial";
VUHDO_I18N_GT_DOWN = "->ab";
VUHDO_I18N_LT_DOWN = "<-ab";
VUHDO_I18N_GT_UP = "->auf";
VUHDO_I18N_LT_UP = "<-auf";
VUHDO_I18N_NAME = "Name";
VUHDO_I18N_MAX_HP = "max.HP";
VUHDO_I18N_UNIT_ID = "Unit-ID";
VUHDO_I18N_MAX_COLUMNS = "max.Spalten: ";
VUHDO_I18N_MAX_ROWS = "max.Zeilen: ";
VUHDO_I18N_CLEAR_PANELS_CONFIRM = "Modelle des Panels leeren!\nYA'RLY?";


-- VuhDoBuffWatchSetup
-- @EXACT = false
VUHDO_I18N_BUFF_SETUP = "VuhDo - Buffs";
VUHDO_I18N_BUFF_NAME = "Buff-Name";
VUHDO_I18N_BUFF_ALL = "alle";
VUHDO_I18N_BUFF_ON_PLAYER = "auf Spieler mit Namen:";
VUHDO_I18N_BUFF_OPTIONS = "Optionen";


-- VuhDoBuffWatch
-- @EXACT = false
VUHDO_I18N_BUFF_WATCH = "|cffffe566VuhDo|r - Buff Watch";


-- VuhDoBuffWatchOptions
-- @EXACT = false
VUHDO_I18N_BUFF_WATCH_OPTIONS = "VuhDo Buff Optionen";
VUHDO_I18N_INDICATE_REBUFF_AT = "Nachbuffen bei...";
VUHDO_I18N_ALWAYS = "Immer";
VUHDO_I18N_USE_GROUP_BUFF_VERSION = "Gruppenversion des Buffs...";
VUHDO_I18N_SMART = "Smart";
VUHDO_I18N_NEVER = "Niemals";
VUHDO_I18N_SHOW_BUFF_WATCH = "Buff Watch anzeigen";
VUHDO_I18N_SHOW_EMPTY_GROUPS = "Leere Gruppen anzeigen";
VUHDO_I18N_SHOW_BUFF_LABELS = "Buffnamen anzeigen";
VUHDO_I18N_FLASH_COOLDOWN = "Blinken wenn CD vorbei";
VUHDO_I18N_MINUTES_REMAINING = "Minuten verbleibend";
VUHDO_I18N_PERCENT_REMAINING = "Prozent verbleibend";
VUHDO_I18N_REFRESH_EVERY = "Erneuern alle";
VUHDO_I18N_SECS = " sec.";
VUHDO_I18N_MAX_SWATCHES_PER_LINE = "Max.Buttons pro Zeile";
VUHDO_I18N_MAX_BUFFS_PER_COLUMN = "Max.Buffs pro Spalte";
VUHDO_I18N_BUFF_PANEL_BG = "Hintergrund";
VUHDO_I18N_BUFF_PANEL_BORDER = "Rahmen";
VUHDO_I18N_BUFF_SWATCH_BORDER = "Buttonrahmen";
VUHDO_I18N_BUFF_SWATCH_BG = "Buttonhint.";
VUHDO_I18N_BUFF_LOW = "Nachbuffen";
VUHDO_I18N_BUFF_CD = "Buff Cooldown";
VUHDO_I18N_BUFF_MISSING = "Buff fehlend";
VUHDO_I18N_BUFF_EMPTY_GROUP = "Gruppe leer";
VUHDO_I18N_BUFF_OOR = "Ausser Reichw.";
VUHDO_I18N_BUFF_OKAY = "Buff Okay";
VUHDO_I18N_AT_LEAST_MISSING = "wenn # mind. ohne Buff";

-- Debuff Names (to be individuallay ignored)
-- @EXACT = true
VUHDO_I18N_DEBUFF_ANCIENT_HYSTERIA = "Uralte Hysterie";
VUHDO_I18N_DEBUFF_IGNITE_MANA = "Mana entz\195\188nden";
VUHDO_I18N_DEBUFF_TAINTED_MIND = "Besudelte Gedanken";
VUHDO_I18N_DEBUFF_VIPER_STING = "Vipernbiss";
VUHDO_I18N_DEBUFF_SILENCE = "Stille";
VUHDO_I18N_DEBUFF_MAGMA_SHACKLES = "Magmafesseln";
VUHDO_I18N_DEBUFF_FROSTBOLT = "Frostblitz";
VUHDO_I18N_DEBUFF_PSYCHIC_HORROR = "Psychischer Schrei";
VUHDO_I18N_DEBUFF_HUNTERS_MARK = "Mal des J\195\164gers";
VUHDO_I18N_DEBUFF_SLOW = "Verlangsamen";
VUHDO_I18N_DEBUFF_ARCANE_BLAST = "Arkanschlag";
VUHDO_I18N_DEBUFF_IMPOTENCE = "Fluch der Machtlosigkeit";
VUHDO_I18N_DEBUFF_DECAYED_STR = "Verfallene St\195\164rke";
VUHDO_I18N_DEBUFF_DECAYED_INT = "Verfallene Intelligenz";
VUHDO_I18N_DEBUFF_CRIPPLE = "Verkr\195\188ppeln";
VUHDO_I18N_DEBUFF_CHILLED = "K\195\164lte";
VUHDO_I18N_DEBUFF_CONEOFCOLD = "K\195\164ltekegel";
VUHDO_I18N_DEBUFF_CONCUSSIVESHOT = "Ersch\195\188tternder Schuss";
VUHDO_I18N_DEBUFF_THUNDERCLAP = "Donnerknall";
VUHDO_I18N_DEBUFF_HOWLINGSCREECH = "Heulender Schrei";
VUHDO_I18N_DEBUFF_DAZED = "Benommen";
VUHDO_I18N_DEBUFF_FALTER = "Z\195\182gern";
VUHDO_I18N_DEBUFF_UNSTABLE_AFFL = "Instabiles Gebrechen";
VUHDO_I18N_DEBUFF_DREAMLESS_SLEEP = "Traumloser Schlaf";
VUHDO_I18N_DEBUFF_GREATER_DREAMLESS = "Gro\195\159er Traumloser Schlaf";
VUHDO_I18N_DEBUFF_MAJOR_DREAMLESS = "\195\156berragender Traumloser Schlaf";
VUHDO_I18N_DEBUFF_FROST_SHOCK = "Frost Shock";
VUHDO_I18N_DEBUFF_DELUSIONS_OF_JINDO = "Fluch der Schatten";
VUHDO_I18N_DEBUFF_MIND_VISION = "Gedankensicht";
VUHDO_I18N_DEBUFF_MUTATING_INJECTION = "???Mutating Injection???"; --@TODO Find translation
VUHDO_I18N_DEBUFF_BANISH = "Verbannen";
VUHDO_I18N_DEBUFF_PHASE_SHIFT = "Phasenverschiebung";


-- Zone names
-- @EXACT = true
VUHDO_I18N_ZONE_ALTERAC = "Alteractal";
VUHDO_I18N_ZONE_WARSONG = "Kriegshymnenschlucht";
VUHDO_I18N_ZONE_ARATHI = "Arathibecken";
VUHDO_I18N_ZONE_EYE = "Auge des Sturms";


-- Heal Spell Names
-- @EXACT = true
--
VUHDO_I18N_RANK = "Rang";
-- by Class
VUHDO_I18N_NAARU_GIFT = "Gabe der Naaru";
-- Paladin
VUHDO_I18N_FLASH_OF_LIGHT = "Lichtblitz";
VUHDO_I18N_HOLY_LIGHT = "Heiliges Licht";
-- Priest
VUHDO_I18N_FLASH_HEAL = "Blitzheilung";
VUHDO_I18N_RENEW = "Erneuerung";
VUHDO_I18N_LESSER_HEAL = "Geringes Heilen";
VUHDO_I18N_HEAL = "Heilen";
VUHDO_I18N_GREATER_HEAL = "Gro\195\159e Heilung";
VUHDO_I18N_BINDING_HEAL = "Verbindende Heilung";
VUHDO_I18N_PRAYER_OF_HEALING = "Gebet der Heilung";
VUHDO_I18N_PRAYER_OF_MENDING = "Gebet der Besserung";
VUHDO_I18N_CIRCLE_OF_HEALING = "Kreis der Heilung";
-- Shaman
VUHDO_I18N_LESSER_HEALING_WAVE = "Geringe Welle der Heilung";
VUHDO_I18N_HEALING_WAVE = "Welle der Heilung";
VUHDO_I18N_CHAIN_HEAL = "Kettenheilung";
-- Druid
VUHDO_I18N_REJUVENATION = "Verj\195\188ngung";
VUHDO_I18N_HEALING_TOUCH = "Heilende Ber\195\188hrung";
VUHDO_I18N_REGROWTH = "Nachwachsen";
VUHDO_I18N_LIFEBLOOM = "Bl\195\188hendes Leben";
VUHDO_I18N_TRANQUILITY = "Gelassenheit";



-- Resurrection spells
-- @EXACT = true
VUHDO_I18N_RESURRECTION = "Auferstehung";
VUHDO_I18N_REDEMPTION = "Erl\195\182sung";
VUHDO_I18N_REBIRTH = "Wiedergeburt";
VUHDO_I18N_ANCESTRAL_SPIRIT = "Geist der Ahnen";


-- Other spells
-- @EXACT = true
-- Pala
VUHDO_I18N_PALA_CLEANSE = "Reinigung des Glaubens";
VUHDO_I18N_DIVINE_FAVOR = "G\195\182ttliche Gunst";
VUHDO_I18N_DIVINE_ILLUMINATION = "G\195\182ttliche Eingebung";
VUHDO_I18N_BLESSING_OF_PROTECTION = "Segen des Schutzes";
VUHDO_I18N_DIVINE_INTERVENTION = "G\195\182ttliches Eingreifen";
VUHDO_I18N_HOLY_SHOCK = "Heiliger Schock";
VUHDO_I18N_LAY_ON_HANDS = "Handauflegung";
-- Shammy
VUHDO_I18N_EARTH_SHIELD = "Erdschild";
VUHDO_I18N_GIFT_OF_THE_NAARU = "Gabe der Naaru";
VUHDO_I18N_CURE_DISEASE = "Krankheit heilen";
VUHDO_I18N_CURE_POISON = "Vergiftung heilen";
VUHDO_I18N_PURGE = "Reinigen";
-- Priest
VUHDO_I18N_DESPERATE_PRAYER = "Verzweifeltes Gebet";
VUHDO_I18N_POWERWORD_SHIELD = "Machtwort: Schild";
VUHDO_I18N_ABOLISH_DISEASE = "Krankheit aufheben";
VUHDO_I18N_DISPEL_MAGIC = "Magiebannung";
-- Druid
VUHDO_I18N_INNERVATE = "Anregen";
VUHDO_I18N_ABOLISH_POISON = "Vergiftung aufheben";
VUHDO_I18N_REMOVE_CURSE = "Fluch aufheben";
-- Mage
VUHDO_I18N_SPELLSTEAL = "Zauberraub";



--
-- Spell Tooltip Texts
-- @EXACT = true
--
VUHDO_I18N_TOOLTIP_FOR_1 = "um (%d+) bis (%d+)";
VUHDO_I18N_TOOLTIP_FOR_2 = "von (%d+) bis (%d+)";
VUHDO_I18N_TOOLTIP_FOR_3 = "um (%d+) Schadensp";
VUHDO_I18N_TOOLTIP_FOR_4 = "um (%d+) \195\188ber";
VUHDO_I18N_TOOLTIP_FOR_5 = "von (%d+) \195\188ber";
VUHDO_I18N_TOOLTIP_FOR_6 = "Sek. lang (%d+)";
VUHDO_I18N_TOOLTIP_FOR_7 = " lang (%d+)";
VUHDO_I18N_TOOLTIP_FOR_8 = " insgesamt (%d+)";
VUHDO_I18N_TOOLTIP_FOR_9 = " f\195\188r (%d+) heilt";
VUHDO_I18N_TOOLTIP_MORE_1 = "weitere (%d+) bis (%d+)";
VUHDO_I18N_TOOLTIP_MORE_2 = "weitere (%d+)";
VUHDO_I18N_TOOLTIP_UBER_1 = "\195\188ber (%d+) Sek";
VUHDO_I18N_TOOLTIP_UBER_2 = "(%d+) Sek. lang";



-- Chat messages
-- @EXACT = false
VUHDO_I18N_COMMAND_LIST = "\n|cffffe566 - [ VuhDo Kommandos ] -|r";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566abo|r[out] - \195\156ber VuhDo";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566gen|r[eral] - Allgemeine Optionen";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566spe|r[lls] - Einstellungen Zauber";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566col|r[ors] - Einstellungen Balkenfarben";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566pan|r[els], |cffffe566opt|r[ions] - Konfiguration Panels";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566buf|r[fs] - Einstellungen Buffs";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566res|r[et] - Panel Positionen zur\195\188cksetzen";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566lock|r - Panelpositionen sperren/freigeben";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566mm, map, minimap|r - Minimap Icon an/aus";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566show, hide, toggle|r - Panels anzeigen/verbergen";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§[broad]|cffffe566cast, mt|r[s] - Main Tanks \195\188bertragen";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566load|r [<profile>] - Lade <profile> / \195\150ffne Laden-Dialog";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566save|r [<profile>] - Speichere <profile> / \195\150ffne Speichern-Dialog";
VUHDO_I18N_COMMAND_LIST = VUHDO_I18N_COMMAND_LIST .. "§|cffffe566help,?|r - Diese Befehlsliste\n";

VUHDO_I18N_BAD_COMMAND = "Ung\195\188ltiges Argument! Gib '/vuhdo help' oder '/vd ?' f\195\188r eine Liste der Kommandos ein.";
VUHDO_I18N_CHAT_SHOWN = "|cffffe566sichtbar|r.";
VUHDO_I18N_CHAT_HIDDEN = "|cffffe566versteckt|r.";
VUHDO_I18N_MM_ICON = "Das Minimap-Symbol ist jetzt ";
VUHDO_I18N_MTS_BROADCASTED = "Die Main-Tanks wurden dem Raid \195\188bertragen";
VUHDO_I18N_SAVED_PROFILE_AS = "Das aktuelle Profil wurde gespeichert unter ";
VUHDO_I18N_PROFILE_NO_EXIST_1 = "Ein Profil namens |cffffe566";
VUHDO_I18N_PROFILE_NO_EXIST_2 = "|r existiert nicht.";
VUHDO_I18N_PROFILE_ENABLED_1 = "Profil |cffffe566";
VUHDO_I18N_PROFILE_ENABLED_2 = "|r wurde aktiviert.";
VUHDO_I18N_PANELS_SHOWN = "Die Heil-Panels werden jetzt |cffffe566angezeigt|r.";
VUHDO_I18N_PANELS_HIDDEN = "Die Heil-Panels werden jetzt |cffffe566versteckt|r.";
VUHDO_I18N_LOCK_PANELS_PRE = "Die Panel-Positionen sind jetzt ";
VUHDO_I18N_LOCK_PANELS_LOCKED = "|cffffe566gesperrt|r.";
VUHDO_I18N_LOCK_PANELS_UNLOCKED = "|cffffe566freigegeben|r.";
VUHDO_I18N_PANELS_RESET = "Die Panel-Positionen wurden zur\195\188ckgesetzt.";


-- Config Pop-Up
-- @EXACT = false
VUHDO_I18N_ROLE = "Rolle";
VUHDO_I18N_MAIN_ASSIST = "Zielgeber";
VUHDO_I18N_SET_BUFF = "Setze Buff";


-- Minimap
-- @EXACT = false
VUHDO_I18N_VUHDO_OPTIONS = "VuhDo Optionen";
VUHDO_I18N_ABOUT = "\195\156ber...";
VUHDO_I18N_SPELL_SETTINGS = "Zauber";
VUHDO_I18N_PANEL_SETUP = "Panel";
VUHDO_I18N_GENEREAL_SETTING = "Allgemein";
VUHDO_I18N_BAR_COLORS = "Balkenfarben";
VUHDO_I18N_MM_TOOLTIP = "Linksklick: Panel-Einstellungen\nRechtsklick: Men\195\188";
VUHDO_I18N_LOAD_PROFILE = "Profil laden";
VUHDO_I18N_SAVE_PROFILE_AS = "Profil speichern";
VUHDO_I18N_TOGGLES = "Schalter";
VUHDO_I18N_LOCK_PANELS = "Panels sperren";
VUHDO_I18N_SHOW_PANELS = "Panels anzeigen";
VUHDO_I18N_MM_BUTTON = "Minimap-Symbol";
VUHDO_I18N_CLOSE = "Schlie\195\159en";
VUHDO_I18N_BROADCAST_MTS = "MTs \195\188bertragen";
VUHDO_I18N_SHOW_BUFF_WATCH = "Buff Watch anzeigen";


-- Buff categories
-- @EXACT = false
-- Priest
VUHDO_I18N_BUFFC_FORTITUDE = "01Seelenst\195\164rke";
VUHDO_I18N_BUFFC_SHADOW_PROTECTION = "03Schattenschutz";
VUHDO_I18N_BUFFC_SPIRIT = "02Willenskraft";
VUHDO_I18N_BUFFC_FEAR_WARD = "04Furchtzauberschutz";
VUHDO_I18N_BUFFC_INNER_FIRE = "05Inneres Feuer";
VUHDO_I18N_BUFFC_SHADOW_SHIELD = "07Schattenschild";
VUHDO_I18N_BUFFC_SHADOW_FIEND = "06Schattengeist";
-- Shaman
VUHDO_I18N_BUFFC_EARTH_SHIELD = "07Erdschild";
VUHDO_I18N_BUFFC_WEAPON_ENCHANT = "08Waffenverzauberung";
VUHDO_I18N_BUFFC_FIRE_TOTEM = "01Feuertotem";
VUHDO_I18N_BUFFC_AIR_TOTEM = "02Lufttotem";
VUHDO_I18N_BUFFC_EARTH_TOTEM = "03Erdtotem";
VUHDO_I18N_BUFFC_WATER_TOTEM = "04Wassertotem";
VUHDO_I18N_BUFFC_HEROISM = "05Heldentum";
VUHDO_I18N_BUFFC_BLOODLUST = "06Kampfrausch";
VUHDO_I18N_BUFFC_SHIELDS = "09Schilde";
VUHDO_I18N_BUFFC_MANA_TIDE = "10Manaflut";
-- Paladin
VUHDO_I18N_BUFFC_BLESSING = "01Segen";
VUHDO_I18N_BUFFC_RIGHTEOUS_FURY = "03Zorn der Gerechtigkeit";
VUHDO_I18N_BUFFC_AURA = "02Aura";
-- Druids
VUHDO_I18N_BUFFC_INNERVATE = "02Anregen";
VUHDO_I18N_BUFFC_TRANQUILITY = "04Gelassenheit";
VUHDO_I18N_BUFFC_GIFT_OF_THE_WILD = "01Gabe der Wildnis";
VUHDO_I18N_BUFFC_REBIRTH = "03Wiedergeburt";
-- Warlock
VUHDO_I18N_BUFFC_SOULSTONE = "01Seelenstein";
VUHDO_I18N_BUFFC_SKIN = "02R\195\188stung";
-- Mage
VUHDO_I18N_BUFFC_ARCANCE_BRILLIANCE = "01Arkane Brillanz";
VUHDO_I18N_BUFFC_ICE_BLOCK = "02Eisblock";
VUHDO_I18N_BUFFC_INVISIBILITY = "03Unsichtbarkeit";


-- Buff names
-- @EXACT = true
-- Priest
VUHDO_I18N_BUFF_PRAYER_OF_FORTITUDE = "Gebet der Seelenst\195\164rke";
VUHDO_I18N_BUFF_POWER_WORD_FORTITUDE = "Machtwort: Seelenst\195\164rke";
VUHDO_I18N_BUFF_PRAYER_OF_SHADOW_PROTECTION = "Gebet des Schattenschutzes";
VUHDO_I18N_BUFF_SHADOW_PROTECTION = "Schattenschutz";
VUHDO_I18N_BUFF_DIVINE_SPIRIT = "G\195\182ttlicher Wille";
VUHDO_I18N_BUFF_PRAYER_OF_SPIRIT = "Gebet der Willenskraft";
VUHDO_I18N_BUFF_FEAR_WARD = "Furchtzauberschutz";
VUHDO_I18N_BUFF_INNER_FIRE = "Inneres Feuer";
VUHDO_I18N_BUFF_SHADOWGUARD = "Schattenschild";
VUHDO_I18N_BUFF_SHADOWFIEND = "Schattengeist";
-- Shaman
VUHDO_I18N_BUFF_EARTH_SHIELD = "Erdschild"
VUHDO_I18N_BUFF_FLAMETONGUE_WEAPON = "Waffe der Flammenzunge";
VUHDO_I18N_BUFF_ROCKBITER_WEAPON = "Waffe des Felsbei\195\159ers";
VUHDO_I18N_BUFF_FROSTBRAND_WEAPON = "Waffe des Frostbrands";
VUHDO_I18N_BUFF_WINDFURY_WEAPON = "Waffe des Windzorns";
VUHDO_I18N_BUFF_FIRE_NOVA_TOTEM = "Totem der Feuernova";
VUHDO_I18N_BUFF_FLAMETONGUE_TOTEM = "Totem der Flammenzunge";
VUHDO_I18N_BUFF_SEARING_TOTEM = "Totem der Verbrennung";
VUHDO_I18N_BUFF_FIRE_ELEMENTAL_TOTEM = "Totem des Feuerelementars";
VUHDO_I18N_BUFF_FROST_RESISTANCE_TOTEM = "Totem des Frostwiderstands";
VUHDO_I18N_BUFF_MAGMA_TOTEM = "Totem des gl\195\188henden Magmas";
VUHDO_I18N_BUFF_GROUNDING_TOTEM = "Totem der Erdung";
VUHDO_I18N_BUFF_WINDWALL_TOTEM = "Totem der Windmauer";
VUHDO_I18N_BUFF_TRANQUIL_AIR_TOTEM = "Totem der beruhigenden Winde";
VUHDO_I18N_BUFF_GRACE_OF_AIR_TOTEM = "Totem der luftgleichen Anmut";
VUHDO_I18N_BUFF_NATURE_RESISTANCE_TOTEM = "Totem des Naturwiderstands";
VUHDO_I18N_BUFF_WINDFURY_TOTEM = "Totem des Windzorns";
VUHDO_I18N_BUFF_WRATH_OF_AIR_TOTEM = "Totem des st\195\188rmischen Zorns";
VUHDO_I18N_BUFF_EARTHBIND_TOTEM = "Totem der Erdbindung";
VUHDO_I18N_BUFF_STRENGTH_OF_EARTH_TOTEM = "Totem der Erdst\195\164rke";
VUHDO_I18N_BUFF_STONESKIN_TOTEM = "Totem der Steinhaut";
VUHDO_I18N_BUFF_STONECLAW_TOTEM = "Totem der Steinklaue";
VUHDO_I18N_BUFF_EARTH_ELEMENTAL_TOTEM = "Totem des Erdelementars";
VUHDO_I18N_BUFF_TREMOR_TOTEM = "Totem des Erdsto\195\159es";
VUHDO_I18N_BUFF_SENTRY_TOTEM = "Totem des Wachens";
VUHDO_I18N_BUFF_POISON_CLEANSING_TOTEM = "Totem der Giftreinigung";
VUHDO_I18N_BUFF_DISEASE_CLEANSING_TOTEM = "Totem der Krankheitsreinigung";
VUHDO_I18N_BUFF_MANA_SPRING_TOTEM = "Totem der Manaquelle";
VUHDO_I18N_BUFF_FIRE_RESISTANCE_TOTEM = "Totem des Feuerwiderstands";
VUHDO_I18N_BUFF_HEALING_STREAM_TOTEM = "Totem des heilenden Flusses";
VUHDO_I18N_BUFF_HEROISM = "Heldentum";
VUHDO_I18N_BUFF_BLOODLUST = "Kampfrausch";
VUHDO_I18N_BUFF_LIGHTNING_SHIELD = "Blitzschlagschild";
VUHDO_I18N_BUFF_WATER_SHIELD = "Wasserschild";
VUHDO_I18N_BUFF_MANA_TIDE = "Totem der Manaflut";
-- Paladin
VUHDO_I18N_BUFF_GREATER_BLESSING_OF_WISDOM = "Gro\195\159er Segen der Weisheit";
VUHDO_I18N_BUFF_BLESSING_OF_WISDOM = "Segen der Weisheit";
VUHDO_I18N_BUFF_GREATER_BLESSING_OF_MIGHT = "Gro\195\159er Segen der Macht";
VUHDO_I18N_BUFF_BLESSING_OF_MIGHT = "Segen der Macht";
VUHDO_I18N_BUFF_GREATER_BLESSING_OF_SALVATION = "Gro\195\159er Segen der Rettung";
VUHDO_I18N_BUFF_BLESSING_OF_SALVATION = "Segen der Rettung";
VUHDO_I18N_BUFF_GREATER_BLESSING_OF_LIGHT = "Gro\195\159er Segen des Lichts";
VUHDO_I18N_BUFF_BLESSING_OF_LIGHT = "Segen des Lichts";
VUHDO_I18N_BUFF_GREATER_BLESSING_OF_SANCTUARY = "Gro\195\159er Segen des Refugiums";
VUHDO_I18N_BUFF_BLESSING_OF_SANCTUARY = "Segen des Refugiums";
VUHDO_I18N_BUFF_GREATER_BLESSING_OF_THE_KINGS = "Gro\195\159er Segen der K\195\182nige";
VUHDO_I18N_BUFF_BLESSING_OF_THE_KINGS = "Segen der K\195\182nige";
VUHDO_I18N_BUFF_RIGHTEOUS_FURY = "Zorn der Gerechtigkeit";
VUHDO_I18N_BUFF_DEVOTION_AURA = "Aura der Hingabe";
VUHDO_I18N_BUFF_RETRIBUTION_AURA = "Aura der Vergeltung";
VUHDO_I18N_BUFF_CONCENTRATION_AURA = "Aura der Konzentration";
VUHDO_I18N_BUFF_SANCTITY_AURA = "Aura der Heiligkeit";
VUHDO_I18N_BUFF_SHADOW_RESISTANCE_AURA = "Aura des Schattenwiderstands";
VUHDO_I18N_BUFF_FROST_RESISTANCE_AURA = "Aura des Frostwiderstands";
VUHDO_I18N_BUFF_FIRE_RESISTANCE_AURA = "Aura des Feuerwiderstands";
VUHDO_I18N_BUFF_CRUSADER_AURA = "Aura des Kreuzfahrers";
-- Druid
VUHDO_I18N_BUFF_INNERVATE = "Anregen";
VUHDO_I18N_BUFF_TRANQUILITY = "Gelassenheit";
VUHDO_I18N_BUFF_MARK_OF_THE_WILD = "Mal der Wildnis";
VUHDO_I18N_BUFF_GIFT_OF_THE_WILD = "Gabe der Wildnis";
VUHDO_I18N_BUFF_REBIRTH = "Wiedergeburt";
-- Warlock
VUHDO_I18N_BUFF_CREATE_SOULSTONE = "Seelenstein herstellen";
VUHDO_I18N_BUFF_DEMON_SKIN = "D\195\164monenhaut";
VUHDO_I18N_BUFF_FEL_ARMOR = "Teufelsr\195\188stung";
-- Mage
VUHDO_I18N_BUFF_ARCANE_BRILLIANCE = "Arkane Brillanz";
VUHDO_I18N_BUFF_ARCANE_INTELLECT = "Arkane Intelligenz";
VUHDO_I18N_BUFF_ICE_BLOCK = "Eisblock";
VUHDO_I18N_BUFF_INVISIBILITY = "Unsichtbarkeit";
