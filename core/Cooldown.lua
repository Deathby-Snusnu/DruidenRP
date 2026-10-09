local _, addon = ...
local lastRPText

function addon.CooldownReady()
    return not lastRPText or GetTime() - lastRPText >= addon.db.cooldown
end

function addon.GetRemainingCooldown()
    if not lastRPText then
        return 0
    end
    return math.max(0, addon.db.cooldown - (GetTime() - lastRPText))
end

function addon.StartCooldown()
    lastRPText = GetTime()
end
