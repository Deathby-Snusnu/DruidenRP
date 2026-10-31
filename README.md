# Druiden RP

Eigenständiges WoW-RP-Chat-Add-on, abgeleitet vom Aufbau und Verhalten von
PaladinRP (Hannes Weichselbaum; Code MPL-2.0, RP-Texte CC BY-SA 4.0).
PaladinRP wird weder verändert noch als Abhängigkeit benötigt. Die Texte
sind neu für Druiden geschrieben.

## Beschreibung

Zufällige Rollenspieltexte für Druidenzauber und Gestalten, mit eigenen
Texten pro Charakter und Volkstexten für Nachtelfen, Tauren und
Himmelsgeborene (`Skyborne`).
Die Ausgabe erfolgt ausschließlich auf manuellen Aufruf.

## Dokumentation

[Sammlungsübersicht](https://github.com/Deathby-Snusnu/RPAddOns/blob/main/README.md) · [Changelog](CHANGELOG.md) ·
[Texteditor und Handbuch](https://github.com/Deathby-Snusnu/RPAddOns/blob/main/docs/RPTextStudio/HANDBUCH.md) ·
[Verpackung und gemeinsame Tests](https://github.com/Deathby-Snusnu/RPAddOns/blob/main/docs/VERPACKUNG.md)

Die gemeinsamen relativen Links setzen den vollständigen Sammlungs-Checkout
voraus. Im einzelnen AddOn-Repository sind die Anleitungen über das
[Sammlungsrepository](https://github.com/Deathby-Snusnu/RPAddOns) erreichbar.

## Installation

Den Ordner `DruidenRP` aus dem ZIP in diesen Ordner entpacken:

```text
<WoW-Installationsordner>\<Client>\Interface\AddOns
```

Danach muss `AddOns\DruidenRP\DruidenRP.toc` vorhanden sein, ohne einen
zusätzlichen verschachtelten Projektordner. WoW neu starten, das Add-on in der
Charakterauswahl aktivieren und mit einem Druiden einloggen.

Das Installations-ZIP enthält Laufzeitdateien und Lizenz-/Rechtehinweise,
aber keine Entwicklungsdokumentation, Tests, Git- oder IDE-Dateien.
Gemeinsame Dokumentation und Tests sind im vollständigen Quellprojekt
verfügbar.

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
Cooldown. Der erste Text ist sofort möglich. Chance und Cooldown gelten
auch für manuelle Befehle; Chance 0 deaktiviert die Ausgabe.
Nur Druiden können RP-Texte senden; andere Klassen können Einstellungen
anzeigen und ändern.

## Befehle

| Befehl | Funktion |
| --- | --- |
| `/drp` oder `/drp help` | Hilfe anzeigen |
| `/drp list` | Für den Charakter verwendbare Textschlüssel auflisten |
| `/drp list racial` | Schlüssel des aktuellen Volks auflisten |
| `/drp list all` | Rassen- und klassenspezifische Schlüssel mit Herkunft auflisten |
| `/drp <schlüssel>` | RP-Text versuchen |
| `/drp status` | Einstellungen anzeigen |
| `/drp chance <0-100>` | Textchance, ganze Zahl |
| `/drp cooldown <0-3600>` | Cooldown in Sekunden, ganze Zahl |
| `/drp channel` | Aktuellen Kanal anzeigen |
| `/drp channel <kanal>` | Kanal setzen |
| `/drp language [deDE\|enUS\|frFR]` | RP-Ausgabesprache anzeigen oder setzen |

Die Herkunfts- und Fallback-Regeln der drei Listenvarianten stehen im
[Listen-Handbuch](../../docs/LISTEN-HANDBUCH.md).

`/druidenrp` unterstützt dieselben Befehle. Groß-/Kleinschreibung der
Befehle und Textschlüssel spielt keine Rolle. Ungültige Zahlen,
Dezimalwerte und zusätzliche Argumente werden abgelehnt, nicht begrenzt.

Texte zwischen `*Sternchen*` werden als `/me`-Emote ausgegeben; die
Sternchen werden entfernt. Solche Handlungen verwenden immer `EMOTE`,
unabhängig vom eingestellten Sprachkanal. Die bestehende manuelle
Kanaleinstellung `EMOTE` bleibt ebenfalls unterstützt.

## Einstellungen

| Einstellung | Standard | Werte |
| --- | --- | --- |
| `outputLanguage` | `deDE` | `deDE`, `enUS`, `frFR` |
| `textChance` | `30` | Ganze Zahl 0-100 |
| `cooldown` | `20` | Ganze Zahl 0-3600 Sekunden |
| `chatChannel` | `SAY` | SAY, YELL, EMOTE, PARTY, RAID, INSTANCE_CHAT, AUTO |

Die Standardwerte stehen in [config/Settings.lua](./config/Settings.lua).
Alle Einstellungen und eigene Texte werden in `DruidenRP_CharacterDB` pro
Charakter gespeichert. Gültige gespeicherte Werte, einschließlich AUTO,
bleiben erhalten; ungültige Werte werden mit einer Meldung repariert.
Die RP-Ausgabesprache kann pro Charakter mit
`/drp language deDE|enUS|frFR` gewählt werden. Fehlende ältere Textpools
fallen auf Deutsch zurück.

Die Ausgabe erfolgt standardmäßig in SAY, auch wenn der Charakter in einer
Gruppe oder einem Schlachtzug ist. Der Kanal kann jederzeit per
`/drp channel <kanal>` gesetzt werden: SAY, YELL, EMOTE, PARTY, RAID,
INSTANCE_CHAT oder AUTO. PARTY, RAID und INSTANCE_CHAT sind damit gezielt
wählbar. AUTO wählt Instanzgruppe, Schlachtzug, Gruppe oder SAY, in dieser
Reihenfolge. Ein nicht verfügbarer Gruppenkanal wird gemeldet, nicht auf
einen öffentlichen Kanal umgeleitet. SAY/YELL verwenden die bekannte
Volkssprache, wenn verfügbar.

Ein abgelehnter Text startet keinen Cooldown. Bei einem erfolgreichen
Chat-API-Aufruf beginnt der Cooldown; Serverbeschränkungen lassen sich
damit nicht als erfolgreiche Zustellung bestätigen.

## Textschlüssel

| Bereich | Schlüssel |
| --- | --- |
| Segen | MARK, GIFT, THORNS |
| Heilung | REJUVENATION, REGROWTH, HEALING_TOUCH, TRANQUILITY |
| Unterstützung | INNERVATE, REBIRTH, BARKSKIN, NATURES_GRASP |
| Kampf | ROOTS, MOONFIRE, WRATH |
| Gestalten | BEAR, CAT, TRAVEL, AQUATIC, MOONKIN, TREE, FLIGHT |

Gestalten und Fähigkeiten sind Textkategorien, keine Prüfung auf bekannte
Zauber. Nicht alle Fähigkeiten existieren in jedem Classic-Client.
Nachtelfen, Tauren und Himmelsgeborene haben eigene Texte für MARK,
REBIRTH und NATURES_GRASP; andere Völker verwenden allgemeine Texte.
Dies beschreibt vorhandene Textdaten, nicht die im jeweiligen Client
spielbaren Völker.

`%s` wird durch den für den Schlüssel aufgelösten Namen ersetzt.
MARK, THORNS, REJUVENATION, REGROWTH, HEALING_TOUCH und INNERVATE verwenden
ein freundliches Ziel, sonst den eigenen Charakter. REBIRTH verwendet nur
ein freundliches Ziel. Gestalten, TRANQUILITY, BARKSKIN und NATURES_GRASP
verwenden keinen Zielnamen. Andere Schlüssel verwenden das aktuelle Ziel,
sofern vorhanden; das Add-on wählt kein Spielziel und bestätigt keinen
Zaubererfolg.

In strukturierten Pools wird mit Namen zuerst `ziel`, dann `gruppe`
versucht. Danach können auch zielunabhängige Einträge aus `ziel`
verwendet werden. Ohne aufgelösten Namen sind Einträge mit `%s` unbrauchbar.

## Makros

Wie PaladinRP reagiert das Add-on nicht automatisch auf Zauberereignisse.
Ein Makro kann Zauber und RP-Aufruf verbinden:

```text
#showtooltip Mal der Wildnis
/cast Mal der Wildnis
/drp mark
```

```text
#showtooltip Bärengestalt
/cast Bärengestalt
/drp bear
```

Zaubernamen an die Sprache und Version des Clients anpassen. Der Textaufruf
prüft nicht, ob der Zauber erfolgreich war: Ein fehlgeschlagener Zauber kann
ebenfalls einen RP-Text auslösen. Alternativ ist
`/run DruidenRP.TryText("MARK")` möglich.
Chatbeschränkungen des Clients gelten weiterhin; insbesondere in
SAY/YELL den Aufruf über einen manuellen Befehl oder Tastendruck auslösen.

`DruidenRP.TryText(key)` erwartet einen nicht leeren String und normalisiert
ihn auf Großbuchstaben. Die Funktion liefert `true` nach einem erfolgreichen
Chat-API-Aufruf, sonst `false`. Vor `PLAYER_LOGIN` werden Aufrufe mit einer
Meldung abgelehnt.

## Eigene Texte

Ein nutzbarer persönlicher Text hat Vorrang. Andernfalls wird der erste
vorhandene Locale-Pool gewählt: Volkstext der Ausgabesprache, allgemeiner
Text der Ausgabesprache, deutscher Volkstext, deutscher allgemeiner Text.
Ein vorhandener, aber unbrauchbarer Locale-Pool wird nicht übersprungen.
Eigene Texte können in `DruidenRP_CharacterDB.personalTexts` unter einem
großgeschriebenen Schlüssel abgelegt werden, zum Beispiel per Makro:

```text
/run DruidenRP_CharacterDB.personalTexts.MARK={"Die Wildnis begleitet Euch, %s.","Der Wald begleitet uns."}
```

Ohne aufgelösten Namen werden Einträge mit `%s` nicht ausgegeben.
Alternativ wird eine Tabelle mit `ziel = {...}` und `gruppe = {...}`
unterstützt. Liefert der persönliche Pool keinen nutzbaren Text, wird der
Locale-Pool versucht.
Zum Entfernen einer Anpassung:

```text
/run DruidenRP_CharacterDB.personalTexts.MARK=nil
```

Texte dürfen nach Ersetzung maximal 255 Bytes enthalten und keine
Zeilenumbrüche oder `|`-Chatmarkierungen.

## Projektstruktur

- [DruidenRP.toc](./DruidenRP.toc): Metadaten und Ladereihenfolge.
- [DruidenRP.lua](./DruidenRP.lua): Login und öffentliche `DruidenRP.TryText`-API.
- [config/Settings.lua](./config/Settings.lua): Standardwerte.
- [core/Database.lua](./core/Database.lua): Charakterdaten und Validierung.
- [core/Text.lua](./core/Text.lua): Poolauswahl und Platzhalterersetzung.
- [core/Chat.lua](./core/Chat.lua): Kanäle, Volkssprache und Textprüfung.
- [core/Cooldown.lua](./core/Cooldown.lua): Wartezeit nach Textausgabe.
- [core/Commands.lua](./core/Commands.lua): Chatbefehle.
- `locales/<locale>/Texts.lua`: Allgemeine Textkategorien auf Deutsch,
  Englisch und Französisch.
- `locales/<locale>/Racial.lua`: Nachtelfen-, Tauren- und Skyborne-Texte je
  Sprache.
- `locales/<locale>/Expansion.lua`: zusätzliche Laufzeittexte; vom
  Texteditor nicht bearbeitet.

Die Kernmodule verwenden die projektweit einheitlichen Funktionen
`BuildText`, `SendText`, `CooldownReady` und `StartCooldown`. `TryText` bleibt
die öffentliche manuelle Schnittstelle; Textauswahl und Priorität bleiben
druidenspezifisch.

Die Dateien unter `data/` sind nicht in der TOC-Ladefolge enthalten; die
Laufzeittexte liegen in den Locale-Dateien.

## Tests

Im Quellprojekt, nicht im Installations-ZIP, liegt
[tests/test_addon.lua](./tests/test_addon.lua). Vom Add-on-Ordner aus mit
Lua 5.1 oder 5.4 ausführen:

```powershell
lua tests\test_addon.lua
```

Der Test lädt die Dateien in TOC-Reihenfolge und simuliert die WoW-APIs.
Er prüft unter anderem Datenbankerhalt, Klassenbeschränkung,
Kanalwahl, Textgrenzen und Cooldown.

## Kompatibilität

Die TOC deklariert Interface `16001` und Version `0.3.1`. Im Spiel zeigt
`/dump select(4, GetBuildInfo())` die benötigte Interface-Version.
Die TOC-Version ist keine Zusage für jeden Classic- oder Beta-Build.
Erforderlich ist `C_ChatInfo.SendChatMessage`; ein Client mit ausschließlich
der alten globalen Chat-API wird mit einer Meldung abgewiesen.
Ein echter Test im WoW-Client steht noch aus; Lua-Tests prüfen nur die
simulierten APIs.

Eigener Namensraum, `/drp` und `DruidenRP_CharacterDB` vermeiden Konflikte
mit PaladinRP. Keine externe Bibliothek, kein automatischer Chat-Spam und
keine unfertige Einstellungsoberfläche. Konfiguration erfolgt per Chatbefehl.

## Lizenz

Dieses Add-on verwendet eine **geteilte Lizenzierung nach Dateityp**:

- Programmcode: **Mozilla Public License 2.0 (MPL-2.0)**, siehe
  [LICENSE](./LICENSE).
- RP-Dialoge, Emote-/Ambient-Texte und Übersetzungen: **CC BY-SA 4.0**, siehe
  [LICENSE-TEXTS](./LICENSE-TEXTS).
- Die verbindliche Zuordnung einer Lua-Datei steht in ihrem
  `SPDX-License-Identifier`.

Weitere Hinweise und der Markenhinweis stehen in [NOTICE](./NOTICE).

## Ambient-Erweiterung (21.10.2026)

Klassen- und rassenspezifisches, dreisprachiges Ambient-System; Konfiguration mit `/drp ambient`. Details in `AMBIENT.md`.
