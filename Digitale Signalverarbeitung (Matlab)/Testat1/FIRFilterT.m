%% Testat 2: FIR Filter mit LMS Anpassung
% 
% firLMS - Führt einen FIR-Filter mit LMS-Anpassung durch.
%
% Eingangsparameter:
% x_k   - Eingangsvektor (Eingangssignal), das gefiltert werden soll. 
%         Dies ist der Signalvektor, der durch den adaptiven Filter bearbeitet wird.
%
% w_k   - Vektor der anfänglichen Filtergewichte. 
%         Zu Beginn des Algorithmus sind dies die Startwerte für die Filterkoeffizienten.
%
% zi    - Verzögerungspuffer (initialisiert), der den Filterzustand speichert.
%         Dieser Puffer wird benötigt, um die Verzögerung der vergangenen Eingangsproben zu speichern.
%
% d_k   - Vektor des gewünschten Ausgangssignals (Zielsignal).
%         Der LMS-Algorithmus versucht, den Filter so anzupassen, dass das Ausgangssignal y_k dem gewünschten Signal d_k möglichst nahe kommt.
%
% muh   - Lernrate, die die Geschwindigkeit der Anpassung der Gewichte bestimmt.
%         Ein höherer Wert führt zu schnellerer Anpassung, kann aber auch zu Instabilität führen.
%
% flag  - Entscheidet, ob das Ergebnis direkt ausgegeben oder in Echtzeit berechnet werden soll.
%
% Ausgangswerte:
% y_k   - Vektor des gefilterten Ausgangssignals. 
%         Das ist das tatsächliche Signal, das durch den Filter generiert wird.
%
% zf    - Aktualisierter Verzögerungspuffer nach der Filterung.
%         Der Puffer enthält die letzten Werte von x_k, um den Filterzustand zwischen den Iterationen zu bewahren.
%
% e_k   - Vektor des Fehlersignals (d_k - y_k).
%         Der Unterschied zwischen dem gewünschten Signal und dem tatsächlichen Ausgangssignal. Dieses Signal wird zur Anpassung der Filtergewichte verwendet.
%
% wf    - Aktualisierter Vektor der Filtergewichte nach der LMS-Anpassung.
%         Die neuen Werte der Filterkoeffizienten, die für die nächste Iteration verwendet werden.

function [y_k, zf, wf, e_k] = FIRFilterT(x_k, w_k, zi, d_k, muh, flag)

    % Echtzeitberechnung
    if flag
        % Eingang + Puffer kombinieren
        zf = [x_k, zi];

        % Aktuellen Ausgang berechnen
        y_k = sum(w_k .* zf);

        % Fehler berechnen
        e_k = d_k - y_k;

        % Filterkoeffizienten anpassen
        wf = w_k + muh * e_k * zf;
        
        % Letzten Wert im Puffer löschen
        zf(end) = [];

    % Komplettes Ergebnis berechnen
    else
        % Prüfen, ob Puffergröße um 1 kleiner als Koeffizienten ist
        if length(w_k) ~= length(zi) + 1
            error('MATLAB:BufferSizeError', 'Die Länge des Puffers muss um 1 kleiner als die Länge der Koeffizienten sein.');
        end

        % Schleife über alle Eingangsproben
        for k = 1:length(x_k)
            % Aktuelle Eingangsprobe in den Puffer einfügen
            zi = [x_k(k), zi];

            % Aktuellen Ausgang berechnen
            y_k(k) = sum(w_k .* zi);

            % Fehler berechnen
            e_k(k) = d_k(k) - y_k(k);

            % Filterkoeffizienten anpassen
            w_k = w_k + muh * e_k(k) * zi;

            zi(end) = [];
        end
        
        % Aktuelle Werte des Puffers und der Koeffizienten speichern
        zf = zi;
        wf = w_k;
    end
end
