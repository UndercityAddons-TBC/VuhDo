


--
function VUHDO_parseAddonMessage(anArg1, anArg2, anArg3, anArg4)
	--VUHDO_Msg("Addon message:" .. anArg1 .. "/" .. anArg2);

	-- CTRaidAssistMessage?
  if (VUHDO_CHAT_PREFIX_CTRA == anArg1) then
  	-- and VUHDO_getAddOnDistribution() == anArg3
  	local tempNick = anArg4;
  	local tempMessage = anArg2;
		--VUHDO_Msg("CTRA message:" .. tempNick .. "/" .. tempMessage);
		if (string.find(tempMessage, "#")) then
			local tempFragments = VUHDO_splitString(tempMessage, "#");
			local tempCommand;
			for _, tempCommand in pairs(tempFragments) do
				VUHDO_parseCtraMessage(tempNick, tempCommand);
			end
		else
			VUHDO_parseCtraMessage(tempNick, tempMessage);
		end
	elseif (VUHDO_CHAT_PREFIX_HEAL_COMM == anArg1) then
		--VUHDO_Msg("Addon-Message: " .. anArg1.. " / " .. anArg2 .. " / " .. anArg4);
		VUHDO_parseHealCommMessage(anArg2, anArg4);
  end
end
