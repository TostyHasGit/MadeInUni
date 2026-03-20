@echo off
setlocal

set JAVA_FILE=ImageDownloader.java
set CLASS_NAME=ImageDownloader
set JAR_FILE=postgresql-42.7.3.jar

echo [INFO] Kompiliere %JAVA_FILE% ...
javac -cp ".;%JAR_FILE%" %JAVA_FILE%
if errorlevel 1 (
    echo [FEHLER] Kompilierung fehlgeschlagen.
    pause
    exit /b 1
)

echo [INFO] Starte %CLASS_NAME% ...
java -cp ".;%JAR_FILE%" %CLASS_NAME%

endlocal
pause