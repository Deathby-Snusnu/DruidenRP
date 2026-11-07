-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Separate cultural voices for both WoW Forever Skyborne factions.
local _, addon = ...
addon.localeData.deDE.racial.SkyborneHighOrder = {
    MARK = { ziel = { "Die Hohe Ordnung geleitet Eure Schritte, %s.", "*zeichnet ein ruhiges Zeichen aus Licht und Blattwerk vor %s.*" }, gruppe = {  } },
    STARFIRE = {
        ziel = { "Möge das geordnete Licht Euch treffen, %s.", "*lenkt einen präzisen Sternenstrahl auf %s.*" },
        gruppe = { "Selbst Sterne folgen ihren Bahnen. So soll auch dieses Licht sein Ziel finden.", "*ordnet die Finger zu einer präzisen Sternfigur.*" },
    },
    REJUVENATION = { ziel = { "Möge die Harmonie Euch wieder Kraft verleihen, %s.", "*ordnet funkelnde Blüten um die Wunde von %s.*" }, gruppe = {  } },
    ECLIPSE = { gruppe = { "Die Ordnung bleibt bestehen, selbst wenn ein Gestirn das andere verdeckt.", "*zeichnet einen makellosen Lichtkreis, dessen Mitte verdunkelt.*" } },
}
addon.localeData.deDE.racial.SkyborneWindshaper = {
    MARK = { ziel = { "Der freie Wind begleite Euch, %s.", "*entlässt einen Wirbel aus Blättern, der %s umspielt.*" }, gruppe = {  } },
    STARFIRE = {
        ziel = { "Der Wind trägt dieses Sternenlicht zu Euch, %s.", "*lenkt einen wirbelnden Sternenfunken auf %s.*" },
        gruppe = { "Ein Stern fällt, wie der Wind es will. Und doch trifft er.", "*breitet die Arme aus und lässt den Himmel antworten.*" },
    },
    REJUVENATION = { ziel = { "Atmet durch, %s. Der Wind findet immer neue Wege.", "*fängt eine warme Brise ein und schickt sie zu %s.*" }, gruppe = {  } },
    ECLIPSE = { gruppe = { "Auch die Wolken verändern den Himmel, ohne ihn zu fesseln.", "*dreht eine Hand, als folge sie einem unsteten Windwirbel.*" } },
}
