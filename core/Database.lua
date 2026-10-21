-- SPDX-License-Identifier: MPL-2.0
-- Copyright (c) 2026 Hannes Weichselbaum
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

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
    if db.outputLanguage ~= nil and not addon.outputLanguages[db.outputLanguage] then
        addon.Notify("Ungueltige Ausgabesprache; Deutsch wird verwendet.")
        db.outputLanguage = nil
    end
    db.outputLanguage = db.outputLanguage or addon.defaults.outputLanguage
    for key, range in pairs({ambientChance={0,100}, ambientMinInterval={30,3600}, ambientMaxInterval={30,7200}}) do
        local value = db[key]
        if type(value) ~= "number" or value ~= value or value % 1 ~= 0 or value < range[1] or value > range[2] then
            db[key] = addon.defaults[key]
        end
    end
    if db.ambientMaxInterval < db.ambientMinInterval then db.ambientMaxInterval = db.ambientMinInterval end
    if type(db.ambientEnabled) ~= "boolean" then db.ambientEnabled = addon.defaults.ambientEnabled end
    if type(db.ambientInCombat) ~= "boolean" then db.ambientInCombat = addon.defaults.ambientInCombat end
    addon.runtimeOutputLanguage = db.outputLanguage
    addon.db = db
end
