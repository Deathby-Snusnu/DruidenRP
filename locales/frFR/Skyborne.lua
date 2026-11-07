-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Separate cultural voices for both WoW Forever Skyborne factions.
local _, addon = ...
addon.localeData.frFR.racial.SkyborneHighOrder = {
    MARK = { ziel = { "Que le Haut Ordre guide tes pas, %s.", "*dessine un sceau précis de lumière et de feuilles devant %s.*" }, gruppe = {  } },
    STARFIRE = {
        ziel = { "Que la lumière ordonnée des étoiles t'atteigne, %s.", "*guide un rayon d'étoile précis vers %s.*" },
        gruppe = { "Même les étoiles suivent leur voie. Cette lumière trouvera la sienne.", "*aligne les doigts dans une figure stellaire parfaite.*" },
    },
    REJUVENATION = { ziel = { "Que l'harmonie te rende tes forces, %s.", "*ordonne des pétales lumineux autour des blessures de %s.*" }, gruppe = {  } },
    ECLIPSE = { gruppe = { "L'ordre demeure quand un astre cache l'autre.", "*trace un cercle parfait dont le centre lumineux s'assombrit.*" } },
}
addon.localeData.frFR.racial.SkyborneWindshaper = {
    MARK = { ziel = { "Que le vent libre t'accompagne, %s.", "*envoie un tourbillon de feuilles danser autour de %s.*" }, gruppe = {  } },
    STARFIRE = {
        ziel = { "Le vent porte cette lumière d'étoile jusqu'à toi, %s.", "*envoie une étincelle tourbillonnante vers %s.*" },
        gruppe = { "Une étoile tombe là où le vent la mène, sans jamais hésiter.", "*écarte les bras pour laisser répondre le ciel.*" },
    },
    REJUVENATION = { ziel = { "Respire, %s. Le vent trouve toujours un autre chemin.", "*cueille une brise tiède et l'envoie vers %s.*" }, gruppe = {  } },
    ECLIPSE = { gruppe = { "Les nuages changent le ciel sans jamais l'enchaîner.", "*tourne une main pour suivre un courant capricieux.*" } },
}
