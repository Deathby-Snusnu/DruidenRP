-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Copyright (c) 2026 Hannes Weichselbaum
--
-- Role-playing dialogue, emote, ambient, and translation text in this
-- file is licensed under the Creative Commons Attribution-ShareAlike
-- 4.0 International License.

local _, addon = ...

addon.localeData.frFR.racial = {
    NightElf = {
        MARK={ziel={"Que la lumiere d Elune et la benediction de la nature vous accompagnent, %s.","Que Cenarius veille sur votre chemin, %s.","*leve une main vers %s tandis qu une pale lueur lunaire effleure l air.*"},gruppe={"Que la lumiere d Elune nous guide.","Sous la lune et les etoiles, nous marchons ensemble."}},
        REBIRTH={ziel={
            "Qu Elune veille sur vous, %s. Revenez parmi nous.",
            "Le Reve d emeraude ne vous a pas abandonne, %s.",
            "*s agenouille pres de %s tandis qu une douce lueur argentee se rassemble.*",
            "Le Rêve vous ouvre une fois de plus le chemin, %s.",
        },gruppe={"La lumiere d Elune montre le chemin du retour.","Le Reve garde encore l espoir d un nouveau commencement."}},
        NATURES_GRASP = { gruppe = {
            "Elune veille sur moi. Ceux qui approchent rencontreront les racines.",
            "Clair de lune au-dessus, racines au-dessous. La nature est prête.",
            "Que Cénarius apprenne aux racines à saisir chaque pas imprudent.",
            "*abaisse les doigts vers la terre tandis qu'une lueur argentée glisse sur des racines cachées.*",
        }},
    },
    Tauren = {
        MARK={ziel={"Que la Terre-Mere pose sa main sur vous, %s.","Que la terre porte vos pas et que le ciel veille sur vous, %s.","*pose une main pres de %s tandis que poussiere et herbe frissonnent dans le vent.*"},gruppe={"Que la Terre-Mere veille sur nous.","Que la terre porte nos pas et que le ciel veille sur nous."}},
        REBIRTH={ziel={"La Terre-Mere vous rappelle, %s.","Revenez au troupeau, %s. Des chemins vous attendent encore.","*s agenouille pres de %s et pose la paume sur la terre.*"},gruppe={"La Terre-Mere accorde un nouveau commencement.","Un compagnon revient au troupeau."}},
        NATURES_GRASP = { gruppe = {
            "La Terre-Mère connaît chaque pas. Ceux qui s'approchent trop seront retenus.",
            "La terre me porte et retient ceux qui me menacent.",
            "Approchez si vous le souhaitez. La Terre-Mère est déjà éveillée.",
            "*pose fermement une main sur le sol et écoute un instant la Terre-Mère.*",
        }},
    },
    Skyborne = {
        MARK = {
            ziel = {"Que le vent vous porte et que le vaste ciel veille sur vous, %s.","Que Zephras insuffle sa force à votre chemin, %s.","*lève une main vers %s tandis que vent et feuilles tourbillonnent ensemble.*"},
            gruppe = {"Que le vent nous porte et que le vaste ciel veille sur nous.","Entre ciel et terre, nous gardons l'équilibre."},
        },
        NATURES_GRASP = { gruppe = {
            "Le vent les attire. Les racines les retiennent.",
            "Entre ciel et terre, la nature attend le prochain faux pas.",
            "Zephras guide le vent. Les racines font le reste.",
            "*trace un geste dans l'air tandis que les premières racines commencent déjà à remuer sous le sol.*",
        }},
        REBIRTH = {
            ziel = {"Revenez parmi nous, %s. Le vent n'a pas emporté votre nom.","Zephras connaît les chutes et les nouveaux courants ascendants. Revenez, %s.","*s'agenouille près de %s tandis qu'un courant ascendant soulève poussière et feuilles.*"},
            gruppe = {"Le vent ramène un compagnon parmi nous.","Même après une chute, un nouveau courant ascendant peut naître."},
        },
    },
}
