local _, addon = ...

SLASH_DRUIDENRP1 = "/drp"
SLASH_DRUIDENRP2 = "/druidenrp"
SlashCmdList.DRUIDENRP = function(message)
    if not addon.ready then
        addon.Notify("Noch nicht geladen. Bitte wartet auf PLAYER_LOGIN.")
        return
    end
    local command, argument = (message or ""):match("^%s*(%S+)%s*(.-)%s*$")
    command = command and command:lower() or "help"
    argument = argument or ""
    if command == "help" and argument == "" then
        addon.Notify("/drp list | /drp <schluessel> | /drp status")
        addon.Notify("/drp chance 0-100 | /drp cooldown 0-3600")
        addon.Notify("/drp channel [SAY | YELL | EMOTE | PARTY | RAID | INSTANCE_CHAT | AUTO]")
        addon.Notify("Keine automatischen Zaubertexte: Befehle in Eure Zaubermakros aufnehmen.")
    elseif command == "list" and argument == "" then
        local keys = {}
        for key in pairs(addon.texts) do
            keys[#keys + 1] = key
        end
        table.sort(keys)
        for _, key in ipairs(keys) do
            addon.Notify(key .. " - " .. addon.texts[key].name)
        end
    elseif command == "status" and argument == "" then
        addon.Notify(string.format("Chance: %g%% | Cooldown: %gs | Kanal: %s",
            addon.db.textChance, addon.db.cooldown, addon.db.chatChannel))
    elseif command == "chance" or command == "cooldown" then
        local maximum = command == "chance" and 100 or 3600
        local value = tonumber(argument)
        if not argument:match("^%d+$") or not addon.ValidNumber(value, maximum) then
            addon.Notify("Benutzung: /drp " .. command .. " <ganze Zahl 0-" .. maximum .. ">")
            return
        end
        local key = command == "chance" and "textChance" or "cooldown"
        addon.db[key] = value
        addon.Notify(command .. ": " .. value)
    elseif command == "channel" then
        if argument == "" then
            addon.Notify("Aktueller Chatkanal: " .. addon.db.chatChannel)
            return
        end
        local channel = argument:upper()
        if not addon.channels[channel] then
            addon.Notify("Kanaele: AUTO, SAY, YELL, EMOTE, PARTY, RAID, INSTANCE_CHAT")
            return
        end
        addon.db.chatChannel = channel
        addon.Notify("Chatkanal: " .. channel)
    elseif argument ~= "" then
        addon.Notify("Benutzung: /drp <textschluessel>. /drp help zeigt die Befehle.")
    else
        addon.TryText(command)
    end
end
