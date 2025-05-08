🧭 Argumentationsrahmen nach ITIL 4 Leitprinzipien

1️⃣ Fokussiere dich auf den Wert

Wertschöpfung durch aktuelle, automatisiert verfügbare Daten:
Dashboards in Power BI sind nur dann nützlich, wenn sie auf konsistenten und aktuellen Daten basieren. Die manuelle Datenpflege verursacht vermeidbaren Aufwand, erhöht das Fehlerpotenzial und behindert operative Entscheidungen – z. B. in Standups, Reviews oder Serviceauswertungen.

2️⃣ Beginne dort, wo du stehst

Ausbau vorhandener Systeme:
Ich nutze Power BI Desktop auf einem VPN-Rechner sowie SharePoint Online als führendes System für operative Datenerfassung. Auf dieser Basis lässt sich ein automatisierter Exportprozess etablieren – ohne Systemwechsel, ohne neue Infrastruktur.

3️⃣ Arbeite iterativ mit Feedback

Schrittweise Automatisierung statt Komplettlösung:
Beginnend mit einem lokalen Python-Skript (z. B. täglicher CSV-Export) lässt sich der Automatisierungsgrad bedarfsorientiert steigern – z. B. um OAuth-Authentifizierung oder differenzierte Filter. Jeder Schritt kann getestet, dokumentiert und gemeinsam bewertet werden.

4️⃣ Kollaboriere und fördere Transparenz

Transparente Datenversorgung schafft Vertrauen:
Automatisierte, reproduzierbare Prozesse sind nicht nur effizient – sie machen Datenquellen, Berechnungsregeln und Visualisierungen für alle nachvollziehbar. Ich dokumentiere jeden Codebestandteil gemäß DAX- und Python-Kommentarstandard, inkl. Versionshistorie.

5️⃣ Denk und arbeite ganzheitlich

Datenanalyse ist kein Einzelthema:
Sie betrifft Roadmap-Management, Incident Reporting, Servicekennzahlen und Veränderungsmanagement zugleich. Mein Ziel ist es, Datenquellen wie SharePoint, Excel oder manuelle Inputs in ein integriertes Modell für Managemententscheidungen zu überführen.

6️⃣ Halte es einfach und praktisch

Kein Power BI Service nötig – keine neue Plattform:
Die Lösung basiert vollständig auf lokal installierbarer Software (Python 3.7, Power BI Desktop). Notwendig ist lediglich die Erlaubnis, vertrauenswürdige Bibliotheken zu installieren, um das automatisierte Datenlesen zu ermöglichen.

7️⃣ Optimiere und automatisiere

Jede Stunde manueller Arbeit weniger zählt:
Die Zeit, die heute in das Öffnen, Exportieren und Umwandeln von Listen gesteckt wird, kann durch ein kurzes Skript ersetzt werden. Diese Zeit fließt dann in Analyse, Interpretation und Entscheidungsunterstützung – der eigentliche Mehrwert der Datenanalyse.

🧩 Python-gestützte Automatisierung zur Datenintegration in Power BI (SharePoint)

🎯 Ziel: Automatisierter, robuster Export von SharePoint-Listen in .csv-Dateien zur Verwendung in Power BI Desktop – ohne Power BI Service oder SQL Server.

✅ Kernidee (für Vorgesetzte):
„Mit einer leichtgewichtigen Python-Lösung lassen sich SharePoint-Daten automatisiert bereitstellen – lokal, sicher, nachvollziehbar. Ich brauche dafür keine Cloud-Dienste oder Systemzugriffe, sondern nur die Möglichkeit, exakt definierte Bibliotheken lokal installieren und nutzen zu dürfen.“

🛠 Notwendige Python-Bibliotheken für den Prozess

| Bibliothek                     | Version     | Funktion / Begründung                                                 |
| ------------------------------ | ----------- | --------------------------------------------------------------------- |
| `pandas`                       | 1.3.5       | Datenanalyse, Transformation, CSV-Export für Power BI                 |
| `Office365-REST-Python-Client` | 2.6.1       | REST-API-Zugriff auf SharePoint Online-Listen                         |
| `numpy`                        | 1.21.6      | Mathematische Basisfunktionen für `pandas`                            |
| `python_dateutil`              | 2.9.0.post0 | Datumsverarbeitung, benötigt von `pandas`                             |
| `pytz`                         | 2025.2      | Zeitzonenunterstützung                                                |
| `requests`                     | 2.31.0      | HTTP-Client-Bibliothek, Basis für REST-Calls                          |
| `urllib3`                      | 2.0.7       | Netzwerkverbindungen, TLS/SSL, wird von `requests` benötigt           |
| `idna`                         | 3.10        | Domain-Name-Encoding für URLs                                         |
| `certifi`                      | 2025.4.26   | Zertifikatsspeicher für HTTPS                                         |
| `charset_normalizer`           | 2.1.1       | Zeichensatzinterpretation bei API-Antworten (von `requests` benötigt) |
| `msal`                         | 1.32.3      | Microsoft Authentication Library (OAuth für M365)                     |
| `PyJWT`                        | 2.8.0       | Token-Verarbeitung (für `msal`)                                       |
| `cffi`                         | 1.15.1      | Low-Level Schnittstelle für `cryptography`                            |
| `cryptography`                 | 44.0.3      | Verschlüsselung und Zertifikatsverarbeitung                           |
| `pycparser`                    | 2.21        | C-Parser für `cffi`                                                   |
| `typing_extensions`            | 4.7.1       | Erweiterungen für Type Hints (benötigt von mehreren Paketen)          |
| `six`                          | 1.17.0      | Kompatibilitätslayer für Python 2/3 (für `python_dateutil` benötigt)  |

📦 Zusammenfassung: Die wichtigsten Bibliotheken (und warum sie in deiner Argumentation relevant sind)
| Bibliothek                                   | Kategorie               | Warum wichtig für dich (Argument im Gespräch)                       |
| -------------------------------------------- | ----------------------- | ------------------------------------------------------------------- |
| `pandas`                                     | Datenanalyse            | Für Transformation, Filterung, CSV-Export – Herzstück für Power BI  |
| `Office365-REST-Python-Client`               | SharePoint-Connector    | Ermöglicht Zugriff auf SharePoint-Listen via REST API               |
| `requests`                                   | Netzwerkanfragen        | Wird vom SharePoint-Client intern genutzt                           |
| `msal`                                       | Authentifizierung       | Microsoft Login-Support (Basic / OAuth)                             |
| `numpy`                                      | Datenbasis für `pandas` | notwendig für Zeitachsen, Tabellenoperationen                       |
| `python_dateutil`, `pytz`                    | Datum/Zeit              | Für korrekte Berechnung von Tages- und Monatswerten                 |
| `certifi`, `urllib3`, `idna`                 | HTTPS-Infrastruktur     | Erlaubt sichere Verbindungen mit SharePoint                         |
| `charset_normalizer`                         | Encoding                | Für korrektes Einlesen von Nicht-ASCII-Zeichen aus SharePoint-Daten |
| `PyJWT`, `cryptography`, `cffi`, `pycparser` | Auth-Sicherheit         | Für Tokenvalidierung und Verschlüsselung bei Login                  |
| `typing_extensions`, `six`                   | Standardisierung        | Helfen Python 3.7 moderne Features und Kompatibilität zu bieten     |


📌 Technischer Ablauf (automatisiert):

 - Python-Skript ruft SharePoint-Liste via REST ab

 - Authentifizierung per Benutzername / Passwort oder Token

 - Daten werden lokal als .csv gespeichert

 - Power BI Desktop lädt diese Datei beim Öffnen automatisch ein

🧠 ITIL 4-Verankerung

 - Fokussiere dich auf den Wert: Tagesaktuelle Dashboards für Entscheidungsträger

 - Halte es einfach und praktisch: Kein Power BI Service, keine Cloud – nur lokale Tools

 - Optimiere und automatisiere: Weg von manuellen Excel-Exports

 - Arbeite iterativ: Zuerst SharePoint → CSV, später ggf. Auth per OAuth oder AD App
