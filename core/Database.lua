local _, addon = ...


-- Normalisiert Custom-Rassen von WoW Forever.
-- Der lokalisierte Rassenname wird bewusst mitgeprueft, falls der Beta-Client
-- fuer eine neue Rasse intern noch einen Legacy-Token liefert.
function addon.GetPlayerRaceToken()
    local localizedRace, raceToken = UnitRace("player")

    local function IsSkyborne(value)
        if type(value) ~= "string" then
            return false
        end
        local lowered = value:lower()
        return lowered:find("skyborne", 1, true) ~= nil
            or lowered:find("himmelsgebor", 1, true) ~= nil
    end

    if IsSkyborne(localizedRace) or IsSkyborne(raceToken) then
        return "Skyborne"
    end
    if raceToken == "Scourge" then
        return "Undead"
    end
    return raceToken
end

function addon.Notify(message)
    print("|cff70c090Druiden RP:|r " .. message)
end

function addon.ValidNumber(value, maximum)
    return type(value) == "number" and value == value
        and value >= 0 and value <= maximum and value % 1 == 0
end

function addon.InitializeDatabase()
    if DruidenRP_CharacterDB ~= nil and type(DruidenRP_CharacterDB) ~= "table" then
        addon.Notify("Ungueltige gespeicherte Einstellungen; Standardwerte werden geladen.")
        DruidenRP_CharacterDB = nil
    end
    DruidenRP_CharacterDB = DruidenRP_CharacterDB or {}
    local db = DruidenRP_CharacterDB
    for _, key in ipairs({ "textChance", "cooldown" }) do
        local maximum = key == "textChance" and 100 or 3600
        if db[key] ~= nil and not addon.ValidNumber(db[key], maximum) then
            addon.Notify("Ungueltiger Wert fuer " .. key .. "; Standardwert wird geladen.")
            db[key] = nil
        end
        if db[key] == nil then
            db[key] = addon.defaults[key]
        end
    end
    if db.chatChannel ~= nil and not addon.channels[db.chatChannel] then
        addon.Notify("Ungueltiger Chatkanal; Standardkanal wird geladen.")
        db.chatChannel = nil
    end
    db.chatChannel = db.chatChannel or addon.defaults.chatChannel
    db.chatChannelVersion = 1
    if db.personalTexts ~= nil and type(db.personalTexts) ~= "table" then
        addon.Notify("Ungueltige eigene Texte; Textsammlung wird zurueckgesetzt.")
        db.personalTexts = nil
    end
    db.personalTexts = db.personalTexts or {}
    addon.db = db
end
