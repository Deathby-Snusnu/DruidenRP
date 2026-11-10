local files = {}
for line in io.lines("DruidenRP.toc") do
    local file = line:match("^%s*(.-)%s*$")
    if file ~= "" and not file:find("^#") then
        files[#files + 1] = file:gsub("\\", package.config:sub(1, 1))
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
        raceId = options.raceId, faction = options.faction,
        hostile = options.hostile or false,
        class = options.class or "DRUID",
        target = nil, group = false, raid = false, instance = false,
    }
    local env = setmetatable({
        SlashCmdList = {}, LE_PARTY_CATEGORY_INSTANCE = 2,
        DruidenRP_CharacterDB = options.db,
        PaladinRP = { untouched = true },
        RPChatMod_Settings = { textChance = 99 },
        RPChatMod = options.rpChatMod,
        DruidenRP = nil,
    }, { __index = _G })
    env._G = env
    -- Stable selection: ordinary chat is tested separately from /me.
    env.math = setmetatable({
        random = function(a, b) return b and a or 1 end,
    }, { __index = math })
    env.print = function(text) state.notices[#state.notices + 1] = text end
    env.GetTime = function() return state.time end
    env.UnitAffectingCombat = function() return options.combat == true end
    env.UnitClass = function() return "class", state.class end
    env.UnitRace = function() return options.localizedRace or "race", state.race, state.raceId end
    env.UnitFactionGroup = function() return state.faction end
    env.UnitCanAttack = function() return state.target ~= nil and state.hostile end
    env.UnitCanAssist = function() return state.target ~= nil and not state.hostile end
    env.UnitExists = function() return state.target ~= nil end
    env.UnitName = function() return state.target end
    if options.secretName then
        env.issecretvalue = function(value) return value == options.secretName end
    elseif options.noSecretAPI then
        env.issecretvalue = false
    end
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
                check(name == "OnEvent" or name == "OnUpdate",
                    "login or ambient frame handler")
                if name == "OnEvent" then state.login = handler
                else state.update = handler end
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
check(client.env.RPChatMod == nil, "optional resolver is absent")
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
client.command("channel PARTY")
local druidDB = client.env.DruidenRP_CharacterDB
druidDB.personalTexts.TEST_EMOTE = { "*  richtet sich auf und hebt die Hand.  *" }
count = #client.messages
check(client.addon.TryText("TEST_EMOTE"), "marked action sends despite unavailable speech channel")
check(client.messages[#client.messages].text == "richtet sich auf und hebt die Hand.",
    "emote markers are stripped")
check(client.messages[#client.messages].channel == "EMOTE", "marked action uses EMOTE")
check(client.messages[#client.messages].language == nil, "emote has no racial language")
count = #client.messages
check(not client.addon.SendText("*unvollstaendige Markierung") and #client.messages == count,
    "unmatched emote marker is rejected")
check(not client.addon.SendText("**") and #client.messages == count,
    "empty emote is rejected")
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
check(client.addon.TryText("MARK"), "unusable personal target-only pool falls back to safe general text")
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
client.target = "HOSTILE_PERSONAL_SENTINEL"
db.personalTexts.DASH = { "Mein Dash-Text fuer %s." }
check(client.addon.BuildText("DASH") == "Mein Dash-Text fuer HOSTILE_PERSONAL_SENTINEL.",
    "personal DASH text retains legacy target resolution")
db.personalTexts.DASH = nil
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
check(categories == 59, "all 59 existing and added druid categories present")
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
local invalidResolver = newClient({
    race = "Tauren",
    rpChatMod = { GetChatLanguageID = true },
    db = { textChance = 100, cooldown = 0 },
})
check(invalidResolver.addon.SendText("fallback"), "non-callable resolver uses racial fallback")
check(invalidResolver.messages[1].language == 3, "non-callable resolver sends racial language")
local resolverCalls = {}
local resolvedLanguages = newClient({
    rpChatMod = {
        GetChatLanguageID = function(channel)
            resolverCalls[#resolverCalls + 1] = channel
            return channel == "SAY" and 101 or 202
        end,
    },
    db = { textChance = 100, cooldown = 0 },
})
check(resolvedLanguages.addon.SendText("speech"), "shared resolver SAY speech")
check(resolverCalls[1] == "SAY", "shared resolver receives SAY channel")
check(resolvedLanguages.messages[1].language == 101, "shared resolver language sent for SAY")
resolvedLanguages.command("channel YELL")
check(resolvedLanguages.addon.SendText("speech"), "shared resolver YELL speech")
check(resolverCalls[2] == "YELL", "shared resolver receives YELL channel")
check(resolvedLanguages.messages[2].language == 202, "shared resolver language sent for YELL")
resolvedLanguages.command("channel EMOTE")
check(resolvedLanguages.addon.SendText("*waves*"), "emote skips shared resolver")
check(#resolverCalls == 2, "emote never invokes shared resolver")
resolvedLanguages.group = true
resolvedLanguages.command("channel PARTY")
check(resolvedLanguages.addon.SendText("group speech"), "group channel skips shared resolver")
check(resolvedLanguages.messages[4].language == nil, "group channel has no language")
check(#resolverCalls == 2, "group channel never invokes shared resolver")
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

-- Separate faction voices and target-safe newly added actions.
local catalogKeys = {
"STARFIRE","INSECT_SWARM","HURRICANE","FAERIE_FIRE","FAERIE_FIRE_FERAL",
"ECLIPSE","WILD_GROWTH","BLOOM","PRIMAL_BITE","LACERATE","REVIVE",
"SWIFTMEND","NATURES_SWIFTNESS","OMEN_OF_CLARITY","SOOTHE_ANIMAL",
"HIBERNATE","REMOVE_CURSE","CURE_POISON","ABOLISH_POISON","POUNCE",
"SHRED","RAKE","RIP","FEROCIOUS_BITE","CLAW","MAUL","SWIPE","BASH",
"GROWL","ENRAGE","DASH","PROWL","FRENZIED_REGENERATION",
"CHALLENGING_ROAR","FERAL_CHARGE","DEMORALIZING_ROAR","SHAPE_SHIFT",
"REJUVENATING_BLOOM"}
check(#catalogKeys == 38, "38 new druid action keys")
local expectedTargetModes = {
    STARFIRE="enemy", INSECT_SWARM="enemy", HURRICANE="self",
    FAERIE_FIRE="enemy", FAERIE_FIRE_FERAL="enemy", ECLIPSE="self",
    WILD_GROWTH="self", BLOOM="friend", PRIMAL_BITE="enemy",
    LACERATE="enemy", REVIVE="friend", SWIFTMEND="friend",
    NATURES_SWIFTNESS="self", OMEN_OF_CLARITY="self", SOOTHE_ANIMAL="enemy",
    HIBERNATE="enemy", REMOVE_CURSE="friend", CURE_POISON="friend",
    ABOLISH_POISON="friend", POUNCE="enemy", SHRED="enemy", RAKE="enemy",
    RIP="enemy", FEROCIOUS_BITE="enemy", CLAW="enemy", MAUL="enemy",
    SWIPE="self", BASH="enemy", GROWL="enemy", ENRAGE="self", DASH="self",
    PROWL="self", FRENZIED_REGENERATION="self", CHALLENGING_ROAR="self",
    FERAL_CHARGE="enemy", DEMORALIZING_ROAR="self", SHAPE_SHIFT="self",
    REJUVENATING_BLOOM="friend",
}
local targetCases = {
    { name="friend", target="FRIEND_TARGET%1", hostile=false },
    { name="enemy", target="ENEMY_TARGET%1", hostile=true },
    { name="absent", hostile=false },
}
for _, lang in ipairs({"deDE","enUS","frFR"}) do
    local druid = newClient({race="NightElf"})
    druid.command("language " .. lang)
    for _, key in ipairs(catalogKeys) do
        local pool = druid.addon.localeData[lang].texts[key]
        check(type(pool) == "table" and type(pool.gruppe) == "table"
            and #pool.gruppe >= 4, lang .. " has original lines for " .. key)
        local dialogueCount, emoteCount, seen = 0, 0, {}
        for _, line in ipairs(pool.gruppe) do
            check(type(line) == "string" and line ~= "" and not seen[line],
                lang .. " " .. key .. " has nonempty distinct generic lines")
            seen[line] = true
            if line:sub(1, 1) == "*" and line:sub(-1) == "*" then
                emoteCount = emoteCount + 1
            else
                dialogueCount = dialogueCount + 1
            end
        end
        check(dialogueCount >= 2 and emoteCount >= 2,
            lang .. " " .. key .. " has two dialogue and two emote lines")
        check(type(druid.addon.BuildText(key)) == "string",
            lang .. " builds targetless " .. key)
        local mode = expectedTargetModes[key]
        check(mode ~= nil, key .. " has independently specified target expectations")
        for _, targetCase in ipairs(targetCases) do
            druid.target, druid.hostile = targetCase.target, targetCase.hostile
            local text = druid.addon.BuildText(key)
            check(type(text) == "string" and not text:find("%s", 1, true),
                lang .. " " .. key .. " " .. targetCase.name .. " resolves placeholders")
            local shouldNameTarget = mode == targetCase.name
            if shouldNameTarget then
                check(text:find(targetCase.target, 1, true) ~= nil,
                    lang .. " " .. key .. " names a suitable " .. targetCase.name)
            else
                check(text == pool.gruppe[1],
                    lang .. " " .. key .. " uses generic text for " .. targetCase.name)
            end
        end
        -- Self-only pools have no authored target lines; a probe makes a
        -- classification regression observable instead of passing by accident.
        if mode == "self" then
            local originalTargetPool = pool.ziel
            pool.ziel = { "TARGET_PROBE %s" }
            for _, targetCase in ipairs(targetCases) do
                druid.target, druid.hostile = targetCase.target, targetCase.hostile
                check(druid.addon.BuildText(key) == pool.gruppe[1],
                    lang .. " " .. key .. " ignores target probe for " .. targetCase.name)
            end
            pool.ziel = originalTargetPool
        end
        druid.target, druid.hostile = nil, false
    end
    local racial = druid.addon.localeData[lang].racial
    for _, name in ipairs({"SkyborneHighOrder", "SkyborneWindshaper"}) do
        check(type(racial[name]) == "table", lang .. " has " .. name .. " voice")
        check(type(racial[name].MARK) == "table", lang .. " skyborne MARK")
    end
    for _, variant in ipairs({
        { name = "SkyborneHighOrder", raceId = 95, faction = "Alliance" },
        { name = "SkyborneWindshaper", raceId = 96, faction = "Horde" },
    }) do
        local skyborne = newClient({
            race = "Skyborne", raceId = variant.raceId, faction = variant.faction,
        })
        skyborne.command("language " .. lang)
        skyborne.target = "STARFIRE_TARGET"
        skyborne.hostile = true
        local text = skyborne.addon.BuildText("STARFIRE")
        local expected = skyborne.addon.localeData[lang].racial[variant.name]
            .STARFIRE.ziel[1]:gsub("%%s", skyborne.target)
        check(text == expected,
            lang .. " " .. variant.name .. " STARFIRE uses targeted localized text")
    end
end
for _, case in ipairs({
    { faction="Alliance", expected="SkyborneHighOrder" },
    { faction="Horde", expected="SkyborneWindshaper" },
    { expected="Skyborne" },
    { faction="Neutral", expected="Skyborne" },
    { raceId=95, faction="Horde", expected="SkyborneHighOrder" },
    { raceId=96, faction="Alliance", expected="SkyborneWindshaper" },
    { race="NightElf", localizedRace="Himmelsgeborene", faction="Alliance",
        expected="SkyborneHighOrder" },
}) do
    local skyborne = newClient({
        race=case.race or "Skyborne", raceId=case.raceId, faction=case.faction,
        localizedRace=case.localizedRace,
    })
    check(skyborne.addon.GetPlayerRaceToken() == case.expected,
        "Skyborne compatibility detection: " .. case.expected)
end
local oldSkyborne = newClient({ race="Skyborne" })
oldSkyborne.env.UnitFactionGroup = nil
check(oldSkyborne.addon.GetPlayerRaceToken() == "Skyborne",
    "Skyborne remains neutral when race ID and faction API are absent")
local targets = newClient({race="Tauren"})
targets.target = "FRIEND_SENTINEL_9"
targets.hostile = false
check(not targets.addon.BuildText("STARFIRE"):find(targets.target, 1, true),
    "starfire never calls a friend hostile")
check(targets.addon.BuildText("REVIVE"):find(targets.target, 1, true),
    "revive addresses a friend")
targets.target = "HOSTILE_SENTINEL_4"
targets.hostile = true
check(targets.addon.BuildText("STARFIRE"):find(targets.target, 1, true),
    "starfire addresses hostile target")
check(not targets.addon.BuildText("REVIVE"):find(targets.target, 1, true),
    "revive never addresses hostile target")
check(not targets.addon.BuildText("ECLIPSE"):find(targets.target, 1, true),
    "self action has no hostile target name")
local secret = newClient({ secretName="SECRET_TARGET" })
secret.target, secret.hostile = "SECRET_TARGET", true
local localizedPlaceholders = {
    deDE = "das Ziel",
    enUS = "the target",
    frFR = "la cible",
}
for lang, placeholder in pairs(localizedPlaceholders) do
    secret.command("language " .. lang)
    local pool = secret.addon.localeData[lang].texts.STARFIRE
    check(secret.addon.BuildText("STARFIRE") == pool.ziel[1]:gsub("%%s", placeholder),
        lang .. " built-in text localizes secret target")
    secret.env.DruidenRP_CharacterDB.personalTexts.STARFIRE = { "Personal %s." }
    check(secret.addon.BuildText("STARFIRE") == "Personal " .. placeholder .. ".",
        lang .. " personal text localizes secret target")
end
secret.command("language enUS")
secret.target = "ORDINARY_TARGET"
check(secret.addon.BuildText("STARFIRE")
    == secret.addon.localeData.enUS.texts.STARFIRE.ziel[1]:gsub("%%s", secret.target),
    "ordinary built-in target name is preserved")
check(secret.addon.BuildText("STARFIRE") == "Personal ORDINARY_TARGET.",
    "ordinary personal target name is preserved")
local noSecretAPI = newClient({ noSecretAPI=true })
noSecretAPI.command("language enUS")
noSecretAPI.target, noSecretAPI.hostile = "SECRET_TARGET", true
noSecretAPI.env.DruidenRP_CharacterDB.personalTexts.STARFIRE = { "Personal %s." }
check(type(noSecretAPI.env.issecretvalue) ~= "function", "client without secret API")
check(noSecretAPI.addon.BuildText("STARFIRE")
    == noSecretAPI.addon.localeData.enUS.texts.STARFIRE.ziel[1]:gsub("%%s", "SECRET_TARGET"),
    "built-in target name is preserved without secret API")
check(noSecretAPI.addon.BuildText("STARFIRE") == "Personal SECRET_TARGET.",
    "personal target name is preserved without secret API")
local special = newClient({race="Skyborne",raceId=95,faction="Alliance"})
check(special.addon.GetPlayerRaceToken() == "SkyborneHighOrder",
    "Alliance Skyborne recognized")
check(special.addon.BuildText("NATURES_GRASP"):find("Wind lockt", 1, true),
    "high-order variant falls back to neutral Skyborne action pool")
check(special.addon.BuildAmbient("BALANCE")
    == special.addon.localeData.deDE.ambientRacial.Skyborne.BALANCE[1],
    "high-order variant falls back to neutral Skyborne ambient pool")
special.command("list racial")
local listedInheritedKeys = {}
for _, notice in ipairs(special.notices) do
    local message = notice:match("|r (.+)$")
    if message then listedInheritedKeys[message] = true end
end
check(listedInheritedKeys.NATURES_GRASP and listedInheritedKeys.REBIRTH,
    "high-order racial list includes inherited Skyborne keys")
check(special.addon.SendText("variant speech"), "high-order Skyborne speech sent")
check(special.messages[1].language == 2, "high-order variant uses Skyborne language")
special = newClient({race="Skyborne",raceId=96,faction="Horde"})
check(special.addon.GetPlayerRaceToken() == "SkyborneWindshaper",
    "Horde Skyborne recognized")
check(special.addon.BuildText("NATURES_GRASP"):find("Wind lockt", 1, true),
    "windshaper variant falls back to neutral Skyborne action pool")
check(special.addon.BuildAmbient("BALANCE")
    == special.addon.localeData.deDE.ambientRacial.Skyborne.BALANCE[1],
    "windshaper variant falls back to neutral Skyborne ambient pool")
check(special.addon.SendText("variant speech"), "windshaper Skyborne speech sent")
check(special.messages[1].language == 2, "windshaper variant uses Skyborne language")
local saved = newClient({db={personalTexts={STARFIRE={"Mein eigener Stern."}}}})
check(saved.addon.BuildText("STARFIRE") == "Mein eigener Stern.",
    "personal druid texts remain untouched")

print("PASS: " .. checks .. " checks")
