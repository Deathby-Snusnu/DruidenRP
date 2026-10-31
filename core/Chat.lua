-- SPDX-License-Identifier: MPL-2.0
-- Copyright (c) 2026 Hannes Weichselbaum
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local _, addon = ...

addon.channels = {
    AUTO = true, SAY = true, YELL = true, EMOTE = true,
    PARTY = true, RAID = true, INSTANCE_CHAT = true,
}
local racialLanguageIDs = {
    NightElf = 2, Skyborne = 2, Tauren = 3, Troll = 14, Worgen = 7,
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
    local race = addon.GetPlayerRaceToken()
    local wanted = racialLanguageIDs[race]
    for index = 1, GetNumLanguages() do
        local _, languageID = GetLanguageByIndex(index)
        if languageID == wanted then
            return languageID
        end
    end
    return nil
end

local function PrepareText(text)
    local startsWithStar = text:sub(1, 1) == "*"
    local endsWithStar = text:sub(-1) == "*"

    if startsWithStar ~= endsWithStar then
        addon.Notify("Text nicht gesendet: fehlerhafte Emote-Markierung.")
        return nil, nil
    end

    if startsWithStar and endsWithStar then
        local emoteText = text:sub(2, -2):match("^%s*(.-)%s*$")
        if not emoteText or emoteText == "" then
            addon.Notify("Text nicht gesendet: leeres Emote.")
            return nil, nil
        end
        return emoteText, true
    end

    return text, false
end

function addon.SendText(text)
    if type(text) ~= "string" or text == "" then
        addon.Notify("Kein nutzbarer Text vorhanden.")
        return false
    end

    local message, isEmote = PrepareText(text)
    if not message then
        return false
    end

    if #message > 255 or message:find("[\r\n]") or message:find("|", 1, true) then
        addon.Notify("Text nicht gesendet: maximal 255 Bytes, keine Zeilenumbrueche oder Chat-Markierungen.")
        return false
    end
    local channel = isEmote and "EMOTE" or addon.GetChatChannel()
    if not channel then
        return false
    end
    if not C_ChatInfo or type(C_ChatInfo.SendChatMessage) ~= "function" then
        addon.Notify("Dieser Client stellt keine unterstuetzte Chat-API bereit.")
        return false
    end
    local languageID
    if channel == "SAY" or channel == "YELL" then
        local rpChat = _G.RPChatMod
        if type(rpChat) == "table" and type(rpChat.GetChatLanguageID) == "function" then
            languageID = rpChat.GetChatLanguageID(channel)
        else
            languageID = GetRacialLanguageID()
        end
    end
    C_ChatInfo.SendChatMessage(message, channel, languageID)
    return true
end
