# Changelog

Aenderungen an Druiden RP. Eine veroeffentlichte Release-Historie wird hier
nicht behauptet; die TOC traegt weiterhin Version `0.1.0`.

## [Unreleased]

### Geaendert

- Datenbank, Textauswahl, Chat, Cooldown und Befehle in Kernmodule getrennt.
- Oeffentliche `DruidenRP.TryText`-API fuer die dokumentierten Makros exportiert.
- Ganze Zahlen fuer Textchance (0-100) und Cooldown (0-3600) strikt validiert,
  einschliesslich gespeicherter Werte.
- Gueltige gespeicherte AUTO-Kanaele bleiben erhalten, statt beim ersten
  Login auf SAY umgestellt zu werden. Bereits frueher migrierte Werte werden
  nicht nachtraeglich umgeschrieben.
- `/drp channel` zeigt ohne Argument den aktuellen Kanal.
- README und TOC-gesteuerte Tests an die Modulstruktur angepasst.
- Legacy-Tests an die tatsaechlich erforderliche `C_ChatInfo`-API angepasst.
- `*...*`-markierte Handlungstexte ohne Sternchen als `/me`-Emotes senden.

### Beibehalten

- Manuelle Ausgabe nur fuer Druiden, sofortiger erster Text und SAY-Standard.
- Eigene Texte vor Volkstexten und allgemeinen Texten; vorhandene Textbestaende.
- Kein oeffentlicher Fallback fuer nicht verfuegbare explizite Gruppenkanaele.
- Textgrenze von 255 Bytes, keine Zeilenumbrueche oder Chat-Markierungen.
- Gemeinsame Modulkonventionen und kanonische Kernfunktionsnamen mit den
  anderen AddOns abgestimmt und dokumentiert.
