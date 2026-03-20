#!/bin/bash
JAVA_FILE="ImageDownloader.java"
CLASS_NAME="ImageDownloader"
JAR_FILE="postgresql-42.7.3.jar"

echo "[INFO] Kompiliere $JAVA_FILE ..."
javac -cp ".:$JAR_FILE" "$JAVA_FILE"
if [ $? -ne 0 ]; then
    echo "[FEHLER] Kompilierung fehlgeschlagen."
    exit 1
fi

echo "[INFO] Starte $CLASS_NAME ..."
java -cp ".:$JAR_FILE" "$CLASS_NAME"
