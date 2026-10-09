local _, addon = ...

addon.channels = {
    AUTO = true, SAY = true, YELL = true, EMOTE = true,
    PARTY = true, RAID = true, INSTANCE_CHAT = true,
}
local racialLanguageIDs = {
    NightElf = 2, Tauren = 3, Troll = 14, Worgen = 7,
}

function addon.GetChatChannel()
    local channel = addon.db.chatChannel
    if channel == "AUTO" then
        if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
            return "INSTANCE_CHAT"
        elseif IsInRaid() then
            return "RAID"
        elseif IsInGroup() then
            return "PARTY"
        end
        return "SAY"
    end
    if not addon.channels[channel] then
        addon.Notify("Ungueltiger Chatkanal. Nutzt /drp channel.")
        return nil
    end
    if channel == "PARTY" and not IsInGroup()
        or channel == "RAID" and not IsInRaid()
        or channel == "INSTANCE_CHAT" and not IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        addon.Notify("Der eingestellte Chatkanal ist hier nicht verfuegbar. Nutzt /drp channel AUTO.")
        return nil
    end
    return channel
end

local function GetRacialLanguageID()
    local _, race = UnitRace("player")
    local wanted = racialLanguageIDs[race]
    for index = 1, GetNumLanguages() do
        local _, languageID = GetLanguageByIndex(index)
        if languageID == wanted then
            return languageID
        end
    end
    return nil
end

function addon.SendText(text)
    if type(text) ~= "string" or text == "" then
        addon.Notify("Kein nutzbarer Text vorhanden.")
        return false
    end
    if #text > 255 or text:find("[\r\n]") or text:find("|", 1, true) then
        addon.Notify("Text nicht gesendet: maximal 255 Bytes, keine Zeilenumbrueche oder Chat-Markierungen.")
        return false
    end
    local channel = addon.GetChatChannel()
    if not channel then
        return false
    end
    if not C_ChatInfo or type(C_ChatInfo.SendChatMessage) ~= "function" then
        addon.Notify("Dieser Client stellt keine unterstuetzte Chat-API bereit.")
        return false
    end
    local languageID
    if channel == "SAY" or channel == "YELL" then
        languageID = GetRacialLanguageID()
    end
    C_ChatInfo.SendChatMessage(text, channel, languageID)
    return true
end
