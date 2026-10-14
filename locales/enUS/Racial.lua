-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Copyright (c) 2026 Hannes Weichselbaum
--
-- Role-playing dialogue, emote, ambient, and translation text in this
-- file is licensed under the Creative Commons Attribution-ShareAlike
-- 4.0 International License.

local _, addon = ...

addon.localeData.enUS.racial = {
    NightElf = {
        MARK={ziel={"May Elune's light and the blessing of the wilds go with you, %s.","May Cenarius watch your path, %s.","*raises a hand toward %s as pale moonlight brushes the air.*"},gruppe={"May Elune's light guide us.","Under moon and stars, we walk together."}},
        REBIRTH={ziel={"Elune watch over you, %s. Return to us.","The Emerald Dream has not released you, %s.","*kneels beside %s as a soft silver glow gathers.*"},gruppe={"Elune's light shows the way back.","The Dream still holds hope for another beginning."}},
        NATURES_GRASP = { gruppe = {
            "Elune watches over me. Those who come closer will meet the roots.",
            "Moonlight above, roots below. The wilds are ready.",
            "May Cenarius teach the roots to seize every careless step.",
            "*lowers their fingertips toward the earth as silver light glides over hidden roots.*",
        }},
    },
    Tauren = {
        MARK={ziel={"May the Earth Mother hold her hand over you, %s.","May earth carry your steps and sky watch above you, %s.","*rests a hand near %s as dust and grass stir in a gentle breath of wind.*"},gruppe={"May the Earth Mother watch over us.","Earth carry our steps and sky watch above us."}},
        REBIRTH={ziel={"The Earth Mother calls you back, %s.","Return to the herd, %s. Roads still wait for you.","*kneels beside %s and presses a palm to the earth.*"},gruppe={"The Earth Mother grants another beginning.","A companion returns to the herd."}},
        NATURES_GRASP = { gruppe = {
            "The Earth Mother knows every step. Those who come too close will be held.",
            "The earth bears me and holds those who threaten me.",
            "Come closer if you wish. The Earth Mother is already awake.",
            "*presses a hand to the ground and listens to the Earth Mother for a moment.*",
        }},
    },
    Skyborne = {
        MARK = {
            ziel = {"May the wind carry you and the open sky watch over you, %s.","May Zephras breathe strength into your path, %s.","*raises a hand toward %s as wind and leaves circle together.*"},
            gruppe = {"May the wind carry us and the open sky watch over us.","Between sky and earth, we keep the balance."},
        },
        NATURES_GRASP = { gruppe = {
            "The wind draws them close. The roots hold them fast.",
            "Between sky and earth, the wilds wait for the next false step.",
            "Zephras guides the wind. The roots do the rest.",
            "*draws their fingers through the air as the first roots begin to stir below.*",
        }},
        REBIRTH = {
            ziel = {"Return to us, %s. The wind has not carried your name away.","Zephras knows falling paths and new updrafts. Return, %s.","*kneels beside %s as a rising current stirs dust and leaves around them.*"},
            gruppe = {"The wind carries a companion back to us.","Even after a fall, a new updraft can begin."},
        },
    },
}
