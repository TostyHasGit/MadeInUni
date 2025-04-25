%% Testat 1: Eigene Filterfunktion implementieren
% Aufgabe: Es soll eine Filterfunktion implementiert werden, die sich
%          ähnlich wie die eingebaute Funktion filter() verhält.
%          Für diese Funktion muss auch eine Testdatei erstellt und getestet
%          werden.
%
% Syntax:
%           [y_k, verz_puffer] = filterT(x_k, b, verz_puffer)
%
% Eingaben:
%           x_k:         Aktueller Eingangswert (Skalar), der durch den Filter verarbeitet wird
%           b:           Vektor der Filterkoeffizienten, der als Gewichtung für aktuelle und
%                        vergangene Eingabewerte dient
%           verz_puffer: Vektor, der die verzögerten (vergangenen) Eingabewerte speichert
%
% Rückgaben:
%           y_k:         Aktueller Ausgangswert (Skalar), der gefilterte Wert
%           verz_puffer: Aktualisierter Verzögerungspuffer, der den aktuellen
%                        Eingangswert `x_k` und die vorherigen Werte enthält

function [y_k, verz_puffer] = filterT(x_k, b, verz_puffer)
    
    if length(b) -1 ~= length(verz_puffer)
        error('MATLAB:BufferSizeError', 'Der Puffer muss einen Wert größer als das b sein.');
    end
    verz_puffer = [x_k, verz_puffer];
    y_k = sum(b .* verz_puffer);
    verz_puffer(end) = [];
end
