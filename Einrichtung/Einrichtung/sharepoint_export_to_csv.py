from office365.sharepoint.client_context import ClientContext
from office365.runtime.auth.authentication_context import AuthenticationContext
import pandas as pd

# ===========================================================
# Skriptname:   sharepoint_export_to_csv.py
# Projekt:      ITIL-Bebauungsplan
# Autor:        Doniman Francisco Peña Parra
# Erstellt:     08.05.2025
# Version:      1.0
# Umgebung:     Python 3.7.3 (VPN-Rechner), Power BI Desktop
#
# Zweck:
#   Dieses Skript verbindet sich mit einer SharePoint-Online-Site,
#   ruft eine definierte Liste (z. B. Projektphasen-Tage) ab und
#   speichert die Daten als CSV-Datei auf dem lokalen Dateisystem.
#
# Beschreibung:
#   - Verwendung der Bibliothek: Office365-REST-Python-Client
#   - Authentifizierung via Benutzername + Passwort (einfach, aber ersetzbar)
#   - Ausgabeziel: Lokale Datei für Power BI (CSV)
#
# Anwendungsfall:
#   - Automatisierte Datenversorgung von Power BI Dashboards
#   - Alternative zur App Factory oder SQL-basierten Exports
#   - Ermöglicht Aktualisierungen durch Windows Task Scheduler
#
# Voraussetzungen:
#   - Python 3.7.3
#   - Bibliotheken: pandas, office365-rest-python-client
#   - Datei-Speicherrechte im Zielpfad (z. B. C:\Daten\)
#
# ITIL-Leitprinzipien:
#   - Fokussiere dich auf den Wert
#   - Arbeite iterativ mit Feedback
#   - Halte es einfach und praktisch
#
# ===========================================================

# Konfiguration
url = "https://deinefirma.sharepoint.com/sites/DEIN_SITE"
liste = "Projektphasen"
username = "dein.benutzer@firma.com"
password = "deinPasswort"  # besser via getpass.getpass()

# Verbindung aufbauen
ctx_auth = AuthenticationContext(url)
if ctx_auth.acquire_token_for_user(username, password):
    ctx = ClientContext(url, ctx_auth)
    sp_list = ctx.web.lists.get_by_title(liste)
    items = sp_list.items.top(500).get().execute_query()

    # Daten extrahieren
    daten = [item.properties for item in items]
    df = pd.DataFrame(daten)
    df.to_csv("C:/Daten/sharepoint_liste.csv", index=False)
else:
    print("Login fehlgeschlagen.")
