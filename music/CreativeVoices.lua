-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Additional original, non-music class dialogue and emotes.
local _, addon = ...
local entries = {
    REJUVENATION = { deDE = { "Ein neuer Anfang wächst oft unbemerkt.", "*streicht sanft über ein Blatt, an dessen Spitze Tau glänzt.*" }, enUS = { "A new beginning often grows unnoticed.", "*brushes a leaf with a shining drop of dew.*" }, frFR = { "Un nouveau départ pousse souvent sans bruit.", "*effleure une feuille où brille une goutte de rosée.*" } },
    REBIRTH = { deDE = { "Die Erde hat Eure Schritte noch nicht vergessen.", "*legt die Stirn auf den Boden und lauscht.*" }, enUS = { "The earth has not forgotten your footsteps.", "*rests a forehead against the soil and listens.*" }, frFR = { "La terre n'a pas oublié vos pas.", "*pose le front contre la terre et écoute.*" } },
    BEAR = { deDE = { "Ein alter Baum steht nicht, weil der Wind schwach ist.", "*stellt die Tatzen fest auf den Grund und knurrt tief.*" }, enUS = { "An old tree stands not because the wind is weak.", "*plants both paws firmly and growls low.*" }, frFR = { "Un vieil arbre tient, non parce que le vent est faible.", "*ancre ses pattes au sol et gronde doucement.*" } },
    MOONFIRE = { deDE = { "Das Licht der Nacht kennt keine Eile.", "*lässt einen silbrigen Funken auf der Handfläche tanzen.*" }, enUS = { "The light of night is never in a hurry.", "*lets a silver spark dance over the palm.*" }, frFR = { "La lumière nocturne ne se presse jamais.", "*fait danser une étincelle argentée dans sa paume.*" } },
}
for key, translations in pairs(entries) do
    for _, language in ipairs({"deDE","enUS","frFR"}) do
        local locale = addon.localeData and addon.localeData[language]
        local source = locale and locale.texts and locale.texts[key]
        for _, poolName in ipairs({"gruppe", "ziel"}) do
            local pool = source and source[poolName]
            if type(pool) == "table" then
                for _, line in ipairs(translations[language]) do
                    local exists = false
                    for _, old in ipairs(pool) do if old == line then exists = true; break end end
                    if not exists then pool[#pool+1] = line end
                end
            end
        end
    end
end
