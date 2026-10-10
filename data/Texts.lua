local _, addon = ...

-- RP-Konvention:
-- Gesprochene Texte stehen ohne Markierung und nutzen den eingestellten Sprachkanal (Standard: /say).
-- Beschreibende Handlungen stehen zwischen *Sternchen* und werden immer als /me ausgegeben.
-- Der Handler entfernt die Sternchen vor der Ausgabe.

addon.texts = {
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
}
