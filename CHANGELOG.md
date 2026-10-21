# Changelog

Aenderungen an DruidenRP. Eine nicht belegte Release-Historie wird nicht
rekonstruiert.

## [Unreleased]

### Dokumentation

- Versionsangabe mit der TOC abgeglichen; Zielregeln, persoenlicher Fallback,
  NATURES_GRASP, Locale-Erweiterungen und gemeinsame Anleitungen dokumentiert.

### Geaendert

- Datenbank, Textauswahl, Chat, Cooldown und Befehle in Kernmodule getrennt.
- Oeffentliche `DruidenRP.TryText`-API fuer dokumentierte Makros exportiert.
- Chance (0-100) und Cooldown (0-3600) als ganze Zahlen strikt validiert,
  einschliesslich gespeicherter Werte.
- Gueltige gespeicherte AUTO-Kanaele bleiben erhalten; frueher migrierte
  Werte werden nicht nachtraeglich umgeschrieben.
- `/drp channel` zeigt ohne Argument den aktuellen Kanal.
- README und TOC-gesteuerte Tests an die Modulstruktur angepasst.
- Legacy-Tests an die benoetigte `C_ChatInfo`-API angepasst.
- Mit `*...*` markierte Handlungstexte werden ohne Sternchen als `/me`-Emotes
  gesendet.

### Beibehalten

- Manuelle Ausgabe nur fuer Druiden, sofortiger erster Text und SAY-Standard.
- Eigene Texte vor Volkstexten und allgemeinen Texten; vorhandene Textbestaende.
- Kein oeffentlicher Fallback fuer nicht verfuegbare explizite Gruppenkanaele.
- Textgrenze von 255 Bytes, keine Zeilenumbrueche oder Chat-Markierungen.
- Gemeinsame Modulkonventionen und kanonische Kernfunktionsnamen.

## [0.2.0] - 2026-10-14

### Geaendert

- Einheitliche Textauswahl und Fallback-Logik.
- Personaltexte fallen bei unbrauchbarem Pool sauber auf Locale-Texte zurueck.
- Erweiterter DE/EN/FR-Textvorrat.

## [0.1.1] - 2026-10-11

### Hinzugefuegt

- "Griff der Natur" (`NATURES_GRASP`) in Deutsch, Englisch und Franzoesisch.
- Eigene Texte fuer Nachtelfen, Tauren und Himmelsgeborene.

### Geaendert

- Rassenerkennung fuer Himmelsgeborene/Skyborne gegen Legacy-Tokens
  abgesichert und die Texte um Natur-, Wind- und Himmelsthemen erweitert.
- Himmelsgeborene verwenden bei SAY Darnassisch, sofern im Client verfuegbar.
- Zielaufloesung unterscheidet feindliche, freundliche und Selbstzauber;
  feindliche Ziele werden bei Selbst-/Freundzaubern nicht fuer `%s` verwendet.
- Die RP-Ausgabesprache kann pro Charakter auf `deDE`, `enUS` oder `frFR`
  gestellt werden. Locale-Tabellen werden separat initialisiert; nicht
  geladene Sprachdateien lassen sich nicht aktivieren.
- Maennliche Pronomen in `/me`-Aktionstexten wurden neutralisiert.
- `NATURES_GRASP` wird als Selbstzauber behandelt.

## Ambient-Erweiterung (21.10.2026)

Klassen- und rassenspezifisches, dreisprachiges Ambient-System; Konfiguration mit `/drp ambient`. Details in `AMBIENT.md`.

## Ambient-Textausbau (21.10.2026)

- Sechs neue Varianten je allgemeiner Kategorie, plus Rassentexte fuer Nachtelf, Tauren und Himmelsgeborene. Keine Aenderung an den Ambient-Triggern oder SavedVariables.
