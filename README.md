Darstellung der IT-Bebauungsplanung nach Service Blueprint im Power BI

Visualisierung der IT-Service-Bebauungsplanung gemäß Service Blueprint zur Differenzierung von Kundenerlebnis und interner Servicebereitstellung

📌 User Story:

Als Referatsleiter des ITIL - Management Abteilung 
möchte ich eine Power BI-Darstellung der ITIL-basierten IT-Bebauungsplanung nach dem Prinzip des Service Blueprints erhalten
sodass sichtbar wird, welche Prozesse und ITIL Practices direkt zur Kundenerfahrung beitragen (Front Desk / Self Service) und welche im Hintergrund als Mitarbeitererfahrung (Backoffice) zur Serviceerstellung, -änderung und -bereitstellung notwendig sind.

🎯 Ziel des Dashboards

Visualisierung der IT-Bebauungsplanung entlang der Customer Journey nach dem Service Blueprint-Modell, um:

die sichtbaren (Frontstage) und unsichtbaren (Backstage) Prozesse im Service Lifecycle darzustellen,

ITIL Practices ihrer Wirkung auf das Kundenerlebnis oder die interne Wertschöpfung zuzuordnen,

Abhängigkeiten zwischen IT-Systemen, Prozessen und Touchpoints zu erkennen.

🧩 Dashboard-Struktur (Power BI)

1. Service Blueprint Layer View (Hauptvisual)
Ein interaktives visuelles Layer-Modell mit folgenden Ebenen:

Customer Actions (oben): Z. B. "Störung melden", "Self-Service-Anfrage"

Frontstage (sichtbare IT-Services): Touchpoints wie Service Desk, Portale, Mobile App

Backstage (unsichtbare IT-Praktiken): z. B. Incident Management, Problem Management, Change Enablement

Supporting Processes & Systems: z. B. CMDB, Monitoring-Systeme, Automatisierungsplattformen

▶ Umsetzung: Matrix mit Shape Map / Custom Visual „Swimlane“ oder gestapelten Balken

2. ITIL Practices Mapping
Tabelle oder Matrix mit Filteroption:

Spalten: Practice Name, ITIL 4 Domain, Prozessverantwortlicher, Tool-Integration, Frontstage/Backstage-Zuordnung

Zeilen: Services, betroffene Systeme

▶ Umsetzung: Matrixvisual oder verknüpfte Karte

3. Kundenerlebnis vs. Mitarbeitererlebnis
Balkendiagramm: Anzahl der Prozesse, die direkt zur Customer Experience beitragen vs. indirekte, unterstützende Prozesse.

▶ Umsetzung: gestapelte Balken nach „Sichtbarkeit“

4. Heatmap: Prozessreife vs. Service-Impact
Ein Koordinatensystem, das zeigt:

X-Achse: Service Impact

Y-Achse: Reifegrad der ITIL-Practice

Größe: Anzahl betroffener Services

▶ Umsetzung: Streudiagramm oder Bubble Chart

🛠 Datenquellen & Modellierungsvorschläge
Excel/SharePoint-Listen mit Zuordnung: [ITIL Practice] – [Service] – [System] – [Verantwortung] – [Touchpoint]

CMDB-Export (CSV/SQL)

Servicemanagement-Tool-Daten (z. B. TOPdesk, ServiceNow, Jira Service Management)

📌 Empfehlungen gemäß ITIL 4
Fokus auf Wert (Leitprinzip 1): Darstellung, welche Practices und Systeme echten Wert für den Kunden erzeugen

Dort beginnen, wo du stehst (Leitprinzip 2): Aktuelle Prozess- und Systemlandschaft erfassen

Iterativ und mit Feedback arbeiten (Leitprinzip 3): Erste Version für 1–2 kritische Services, dann ausbauen


