-- ===========================================
-- Power BI Datenmodell: ITIL Practice Governance & Bebauungsplan (mit Python/SharePoint-Anbindung)
-- ===========================================

-- 1. Tabelle: ITIL_Practice_Catalogue_07052025
-- Quelle: SharePoint-Export via Python (z. B. mit pandas + Office365 REST API)
-- Enthält zentrale Informationen zu Reifegrad, Nutzung, Phase, Blueprint, Prio etc.

-- Berechnete Spalte: Ampel-Reifegrad (farbliche Codierung)
Ampel_Reifegrad = 
SWITCH(TRUE(),
    LEFT([Reifegrad],1) = "0", "Kritisch",
    LEFT([Reifegrad],1) = "1", "Mittel",
    LEFT([Reifegrad],1) >= "2", "Gut",
    BLANK()
)
//
// Dokumentation
// Berechnete Spalte: Ampel-Reifegrad (farbliche Codierung)
// Tabelle:    ITIL_Practice_Catalogue_07052025
// Projekt:    ITIL Practice Governance & Bebauungsplan (mit Python/SharePoint-Anbindung)
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Berechnung der Reifegrad-Kategorie zur vereinfachten Farbcodierung und Filterung
// Beschreibung:
//   - Übersetzt numerischen Reifegrad (0–2) in verbale Ampel-Werte
//   - Unterstützt bedingte Formatierung in Matrix-Visuals und KPI-Berichten
//   - Fördert visuelles Management und schnelle Erkennung kritischer Practices
// Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Halte es einfach und praktisch
//   - Arbeite iterativ mit Feedback
//

-- 2. Tabelle: tbl_ITIL_Bebauungsplan_Map
-- Zweck: Mapping von ITIL Practices zu den Sichtbarkeitsstufen im Service Blueprint
-- Quelle: Abgeleitet aus 'Blueprint' Spalte in ITIL_Practice_Catalogue_07052025
-- Spaltenbeschreibung:
--   - Practice: Name der ITIL Practice
--   - Bereich: Grobe Kategorisierung (Self Service, Front Desk, Back Desk)
--   - Phase: ITIL Lifecycle Phase oder Zuordnungsphase
--   - Stufe: Darstellungsreihenfolge für Visualisierung
--   - Blueprint_Kategorie: Aggregierte Darstellung im Blueprint-Visual (z. B. Frontstage vs. Backstage)
-- Beschreibung:
--   - Diese Tabelle erlaubt es, ITIL Practices entlang der Customer Journey zu visualisieren
--   - Unterstützt Layer-basierte Visuals und Slicer-Funktionalität nach Sichtbarkeit
--   - Dient als Bindeglied zwischen operativen Praktiken und Experience-Ebenen
-- Erstellt durch DAX-Tabelle aus der Haupttabelle: siehe Abschnitt „DAX-Code zur Generierung“
-- Beispielwerte:

-- DAX-Code zur Generierung der Tabelle tbl_ITIL_Bebauungsplan_Map:
tbl_ITIL_Bebauungsplan_Map =
SELECTCOLUMNS(
    ITIL_Practice_Catalogue_07052025,
    "Practice", [ITIL Practice],
    "Bereich",
        SWITCH(
            TRUE(),
            SEARCH("Self Service", [Blueprint], 1, 0) > 0, "Self Service",
            SEARCH("Front Desk", [Blueprint], 1, 0) > 0, "Front Desk",
            SEARCH("Back Desk", [Blueprint], 1, 0) > 0, "Back Desk",
            "Nicht zugeordnet"
        ),
    "Phase", [Einordnung ITIL Lifecycle Phase],
    "Stufe", [Reihenfolge],
    "Blueprint_Kategorie",
        SWITCH(
            TRUE(),
            SEARCH("Self Service", [Blueprint], 1, 0) > 0, "Self Service",
            SEARCH("Front Desk", [Blueprint], 1, 0) > 0, "Frontstage",
            SEARCH("Back Desk", [Blueprint], 1, 0) > 0, "Backstage",
            "Nicht zugeordnet"
        )
)

-- | Incident Management | Back Desk | Operation | 2 | Backstage |
-- | Service Desk        | Front Desk| Operation | 1 | Frontstage |
-- Spalten: Practice | Bereich | Phase | Stufe | Blueprint_Kategorie

-- 3. Tabelle: tbl_Phase_Legende
-- Zweck: Einheitliche Darstellung und strukturierte Gruppierung von Lifecycle-Phasen
-- Spaltenbeschreibung:
--   - Phase: Name der ITIL V3 Lifecycle-Phase (z. B. Service Operation, Service Design)
--   - Farbe: Visuelle Zuweisung für Darstellung in Charts, Matrix oder Synoptic Visual
-- Beispielwerte:
--   | Phase                 | Farbe   |
--   |----------------------|---------|
--   | Service Strategy     | Blau    |
--   | Service Design       | Orange  |
--   | Service Transition   | Gelb    |
--   | Service Operation    | Grün    |
--   | Continual Improvement| Grau    |
-- Hinweise:
--   - Die Tabelle wird mit tbl_ITIL_Practice_Catalogue_07052025[Phase] verknüpft
--   - Dient zur farblichen Kodierung von Matrixen oder zur Steuerung von Reports
--   - Erweiterbar für ITIL 4 Domains, falls gewünscht

-- DAX-Code zur Erstellung der Tabelle tbl_Phase_Legende:
tbl_Phase_Legende =
DATATABLE(
    "Phase", STRING,
    "Farbe", STRING,
    {
        {"Service Strategy", "Blau"},
        {"Service Design", "Orange"},
        {"Service Transition", "Gelb"},
        {"Service Operation", "Grün"},
        {"Continual Improvement", "Grau"}
    }
)

-- 4. Tabelle: tbl_Practice_Kategorie (optional für ITIL 4)
-- Zweck: Kategorisierung von Practices nach ITIL 4 Practice Domains
-- Spaltenbeschreibung:
--   - Practice_Kategorie: Oberkategorie nach ITIL 4 (z. B. Service Management)
--   - Beschreibung: Erläuterung oder Zuordnungstext zur Einordnung
-- Beispielwerte:
--   | Practice_Kategorie     | Beschreibung                          |
--   |------------------------|---------------------------------------|
--   | General Management     | Unterstützende Führungsprozesse       |
--   | Service Management     | Wertstrom- und Servicebereitstellung  |
--   | Technical Management   | Technisch-operative Funktionen        |
-- Hinweise:
--   - Dient der Filterung und Gruppierung in Analysen nach strukturellen Ebenen
--   - Unterstützt strategische Auswertungen zur Practice-Vollständigkeit

-- DAX-Code zur Erstellung der Tabelle tbl_Practice_Kategorie:
tbl_Practice_Kategorie =
DATATABLE(
    "Practice_Kategorie", STRING,
    "Beschreibung", STRING,
    {
        {"General Management", "Unterstützende Führungsprozesse"},
        {"Service Management", "Wertstrom- und Servicebereitstellung"},
        {"Technical Management", "Technisch-operative Funktionen"}
    }
)


Tabelle_Blueprint_Kategorie = 
SUMMARIZE(
    tbl_ITIL_Bebauungsplan_Map,
    tbl_ITIL_Bebauungsplan_Map[Blueprint_Kategorie],
    "Anzahl", COUNTROWS(tbl_ITIL_Bebauungsplan_Map)
)

// Dokumentation
// Tabelle:    Tabelle_Blueprint_Kategorie
// Quelle:     tbl_ITIL_Bebauungsplan_Map
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Bereitstellung einer Tabelle zur Anzahl Practices je Blueprint-Kategorie
// Beschreibung:
//   - Ideal für Matrix-Visuals oder Gruppierungsanalysen
//   - Nutzt die aggregierte Kategorie: Frontstage, Backstage, Self Service
//   - Es ist bewusst und modelltechnisch sauber, diese aggregierte Tabelle ohne Beziehung zu verwenden.
// Prinzipien:
//   - Denk und arbeite ganzheitlich
//   - Fördere Transparenz

-- 5. Beziehungen:
-- ITIL_Practice_Catalogue_07052025[ITIL Practice] 1:* tbl_ITIL_Bebauungsplan_Map[Practice]
-- ITIL_Practice_Catalogue_07052025[Phase]         *:* tbl_Phase_Legende[Phase]
-- ITIL_Practice_Catalogue_07052025[Kategorie]     *:* tbl_Practice_Kategorie[Practice_Kategorie]

-- 6. Measures / KPIs:

-- KPI: Anzahl Practices pro ITIL 4 Kategorie
KPI_Practices_Je_Kategorie = 
CALCULATE(
    COUNTROWS(ITIL_Practice_Catalogue_07052025),
    ITIL_Practice_Catalogue_07052025[Zuordnung ITIL 4 Kategorie] = "Service Management"
)
//
// Dokumentation
// Measure:    KPI_Practices_Je_Kategorie
// Tabelle:    ITIL_Practice_Catalogue_07052025
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Zählt alle Practices, die der Kategorie "Service Management" zugeordnet sind
// Beschreibung:
//   - Nutzt die Spalte "Zuordnung ITIL 4 Kategorie" aus dem Practice-Katalog
//   - Kann über zusätzliche FILTER- oder SWITCH-Funktionen auf andere Kategorien erweitert werden
// Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Halte es einfach und praktisch
// Measure:    KPI_Practices_Je_Kategorie
// Tabelle:    ITIL_Practice_Catalogue_07052025
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Zeigt die Anzahl der Practices je ITIL 4 Kategorie
// Beschreibung:
//   - Dient zur Gruppierung und Analyse nach strukturellen Kategorien
//   - Ideal für Matrix-Visuals oder Balkendiagramme nach Kategorien
// Prinzipien:
//   - Denk und arbeite ganzheitlich
//   - Halte es einfach und praktisch
//

-- KPI: Ø Reifegrad pro Practice-Kategorie
KPI_Ø_Reifegrad_Je_Kategorie = 
AVERAGEX(
    FILTER(
        ITIL_Practice_Catalogue_07052025,
        ITIL_Practice_Catalogue_07052025[Zuordnung ITIL 4 Kategorie] = "Service Management"
    ),
    VALUE(LEFT(ITIL_Practice_Catalogue_07052025[Reifegrad],1))
)
//
// Dokumentation
// Measure:    KPI_Ø_Reifegrad_Je_Kategorie
// Tabelle:    ITIL_Practice_Catalogue_07052025
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Durchschnittlicher Reifegrad der Practices mit ITIL 4 Kategorie "Service Management"
// Beschreibung:
//   - Verwendet den ersten Buchstaben des Reifegrads zur Berechnung
//   - Ideal zur Bewertung der strukturellen Reife je Kategorie
// Prinzipien:
//   - Optimiere und automatisiere
//   - Arbeite iterativ mit Feedback
// Measure:    KPI_Ø_Reifegrad_Je_Kategorie
// Tabelle:    ITIL_Practice_Catalogue_07052025
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Durchschnittlicher Reifegrad je ITIL 4 Kategorie
// Beschreibung:
//   - Berechnet den Mittelwert des Reifegrads für jede Practice-Kategorie
//   - Unterstützt strategisches Reifegradmonitoring nach Managementebene
// Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Optimiere und automatisiere
//

-- Blueprint-Kategorie-Zähler (z. B. für Filter oder Visual-Abgrenzung)
Tabelle_Blueprint_Kategorie =
SUMMARIZE(
    tbl_ITIL_Bebauungsplan_Map,
    tbl_ITIL_Bebauungsplan_Map[Blueprint_Kategorie],
    "Anzahl", COUNTROWS(tbl_ITIL_Bebauungsplan_Map)
)
//
// Dokumentation
// Tabelle:    Tabelle_Blueprint_Kategorie
// Quelle:     tbl_ITIL_Bebauungsplan_Map
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Bereitstellung einer Tabelle zur Anzahl Practices je Blueprint-Kategorie
// Beschreibung:
//   - Ideal für Matrix-Visuals oder Gruppierungsanalysen
//   - Nutzt die aggregierte Kategorie: Frontstage, Backstage, Self Service
// Prinzipien:
//   - Denk und arbeite ganzheitlich
//   - Fördere Transparenz
//

-- Anzahl Practices je Blueprint-Ebene
KPI_FrontDesk = 
CALCULATE(
    COUNTROWS(tbl_ITIL_Bebauungsplan_Map)
)

// Dokumentation
// Measure:    KPI_FrontDesk
// Tabelle:    tbl_ITIL_Bebauungsplan_Map
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Zählt alle Practices mit Sichtbarkeit "Frontstage" (direkte Kundenschnittstelle)
// Beschreibung:
//   - Nutzt die Spalte "Blueprint_Kategorie"
//   - Unterstützt KPI-Karten oder Visuals zur Frontdesk-Experience
// Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Fördere Transparenz

KPI_BackDesk = 
CALCULATE(
    COUNTROWS(tbl_ITIL_Bebauungsplan_Map)
)
//
// Dokumentation
// Measure:    KPI_BackDesk
// Tabelle:    tbl_ITIL_Bebauungsplan_Map
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Zählt alle Practices mit Sichtbarkeit "Backstage" (Mitarbeitererfahrung)
// Beschreibung:
//   - Unterstützt Analyse interner Prozesslandschaft
//   - Geeignet zur Darstellung von Hintergrundprozessen
// Prinzipien:
//   - Denk und arbeite ganzheitlich
//   - Fördere Transparenz
//

KPI_SelfService = 
CALCULATE(
    COUNTROWS(tbl_ITIL_Bebauungsplan_Map)
)
//
// Dokumentation
// Measure:    KPI_SelfService
// Tabelle:    tbl_ITIL_Bebauungsplan_Map
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Zählt alle Practices mit Sichtbarkeit "Self Service"
// Beschreibung:
//   - Bezieht sich auf Prozesse, die Nutzende selbstständig auslösen oder abwickeln können
//   - Fördert digitale Serviceerfahrungen und Automatisierung
// Prinzipien:
//   - Optimiere und automatisiere
//   - Halte es einfach und praktisch
//

KPI_Anzahl_Kritisch = 
CALCULATE(
    COUNTROWS(ITIL_Practice_Catalogue_07052025), 
    LEFT(ITIL_Practice_Catalogue_07052025[Reifegrad],1) = "0"
)
//
// Dokumentation
// Measure:    KPI_Anzahl_Kritisch
// Tabelle:    ITIL_Practice_Catalogue_07052025
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Zählt alle Practices mit dem Reifegrad-Stadium "0" = Kritisch
// Beschreibung:
//   - Nutzt die berechnete Ableitung des Reifegrads aus der ersten Zeichenposition
//   - Unterstützt Ampelanalysen, Heatmaps und kritische KPI-Warnungen
// Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Halte es einfach und praktisch
//

KPI_Ø_Reifegrad = 
AVERAGEX(
    ITIL_Practice_Catalogue_07052025,
    VALUE(LEFT(ITIL_Practice_Catalogue_07052025[Reifegrad],1))
)
//
// Dokumentation
// Measure:    KPI_Ø_Reifegrad
// Tabelle:    ITIL_Practice_Catalogue_07052025
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Durchschnittlicher Reifegrad aller Practices (basierend auf erster Ziffer)
// Beschreibung:
//   - Nutzt die erste Stelle der Reifegrad-Spalte zur Berechnung eines Durchschnittswerts
//   - Ideal zur übergreifenden Bewertung der Gesamtreife der Service Practices
// Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Optimiere und automatisiere)
//

KPI_Aktive_Hochrelevante = 
CALCULATE(
    COUNTROWS(ITIL_Practice_Catalogue_07052025),
    FILTER(
        ITIL_Practice_Catalogue_07052025,
        ITIL_Practice_Catalogue_07052025[Nutzung] = "aktiv"
        && ITIL_Practice_Catalogue_07052025[Prio] IN { "A", "B" }
    )
)
//
// Dokumentation
// Measure:    KPI_Aktive_Hochrelevante
// Tabelle:    ITIL_Practice_Catalogue_07052025
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Zählt alle Practices, die aktiv genutzt und hoch priorisiert sind (Prio A oder B)
// Beschreibung:
//   - Kombination aus Nutzungsstatus = "aktiv" und Prio-Stufe A oder B
//   - Unterstützt Steuerung und gezielte Investitionslenkung
// Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Optimiere und automatisiere
//

KPI_Backdesk_Anteil = 
DIVIDE(
    CALCULATE(
        COUNTROWS(tbl_ITIL_Bebauungsplan_Map)
)
//
// Dokumentation
// Measure:    KPI_Backdesk_Anteil
// Tabelle:    tbl_ITIL_Bebauungsplan_Map
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Ermittelt den prozentualen Anteil der Practices im Bereich "Back Desk"
// Beschreibung:
//   - Nutzt den Bereichsfilter "Back Desk" und berechnet den relativen Anteil an allen Practices
//   - Unterstützt Analyse zur internen Ausrichtung und Verteilung zwischen Front-/Back-End
// Prinzipien:
//   - Denk und arbeite ganzheitlich
//   - Fördere Transparenz
//

KPI_Ungeplant_Kritisch = 
CALCULATE(
    COUNTROWS(ITIL_Practice_Catalogue_07052025)
)
//
// Dokumentation
// Measure:    KPI_Ungeplant_Kritisch
// Tabelle:    ITIL_Practice_Catalogue_07052025
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   10.05.2025
// Zweck:      Zählt alle ungeplanten Practices mit Reifegrad 0 (kritisch)
// Beschreibung:
//   - Unterstützt das gezielte Aufdecken von riskanten oder unbeaufsichtigten ITIL Practices
//   - Kombiniert den Nutzungsstatus "ungeplant" mit Reifegrad "0" zur Risikobewertung
// Prinzipien:
//   - Beginne dort, wo du stehst
//   - Fördere Transparenz
//   - Optimiere und automatisiere
//

-- 7. Visuals:
-- Matrix: ITIL Practice × Phase (Ampel-Farbcodierung)
-- KPI-Karten: KPI_Anzahl_Kritisch, KPI_Ø_Reifegrad, KPI_Aktive_Hochrelevante
-- Filter: Nutzung, Prio, Phase, Blueprint_Kategorie, Practice_Kategorie
-- Synoptic Panel: Blueprint-Darstellung (Frontstage vs. Backstage)

-- 8. Power Query Beispiel: Automatischer Zugriff auf aktuelle Datei via SharePoint
let
    Quelle = SharePoint.Files("https://<deinTenant>.sharepoint.com/sites/<DeinSite>", [ApiVersion = 15]),
    Gefiltert = Table.SelectRows(Quelle, each Text.StartsWith([Name], "Liste_Aktuell")),
    Sortiert = Table.Sort(Gefiltert, {{"Date modified", Order.Descending}}),
    ErsteDatei = Table.FirstN(Sortiert,1),
    Inhalt = Table.AddColumn(ErsteDatei, "Custom", each Excel.Workbook([Content])),
    Expandiert = Table.ExpandTableColumn(Inhalt, "Custom", {"Data"}, {"Data"})
in
    Expandiert

// Dokumentation
// Measure:    AktivePhasen_Heute
// Tabelle:    ITIL_Practice_Catalogue_07052025
// Projekt:    ITIL Practice Governance & Bebauungsplan
// Autor:      Doniman Francisco Peña Parra
// Erstellt:   08.05.2025
// Zweck:      Ermittelt die Anzahl der aktiven Projektphasen am heutigen Kalendertag
// Beschreibung:
//   - Zählt, wie viele Zeilen in der Tages-Roadmap dem aktuellen Datum entsprechen
//   - Grundlage: Jede Zeile in 'Roadmap_Tage' repräsentiert einen aktiven Phasentag
//   - Unterstützt Daily Standups, Tages-KPIs und Sprintsteuerung
//   - Einsatz z. B. auf KPI-Karten oder als Indikator für Auslastung
// Prinzipien:
//   - Fokussiere dich auf den Wert
//   - Halte es einfach und praktisch
