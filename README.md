# Druiden RP

Eigenstaendiges WoW-RP-Chat-Addon, abgeleitet vom Aufbau und Verhalten von
PaladinRP (Hannes, MIT). PaladinRP wird weder veraendert noch als Abhaengigkeit
benoetigt. Die Texte sind neu fuer Druiden geschrieben.

## Installation

Den Ordner `DruidenRP` aus dem ZIP in diesen Ordner entpacken:

```text
E:\Program Files (x86)\World of Warcraft\_classic_beta_\Interface\AddOns
```

Danach muss `AddOns\DruidenRP\DruidenRP.toc` vorhanden sein, ohne einen
zusaetzlichen verschachtelten Projektordner. WoW neu starten, das Addon in der
Charakterauswahl aktivieren und mit einem Druiden einloggen.

Die Interface-Version `16001` wurde aus PaladinRP uebernommen; sie ist keine
Zusage zur Kompatibilitaet mit jedem Beta-Build. Im Spiel zeigt
`/dump select(4, GetBuildInfo())` die benoetigte Interface-Version.
Bei einer Versionswarnung diese mit der TOC vergleichen. Ein echter Test im
WoW-Client steht noch aus; Lua-Tests simulieren nur die benoetigten WoW-APIs.

## Bedienung

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
Alle Einstellungen und eigene Texte werden pro Charakter gespeichert.

Die Ausgabe erfolgt standardmaessig in SAY, auch wenn der Charakter in einer
Gruppe oder einem Schlachtzug ist. Der Kanal kann jederzeit per
`/drp channel <kanal>` gesetzt werden: SAY, YELL, EMOTE, PARTY, RAID,
INSTANCE_CHAT oder AUTO. PARTY, RAID und INSTANCE_CHAT sind damit gezielt
waehlbar. AUTO waehlt Instanzgruppe, Schlachtzug, Gruppe oder SAY, in dieser
Reihenfolge. Ein nicht verfuegbarer Gruppenkanal wird gemeldet, nicht auf
einen oeffentlichen Kanal umgeleitet. SAY/YELL verwenden die bekannte
Volkssprache, wenn verfuegbar.
Ein bisher gespeicherter AUTO-Standard wird beim ersten Login auf SAY
umgestellt; AUTO kann anschliessend weiterhin explizit gesetzt werden.
Nur Druiden koennen RP-Texte senden; andere Klassen koennen Einstellungen
anzeigen und aendern.

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

## Eigene Texte und Projektstruktur

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

- [DruidenRP.lua](./DruidenRP.lua): Datenbank, Textauswahl, Chat und Befehle.
- [config/Settings.lua](./config/Settings.lua): Standardwerte.
- [data/Texts.lua](./data/Texts.lua): 20 allgemeine Textkategorien.
- [data/Racial.lua](./data/Racial.lua): Nachtelfen- und Taurentexte.
- [tests/test_addon.lua](./tests/test_addon.lua): eigenstaendiger Lua-Test
  mit simulierten WoW-APIs; vom Projektordner mit `lua tests\test_addon.lua`.

Eigener Namensraum, `/drp` und `DruidenRP_CharacterDB` vermeiden Konflikte
mit PaladinRP. Keine externe Bibliothek, kein automatischer Chat-Spam und
keine unfertige Einstellungsoberflaeche. Konfiguration erfolgt per Chatbefehl.
