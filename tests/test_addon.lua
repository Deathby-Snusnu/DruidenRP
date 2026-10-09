local files = {}
for line in io.lines("DruidenRP.toc") do
    local file = line:match("^%s*(.-)%s*$")
    if file ~= "" and not file:find("^#") then
        files[#files + 1] = file:gsub("/", "\\")
    end
end
local checks = 0
local function check(condition, message)
    assert(condition, message)
    checks = checks + 1
end

local function newClient(options)
    options = options or {}
    local state = {
        time = 0, messages = {}, notices = {},
        race = options.race or "NightElf",
        class = options.class or "DRUID",
        target = nil, group = false, raid = false, instance = false,
    }
    local env = setmetatable({
        SlashCmdList = {}, LE_PARTY_CATEGORY_INSTANCE = 2,
        DruidenRP_CharacterDB = options.db,
        PaladinRP = { untouched = true },
        RPChatMod_Settings = { textChance = 99 },
        DruidenRP = nil,
    }, { __index = _G })
    env._G = env
    env.print = function(text) state.notices[#state.notices + 1] = text end
    env.GetTime = function() return state.time end
    env.UnitClass = function() return "class", state.class end
    env.UnitRace = function() return "race", state.race end
    env.UnitExists = function() return state.target ~= nil end
    env.UnitName = function() return state.target end
    env.IsInGroup = function(category)
        if category then return state.instance end
        return state.group or state.raid or state.instance
    end
    env.IsInRaid = function() return state.raid end
    env.GetNumLanguages = function() return 2 end
    env.GetLanguageByIndex = function(index)
        if index == 1 then return "Common", 7 end
        return "racial", state.race == "Tauren" and 3 or 2
    end
    local function send(text, channel, language)
        state.messages[#state.messages + 1] = {
            text = text, channel = channel, language = language,
        }
    end
    if options.legacy then
        env.SendChatMessage = send
        env.C_ChatInfo = nil
    elseif options.noChat then
        env.SendChatMessage = nil
        env.C_ChatInfo = nil
    else
        env.C_ChatInfo = { SendChatMessage = send }
    end
    env.CreateFrame = function()
        return {
            RegisterEvent = function(_, event)
                check(event == "PLAYER_LOGIN", "only player login is registered")
            end,
            SetScript = function(_, name, handler)
                check(name == "OnEvent", "login event handler")
                state.login = handler
            end,
        }
    end
    local addon = {}
    for _, file in ipairs(files) do
        local chunk
        if setfenv then
            chunk = assert(loadfile(file))
            setfenv(chunk, env)
        else
            chunk = assert(loadfile(file, "t", env))
        end
        chunk("DruidenRP", addon)
    end
    state.env = env
    state.addon = addon
    state.command = env.SlashCmdList.DRUIDENRP
    if not options.beforeLogin then state.login() end
    return state
end

local client = newClient({ beforeLogin = true })
check(not client.addon.TryText("MARK"), "pre-login calls are safe")
client.command("chance 100")
client.login()
check(client.env.DruidenRP_CharacterDB.textChance == 30, "defaults")
check(client.env.DruidenRP_CharacterDB.chatChannel == "SAY", "say is the default channel")
check(client.env.RPChatMod_Settings.textChance == 99, "other addon settings untouched")
check(client.env.PaladinRP.untouched, "Paladin namespace untouched")
check(client.env.DruidenRP == client.addon, "public macro API")
client.command("chance 100")
client.command("cooldown 20")
check(client.addon.TryText("mark"), "first text allowed at time zero")
check(client.messages[1].channel == "SAY", "solo channel")
check(client.messages[1].language == 2, "locale independent night elf language")
check(not client.messages[1].text:find("%s", 1, true), "no unresolved target")
check(not client.addon.TryText("MARK"), "cooldown applied")
client.time = 19.99
check(not client.addon.TryText("MARK"), "cooldown boundary below")
client.time = 20
check(client.addon.TryText("MARK"), "cooldown boundary inclusive")
client.command("cooldown 0")
client.target = "Ziel%1"
check(client.addon.TryText("HEALING_TOUCH"), "target healing")
check(client.messages[#client.messages].text:find("Ziel%1", 1, true), "literal target name")
client.command("chance 0")
local count = #client.messages
check(not client.addon.TryText("MARK") and #client.messages == count, "zero chance")
client.command("chance 100")
for _, invalid in ipairs({ "chance -1", "chance 101", "chance 3x", "chance 1.5",
    "cooldown 3601", "cooldown inf", "chance 30 garbage", "chance 1e2",
    "chance +30", "chance 0x32", "cooldown 1.0" }) do
    client.command(invalid)
end
check(client.env.DruidenRP_CharacterDB.textChance == 100, "invalid chance rejected")
check(client.env.DruidenRP_CharacterDB.cooldown == 0, "invalid cooldown rejected")
client.group, client.raid, client.instance = true, true, true
check(client.addon.TryText("BEAR"), "default channel text in group and raid")
check(client.messages[#client.messages].channel == "SAY", "default stays say in group and raid")
client.command("channel PARTY")
check(client.addon.TryText("BEAR"), "configured party channel")
check(client.messages[#client.messages].channel == "PARTY", "party channel setting")
client.command("channel RAID")
check(client.addon.TryText("BEAR"), "configured raid channel")
check(client.messages[#client.messages].channel == "RAID", "raid channel setting")
client.command("channel INSTANCE_CHAT")
check(client.addon.TryText("BEAR"), "configured instance channel")
check(client.messages[#client.messages].channel == "INSTANCE_CHAT", "instance channel setting")
client.group, client.raid, client.instance = false, false, false
client.command("channel AUTO")
for _, setup in ipairs({
    { false, false, false, "SAY" },
    { true, false, false, "PARTY" },
    { true, true, false, "RAID" },
    { true, true, true, "INSTANCE_CHAT" },
}) do
    client.group, client.raid, client.instance = setup[1], setup[2], setup[3]
    check(client.addon.TryText("BEAR"), "auto channel text")
    check(client.messages[#client.messages].channel == setup[4], "auto channel priority")
    if setup[4] ~= "SAY" then
        check(client.messages[#client.messages].language == nil, "no group racial language")
    end
end
client.group, client.raid, client.instance = false, false, false
client.command("channel RAID")
count = #client.messages
check(not client.addon.TryText("MARK") and #client.messages == count, "unavailable raid rejected")
client.command("channel EMOTE")
check(client.addon.TryText("BEAR"), "emote channel")
check(client.messages[#client.messages].language == nil, "no emote language")
client.command("channel AUTO")
client.command("channel WHISPER")
check(client.env.DruidenRP_CharacterDB.chatChannel == "AUTO", "invalid channel rejected")
client.command("channel")
check(client.env.DruidenRP_CharacterDB.chatChannel == "AUTO", "channel query preserves setting")
check(client.notices[#client.notices]:find("AUTO", 1, true), "channel query displays value")
for _, channel in ipairs({ "PARTY", "RAID", "INSTANCE_CHAT" }) do
    client.command("channel " .. channel)
    count = #client.messages
    check(not client.addon.TryText("MARK") and #client.messages == count,
        channel .. " unavailable never falls back to say")
end
client.command("channel AUTO")

local db = client.env.DruidenRP_CharacterDB
db.personalTexts.MARK = { "Eigener Text fuer %s." }
check(client.addon.TryText("MARK"), "personal pool priority")
check(client.messages[#client.messages].text == "Eigener Text fuer Ziel%1.", "personal replacement")
client.target = nil
check(not client.addon.TryText("MARK"), "target-only personal pool without target")
db.personalTexts.MARK = { ziel = { "Hallo %s." }, gruppe = { "Hallo Wald." } }
check(client.addon.TryText("MARK"), "personal generic fallback")
check(client.messages[#client.messages].text == "Hallo Wald.", "personal generic content")
db.personalTexts.MARK = { string.rep("x", 256) }
check(not client.addon.TryText("MARK"), "255 byte maximum enforced")
db.personalTexts.MARK = { "a\nb" }
check(not client.addon.TryText("MARK"), "newline rejected")
db.personalTexts.MARK = { "|Hbad|hlink|h" }
check(not client.addon.TryText("MARK"), "chat markup rejected")
db.personalTexts.MARK = { string.rep("x", 255) }
check(client.addon.TryText("MARK"), "255 byte boundary accepted")
db.personalTexts.MARK = nil
check(not client.addon.TryText("UNKNOWN"), "unknown key")

local categories = 0
for key, pool in pairs(client.addon.texts) do
    categories = categories + 1
    check(type(pool.name) == "string", "named text category")
    client.target = nil
    check(client.addon.TryText(key), key .. " without target")
    client.target = "Testziel"
    check(client.addon.TryText(key), key .. " with target")
    check(not client.messages[#client.messages].text:find("%s", 1, true), "resolved placeholder")
end
check(categories == 20, "all twenty categories present")
for race, pools in pairs(client.addon.racial) do
    client.race = race
    for key in pairs(pools) do
        client.target = nil
        check(client.addon.TryText(key), race .. " generic")
        client.target = "Testziel"
        check(client.addon.TryText(key), race .. " target")
    end
end
client.command("list")
client.command("status")
client.command("")
client.command("mark unexpected")
check(client.env.SLASH_DRUIDENRP1 == "/drp", "short slash command")
check(client.env.SLASH_DRUIDENRP2 == "/druidenrp", "long slash command")

local legacy = newClient({ legacy = true, race = "Tauren",
    db = { textChance = 100, cooldown = 0 } })
check(not legacy.addon.TryText("MARK"), "legacy-only client reported unsupported")
check(#legacy.messages == 0, "legacy-only client never silently sends")
local tauren = newClient({ race = "Tauren", db = { textChance = 100, cooldown = 0 } })
check(tauren.addon.TryText("MARK"), "tauren text")
check(tauren.messages[1].language == 3, "tauren racial language")
local unsupported = newClient({ noChat = true, db = { textChance = 100, cooldown = 0 } })
check(not unsupported.addon.TryText("MARK"), "missing chat API reported")
local otherClass = newClient({ class = "PALADIN" })
otherClass.command("chance 100")
check(not otherClass.addon.TryText("MARK"), "non-druid blocked")
check(#otherClass.messages == 0, "non-druid never sends")
local damaged = newClient({
    db = { textChance = -3, cooldown = "bad", chatChannel = "WHISPER", personalTexts = false },
})
check(damaged.env.DruidenRP_CharacterDB.textChance == 30, "repair invalid chance")
check(damaged.env.DruidenRP_CharacterDB.cooldown == 20, "repair invalid cooldown")
check(damaged.env.DruidenRP_CharacterDB.chatChannel == "SAY", "repair invalid channel")
local migrated = newClient({ db = { chatChannel = "AUTO" } })
check(migrated.env.DruidenRP_CharacterDB.chatChannel == "AUTO", "saved auto is preserved")
check(migrated.env.DruidenRP_CharacterDB.chatChannelVersion == 1, "channel version retained")
local saved = newClient({ db = { textChance = 71, cooldown = 12, chatChannel = "EMOTE",
    personalTexts = { MARK = { "Gespeichert." } } } })
check(saved.env.DruidenRP_CharacterDB.textChance == 71, "saved chance preserved")
check(saved.env.DruidenRP_CharacterDB.cooldown == 12, "saved cooldown preserved")
check(saved.env.DruidenRP_CharacterDB.personalTexts.MARK[1] == "Gespeichert.", "saved text preserved")

local fractional = newClient({ db = { textChance = 2.5, cooldown = 1.5 } })
check(fractional.env.DruidenRP_CharacterDB.textChance == 30, "fractional saved chance repaired")
check(fractional.env.DruidenRP_CharacterDB.cooldown == 20, "fractional saved cooldown repaired")
local invalidDB = newClient({ db = "invalid" })
check(type(invalidDB.env.DruidenRP_CharacterDB) == "table", "invalid database repaired")
local failedSend = newClient({ noChat = true, db = { textChance = 100, cooldown = 20 } })
check(not failedSend.addon.TryText("MARK"), "failed send")
check(failedSend.addon.CooldownReady(), "failed send never starts cooldown")
check(failedSend.addon.GetRemainingCooldown() == 0, "first remaining cooldown zero")
check(not client.addon.TryText({}), "invalid public key rejected")
client.command("cooldown 3600")
check(client.env.DruidenRP_CharacterDB.cooldown == 3600, "cooldown maximum accepted")
client.command("cooldown 0")
client.command("chance 0")
check(client.env.DruidenRP_CharacterDB.textChance == 0, "chance minimum accepted")
client.command("chance 100")

print("PASS: " .. checks .. " checks")
