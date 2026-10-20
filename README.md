# Druiden RP

Eigenstaendiges WoW-RP-Chat-Addon, abgeleitet vom Aufbau und Verhalten von
PaladinRP (Hannes Weichselbaum; Code MPL-2.0, RP-Texte CC BY-SA 4.0). PaladinRP wird weder veraendert noch als Abhaengigkeit
benoetigt. Die Texte sind neu fuer Druiden geschrieben.

## Beschreibung

Zufaellige Rollenspieltexte fuer Druidenzauber und Gestalten, mit eigenen
Texten pro Charakter und Volkstexten fuer Nachtelfen, Tauren und
Himmelsgeborene (`Skyborne`).
Die Ausgabe erfolgt ausschliesslich auf manuellen Aufruf.

## Dokumentation

[Sammlungsuebersicht](../README.md) · [Changelog](CHANGELOG.md) ·
[Texteditor und Handbuch](../RPTextStudio/HANDBUCH.md) ·
[Verpackung und gemeinsame Tests](../VERPACKUNG.md)

## Installation

Den Ordner `DruidenRP` aus dem ZIP in diesen Ordner entpacken:

```text
<WoW-Installationsordner>\<Client>\Interface\AddOns
```

Danach muss `AddOns\DruidenRP\DruidenRP.toc` vorhanden sein, ohne einen
zusaetzlichen verschachtelten Projektordner. WoW neu starten, das Addon in der
Charakterauswahl aktivieren und mit einem Druiden einloggen.

Das ZIP enthaelt Spieldateien, Dokumentation und Lizenz, aber keine Tests,
Git- oder IDE-Dateien innerhalb des AddOns. Das Sammlungspaket kann
zusaetzlich RPTextStudio und gemeinsame Hilfsskripte enthalten.
Die Tests sind nur im Quellprojekt vorhanden.

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
| `/drp language [deDE\|enUS\|frFR]` | RP-Ausgabesprache anzeigen oder setzen |

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
| `outputLanguage` | `deDE` | `deDE`, `enUS`, `frFR` |
| `textChance` | `30` | Ganze Zahl 0-100 |
| `cooldown` | `20` | Ganze Zahl 0-3600 Sekunden |
| `chatChannel` | `SAY` | SAY, YELL, EMOTE, PARTY, RAID, INSTANCE_CHAT, AUTO |

Die Standardwerte stehen in [config/Settings.lua](./config/Settings.lua).
Alle Einstellungen und eigene Texte werden in `DruidenRP_CharacterDB` pro
Charakter gespeichert. Gueltige gespeicherte Werte, einschliesslich AUTO,
bleiben erhalten; ungueltige Werte werden mit einer Meldung repariert.
Die RP-Ausgabesprache kann pro Charakter mit
`/drp language deDE|enUS|frFR` gewaehlt werden. Fehlende aeltere Textpools
fallen auf Deutsch zurueck.

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
| Unterstuetzung | INNERVATE, REBIRTH, BARKSKIN, NATURES_GRASP |
| Kampf | ROOTS, MOONFIRE, WRATH |
| Gestalten | BEAR, CAT, TRAVEL, AQUATIC, MOONKIN, TREE, FLIGHT |

Gestalten und Faehigkeiten sind Textkategorien, keine Pruefung auf bekannte
Zauber. Nicht alle Faehigkeiten existieren in jedem Classic-Client.
Nachtelfen, Tauren und Himmelsgeborene haben eigene Texte fuer MARK,
REBIRTH und NATURES_GRASP; andere Voelker verwenden allgemeine Texte.
Dies beschreibt vorhandene Textdaten, nicht die im jeweiligen Client
spielbaren Voelker.

`%s` wird durch den fuer den Schluessel aufgeloesten Namen ersetzt.
MARK, THORNS, REJUVENATION, REGROWTH, HEALING_TOUCH und INNERVATE verwenden
ein freundliches Ziel, sonst den eigenen Charakter. REBIRTH verwendet nur
ein freundliches Ziel. Gestalten, TRANQUILITY, BARKSKIN und NATURES_GRASP
verwenden keinen Zielnamen. Andere Schluessel verwenden das aktuelle Ziel,
sofern vorhanden; das AddOn waehlt kein Spielziel und bestaetigt keinen
Zaubererfolg.

In strukturierten Pools wird mit Namen zuerst `ziel`, dann `gruppe`
versucht. Danach koennen auch zielunabhaengige Eintraege aus `ziel`
verwendet werden. Ohne aufgeloesten Namen sind Eintraege mit `%s` unbrauchbar.

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

`DruidenRP.TryText(key)` erwartet einen nicht leeren String und normalisiert
ihn auf Grossbuchstaben. Die Funktion liefert `true` nach einem erfolgreichen
Chat-API-Aufruf, sonst `false`. Vor `PLAYER_LOGIN` werden Aufrufe mit einer
Meldung abgelehnt.

## Eigene Texte

Ein nutzbarer persoenlicher Text hat Vorrang. Andernfalls wird der erste
vorhandene Locale-Pool gewaehlt: Volkstext der Ausgabesprache, allgemeiner
Text der Ausgabesprache, deutscher Volkstext, deutscher allgemeiner Text.
Ein vorhandener, aber unbrauchbarer Locale-Pool wird nicht uebersprungen.
Eigene Texte koennen in `DruidenRP_CharacterDB.personalTexts` unter einem
grossgeschriebenen Schluessel abgelegt werden, zum Beispiel per Makro:

```text
/run DruidenRP_CharacterDB.personalTexts.MARK={"Die Wildnis begleitet Euch, %s.","Der Wald begleitet uns."}
```

Ohne aufgeloesten Namen werden Eintraege mit `%s` nicht ausgegeben.
Alternativ wird eine Tabelle mit `ziel = {...}` und `gruppe = {...}`
unterstuetzt. Liefert der persoenliche Pool keinen nutzbaren Text, wird der
Locale-Pool versucht.
Zum Entfernen einer Anpassung:

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
- `locales/<locale>/Texts.lua`: Allgemeine Textkategorien auf Deutsch,
  Englisch und Franzoesisch.
- `locales/<locale>/Racial.lua`: Nachtelfen-, Tauren- und Skyborne-Texte je Sprache.
- `locales/<locale>/Expansion.lua`: zusaetzliche Laufzeittexte; vom
  Texteditor nicht bearbeitet.

Die Kernmodule verwenden die projektweit einheitlichen Funktionen
`BuildText`, `SendText`, `CooldownReady` und `StartCooldown`. `TryText` bleibt
die oeffentliche manuelle Schnittstelle; Textauswahl und Prioritaet bleiben
druidenspezifisch.

Die Dateien unter `data/` sind nicht in der TOC-Ladefolge enthalten; die
Laufzeittexte liegen in den Locale-Dateien.

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

Die TOC deklariert Interface `16001` und Version `0.2.0`. Im Spiel zeigt
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

Dieses AddOn verwendet eine **geteilte Lizenzierung nach Dateityp**:

- Programmcode: **Mozilla Public License 2.0 (MPL-2.0)**, siehe [LICENSE](./LICENSE).
- RP-Dialoge, Emote-/Ambient-Texte und Übersetzungen: **CC BY-SA 4.0**, siehe [LICENSE-TEXTS](./LICENSE-TEXTS).
- Die verbindliche Zuordnung einer Lua-Datei steht in ihrem `SPDX-License-Identifier`.

Weitere Hinweise und der Markenhinweis stehen in [NOTICE](./NOTICE).
