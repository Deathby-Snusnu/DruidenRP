local _, addon = ...

addon.localeData.enUS.racial = {
    NightElf = {
        NATURES_GRASP = { gruppe = {
            "Elune watches over me. Those who come closer will meet the roots.",
            "Moonlight above, roots below. The wilds are ready.",
            "May Cenarius teach the roots to seize every careless step.",
            "*lowers their fingertips toward the earth as silver light glides over hidden roots.*",
        }},
    },
    Tauren = {
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
