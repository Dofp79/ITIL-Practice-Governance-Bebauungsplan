Ziel des Power BI Dashboards
Darstellung der IT-Bebauungsplanung nach dem Prinzip des Service Blueprint, mit Fokus auf:
•	Differenzierung zwischen Kundenerlebnis (Front Desk & Self Service) und Mitarbeitererlebnis (Back Desk)
•	Transparenz über Reifegrad, Nutzung und Priorisierung der ITIL Practices
•	Einbindung aller IT-Disziplinen in die Service-Erstellung, -Änderung und -Erbringung
________________________________________
🧱 Dashboard-Komponenten (konkret & abgestimmt auf deine Daten)
1. ✅ Blueprint-Visualisierung nach Service Blueprint Logik
•	Kategorien aus Spalte Blueprint:
o	Self Service Aktionen → Self Service
o	Front Desk Aktionen → direkte Kundenschnittstellen
o	Back Desk Aktionen → interne Servicebereitstellung
•	Umsetzung als Swimlane oder Layer-Grafik
o	Zeilen: Blueprint-Kategorie
o	Elemente: ITIL Practices mit Symbolen (Farben = Reifegrad, Größe = Prio)
2. 🟡 Ampel-Matrix der ITIL Practices (Matrix.png)
•	Darstellung der ITIL Practices entlang der ITIL V3 Lifecycle-Phasen
•	Farbliche Markierung des Reifegrads (Rot, Gelb, Grün) je Phase
•	Berechnung eines Gesamtwerts pro Practice zur Reifeanalyse
3. 🎛️ Filterfelder (aus Filter.png)
•	Nutzung: Aktiv, Geplant, Ungeplant (aus Spalte Dataport Nutzung)
•	Reifegrad-Ampel: automatisch berechnet aus Reifegrad (1–3 → Rot/Gelb/Grün)
•	Prio: A–D (aus Spalte Prio)
•	Phase: gemäß Einordnung ITIL Lifecycle Phase
4. 📊 Bubble Chart: Optimierungspotenzial
•	X-Achse: Prio (A bis D)
•	Y-Achse: Reifegrad (numerisch übersetzt)
•	Größe der Blase: Anzahl Subprozesse oder Systemschnittstellen
•	Hervorragend zur Identifikation von Quick Wins
5. 📄 Service Experience Table
•	Spalten: ITIL Practice | Blueprint-Kategorie | Reifegrad | Nutzung | Prio | Phase
•	Verlinkung zur Rollenverantwortung über „Pfad“-Spalte
•	Filterbar nach Sichtweise (z. B. nur Front Desk anzeigen)
________________________________________
Integration aktueller ITIL 4 Struktur (optional)
Da du dich noch an ITIL V3 Lifecycle-Phasen orientierst, empfehle ich:
•	Mapping zu ITIL 4 Practice Domains (z. B. „Service Management“, „General Management“)
•	Spalte Zuordnung ITIL 4 Kategorie ist bereits vorhanden und kann genutzt werden
________________________________________
Visualer Lesevorschlag für Stakeholder
•	Managementsicht (Front Desk / Self Service): Fokus auf direkte Customer Touchpoints und deren Reife
•	Operative Sicht (Back Desk): Identifikation von Engpässen, kritischen Bereichen und nicht aktivierten Practices
•	Governance-Sicht: Verbindung zu Rollenverantwortung (z. B. „ITIL Core Team“) und Lenkungskreisen
