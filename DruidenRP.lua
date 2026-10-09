local _, addon = ...

local DruidenRP = addon
addon.DruidenRP = addon

local lastRPText
local ready = false
local isDruid = false
local channels = {
    AUTO = true, SAY = true, YELL = true, EMOTE = true,
    PARTY = true, RAID = true, INSTANCE_CHAT = true,
}
local racialLanguageIDs = {
    NightElf = 2,
    Tauren = 3,
    Troll = 14,
    Worgen = 7,
}

local function Notify(message)
    print("|cff70c090Druiden RP:|r " .. message)
end

local function ValidNumber(value, minimum, maximum)
    return type(value) == "number" and value == value
        and value >= minimum and value <= maximum
end

local function InitializeDatabase()
    if DruidenRP_CharacterDB ~= nil and type(DruidenRP_CharacterDB) ~= "table" then
        Notify("Ungueltige gespeicherte Einstellungen; Standardwerte werden geladen.")
        DruidenRP_CharacterDB = nil
    end
    DruidenRP_CharacterDB = DruidenRP_CharacterDB or {}
    local db = DruidenRP_CharacterDB
    for _, key in ipairs({ "textChance", "cooldown" }) do
        local maximum = key == "textChance" and 100 or 3600
        if db[key] ~= nil and not ValidNumber(db[key], 0, maximum) then
            Notify("Ungueltiger Wert fuer " .. key .. "; Standardwert wird geladen.")
            db[key] = nil
        end
        if db[key] == nil then
            db[key] = addon.defaults[key]
        end
    end
    if db.chatChannelVersion == nil then
        if db.chatChannel == "AUTO" then
            db.chatChannel = addon.defaults.chatChannel
        end
        db.chatChannelVersion = 1
    end
    if db.chatChannel ~= nil and not channels[db.chatChannel] then
        Notify("Ungueltiger Chatkanal; Standardkanal wird geladen.")
        db.chatChannel = nil
    end
    db.chatChannel = db.chatChannel or addon.defaults.chatChannel
    if db.personalTexts ~= nil and type(db.personalTexts) ~= "table" then
        Notify("Ungueltige eigene Texte; Textsammlung wird zurueckgesetzt.")
        db.personalTexts = nil
    end
    db.personalTexts = db.personalTexts or {}
end

local function GetChatChannel()
    local channel = DruidenRP_CharacterDB.chatChannel
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
    if channel == "PARTY" and not IsInGroup()
        or channel == "RAID" and not IsInRaid()
        or channel == "INSTANCE_CHAT" and not IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
        Notify("Der eingestellte Chatkanal ist hier nicht verfuegbar. Nutzt /drp channel AUTO.")
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

local function ChooseText(pool, targetName)
    if type(pool) ~= "table" then
        return nil
    end
    local choices = pool
    if #pool == 0 then
        choices = targetName and pool.ziel or pool.gruppe
        if type(choices) ~= "table" or #choices == 0 then
            choices = pool.gruppe
        end
    end
    if type(choices) ~= "table" or #choices == 0 then
        return nil
    end
    local usable = {}
    for _, text in ipairs(choices) do
        if type(text) == "string" and text ~= ""
            and (targetName or not text:find("%s", 1, true)) then
            usable[#usable + 1] = text
        end
    end
    if #usable == 0 then
        return nil
    end
    local text = usable[math.random(#usable)]
    -- A function replacement keeps percent characters in player names literal.
    return (text:gsub("%%s", function() return targetName end))
end

function addon.TryText(key)
    if not ready then
        Notify("Noch nicht geladen. Bitte wartet auf PLAYER_LOGIN.")
        return false
    end
    if not isDruid then
        Notify("RP-Texte sind nur fuer Druiden verfuegbar.")
        return false
    end
    if type(key) ~= "string" or key == "" then
        Notify("Benutzung: /drp <textschluessel>. /drp list zeigt alle Texte.")
        return false
    end
    key = key:upper()
    local db = DruidenRP_CharacterDB
    local targetName = UnitExists("target") and UnitName("target") or nil
    local _, race = UnitRace("player")
    local personal = db.personalTexts[key]
    local racial = addon.racial[race] and addon.racial[race][key]
    local pool = personal or racial or addon.texts[key]
    local text = ChooseText(pool, targetName)
    if not text then
        Notify("Kein nutzbarer Text fuer " .. key .. " vorhanden.")
        return false
    end
    local now = GetTime()
    if lastRPText and now - lastRPText < db.cooldown then
        return false
    end
    if math.random(100) > db.textChance then
        return false
    end
    local channel = GetChatChannel()
    if not channel then
        return false
    end
    if #text > 255 or text:find("[\r\n]") or text:find("|", 1, true) then
        Notify("Text nicht gesendet: maximal 255 Bytes, keine Zeilenumbrueche oder Chat-Markierungen.")
        return false
    end
    local languageID
    if channel == "SAY" or channel == "YELL" then
        languageID = GetRacialLanguageID()
    end
    if not C_ChatInfo or not C_ChatInfo.SendChatMessage then
        Notify("Dieser Client stellt keine unterstuetzte Chat-API bereit.")
        return false
    end
    C_ChatInfo.SendChatMessage(text, channel, languageID)
    lastRPText = now
    return true
end

SLASH_DRUIDENRP1 = "/drp"
SLASH_DRUIDENRP2 = "/druidenrp"
SlashCmdList.DRUIDENRP = function(message)
    if not ready then
        Notify("Noch nicht geladen. Bitte wartet auf PLAYER_LOGIN.")
        return
    end
    local command, argument = (message or ""):match("^%s*(%S+)%s*(.-)%s*$")
    command = command and command:lower() or "help"
    if command == "help" then
        Notify("/drp list | /drp <schluessel> | /drp status")
        Notify("/drp chance 0-100 | /drp cooldown 0-3600")
        Notify("/drp channel SAY | YELL | EMOTE | PARTY | RAID | INSTANCE_CHAT | AUTO")
        Notify("Keine automatischen Zaubertexte: Befehle in Eure Zaubermakros aufnehmen.")
    elseif command == "list" then
        local keys = {}
        for key in pairs(addon.texts) do
            keys[#keys + 1] = key
        end
        table.sort(keys)
        for _, key in ipairs(keys) do
            Notify(key .. " - " .. addon.texts[key].name)
        end
    elseif command == "status" then
        local db = DruidenRP_CharacterDB
        Notify(string.format("Chance: %g%% | Cooldown: %gs | Kanal: %s",
            db.textChance, db.cooldown, db.chatChannel))
    elseif command == "chance" or command == "cooldown" then
        local maximum = command == "chance" and 100 or 3600
        local value = tonumber(argument)
        if not ValidNumber(value, 0, maximum) or value % 1 ~= 0 then
            Notify("Benutzung: /drp " .. command .. " <ganze Zahl 0-" .. maximum .. ">")
            return
        end
        local key = command == "chance" and "textChance" or "cooldown"
        DruidenRP_CharacterDB[key] = value
        Notify(command .. ": " .. value)
    elseif command == "channel" then
        local channel = argument:upper()
        if not channels[channel] then
            Notify("Kanaele: AUTO, SAY, YELL, EMOTE, PARTY, RAID, INSTANCE_CHAT")
            return
        end
        DruidenRP_CharacterDB.chatChannel = channel
        Notify("Chatkanal: " .. channel)
    elseif argument ~= "" then
        Notify("Benutzung: /drp <textschluessel>. /drp help zeigt die Befehle.")
    else
        addon.TryText(command)
    end
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", function()
    InitializeDatabase()
    local _, class = UnitClass("player")
    isDruid = class == "DRUID"
    ready = true
    Notify("geladen. Befehle: /drp und /druidenrp.")
    if not isDruid then
        Notify("Kein Druide: Einstellungen verfuegbar, RP-Ausgabe deaktiviert.")
    end
end)
