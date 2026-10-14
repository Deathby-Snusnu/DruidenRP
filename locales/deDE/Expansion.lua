-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Copyright (c) 2026 Hannes Weichselbaum
--
-- Supplemental role-playing dialogue, emote, ambient, and translation text.
-- Licensed under Creative Commons Attribution-ShareAlike 4.0 International.

local _, addon = ...

local groupSpeech = 'Die Wildnis antwortet auf meinen Ruf.'
local groupEmote = '*sammelt sich einen Augenblick, waehrend die Kraefte der Wildnis antworten.*'
local targetSpeech = 'Die Wildnis wendet sich Euch zu, %s.'
local targetEmote = '*richtet die Aufmerksamkeit der Wildnis auf %s.*'

local function appendUnique(list, text)
    if type(list) ~= "table" then return end
    for _, value in ipairs(list) do
        if value == text then return end
    end
    list[#list + 1] = text
end

local function expand(node, seen)
    if type(node) ~= "table" or seen[node] then return end
    seen[node] = true
    if type(node.ziel) == "table" then
        appendUnique(node.ziel, targetSpeech)
        appendUnique(node.ziel, targetEmote)
    end
    if type(node.gruppe) == "table" then
        appendUnique(node.gruppe, groupSpeech)
        appendUnique(node.gruppe, groupEmote)
    end
    if type(node.name) == "string" and node.name ~= "" then
        if type(node.gruppe) == "table" then appendUnique(node.gruppe, "*konzentriert sich auf " .. node.name .. ", waehrend die Wildnis antwortet.*") end
        if type(node.ziel) == "table" then appendUnique(node.ziel, "*lenkt " .. node.name .. " mit ruhiger Geste auf %s.*") end
    end
    for key, value in pairs(node) do
        if key ~= "ziel" and key ~= "gruppe" and type(value) == "table" then
            expand(value, seen)
        end
    end
end

for _, container in ipairs({addon.localeData.deDE.texts, addon.localeData.deDE.racial}) do
    expand(container, {})
end
