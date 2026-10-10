local _, addon = ...

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
    -- Function replacement preserves percent characters in target names.
    return (text:gsub("%%s", function() return targetName end))
end

function addon.BuildText(key)
    local targetName = UnitExists("target") and UnitName("target") or nil
    local race = addon.GetPlayerRaceToken()
    local personal = addon.db.personalTexts[key]
    local racial = addon.racial[race] and addon.racial[race][key]
    return ChooseText(personal or racial or addon.texts[key], targetName)
end
