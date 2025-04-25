function tests = testFIRFilterT
    tests = functiontests(localfunctions);
end

%% Test 1: Echtzeitberechnung (flag = true)
function test_1_real_time(testCase)
% Testskript für den adaptiven MA-Filter

% Eingangsparameter
N = 400;                         % Anzahl der Iterationen
M = 10;                          % Filterordnung (Anzahl der Koeffizienten)
mu = 0.01;                       % Schrittweite (Lernrate)
wi = zeros(1, M);                % Initiale Filterkoeffizienten
zi = zeros(1, M-1);              % Gedächtnis (Vergangene Werte)

% Eingangs- und Zielsignale
xr = randn(1, N);                % Eingangssignal (z.B. Rauschen)
d = filter([10 4.5 34], 1, xr);      % Zielsignal als gefiltertes Eingangssignal

% Verlauf der Filterkoeffizienten speichern
wf_history = zeros(N, M);

% Echtzeitfähige Filterung mit adaptiven Koeffizienten
for k = 1:N
    % Aufruf der Funktion mit aktuellem Eingang und Zielwert
    [yk, zf, wf, ek] = FIRFilterT(xr(k), wi, zi, d(k), mu, true);
    
    % Aktualisierung des Gedächtnisses und der Koeffizienten
    zi = zf;
    wi = wf;
    
    % Speichern des aktuellen Koeffizientenverlaufs
    wf_history(k, :) = wi;
    
    % Echtzeitdarstellung der Filterkoeffizienten (optional)
    stem(wi, 'ro'); title('Adaptive Filterkoeffizienten'); grid on;
    drawnow;
end

% Plot der Entwicklung der Filterkoeffizienten über die Zeit
figure;
plot(wf_history);
title('Entwicklung der Filterkoeffizienten');
xlabel('Iteration');
ylabel('Koeffizientenwerte');
legend(arrayfun(@(x) ['w[' num2str(x) ']'], 1:M, 'UniformOutput', false));
grid on;
end

%% Test 2: Gesamte Berechnung ohne Echtzeit (flag = false)
function test_2_batch_mode(testCase)
    % Eingangsparameter
    x_k = [1, 2, 3];               % Eingangssignal
    w_k = [0.3, 0.3, 0.3, 0.3];    % Anfangsgewichte
    zi = [0, 0, 0];                % Verzögerungspuffer
    d_k = [1.5, 1.2, 1.8];         % Zielsignal
    muh = 0.01;                    % Lernrate
    flag = false;                  % Echtzeitberechnung deaktivieren

    % Aufruf der FIRFilterT-Funktion
    [y_k, zf, wf, e_k] = FIRFilterT(x_k, w_k, zi, d_k, muh, flag);

    % Erwartete Ergebnisse basierend auf Simulation
    expected_y_k = [0.3, 0.924, 1.85808];                   % Schätzwert von y_k
    expected_zf =  [3, 2, 1];                            % Erwarteter Puffer
    expected_e_k = [1.2, 0.276, -0.05808];                  % Fehler (d_k - y_k)
    expected_wf = [0.3157776, 0.3015984, 0.2994192, 0.3];   % Gewichtsaktualisierungen

    % Verifikation der Ergebnisse
    verifyEqual(testCase, y_k, expected_y_k, 'AbsTol', 1e-10);
    verifyEqual(testCase, zf, expected_zf, 'AbsTol', 1e-10);
    verifyEqual(testCase, e_k, expected_e_k, 'AbsTol', 1e-10);
    verifyEqual(testCase, wf, expected_wf, 'AbsTol', 1e-10);
end

%% Test 3: Grenztest mit konstantem Signal und flag = false
function test_3_constant_signal(testCase)
    % Eingangsparameter
    x_k = [1, 1, 1];               % Konstantes Eingangssignal
    w_k = [0.2, 0.2, 0.2, 0.2];    % Anfangsgewichte
    zi = [0, 0, 0];                % Verzögerungspuffer
    d_k = [1, 1, 1];               % Konstantes Zielsignal
    muh = 0.01;                    % Lernrate
    flag = false;                  % Echtzeitberechnung deaktivieren

    % Aufruf der FIRFilterT-Funktion
    [y_k, zf, wf, e_k] = FIRFilterT(x_k, w_k, zi, d_k, muh, flag);

    % Erwartete Ergebnisse basierend auf Simulation
    expected_y_k = [0.2, 0.408, 0.61984];   % Schätzwert für y_k
    expected_zf = [1, 1, 1];             % Erwarteter Puffer am Ende
    expected_wf = [0.2177216, 0.2097216, 0.2038016, 0.2];   % Fehler (d_k - y_k)
    expected_e_k = [0.8, 0.592, 0.38016]; % Gewichtsaktualisierungen nach LMS-Anpassung

    % Verifikation der Ergebnisse
    verifyEqual(testCase, y_k, expected_y_k, 'AbsTol', 1e-10);
    verifyEqual(testCase, zf, expected_zf, 'AbsTol', 1e-10);
    verifyEqual(testCase, e_k, expected_e_k, 'AbsTol', 1e-10);
    verifyEqual(testCase, wf, expected_wf, 'AbsTol', 1e-10);
end
