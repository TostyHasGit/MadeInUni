function tests = testFilterT
    tests = functiontests(localfunctions);
end

%% Test 1
function test_1(testCase)

    b = [0.5, 0.5];
    verz_puffer = [1];
    x_k = 2;

    [y_k, new_puffer] = filterT(x_k, b, verz_puffer);

    expected_y_k = 1.5;
    expected_puffer = [x_k];

    verifyEqual(testCase, y_k, expected_y_k);
    verifyEqual(testCase, new_puffer, expected_puffer);
end

%% Test 2:
function test_2(testCase)

    b = [0.7, 0.3, 0.5, 1];
    verz_puffer = [2, 1, 1];
    x_k = 4;

    [y_k, new_puffer] = filterT(x_k, b, verz_puffer);

    expected_y_k = 4.9;
    expected_puffer = [4, 2, 1];

    verifyEqual(testCase, y_k, expected_y_k);
    verifyEqual(testCase, new_puffer, expected_puffer);
end

%% Test 3:
function test_3(testCase)
    % Setup
    b = [0.2, 0.3, 0.5, 3, 1.5, 2.1];
    verz_puffer = [10, 20, 7, 4, 9];
    x_k = 5;

    [y_k, new_puffer] = filterT(x_k, b, verz_puffer);

    expected_y_k = 59.9;
    expected_puffer = [5, 10, 20, 7, 4];

    verifyEqual(testCase, y_k, expected_y_k, 'AbsTol', 1e-10);
    verifyEqual(testCase, new_puffer, expected_puffer);
end

%% Test 4:
function testSize_1(testCase)
    
    b = [0.5, 0.5, 0.5];
    verz_puffer = [1];
    x_k = 2;

    verifyError(testCase, @() filterT(x_k, b, verz_puffer), 'MATLAB:BufferSizeError');
end

%% Test 5:
function testSize_2(testCase)
    
    b = [1];
    verz_puffer = [0.5, 0.5, 0.5];
    x_k = 2;

    verifyError(testCase, @() filterT(x_k, b, verz_puffer), 'MATLAB:BufferSizeError');
end