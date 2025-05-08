@echo off
echo [INFO] Starte Offline-Installation mit pip...

REM Pfad zur portablen Python-Umgebung
set PYTHON=C:\Users\Anwender-Admin\Desktop\python-3.10.0-embed-amd64\python.exe

REM Verzeichnis mit den .whl-Dateien und requirements.txt
set PKGDIR=C:\python-pakete

REM Anforderungen prüfen
if not exist "%PYTHON%" (
    echo [ERROR] Python wurde nicht gefunden: %PYTHON%
    pause
    exit /b
)

if not exist "%PKGDIR%\requirements.txt" (
    echo [ERROR] requirements.txt fehlt im Verzeichnis: %PKGDIR%
    pause
    exit /b
)

echo [INFO] Verwende Python: %PYTHON%
echo [INFO] Installiere Pakete aus: %PKGDIR%
echo.

"%PYTHON%" -m pip install --no-index --find-links=%PKGDIR% -r %PKGDIR%\requirements.txt

echo.
echo [INFO] Installation abgeschlossen.
pause
