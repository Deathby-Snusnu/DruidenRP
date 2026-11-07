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

addon.localeData.deDE.texts = {
    MARK = {
        name = "Mal der Wildnis",
        ziel = {
            "Die Wildnis wache ueber Euch, %s.",
            "Moegen Wurzel, Wind und Stern Euch staerken, %s.",
            "Tragt den Segen der Natur mit Euch, %s.",
            "Moege das Gleichgewicht der Wildnis Euch begleiten, %s.",
            "Erde unter den Fuessen, Himmel ueber dem Haupt und Leben in Eurem Herzen, %s.",
            "Moege die Natur Euch Kraft geben, ohne Euch zu beschweren, %s.",
            "*legt %s kurz die Hand auf die Schulter und murmelt einen alten Segen der Wildnis.*",
            "*zeichnet mit zwei Fingern ein schlichtes Zeichen der Natur vor %s in die Luft.*",
        },
        gruppe = {
            "Die Wildnis wache ueber uns.",
            "Moege die Natur uns Kraft und Widerstand schenken.",
            "Wir gehen nicht allein. Der Wald begleitet uns.",
            "Moege das Gleichgewicht der Wildnis unsere Schritte leiten.",
            "Erde, Wind und Leben stehen mit uns.",
            "Die Natur staerke jeden von uns auf seine Weise.",
            "*breitet die Arme aus und ruft den Segen der Wildnis auf die Gefaehrten herab.*",
            "*senkt den Kopf und lauscht einen Augenblick auf Wind, Blaetter und Erde.*",
        },
    },

    GIFT = {
        name = "Gabe der Wildnis",
        gruppe = {
            "Der Segen der Wildnis sei mit Euch allen.",
            "Wie die Wurzeln eines Waldes sind wir miteinander verbunden.",
            "Moege die Natur unsere Gemeinschaft staerken.",
            "Viele Zweige, ein lebendiges Ganzes.",
            "Moege jeder von uns Kraft aus der Wildnis schoepfen.",
            "Die Gabe der Natur ruhe auf unserer Gemeinschaft.",
            "*hebt beide Haende und laesst die Kraft der Wildnis durch die Gemeinschaft stroemen.*",
            "*zieht mit einer weiten Geste einen unsichtbaren Kreis des Segens um die Gefaehrten.*",
        },
    },

    THORNS = {
        name = "Dornen",
        ziel = {
            "Moegen die Dornen Euch schuetzen, %s.",
            "Wer Euch verletzt, spuere die Wehrhaftigkeit der Wildnis, %s.",
            "Auch die sanfteste Bluete hat ihre Dornen, %s.",
            "Moege jeder Schlag gegen Euch seinen Preis fordern, %s.",
            "Die Wildnis schuetzt, was zu ihr gehoert, %s.",
            "Tragt die Warnung der Dornen mit Euch, %s.",
            "*streicht mit der Hand ueber %s; fuer einen Moment scheint die Luft von unsichtbaren Dornen zu flirren.*",
            "*schliesst kurz die Finger, als wuerden sich scharfe Ranken um %s legen.*",
        },
        gruppe = {
            "Die Wildnis ist nicht wehrlos.",
            "Dornen wachen ueber uns.",
            "Wer nach uns greift, greift in Dornen.",
            "Die Natur kennt nicht nur Sanftmut.",
            "Jeder Angriff soll an der Wildnis seinen Preis finden.",
            "Lasst unsere Feinde lernen, dass auch Blaetter Dornen tragen koennen.",
            "*laesst den Blick ueber die Gefaehrten wandern, waehrend die Wildnis ihren Schutz verdichtet.*",
            "*zieht die Hand zur Faust; die Luft um die Gruppe wirkt fuer einen Augenblick stachelig und gespannt.*",
        },
    },

    REJUVENATION = {
        name = "Verjuengung",
        ziel = {
            "Neue Kraft wachse in Euch, %s.",
            "Wie ein Blatt im Fruehling sollt Ihr Euch erneuern, %s.",
            "Lasst die Natur Eure Wunden lindern, %s.",
            "Mit jedem Atemzug kehre ein wenig Kraft zurueck, %s.",
            "Das Leben arbeitet still. Gebt ihm einen Augenblick, %s.",
            "Moege neue Lebenskraft durch Euch stroemen, %s.",
            "*legt %s behutsam die Hand auf und laesst neue Lebenskraft stroemen.*",
            "*streicht langsam ueber eine Verletzung von %s, waehrend gruene Energie aufflackert.*",
        },
        gruppe = {
            "Mit jedem Atemzug kehrt neue Kraft zurueck.",
            "Der Fruehling kennt einen neuen Anfang.",
            "Die Natur erneuert, was verwundet wurde.",
            "Heilung braucht nicht immer Eile. Manchmal braucht sie Zeit.",
            "Das Leben kehrt Schritt fuer Schritt zurueck.",
            "Neue Kraft waechst, solange wir ihr Raum geben.",
            "*atmet tief ein und fuehrt die Haende ruhig zusammen, waehrend neue Lebenskraft erwacht.*",
            "*senkt die Haende langsam und beruhigt den Rhythmus des Lebens.*",
        },
    },

    REGROWTH = {
        name = "Nachwachsen",
        ziel = {
            "Wie junge Triebe nach dem Sturm sollt Ihr wieder erstarken, %s.",
            "Die Natur schliesse Eure Wunden, %s.",
            "Atmet ruhig, %s. Neue Kraft kehrt zurueck.",
            "Wo etwas gebrochen ist, soll neues Leben wachsen, %s.",
            "Die Wildnis gibt nicht auf, was noch leben will, %s.",
            "Lasst Eure Kraft neu austreiben, %s.",
            "*kniet sich zu %s und legt beide Haende ueber die Verletzung.*",
            "*zieht die Finger langsam zurueck, als wuerden unsichtbare Triebe eine Wunde von %s schliessen.*",
        },
        gruppe = {
            "Selbst nach dem Sturm treibt der Wald neu aus.",
            "Wo Leben ist, kann Heilung wachsen.",
            "Die Wurzeln halten. Wir werden wieder erstarken.",
            "Was verletzt wurde, muss nicht verloren sein.",
            "Der Wald kennt den Weg vom Bruch zum neuen Trieb.",
            "Heilung waechst dort, wo wir sie gedeihen lassen.",
            "*zeichnet mit den Haenden eine wachsende Bewegung in die Luft.*",
            "*senkt sich kurz in die Knie und legt eine Hand auf die Erde, bevor neue Kraft aufsteigt.*",
        },
    },

    HEALING_TOUCH = {
        name = "Heilende Beruehrung",
        ziel = {
            "Die Kraft der Erde heile Euch, %s.",
            "Moege meine Beruehrung Euch Ruhe und Heilung bringen, %s.",
            "Das Leben halte Euch fest, %s.",
            "Bleibt bei uns, %s. Die Natur schenkt Euch neue Kraft.",
            "Moege die Lebenskraft der Wildnis Eure Wunden schliessen, %s.",
            "Atmet, %s. Erde und Leben stehen Euch bei.",
            "*legt %s ruhig die Hand auf und konzentriert sich ganz auf die heilende Beruehrung.*",
            "*schliesst fuer einen Augenblick die Augen, waehrend warme Lebenskraft durch die Hand zu %s fliesst.*",
        },
        gruppe = {
            "Die Natur schenkt uns Heilung.",
            "Moege die Erde unsere Wunden tragen.",
            "Das Leben findet seinen Weg.",
            "Wo Leben bleibt, bleibt auch Hoffnung auf Heilung.",
            "Die Wildnis leiht uns ihre Kraft.",
            "Erde und Leben tragen uns durch diesen Augenblick.",
            "*legt beide Haende aneinander und sammelt einen ruhigen Strom heilender Kraft.*",
            "*atmet langsam aus und laesst die heilende Energie der Natur durch sich hindurchfliessen.*",
        },
    },

    TRANQUILITY = {
        name = "Gelassenheit",
        gruppe = {
            "Werdet still und hoert den Atem des Waldes.",
            "Wie ruhiges Wasser kehre Frieden in unsere Herzen zurueck.",
            "Die Natur halte uns in diesem Augenblick geborgen.",
            "Lasst den Laerm des Kampfes fuer einen Moment verstummen.",
            "Atmet gemeinsam. Die Wildnis heilt auch in der Stille.",
            "Wie ein stiller Hain gebe uns dieser Augenblick neue Kraft.",
            "*senkt die Arme langsam und wird vollkommen still, waehrend sich eine ruhige Aura ausbreitet.*",
            "*schliesst die Augen und atmet im gleichmaessigen Rhythmus des Waldes.*",
        },
    },

    INNERVATE = {
        name = "Anregen",
        ziel = {
            "Die Quellen der Natur erneuern Eure Kraft, %s.",
            "Schoepft tief aus dem Strom des Lebens, %s.",
            "Moege Euer Geist wieder klar und kraftvoll werden, %s.",
            "Lasst neue Kraft durch Euch stroemen, %s.",
            "Eure Reserven sind noch nicht erschoepft, %s. Schoepft erneut.",
            "Moege die Wildnis Euren Geist mit neuer Kraft fuellen, %s.",
            "*legt zwei Finger an die Stirn von %s und ruft neue geistige Kraft hervor.*",
            "*zieht mit der Hand einen kleinen Kreis vor %s, waehrend neue Energie aufsteigt.*",
        },
        gruppe = {
            "Neue Kraft aus den Quellen der Natur.",
            "Der Strom des Lebens versiegt noch nicht.",
            "Ein tiefer Atemzug, ein neuer Anfang.",
            "Die Wildnis gibt Kraft, wenn wir sie mit Bedacht erbitten.",
            "Noch ist unsere Kraft nicht erschoepft.",
            "Aus stillen Quellen waechst neue Staerke.",
            "*hebt eine Hand und sammelt neue Kraft aus den stillen Quellen der Natur.*",
            "*schliesst kurz die Augen und richtet den Geist auf den Strom des Lebens.*",
        },
    },

    REBIRTH = {
        name = "Wiedergeburt",
        ziel = {
            "Kehrt zu uns zurueck, %s. Euer Weg ist noch nicht zu Ende.",
            "Das Leben ruft Euch beim Namen, %s.",
            "Erwacht, %s. Wir brauchen Euch an unserer Seite.",
            "Der Kreislauf oeffnet Euch noch einmal seine Tuer, %s.",
            "Noch ist Eure Geschichte nicht zu Ende, %s. Kehrt zurueck.",
            "Das Leben laesst Euch noch nicht los, %s.",
            "*kniet neben %s nieder, legt eine Hand auf dessen Brust und ruft eindringlich nach dem Leben.*",
            "*beugt sich ueber %s und presst die Hand gegen die Erde, waehrend neue Lebenskraft aufsteigt.*",
        },
        gruppe = {
            "Der Kreislauf schenkt uns eine zweite Chance.",
            "Noch ist diese Reise nicht zu Ende.",
            "Das Leben ruft einen Gefaehrten zurueck.",
            "Wo das Ende schien, beginnt noch einmal ein Weg.",
            "Ein Atemzug gegen die Stille. Ein Gefaehrte kehrt zurueck.",
            "Der Kreislauf dreht sich noch einmal fuer einen von uns.",
            "*kniet nieder und legt beide Haende auf die Erde, waehrend der Kreislauf des Lebens antwortet.*",
            "*senkt ehrfuerchtig den Kopf, bis ein neuer Atemzug die Stille durchbricht.*",
        },
    },

    NATURES_GRASP = {
        name = "Griff der Natur",
        gruppe = {
            "Die Wildnis wartet nur auf den naechsten unvorsichtigen Schritt.",
            "Kommt nur naeher. Die Erde ist bereit.",
            "Wer mich bedrängt, wird die Antwort der Wurzeln spueren.",
            "Die Natur greift nach jedem, der mir zu nahe kommt.",
            "Der Boden unter meinen Fuessen ist wacher, als er aussieht.",
            "Ein Schritt zu viel, und die Wildnis haelt fest.",
            "*senkt eine Hand zum Boden, waehrend sich feine Wurzeln unter der Erde regen.*",
            "*streicht mit den Fingern durch die Luft; am Boden antworten verborgene Ranken.*",
        },
    },

    ROOTS = {
        name = "Wucherwurzeln",
        ziel = {
            "Wurzeln der Erde, haltet %s fest!",
            "Die Wildnis gebietet Euch Einhalt, %s.",
            "Keinen Schritt weiter, %s. Der Boden selbst haelt Euch.",
            "Die Erde hat Euch gehoert, %s. Nun bleibt Ihr hier.",
            "Wurzeln, umschlingt %s und nehmt ihm den Weg!",
            "Die Wildnis entscheidet, wann Ihr weitergeht, %s.",
            "*reisst eine Hand nach oben; Wurzeln brechen aus dem Boden und greifen nach %s.*",
            "*stampft mit dem Fuss auf und lenkt die Kraft der Erde gegen %s.*",
        },
        gruppe = {
            "Wurzeln der Erde, haltet fest!",
            "Die Wildnis gebietet Einhalt.",
            "Der Wald laesst seine Feinde nicht vorueber.",
            "Der Boden selbst erhebt sich gegen unsere Feinde.",
            "Wo Wurzeln greifen, endet jeder Ansturm.",
            "Die Erde haelt fest, was nicht weitergehen soll.",
            "*streckt beide Haende zum Boden aus und weckt die Wurzeln unter der Erde.*",
            "*reisst den Arm hoch; der Boden antwortet mit knorrigen Ranken.*",
        },
    },

    MOONFIRE = {
        name = "Mondfeuer",
        ziel = {
            "Das Licht des Mondes trifft Euch, %s.",
            "Silbernes Feuer erhelle Euren Schatten, %s.",
            "Der Mond blickt auf Euch, %s.",
            "Unter kaltem Mondlicht findet Euch mein Zorn, %s.",
            "Silbernes Licht brenne auf Euch, %s.",
            "Dem Blick des Mondes entgeht Ihr nicht, %s.",
            "*hebt die Hand zum Himmel und reisst einen silbernen Lichtstrahl auf %s herab.*",
            "*deutet scharf auf %s, waehrend kaltes Mondlicht aufflammt.*",
        },
        gruppe = {
            "Silbernes Feuer durchbricht die Dunkelheit.",
            "Der Mond erhellt meinen Weg.",
            "Unter den Sternen stehe ich nicht allein.",
            "Mondlicht kann sanft sein. Dieses ist es nicht.",
            "Silbernes Licht weist meinem Zorn den Weg.",
            "Der Himmel selbst antwortet auf meinen Ruf.",
            "*hebt den Blick zum Himmel und ruft silbernes Licht herab.*",
            "*reisst die Hand nach vorn; ein kalter Schimmer des Mondes folgt der Bewegung.*",
        },
    },

    WRATH = {
        name = "Zorn",
        gruppe = {
            "Die Natur erhebt ihre Stimme.",
            "Auch die Geduld der Wildnis hat Grenzen.",
            "Die Kraft der Erde fuehre meine Hand.",
            "Die Wildnis ist geduldig, aber nicht wehrlos.",
            "Wind und Erde antworten auf meinen Ruf.",
            "Wer das Gleichgewicht bricht, spuert den Zorn der Natur.",
            "*ballt die Hand, waehrend sich die Kraft der Natur darin sammelt.*",
            "*reisst den Arm nach vorn und entlaedt den Zorn der Wildnis.*",
        },
    },

    BARKSKIN = {
        name = "Baumrinde",
        gruppe = {
            "Wie alte Rinde halte ich dem Sturm stand.",
            "Die Staerke der Baeume schuetzt mich.",
            "Tief verwurzelt weiche ich nicht.",
            "Schlag fuer Schlag. Die Rinde haelt.",
            "Die aeltesten Baeume haben viele Stuerme gesehen.",
            "Heute breche ich nicht.",
            "*spannt die Schultern an, waehrend die Haut rau und rindenartig wird.*",
            "*steht fest, als sich eine schutzende Schicht wie Baumrinde ueber den Koerper legt.*",
        },
    },

    BEAR = {
        name = "Baerengestalt / Terrorbaerengestalt",
        gruppe = {
            "Mit der Kraft des Baeren wache ich ueber meine Gefaehrten.",
            "Die Wildnis schenkt mir Standhaftigkeit.",
            "Wer meine Gefaehrten bedroht, muss an mir vorbei.",
            "Klauen bereit. Ich halte die Linie.",
            "Der Baer fragt nicht, ob der Feind gross ist.",
            "Kommt nur. Die Wildnis hat mir breite Schultern gegeben.",
            "*geht tief in die Knie, waehrend der Koerper massiger wird und sich in Baerengestalt wandelt.*",
            "*richtet sich mit einem tiefen Knurren in Baerengestalt auf.*",
        },
    },

    CAT = {
        name = "Katzengestalt",
        gruppe = {
            "Leise wie ein Schatten zwischen den Baeumen.",
            "Die Katze leiht mir ihre Schritte.",
            "Geduld und scharfe Sinne fuehren mich.",
            "Ein falscher Schritt, und ich bin schon hinter Euch.",
            "Die Wildnis kennt auch lautlose Jaeger.",
            "Klauen brauchen keine langen Reden.",
            "*senkt den Koerperschwerpunkt und gleitet geschmeidig in Katzengestalt.*",
            "*streckt sich kurz, bevor Fell und Klauen die menschliche Gestalt ersetzen.*",
        },
    },

    TRAVEL = {
        name = "Reisegestalt",
        gruppe = {
            "Der Wind weist mir den Weg.",
            "Die Wildnis kennt keine gepflasterten Strassen.",
            "Leichte Schritte tragen mich weiter.",
            "Der Horizont ist noch lange nicht erreicht.",
            "Wo ein Pfad endet, beginnt fuer die Wildnis nur ein anderer.",
            "Keine Rast. Der Weg selbst ruft.",
            "*nimmt Schwung auf, waehrend sich die Gestalt fliessend fuer die Reise wandelt.*",
            "*beugt sich nach vorn und laesst die Wildnis den Koerper fuer den Weg formen.*",
        },
    },

    AQUATIC = {
        name = "Wassergestalt",
        gruppe = {
            "Die Stroemung traegt mich.",
            "Auch unter den Wellen ist das Leben mein Gefaehrte.",
            "Ich folge dem Ruf des Wassers.",
            "Wo Wege enden, beginnt manchmal eine Stroemung.",
            "Das Wasser kennt keinen geraden Pfad und erreicht doch sein Ziel.",
            "Unter der Oberflaeche wartet eine andere Wildnis.",
            "*taucht nach vorn, waehrend sich die Gestalt noch in der Bewegung an das Wasser anpasst.*",
            "*laesst sich ins Wasser gleiten und nimmt geschmeidig Wassergestalt an.*",
        },
    },

    MOONKIN = {
        name = "Mondkingestalt",
        gruppe = {
            "Unter Mond und Sternen halte ich das Gleichgewicht.",
            "Die Sterne leihen mir ihre Kraft.",
            "Moege das Gleichgewicht meine Schritte leiten.",
            "Zwischen Erde und Himmel liegt meine Kraft.",
            "Die Sterne sind fern. Ihre Macht ist es nicht.",
            "Das Gleichgewicht braucht gelegentlich sehr grosse Federn.",
            "*breitet die Arme aus, waehrend Federn und eine massige Mondkingestalt entstehen.*",
            "*richtet sich unter einem Schimmer von Mondlicht in Mondkingestalt auf.*",
        },
    },

    TREE = {
        name = "Baum des Lebens",
        gruppe = {
            "Meine Wurzeln halten, meine Zweige schenken Heilung.",
            "Im Schatten des Lebensbaumes findet Ihr neue Kraft.",
            "Das Leben waechst, solange wir es bewahren.",
            "Kommt naeher. Unter meinen Zweigen ist noch Platz.",
            "Solange die Wurzeln halten, gebe ich Euch Kraft.",
            "Ein Wald heilt nicht mit Eile, sondern mit Ausdauer.",
            "*verwurzelt die Fuesse im Boden, waehrend Aeste und Blaetter aus der Gestalt wachsen.*",
            "*breitet die Arme wie Zweige aus und nimmt die Gestalt des Lebensbaumes an.*",
        },
    },

    FLIGHT = {
        name = "Fluggestalt",
        gruppe = {
            "Der Himmel oeffnet mir seine Wege.",
            "Auf den Schwingen der Wildnis trage ich meine Hoffnung.",
            "Ueber den Baumkronen folge ich dem Wind.",
            "Der Boden kann warten. Der Himmel ruft.",
            "Der Wind kennt Wege, die kein Fuss betreten kann.",
            "Von hier oben wirkt selbst der laengste Weg ein wenig kuerzer.",
            "*springt leicht vom Boden ab, waehrend Arme zu Schwingen werden.*",
            "*breitet die Schwingen aus und laesst sich vom Wind in die Hoehe tragen.*",
        },
    },
    -- 2026-11: zusätzliches, fähigkeitsspezifisches Druidenvokabular
    STARFIRE = { name = "Sternenfeuer", gruppe = { "Auch fernes Sternenlicht findet seinen Weg durch Blätter und Dunkel.", "Ein Funke vom Himmel genügt, um die Nacht zu spalten.", "*zeichnet die Bahn eines Sterns zwischen den erhobenen Händen nach.*", "*richtet den Blick über die Baumkronen und ruft einen silbernen Strahl herab.*" }, ziel = { "%s, selbst der weite Himmel hat Euch gefunden." }, },
    INSECT_SWARM = { name = "Insektenschwarm", gruppe = { "Die kleinsten Wesen der Wildnis führen ihre eigenen Kriege.", "Ein Summen wird zur Warnung, wenn die Natur sich erhebt.", "*streicht über eine Blüte und lässt einen Schwarm aus dem Unterholz aufsteigen.*", "*dreht die Hand, als lenke ein unsichtbares Flügelmeer den Weg.*" }, ziel = { "%s, unterschätzt die kleinen Flügel nicht." }, },
    HURRICANE = { name = "Hurrikan", gruppe = { "Der Wind wird nicht um Erlaubnis bitten.", "Die Baumkronen haben den Sturm schon angekündigt.", "*zieht mit beiden Armen große Kreise, bis die Luft zu heulen beginnt.*", "*stemmt die Füße in den Boden, während Äste und Blätter im Wirbel tanzen.*" }, },
    FAERIE_FIRE = { name = "Feenfeuer", gruppe = { "Was sich verbirgt, soll im Schimmer der Lichtung sichtbar werden.", "Ein Funke aus dem Feenreich verrät selbst den leisesten Schatten.", "*zeichnet ein glühendes Blatt in die Luft.*", "*lässt einen flirrenden Schein auf dem Pfad zurück.*" }, ziel = { "Verstecken hilft Euch nicht, %s." }, },
    FAERIE_FIRE_FERAL = { name = "Feenfeuer (wild)", gruppe = { "Auch Klauen verstehen die Sprache des Feenlichts.", "Der Wald zeichnet seine Gegner mit einem anderen Licht.", "*schüttelt ein unheimliches Glimmen aus dem Fell.*", "*zieht eine leuchtende Spur mit den Krallen in die Erde.*" }, ziel = { "Ihr seid markiert, %s. Der Wald sieht Euch." }, },
    ECLIPSE = { name = "Finsternis", gruppe = { "Sonne und Mond streiten nicht. Sie teilen sich den Himmel.", "Wo das eine Licht vergeht, wird das andere geboren.", "*hält zwei Handflächen gegeneinander, während ein Lichtkreis dazwischen verdunkelt.*", "*senkt den Blick, als wandere ein Schatten über die Sonne.*" }, },
    WILD_GROWTH = { name = "Wildwuchs", gruppe = { "Eine Wurzel hält selten nur einen einzigen Ast am Leben.", "Wachst, wo der Kampf die Erde wund gemacht hat.", "*schickt einen grünen Schimmer durch die Reihen der Gefährten.*", "*berührt den Boden, und ein Wellenring aus jungen Blättern breitet sich aus.*" }, },
    BLOOM = { name = "Blüte", gruppe = { "Aus dem kleinsten Samen wird mit Geduld ein ganzer Frühling.", "Eine Blüte braucht kein Publikum, um Hoffnung zu schenken.", "*öffnet die Hände, als entfalte sich darin eine unsichtbare Knospe.*", "*lässt einen frischen Duft und sanftes Licht durch die Luft ziehen.*" }, ziel = { "Die Blüte der Wildnis gehört Euch, %s." }, },
    PRIMAL_BITE = { name = "Urbiss", gruppe = { "Die Wildnis erklärt ihren Hunger nicht.", "Ein einziger Biss entscheidet, ob die Jagd weitergeht.", "*spannt die Schultern wie ein Raubtier vor dem Sprung.*", "*schnappt mit voller Kraft nach einer nahen Öffnung in der Deckung.*" }, ziel = { "%s, nun kennt Ihr die Zähne der Wildnis." }, },
    LACERATE = { name = "Zerfleischen", gruppe = { "Nicht jeder Kratzer heilt mit einem Blatt.", "Die Spur der Krallen bleibt, wenn der Kampf schon weiterzieht.", "*setzt mit tiefer Haltung zu mehreren scharfen Hieben an.*", "*fährt mit den Klauen in einem kurzen, reißenden Bogen vor.*" }, ziel = { "Diese Wunde werdet Ihr in Erinnerung behalten, %s." }, },
    REVIVE = { name = "Wiederbeleben", gruppe = { "Das Leben schläft manchmal nur hinter einer schweren Tür.", "Komm zurück. Es warten noch Wurzeln, Wege und Stimmen.", "*kniet nieder und legt eine Hand auf das reglose Herz.*", "*spricht sanft zu einer gefallenen Seele und lässt grünes Licht entstehen.*" }, ziel = { "%s, die Wildnis ruft Euch zurück." }, },
    SWIFTMEND = { name = "Rasche Heilung", gruppe = { "Die Natur braucht keinen langen Weg, wenn die Not nahe ist.", "Ein Augenblick grüner Wärme reicht oft aus.", "*zieht die Hand zurück und schickt die gebündelte Heilung vorwärts.*", "*streicht einen heilenden Funken über eine Wunde.*" }, ziel = { "%s, haltet durch. Es wird leichter." }, },
    NATURES_SWIFTNESS = { name = "Schnelligkeit der Natur", gruppe = { "Was die Natur beschließt, geschieht ohne Zögern.", "Der Wind wartet nicht auf einen zweiten Gedanken.", "*richtet sich plötzlich auf, als flösse der Wind durch die Glieder.*", "*legt zwei Finger an den Boden und sammelt sich in einem Atemzug.*" }, },
    OMEN_OF_CLARITY = { name = "Omen der Klarsicht", gruppe = { "Zwischen zwei Atemzügen liegt die Antwort.", "Die klarste Entscheidung wächst oft im Stillen.", "*schließt kurz die Augen und lauscht auf eine innere Stimme.*", "*lässt einen stillen Lichtschimmer über die Finger huschen.*" }, },
    SOOTHE_ANIMAL = { name = "Tier besänftigen", gruppe = { "Ruhig, kleines Herz. Niemand muss heute kämpfen.", "Furcht ist kein Feind, den man mit Zähnen besiegen muss.", "*senkt die Schultern und spricht mit sanfter Stimme auf ein Tier ein.*", "*hält die offene Hand still und wartet auf ein Zeichen des Vertrauens.*" }, ziel = { "Ganz ruhig, %s. Ich will Euch nichts nehmen." }, },
    HIBERNATE = { name = "Winterschlaf", gruppe = { "Ein tiefer Schlaf kann ein freundlicherer Weg sein als ein Kampf.", "Die kühle Stille des Winters kennt keine Eile.", "*zeichnet einen ruhigen Kreis in die Luft und senkt die Stimme.*", "*lässt einen Hauch Frost und Stille über das Unterholz ziehen.*" }, ziel = { "Schlaft, %s. Die Nacht ist lang genug." }, },
    REMOVE_CURSE = { name = "Fluch aufheben", gruppe = { "Kein dunkles Wort soll dieses Herz fesseln.", "Ein Fluch ist nur eine Geschichte, deren Ende ich ändere.", "*wischt mit zwei Fingern einen unsichtbaren Knoten aus der Luft.*", "*streicht einen Schatten von der Schulter eines Gefährten.*" }, ziel = { "%s, dieser Fluch gehört nicht länger zu Euch." }, },
    CURE_POISON = { name = "Vergiftung heilen", gruppe = { "Gegen jedes Gift kennt die Erde einen geduldigen Widerstand.", "Die richtige Wurzel ist oft stärker als der falsche Stich.", "*zerreibt ein heilendes Blatt zwischen den Fingern.*", "*legt eine warme, grün leuchtende Hand auf eine Wunde.*" }, ziel = { "%s, lasst die Wildnis das Gift zurückholen." }, },
    ABOLISH_POISON = { name = "Vergiftung aufheben", gruppe = { "Möge kein Tropfen Gift Eure Kraft weiter stehlen.", "Ich bewahre diesen Atem vor dem stillen Feind.", "*zieht mit ruhiger Hand eine dunkle Spur aus der Luft.*", "*spricht einen alten Heilvers, während das Grün heller wird.*" }, ziel = { "%s, das Gift hat hier keine Heimstatt." }, },
    POUNCE = { name = "Anspringen", gruppe = { "Der Schatten sprang, bevor der Ast sich bewegte.", "Wer leise landet, hat den halben Kampf gewonnen.", "*duckt sich und schießt aus der Deckung nach vorn.*", "*landet mit ausgefahrenen Krallen und tiefem Schwerpunkt.*" }, ziel = { "Zu spät gesehen, %s." }, },
    SHRED = { name = "Schreddern", gruppe = { "Die Deckung hat eine Schwachstelle. Meine Klauen kennen sie.", "Der leiseste Schlag ist oft der letzte, den man kommen sieht.", "*schleicht um die Flanke und setzt einen reißenden Hieb.*", "*nutzt die Drehung des Gegners für einen raschen Angriff von hinten.*" }, ziel = { "Den Rücken solltet Ihr schützen, %s." }, },
    RAKE = { name = "Krallenhieb", gruppe = { "Ein kurzer Hieb. Eine lange Erinnerung.", "Die Krallen schreiben schneller, als Worte es könnten.", "*zieht drei schnelle Linien mit den Krallen durch die Luft.*", "*springt seitwärts und schlägt aus dem Handgelenk zu.*" }, ziel = { "%s, nehmt diese Warnung mit." }, },
    RIP = { name = "Zerfetzen", gruppe = { "Jetzt ist die Jagd entschieden.", "Ein Raubtier vergisst die letzte Öffnung nicht.", "*setzt zu einem entschlossenen, tiefen Krallenangriff an.*", "*stemmt sich ab und führt einen langen, reißenden Hieb.*" }, ziel = { "Die Jagd endet hier, %s." }, },
    FEROCIOUS_BITE = { name = "Wilder Biss", gruppe = { "Ein Raubtier spart seine Kraft für den letzten Biss.", "Zähne sind keine Drohung, sondern ein Versprechen.", "*spannt den Kiefer und stößt aus kurzer Distanz vor.*", "*wirft das Gewicht nach vorn und schnappt blitzschnell zu.*" }, ziel = { "%s, jetzt wird es eng." }, },
    CLAW = { name = "Klaue", gruppe = { "Kleine Narben erzählen von langen Kämpfen.", "Die Pfote ist flink, die Klaue entschieden.", "*zieht die Vorderpfote in einem scharfen Bogen durch die Luft.*", "*senkt den Körper und setzt einen raschen Krallenstoß.*" }, ziel = { "%s, unterschätzt die kleine Klaue nicht." }, },
    MAUL = { name = "Zermalmen", gruppe = { "Der Bär fragt nicht, wie stark der Baum aussieht.", "Manchmal antwortet die Wildnis mit roher Kraft.", "*richtet den mächtigen Oberkörper auf und schlägt abwärts.*", "*setzt die schweren Pranken mit aller Wucht ein.*" }, ziel = { "%s, das ist die Antwort des Bären." }, },
    SWIPE = { name = "Prankenhieb", gruppe = { "Ein Schlag, der mehrere Schatten vertreibt.", "Der Wald schlägt breit, wenn er sich verteidigt.", "*schwingt die Pranke in einem weiten Bogen.*", "*reißt mit einem mächtigen Hieb die Luft vor sich auf.*" }, },
    BASH = { name = "Hieb", gruppe = { "Stillstand ist manchmal die höflichste Antwort.", "Ein schwerer Schlag spart viele weitere Worte.", "*richtet sich auf und setzt einen kurzen, wuchtigen Stoß.*", "*trifft mit der Pranke und hält den Stand.*" }, ziel = { "%s, einen Moment Ruhe, bitte." }, },
    GROWL = { name = "Knurren", gruppe = { "Das ist mein Revier. Und meine Gefährten stehen dahinter.", "Ein Knurren erklärt genug.", "*stellt sich breitbeinig vor die Gruppe und knurrt tief.*", "*zeigt die Zähne und hält die Aufmerksamkeit auf sich.*" }, ziel = { "Hierher, %s. Ich warte." }, },
    ENRAGE = { name = "Wutanfall", gruppe = { "Selbst der ruhige Wald hat seine Stürme.", "Geduld endet nicht immer leise.", "*gräbt die Pranken in den Boden und spannt alle Muskeln.*", "*stößt einen tiefen, bebenden Laut aus.*" }, },
    DASH = { name = "Spurt", gruppe = { "Der Weg wird kürzer, wenn vier Pfoten ihn nehmen.", "Wind im Fell, Boden unter den Krallen.", "*springt los, noch bevor ein Blatt zu Boden gefallen ist.*", "*saust geschmeidig zwischen zwei Baumstämmen hindurch.*" }, },
    PROWL = { name = "Schleichen", gruppe = { "Ein Blatt raschelt. Ich nicht.", "Nur die Wildnis weiß, wo ich gerade gehe.", "*senkt sich tief ins Gras und verschwindet im Schatten.*", "*setzt eine Pfote vor die andere, ohne einen Zweig zu knicken.*" }, },
    FRENZIED_REGENERATION = { name = "Rasende Regeneration", gruppe = { "Ein Bär fällt nicht, nur weil das Leben schwer wird.", "Die Erde gibt zurück, was der Kampf genommen hat.", "*atmet schwer, dann strafft sich der mächtige Körper erneut.*", "*stemmt sich auf die Pranken und sammelt verbliebene Kraft.*" }, },
    CHALLENGING_ROAR = { name = "Herausforderndes Gebrüll", gruppe = { "Wenn ihr kämpfen wollt, dann seht mich an!", "Meine Gefährten bleiben hinter mir.", "*stößt ein gewaltiges Brüllen aus, das durch die Lichtung dröhnt.*", "*schlägt mit der Pranke auf den Boden und versperrt den Weg.*" }, },
    FERAL_CHARGE = { name = "Wilde Attacke", gruppe = { "Keine Deckung hält einen entschlossenen Bären auf.", "Zuerst kommt der Boden ins Beben, dann ich.", "*stößt sich mit den Hinterpranken ab und stürmt vorwärts.*", "*rammt die Schulter in die entstandene Lücke.*" }, ziel = { "%s, jetzt komme ich." }, },
    DEMORALIZING_ROAR = { name = "Demoralisierendes Gebrüll", gruppe = { "Mut klingt anders als dieses Knurren.", "Ein Wald voller Gegner kann plötzlich sehr still werden.", "*hebt den schweren Kopf und entfesselt ein grollendes Gebrüll.*", "*stellt das Fell auf und lässt die Stimme über die Lichtung rollen.*" }, },
    SHAPE_SHIFT = { name = "Gestaltwandel", gruppe = { "Die Haut ist nur eine Form des Lebens.", "Ich trage viele Gestalten, doch nur eine Erinnerung.", "*senkt den Kopf, während der Körper im grünen Schimmer verschmilzt.*", "*zieht die Hände an die Brust, als würde eine andere Silhouette erwachen.*" }, },
    REJUVENATING_BLOOM = { name = "Verjüngende Blüte", gruppe = { "Auch die kleinste Blüte kennt den Weg zurück zum Leben.", "Ein frischer Trieb zwischen den Steinen genügt als Zeichen.", "*lässt eine einzelne Knospe zwischen den Fingern erblühen.*", "*verstreut einen sanften grünen Schimmer über eine Wunde.*" }, ziel = { "%s, die Wildnis schenkt Euch einen neuen Anfang." }, },
}