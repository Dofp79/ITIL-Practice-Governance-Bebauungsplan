Elementübersicht des Datenmodells
----------------------------------

| Kategorie           | Name                             | Beschreibung                                           | Typ         |
|---------------------|----------------------------------|--------------------------------------------------------|-------------|
| Tabelle             | ITIL_Practice_Catalogue_07052025 | Haupttabelle (SharePoint Export via Python)           | Tabelle     |
| Tabelle             | tbl_ITIL_Bebauungsplan_Map       | Mapping-Tabelle zur Sichtbarkeit & Phase              | Tabelle     |
| Tabelle             | tbl_Phase_Legende                | Farb- und Phasenlegende für Matrix und Visuals        | Tabelle     |
| Tabelle             | tbl_Practice_Kategorie           | ITIL 4 Kategorien (General, Service, Technical)       | Tabelle     |
| Tabelle             | Tabelle_Blueprint_Kategorie      | Aggregierte Blueprint-Kategoriezählung                | Tabelle     |

| Measures & KPIs     |                                  
|---------------------|----------------------------------|---------------------|-------------|
| KPI_Summe_Reifegrade_Pro_Practice | Zählt Reifegrade je Practice             | Measure     |
| KPI_Practices_Je_Kategorie       | Anzahl Practices je ITIL Kategorie        | Measure     |
| KPI_Ø_Reifegrad_Je_Kategorie     | Durchschnitts-Reifegrad je Kategorie      | Measure     |
| KPI_FrontDesk / BackDesk / SelfService | Blueprint-Anteile je Sichtbarkeit    | Measure     |
| KPI_Anzahl_Kritisch              | Kritische Practices (Reifegrad = 0)       | Measure     |
| KPI_Aktive_Hochrelevante         | Aktive, hoch priorisierte Practices       | Measure     |
| KPI_Ungeplant_Kritisch           | Kritisch & ungeplant                      | Measure     |
| KPI_Ø_Reifegrad                  | Gesamtdurchschnitt Reifegrad              | Measure     |
| KPI_Anzahl_Pro_Kategorie_und_Phase | Zählung je Kategorie × Phase           | Measure     |
| KPI_Anzahl_Phase_Zuordnung       | Wie viele Phasen je Practice              | Measure     |
| Filter_Aktuelle_Phase            | Zeigt aktuelle Phasenauswahl              | Measure     |
| Filter_Aktuelle_Blueprint        | Zeigt aktuelle Blueprint-Auswahl          | Measure     |
| Tooltip_Info                     | Dynamischer Tooltip mit Kontextdaten      | Measure     |

Beziehungen
-----------
- ITIL_Practice_Catalogue_07052025[ITIL Practice] → tbl_ITIL_Bebauungsplan_Map[Practice]
- ITIL_Practice_Catalogue_07052025[Phase] → tbl_Phase_Legende[Phase]
- ITIL_Practice_Catalogue_07052025[Zuordnung ITIL 4 Kategorie] → tbl_Practice_Kategorie[Practice_Kategorie]

Anmerkung:
- Datenmodell konsequent nach ITIL 4 Prinzipien gestaltet
- Fokus auf strategische Steuerung, Transparenz und Mehrwert

Erstellt von: Doniman Francisco Peña Parra
Datum: 11.05.2025
Projekt: ITIL Practice Governance & Bebauungsplan
