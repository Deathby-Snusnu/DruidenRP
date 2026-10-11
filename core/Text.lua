local _, addon = ...

local SELF_ONLY = {
    TRANQUILITY = true,
    BARKSKIN = true,
    BEAR = true,
    CAT = true,
    TRAVEL = true,
    AQUATIC = true,
    MOONKIN = true,
    TREE = true,
    FLIGHT = true,
}

local FRIENDLY_OR_SELF = {
    MARK = true,
    THORNS = true,
    REJUVENATION = true,
    REGROWTH = true,
    HEALING_TOUCH = true,
    INNERVATE = true,
}

local FRIENDLY_ONLY = {
    REBIRTH = true,
}

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
    return (text:gsub("%%s", function() return targetName end))
end

local function FriendlyTargetName()
    if UnitExists("target") and UnitCanAssist("player", "target") then
        return UnitName("target")
    end
    return nil
end

local function ResolveTargetName(key)
    if SELF_ONLY[key] then
        return nil
    end
    if FRIENDLY_OR_SELF[key] then
        return FriendlyTargetName() or UnitName("player")
    end
    if FRIENDLY_ONLY[key] then
        return FriendlyTargetName()
    end
    if UnitExists("target") then
        return UnitName("target")
    end
    return nil
end

function addon.BuildText(key)
    local targetName = ResolveTargetName(key)
    local race = addon.GetPlayerRaceToken()
    local personal = addon.db.personalTexts[key]
    if personal then return ChooseText(personal, targetName) end
    local lang = addon.GetOutputLanguage()
    local pool = addon.GetLocalePoolExact(lang, "racial", race, key)
        or addon.GetLocalePoolExact(lang, "texts", key)
        or addon.GetLocalePoolExact("deDE", "racial", race, key)
        or addon.GetLocalePoolExact("deDE", "texts", key)
    return ChooseText(pool, targetName)
end
