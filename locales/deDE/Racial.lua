-- SPDX-License-Identifier: CC-BY-SA-4.0
-- Copyright (c) 2026 Hannes Weichselbaum
--
-- Role-playing dialogue, emote, ambient, and translation text in this
-- file is licensed under the Creative Commons Attribution-ShareAlike
-- 4.0 International License.

local _, addon = ...

-- RP-Konvention:
-- Gesprochene Texte stehen ohne Markierung und nutzen den eingestellten Sprachkanal (Standard: /say).
-- Beschreibende Handlungen stehen zwischen *Sternchen* und werden immer als /me ausgegeben.
-- Der Handler entfernt die Sternchen vor der Ausgabe.

addon.localeData.deDE.racial = {
    NightElf = {
        MARK = {
            ziel = {
                "Elunes Licht und der Segen der Wildnis begleiten Euch, %s.",
                "Moege Cenarius ueber Euren Weg wachen, %s.",
                "Mondlicht und Blätterdach moegen Euch behueten, %s.",
                "Moege der Smaragdgruene Traum Euren Schritt leiten, %s.",
                "Elunes Segen ruhe auf Euch, %s.",
                "Moege das Gleichgewicht der Wildnis Euch Kraft schenken, %s.",
                "*hebt den Blick zum Mond und zeichnet ein Zeichen Elunes ueber %s.*",
                "*legt %s zwei Finger an die Stirn und murmelt einen leisen Segen Elunes.*",
            },
            gruppe = {
                "Elunes Licht und der Segen der Wildnis begleiten uns.",
                "Moege Cenarius ueber unsere Wege wachen.",
                "Unter Mond und Sternen gehen wir gemeinsam.",
                "Der Smaragdgruene Traum begleite unsere Schritte.",
                "Elunes Segen ruhe auf uns allen.",
                "Moege das Gleichgewicht der Wildnis uns staerken.",
                "*hebt die Haende zum Himmel, als wuerde Mondlicht auf die Gefaehrten herabgerufen.*",
                "*senkt ehrfuerchtig den Kopf und bittet Elune um Schutz fuer die Gemeinschaft.*",
            },
        },
        NATURES_GRASP = {
            gruppe = {
                "Elunes Blick ruht auf mir. Wer naeher kommt, wird von den Wurzeln empfangen.",
                "Mondlicht ueber mir, Wurzeln unter mir. Die Wildnis ist bereit.",
                "Cenarius lehre die Wurzeln, jeden unbedachten Schritt festzuhalten.",
                "*senkt die Fingerspitzen zum Boden, waehrend silbriges Licht ueber verborgene Wurzeln gleitet.*",
                "*hebt kurz den Blick zum Himmel und legt dann die Hand auf die Erde, als wuerde Elune die Wurzeln wecken.*",
            },
        },
        REBIRTH = {
            ziel = {
                "Elune wache ueber Euch, %s. Kehrt zu uns zurueck.",
                "Der Smaragdgruene Traum gibt Euch noch nicht auf, %s.",
                "Erwacht unter Elunes Blick, %s. Eure Reise geht weiter.",
                "Der Traum oeffnet Euch noch einmal den Weg, %s.",
                "Kehrt aus der Stille zurueck, %s. Die Sterne warten noch auf Euch.",
                "Das Leben ruft Euch erneut unter das Licht Elunes, %s.",
                "*kniet neben %s nieder und hebt suchend eine Hand in Elunes Licht.*",
                "*legt %s die Hand auf die Brust und ruft leise unter den Sternen nach dessen Geist.*",
            },
            gruppe = {
                "Elunes Licht weist den Weg zurueck ins Leben.",
                "Der Traum bewahrt die Hoffnung auf einen neuen Anfang.",
                "Unter den Sternen beginnt ein weiterer Schritt.",
                "Der Smaragdgruene Traum gibt einen Gefaehrten noch nicht verloren.",
                "Elune schenkt uns einen Augenblick gegen den Lauf des Schicksals.",
                "Noch ist die Reise unter Mond und Sternen nicht beendet.",
                "*kniet nieder, wendet das Gesicht zum Himmel und bittet Elune um einen neuen Atemzug.*",
                "*breitet die Haende aus, als wuerde Mondlicht den Weg zurueck weisen.*",
            },
        },
    },

    Tauren = {
        MARK = {
            ziel = {
                "Die Erdenmutter halte ihre Hand ueber Euch, %s.",
                "Moege der Segen der weiten Ebenen Euch begleiten, %s.",
                "Moege die Erde Eure Schritte tragen und der Himmel ueber Euch wachen, %s.",
                "Die Erdenmutter schenke Euch Kraft und Geduld, %s.",
                "Moege Euer Pfad fest unter den Hufen und weit vor Euch liegen, %s.",
                "Wind, Erde und Sonne moegen Euch begleiten, %s.",
                "*legt %s eine schwere, ruhige Hand auf die Schulter und murmelt einen Segen der Erdenmutter.*",
                "*beruehrt kurz den Boden und dann die Stirn von %s.*",
            },
            gruppe = {
                "Die Erdenmutter halte ihre Hand ueber uns.",
                "Moege der Segen der weiten Ebenen uns begleiten.",
                "Die Erde trage unsere Schritte und der Himmel wache ueber uns.",
                "Die Erdenmutter schenke uns Kraft und Geduld.",
                "Unser Pfad sei fest und unser Blick weit.",
                "Wind, Erde und Sonne begleiten unseren Weg.",
                "*legt eine Hand auf die Erde und die andere aufs Herz und ruft die Erdenmutter an.*",
                "*stampft einmal ruhig auf und senkt respektvoll den Kopf.*",
            },
        },
        NATURES_GRASP = {
            gruppe = {
                "Die Erdenmutter kennt jeden Schritt. Wer zu nahe kommt, wird festgehalten.",
                "Die Erde traegt mich und haelt jene, die mich bedraengen.",
                "Kommt naeher, wenn Ihr wollt. Die Erdenmutter ist bereits wach.",
                "*legt die Hand fest auf den Boden und lauscht einen Moment der Erdenmutter.*",
                "*stampft einmal ruhig auf; tief unter den Hufen beginnen Wurzeln sich zu regen.*",
            },
        },
        REBIRTH = {
            ziel = {
                "Die Erdenmutter ruft Euch zurueck, %s.",
                "Erhebt Euch, %s. Euer Pfad unter dem Himmel ist noch nicht zu Ende.",
                "Kehrt zur Herde zurueck, %s. Noch warten Wege auf Euch.",
                "Die Erde traegt Euch noch immer, %s. Erhebt Euch.",
                "Euer Platz am Feuer ist noch nicht leer, %s. Kehrt zurueck.",
                "Die Erdenmutter schenkt Euch einen weiteren Schritt auf Eurem Pfad, %s.",
                "*kniet neben %s und presst die Hand fest auf die Erde, um einen Herzschlag zurueckzurufen.*",
                "*beugt sich zu %s und spricht mit tiefer Stimme den Ruf der Herde.*",
            },
            gruppe = {
                "Die Erdenmutter schenkt einen neuen Anfang.",
                "Noch sind nicht alle Schritte auf diesem Pfad gegangen.",
                "Ein Gefaehrte kehrt zur Herde zurueck.",
                "Die Erde traegt uns, selbst wenn wir fallen.",
                "Noch ist ein Platz an unserem Feuer nicht leer.",
                "Die Erdenmutter schenkt unserem Weg einen weiteren Schritt.",
                "*kniet nieder, legt beide Haende auf die Erde und bittet die Erdenmutter um Rueckkehr.*",
                "*senkt die Hoerner und verharrt still, bis der Ruf des Lebens beantwortet wird.*",
            },
        },
    },

    Skyborne = {
        MARK = {
            ziel = {
                "Moege der Wind Euch tragen und der weite Himmel ueber Euch wachen, %s.",
                "Der Atem von Zephras begleite Eure Schritte, %s.",
                "Wind und Wildnis moegen Euch im Gleichgewicht halten, %s.",
                "Moege die Hoehe Euren Blick klaeren und die Erde Euren Schritt sichern, %s.",
                "Die Stroemungen des Himmels seien Euch gewogen, %s.",
                "Moege der Segen der Wildnis Euch leicht wie den Wind und standhaft wie eine alte Wurzel machen, %s.",
                "Zwischen Wolken und Wurzeln finde Euer Schritt sein Gleichgewicht, %s.",
                "Der freie Himmel schenke Euch Weitsicht, die Wildnis sicheren Stand, %s.",
                "*hebt eine Hand in den Wind und fuehrt die Stroemung sanft um %s.*",
                "*zeichnet mit einer leichten Bewegung eine Spirale in die Luft vor %s.*",
            },
            gruppe = {
                "Moege der Wind uns tragen und der weite Himmel ueber uns wachen.",
                "Der Atem von Zephras begleite unsere Schritte.",
                "Wind und Wildnis halten uns im Gleichgewicht.",
                "Der Himmel weitet unseren Blick, die Erde sichert unseren Schritt.",
                "Die Stroemungen des Himmels seien uns gewogen.",
                "Zwischen Himmel und Erde bewahren wir das Gleichgewicht.",
                "Wurzeln geben Halt, der Wind gibt Richtung.",
                "Unter offenem Himmel bleibt unser Blick frei.",
                "*breitet die Arme aus und laesst den Wind durch die Reihen der Gefaehrten ziehen.*",
                "*hebt das Gesicht in die Stroemung und lauscht einen Moment dem Himmel.*",
            },
        },
        NATURES_GRASP = {
            gruppe = {
                "Der Wind lockt sie heran. Die Wurzeln halten sie fest.",
                "Zwischen Himmel und Erde wartet die Wildnis auf den naechsten falschen Schritt.",
                "Zephras fuehrt den Wind. Die Wurzeln uebernehmen den Rest.",
                "*streicht mit den Fingern durch die Luft, waehrend sich am Boden bereits die ersten Wurzeln regen.*",
                "*laesst einen kurzen Windwirbel ueber den Boden ziehen; darunter antworten verborgene Ranken.*",
            },
        },
        REBIRTH = {
            ziel = {
                "Kehrt zu uns zurueck, %s. Der Wind hat Euren Namen noch nicht fortgetragen.",
                "Erhebt Euch, %s. Noch traegt Euch der Himmel.",
                "Der Atem des Lebens kehre in Euch zurueck, %s.",
                "Zephras kennt fallende Wege und neue Aufwinde. Kehrt zurueck, %s.",
                "Lasst Euch vom Wind zurueck zu uns tragen, %s.",
                "Euer Weg zwischen Himmel und Erde ist noch nicht beendet, %s.",
                "*kniet neben %s und fuehrt eine offene Hand langsam nach oben, um einen neuen Aufwind zu fangen.*",
                "*beugt sich ueber %s und haucht leise, waehrend der Wind um beide kreist.*",
            },
            gruppe = {
                "Der Wind traegt einen Gefaehrten zu uns zurueck.",
                "Noch haelt der Himmel einen neuen Aufwind bereit.",
                "Der Atem des Lebens kehrt zurueck.",
                "Auch nach dem Sturz kann ein neuer Aufwind beginnen.",
                "Zwischen Himmel und Erde ist diese Reise noch nicht beendet.",
                "Zephras lehrte uns: Was faellt, kann wieder getragen werden.",
                "*streckt beide Haende in den Wind und ruft nach einem neuen Aufwind fuer den gefallenen Gefaehrten.*",
                "*senkt sich nieder, waehrend ein sanfter Luftzug durch die Stille zieht.*",
            },
        },
    },
}
