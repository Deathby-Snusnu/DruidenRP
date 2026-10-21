# Ambient-System DruidenRP

## Verwendung

`/drp ambient status` zeigt den aktuellen Zustand.

`/drp ambient on|off` aktiviert/deaktiviert Ambient.

`/drp ambient chance 70` setzt die Wahrscheinlichkeit (0 bis 100).

`/drp ambient interval 180 420` setzt Mindest- und Hoechstintervall in Sekunden.

`/drp ambient combat off` unterdrueckt Ambient im Kampf.

`/drp ambient test` gibt bei Spieleraktion eine zufaellige Zeile aus.

Ambient-Zeilen werden vom Timer **nur vorgemerkt** und erst beim naechsten spielergesteuerten `/drp <SCHLUESSEL>` ausgegeben. Kein Chatversand aus `OnUpdate`. Der gemeinsame RP-Cooldown gilt auch fuer Ambient.

## Daten und Prioritaeten

`locales/<Sprache>/AmbientRacial.lua` (Rasse+Kategorie), danach `Ambient.lua` (Klasse+Kategorie), danach dieselben beiden Quellen in `deDE`. Die Textsammlung nutzt CC BY-SA 4.0, Code MPL 2.0. `*...*` bezeichnet eine `/me`-Handlung. Keine dynamischen Ziel-/Pet-Platzhalter in diesen Ambient-Pools.

Backups vor Installation: AddOn-Ordner und WTF-Verzeichnis sichern.

## Erweiterte Textsammlung

Sechs neue Varianten je allgemeiner Kategorie, plus Rassentexte fuer Nachtelf, Tauren und Himmelsgeborene. Jede Sprachfassung (deDE, enUS, frFR) enthaelt dieselben Kategorien und Variantenanzahlen. Die Lua-Textdateien sind im RP Text Studio bearbeitbar.
