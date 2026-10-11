# Druiden RP

Eigenstaendiges WoW-RP-Chat-Addon, abgeleitet vom Aufbau und Verhalten von
PaladinRP (Hannes, MIT). PaladinRP wird weder veraendert noch als Abhaengigkeit
benoetigt. Die Texte sind neu fuer Druiden geschrieben.

## Beschreibung

Zufaellige Rollenspieltexte fuer Druidenzauber und Gestalten, mit eigenen
Texten pro Charakter und Volkstexten fuer Nachtelfen und Tauren.
Die Ausgabe erfolgt ausschliesslich auf manuellen Aufruf.

## Installation

Den Ordner `DruidenRP` aus dem ZIP in diesen Ordner entpacken:

```text
<WoW-Installationsordner>\<Client>\Interface\AddOns
```

Danach muss `AddOns\DruidenRP\DruidenRP.toc` vorhanden sein, ohne einen
zusaetzlichen verschachtelten Projektordner. WoW neu starten, das Addon in der
Charakterauswahl aktivieren und mit einem Druiden einloggen.

Das ZIP enthaelt Spieldateien, Dokumentation und Lizenz, aber keine Tests,
Git- oder Editor-Dateien. Die Tests sind nur im Quellprojekt vorhanden.

## Schnellstart

```text
/drp help
/drp list
/drp mark
/drp rejuvenation
/drp bear
/drp status
/drp chance 100
/drp cooldown 20
/drp channel SAY
/drp channel PARTY
/drp channel INSTANCE_CHAT
```

`/druidenrp` ist ein Alias. Standard: 30 Prozent Textchance, 20 Sekunden
Cooldown. Der erste Text ist sofort moeglich. Chance und Cooldown gelten
auch fuer manuelle Befehle; Chance 0 deaktiviert die Ausgabe.
Nur Druiden koennen RP-Texte senden; andere Klassen koennen Einstellungen
anzeigen und aendern.

## Befehle

| Befehl | Funktion |
| --- | --- |
| `/drp` oder `/drp help` | Hilfe anzeigen |
| `/drp list` | Allgemeine Textschluessel auflisten |
| `/drp <schluessel>` | RP-Text versuchen |
| `/drp status` | Einstellungen anzeigen |
| `/drp chance <0-100>` | Textchance, ganze Zahl |
| `/drp cooldown <0-3600>` | Cooldown in Sekunden, ganze Zahl |
| `/drp channel` | Aktuellen Kanal anzeigen |
| `/drp channel <kanal>` | Kanal setzen |

`/druidenrp` unterstuetzt dieselben Befehle. Gross-/Kleinschreibung der
Befehle und Textschluessel spielt keine Rolle. Ungueltige Zahlen,
Dezimalwerte und zusaetzliche Argumente werden abgelehnt, nicht begrenzt.

Texte zwischen `*Sternchen*` werden als `/me`-Emote ausgegeben; die
Sternchen werden entfernt. Solche Handlungen verwenden immer `EMOTE`,
unabhaengig vom eingestellten Sprachkanal. Die bestehende manuelle
Kanaleinstellung `EMOTE` bleibt ebenfalls unterstuetzt.

## Einstellungen

| Einstellung | Standard | Werte |
| --- | --- | --- |
| `textChance` | `30` | Ganze Zahl 0-100 |
| `cooldown` | `20` | Ganze Zahl 0-3600 Sekunden |
| `chatChannel` | `SAY` | SAY, YELL, EMOTE, PARTY, RAID, INSTANCE_CHAT, AUTO |

Die Standardwerte stehen in [config/Settings.lua](./config/Settings.lua).
Alle Einstellungen und eigene Texte werden in `DruidenRP_CharacterDB` pro
Charakter gespeichert. Gueltige gespeicherte Werte, einschliesslich AUTO,
bleiben erhalten; ungueltige Werte werden mit einer Meldung repariert.

Die Ausgabe erfolgt standardmaessig in SAY, auch wenn der Charakter in einer
Gruppe oder einem Schlachtzug ist. Der Kanal kann jederzeit per
`/drp channel <kanal>` gesetzt werden: SAY, YELL, EMOTE, PARTY, RAID,
INSTANCE_CHAT oder AUTO. PARTY, RAID und INSTANCE_CHAT sind damit gezielt
waehlbar. AUTO waehlt Instanzgruppe, Schlachtzug, Gruppe oder SAY, in dieser
Reihenfolge. Ein nicht verfuegbarer Gruppenkanal wird gemeldet, nicht auf
einen oeffentlichen Kanal umgeleitet. SAY/YELL verwenden die bekannte
Volkssprache, wenn verfuegbar.
Ein abgelehnter Text startet keinen Cooldown. Bei einem erfolgreichen
Chat-API-Aufruf beginnt der Cooldown; Serverbeschraenkungen lassen sich
damit nicht als erfolgreiche Zustellung bestaetigen.

## Textschluessel

| Bereich | Schluessel |
| --- | --- |
| Segen | MARK, GIFT, THORNS |
| Heilung | REJUVENATION, REGROWTH, HEALING_TOUCH, TRANQUILITY |
| Unterstuetzung | INNERVATE, REBIRTH, BARKSKIN |
| Kampf | ROOTS, MOONFIRE, WRATH |
| Gestalten | BEAR, CAT, TRAVEL, AQUATIC, MOONKIN, TREE, FLIGHT |

Gestalten und Faehigkeiten sind Textkategorien, keine Pruefung auf bekannte
Zauber. Nicht alle Faehigkeiten existieren in jedem Classic-Client.
Nachtelfen und Tauren haben eigene Texte fuer MARK und REBIRTH;
andere Voelker verwenden die allgemeinen Texte.

Bei vorhandenem Ziel wird der Zieltext genutzt, sonst ein allgemeiner Text.
`%s` wird durch den Zielnamen ersetzt. Bei offensiven und heilenden Texten
liegt die Auswahl eines passenden Ziels beim Spieler.

## Makros

Wie PaladinRP reagiert das Addon nicht automatisch auf Zauberereignisse.
Ein Makro kann Zauber und RP-Aufruf verbinden:

```text
#showtooltip Mal der Wildnis
/cast Mal der Wildnis
/drp mark
```

```text
#showtooltip Baerengestalt
/cast Baerengestalt
/drp bear
```

Zaubernamen an die Sprache und Version des Clients anpassen. Der Textaufruf
prueft nicht, ob der Zauber erfolgreich war: Ein fehlgeschlagener Zauber kann
ebenfalls einen RP-Text ausloesen. Alternativ ist
`/run DruidenRP.TryText("MARK")` moeglich.
Chatbeschraenkungen des Clients gelten weiterhin; insbesondere in
SAY/YELL den Aufruf ueber einen manuellen Befehl oder Tastendruck ausloesen.

## Eigene Texte

Die Auswahl folgt der Reihenfolge eigene Texte, Volkstexte, allgemeine Texte.
Eigene Texte koennen in `DruidenRP_CharacterDB.personalTexts` unter einem
grossgeschriebenen Schluessel abgelegt werden, zum Beispiel per Makro:

```text
/run DruidenRP_CharacterDB.personalTexts.MARK={"Die Wildnis begleitet Euch, %s.","Der Wald begleitet uns."}
```

Ohne Ziel werden Eintraege mit `%s` nicht ausgegeben. Alternativ wird eine
Tabelle mit `ziel = {...}` und `gruppe = {...}` unterstuetzt. Ungueltige oder
leere eigene Textpools werden gemeldet. Zum Entfernen einer Anpassung:

```text
/run DruidenRP_CharacterDB.personalTexts.MARK=nil
```

Texte duerfen nach Ersetzung maximal 255 Bytes enthalten und keine
Zeilenumbrueche oder `|`-Chatmarkierungen.

## Projektstruktur

- [DruidenRP.toc](./DruidenRP.toc): Metadaten und Lade-Reihenfolge.
- [DruidenRP.lua](./DruidenRP.lua): Login und oeffentliche `DruidenRP.TryText`-API.
- [config/Settings.lua](./config/Settings.lua): Standardwerte.
- [core/Database.lua](./core/Database.lua): Charakterdaten und Validierung.
- [core/Text.lua](./core/Text.lua): Poolauswahl und Platzhalterersetzung.
- [core/Chat.lua](./core/Chat.lua): Kanaele, Volkssprache und Textpruefung.
- [core/Cooldown.lua](./core/Cooldown.lua): Wartezeit nach Textausgabe.
- [core/Commands.lua](./core/Commands.lua): Chatbefehle.
- [data/Texts.lua](./data/Texts.lua): 20 allgemeine Textkategorien.
- [data/Racial.lua](./data/Racial.lua): Nachtelfen- und Taurentexte.

Die Kernmodule verwenden die projektweit einheitlichen Funktionen
`BuildText`, `SendText`, `CooldownReady` und `StartCooldown`. `TryText` bleibt
die oeffentliche manuelle Schnittstelle; Textauswahl und Prioritaet bleiben
druidenspezifisch.

## Tests

Im Quellprojekt, nicht im Installations-ZIP, liegt
[tests/test_addon.lua](./tests/test_addon.lua). Vom AddOn-Ordner aus mit
Lua 5.1 oder 5.4 ausfuehren:

```powershell
lua tests\test_addon.lua
```

Der Test laedt die Dateien in TOC-Reihenfolge und simuliert die WoW-APIs.
Er prueft unter anderem Datenbankerhalt, Klassenbeschraenkung,
Kanalwahl, Textgrenzen und Cooldown.

## Kompatibilitaet

Die TOC deklariert Interface `16001` und Version `0.1.0`. Im Spiel zeigt
`/dump select(4, GetBuildInfo())` die benoetigte Interface-Version.
Die TOC-Version ist keine Zusage fuer jeden Classic- oder Beta-Build.
Erforderlich ist `C_ChatInfo.SendChatMessage`; ein Client mit ausschliesslich
der alten globalen Chat-API wird mit einer Meldung abgewiesen.
Ein echter Test im WoW-Client steht noch aus; Lua-Tests pruefen nur die
simulierten APIs.

Eigener Namensraum, `/drp` und `DruidenRP_CharacterDB` vermeiden Konflikte
mit PaladinRP. Keine externe Bibliothek, kein automatischer Chat-Spam und
keine unfertige Einstellungsoberflaeche. Konfiguration erfolgt per Chatbefehl.

## Lizenz

MIT-Lizenz, Copyright (c) 2026 Hannes, siehe [LICENSE](./LICENSE).
Die Aenderungen sind in [CHANGELOG.md](./CHANGELOG.md) dokumentiert.

## RP-Ausgabesprache

Die RP-Texte koennen pro Charakter auf `deDE`, `enUS` oder `frFR` gestellt werden. Beispiel: `/drp language frFR`. Fehlende Alt-Texpools fallen sicher auf Deutsch zurueck.
