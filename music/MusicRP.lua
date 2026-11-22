-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Original RP voice texts, with musical inspiration metadata only.
local _, addon = ...
addon.musicRP = { deDE = {}, enUS = {}, frFR = {} }
addon.musicRPReferences = {}
addon.musicRPReferences.REJUVENATION = { artist = "Alphaville", song = "Forever Young" }
addon.musicRP.deDE.REJUVENATION = { "Die Zeit vergeht. Doch der Frühling findet neue Wege.", "*lässt eine kleine Knospe zwischen den Händen erblühen.*" }
addon.musicRP.enUS.REJUVENATION = { "Time passes. Spring still finds new paths.", "*coaxes a small bud into bloom between both hands.*" }
addon.musicRP.frFR.REJUVENATION = { "Le temps passe. Le printemps trouve de nouveaux chemins.", "*fait éclore un bourgeon entre ses mains.*" }
addon.musicRPReferences.REBIRTH = { artist = "Guns N' Roses", song = "Coma" }
addon.musicRP.deDE.REBIRTH = { "Unter dieser Stille schlägt noch ein Herz aus Wurzeln.", "*legt die Hände auf den Boden und lauscht tief in die Erde.*" }
addon.musicRP.enUS.REBIRTH = { "Beneath this silence, a heart of roots still beats.", "*places both hands on the ground and listens to the earth.*" }
addon.musicRP.frFR.REBIRTH = { "Sous ce silence, un cœur de racines bat encore.", "*pose les mains au sol et écoute la terre profonde.*" }
addon.musicRPReferences.TRANQUILITY = { artist = "Guns N' Roses", song = "November Rain" }
addon.musicRP.deDE.TRANQUILITY = { "Kein Sturm bleibt ewig. Wir warten gemeinsam auf die Stille.", "*lässt den Regen leise über schützende Blätter rieseln.*" }
addon.musicRP.enUS.TRANQUILITY = { "No storm lasts forever. We will wait together for calm.", "*lets rain patter softly across sheltering leaves.*" }
addon.musicRP.frFR.TRANQUILITY = { "Aucune tempête n'est éternelle. Attendons le calme ensemble.", "*laisse la pluie murmurer sur des feuilles protectrices.*" }
addon.musicRPReferences.ROOTS = { artist = "Sepultura", song = "Roots Bloody Roots" }
addon.musicRP.deDE.ROOTS = { "Meine Wurzeln kennen Wege, die Euer Blick nicht findet.", "*zieht mit der Hand eine grüne Spur durch den Boden.*" }
addon.musicRP.enUS.ROOTS = { "My roots know roads your eyes will never find.", "*draws a green trail across the earth with one hand.*" }
addon.musicRP.frFR.ROOTS = { "Mes racines connaissent des chemins invisibles à vos yeux.", "*trace de la main une piste verte dans la terre.*" }
addon.musicRPReferences.MOONFIRE = { artist = "Pink Floyd", song = "Time" }
addon.musicRP.deDE.MOONFIRE = { "Der Mond zählt keine Jahre. Er zählt Nächte voller Leben.", "*hebt die Hand, bis ein silberner Schimmer darauf ruht.*" }
addon.musicRP.enUS.MOONFIRE = { "The moon counts no years. Only nights alive with wonder.", "*raises a hand until silver light settles upon it.*" }
addon.musicRP.frFR.MOONFIRE = { "La lune ne compte pas les ans, mais les nuits vivantes.", "*lève la main et accueille une lueur argentée.*" }
addon.musicRPReferences.BEAR = { artist = "Black Sabbath", song = "Iron Man" }
addon.musicRP.deDE.BEAR = { "Es braucht keinen Stahl, wenn die Erde selbst Euch trägt.", "*senkt den Kopf und gräbt die Krallen fest in den Boden.*" }
addon.musicRP.enUS.BEAR = { "Steel is needless when the earth itself bears your weight.", "*lowers the head and plants claws firmly in the earth.*" }
addon.musicRP.frFR.BEAR = { "Point besoin d'acier quand la terre porte votre poids.", "*baisse la tête et enfonce ses griffes dans la terre.*" }

-- Extra original spoken lines and actions for existing music-inspired keys.
table.insert(addon.musicRP.deDE.REJUVENATION, "Auch nach dem längsten Winter erinnert sich die Erde an den Frühling.")
table.insert(addon.musicRP.deDE.REJUVENATION, "*lässt eine neue Knospe zwischen welken Blättern wachsen.*")
table.insert(addon.musicRP.enUS.REJUVENATION, "After the longest winter, the earth remembers spring.")
table.insert(addon.musicRP.enUS.REJUVENATION, "*coaxes a fresh bud among the withered leaves.*")
table.insert(addon.musicRP.frFR.REJUVENATION, "Après le plus long hiver, la terre se souvient du printemps.")
table.insert(addon.musicRP.frFR.REJUVENATION, "*fait naître un bourgeon parmi les feuilles fanées.*")
table.insert(addon.musicRP.deDE.MOONFIRE, "Die Nacht schweigt nicht. Sie spricht in silbernen Zeichen.")
table.insert(addon.musicRP.deDE.MOONFIRE, "*zieht einen leuchtenden Halbkreis über den Waldboden.*")
table.insert(addon.musicRP.enUS.MOONFIRE, "Night is not silent. It speaks in silver signs.")
table.insert(addon.musicRP.enUS.MOONFIRE, "*draws a glowing crescent across the forest floor.*")
table.insert(addon.musicRP.frFR.MOONFIRE, "La nuit n'est pas muette. Elle parle en signes d'argent.")
table.insert(addon.musicRP.frFR.MOONFIRE, "*trace un croissant lumineux sur le sol de la forêt.*")

function addon.ChooseMusicText(key)
    local db = addon.db
    if not db or not db.musicEnabled or (db.musicChance or 0) <= 0 then return nil end
    if math.random(100) > db.musicChance then return nil end
    local language = db.outputLanguage or "deDE"
    local texts = addon.musicRP[language] and addon.musicRP[language][key]
    if not texts then texts = addon.musicRP.deDE[key] end
    if type(texts) ~= "table" or #texts == 0 then return nil end
    return texts[math.random(#texts)]
end
