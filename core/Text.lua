-- SPDX-License-Identifier: MPL-2.0
-- Copyright (c) 2026 Hannes Weichselbaum
--
-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local _, addon = ...

local SELF_ONLY = {
    TRANQUILITY=true, BARKSKIN=true, NATURES_GRASP=true,
    BEAR=true, CAT=true, TRAVEL=true, AQUATIC=true, MOONKIN=true, TREE=true, FLIGHT=true,
}
local FRIENDLY_OR_SELF = {
    MARK=true, THORNS=true, REJUVENATION=true, REGROWTH=true, HEALING_TOUCH=true, INNERVATE=true,
}
local FRIENDLY_ONLY = { REBIRTH=true }

local function ChooseArray(pool, targetName)
    if type(pool) ~= "table" or #pool == 0 then return nil end
    local usable = {}
    for _, text in ipairs(pool) do
        if type(text) == "string" and text ~= "" then
            local needsTarget = text:find("%s",1,true) ~= nil
            if not needsTarget or targetName then usable[#usable+1] = text end
        end
    end
    if #usable == 0 then return nil end
    local text = usable[math.random(#usable)]
    if targetName then text = text:gsub("%%s", function() return targetName end) end
    return text
end

local function ChooseText(pool, targetName)
    if type(pool) ~= "table" then return nil end
    if #pool > 0 then return ChooseArray(pool, targetName) end
    if targetName then
        local text = ChooseArray(pool.ziel, targetName)
        if text then return text end
    end
    local text = ChooseArray(pool.gruppe, targetName)
    if text then return text end
    return ChooseArray(pool.ziel, targetName)
end

local function FriendlyTargetName()
    if UnitExists("target") and UnitCanAssist("player", "target") then return UnitName("target") end
end

local function ResolveTargetName(key)
    if SELF_ONLY[key] then return nil end
    if FRIENDLY_OR_SELF[key] then return FriendlyTargetName() or UnitName("player") end
    if FRIENDLY_ONLY[key] then return FriendlyTargetName() end
    if UnitExists("target") then return UnitName("target") end
end

function addon.BuildText(key)
    local targetName = ResolveTargetName(key)
    local personal = addon.db.personalTexts[key]
    if personal then
        local text = ChooseText(personal, targetName)
        if text then return text end
    end

    local race = addon.GetPlayerRaceToken()
    local lang = addon.GetOutputLanguage()
    local pool = addon.GetLocalePoolExact(lang, "racial", race, key)
        or addon.GetLocalePoolExact(lang, "texts", key)
        or addon.GetLocalePoolExact("deDE", "racial", race, key)
        or addon.GetLocalePoolExact("deDE", "texts", key)
    return ChooseText(pool, targetName)
end

addon.ChooseStructuredText = ChooseText
