% Calibration.m

sd = [ Xgdxdir('S',1) 'S0001_00'];
% Define images to process
imageFileNames = {[sd '01.png'],[sd '02.png'],[sd '03.png'],[sd '04.png'],...
    [sd '05.png'],[sd '06.png'],[sd '07.png'],[sd '08.png'],[sd '09.png'],...
    [sd '10.png'],[sd '11.png'],[sd '12.png'],[sd '13.png'],[sd '14.png'],...
    [sd '15.png'],[sd '16.png'],[sd '17.png'],[sd '18.png']};

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Generate world coordinates of the corners of the squares
squareSize  = 25;  % in units of 'mm'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'mm');

% View reprojection errors
figure; showReprojectionErrors(cameraParams, 'BarGraph');
figure; showReprojectionErrors(cameraParams, 'ScatterPlot')

% Visualize pattern locations
figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% Example: Superimposition of 3D Gaussian bell onto image #6
i      = 6;
I      = imread(imageFileNames{i});

% Projection matrix of image i
R      = cameraParams.RotationMatrices(:,:,i); % Rotation matrix
t      = cameraParams.TranslationVectors(i,:); % Translation vector
P      = cameraMatrix(cameraParams, R, t)';    % Projection matrix

GaussianSuperimposition(I,P,squareSize)

