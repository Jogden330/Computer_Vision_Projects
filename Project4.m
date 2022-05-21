%% Harris Corner Detection: Image 1 (working)
check = imread("checkerboard-noisy1.tif");
checker = double(imread("checkerboard-noisy1.tif"));
% imshow(checker);
 
% Gaussian filter
sigma = 1;
I = imfilter(checker, fspecial("gaussian", round(6*sigma+1), sigma));
 
% Gradient
Sx = [-1 -2 -1; 0 0 0; 1 2 1];
Sy = Sx';
Ix = imfilter(I, Sx);
Iy = imfilter(I, Sy);
 
% Second Moment Matrix (M)
Ixx = Ix.*Ix;
Iyy = Iy.*Iy;
Ixy = Ix.*Iy;
 
sigma = 2;
W = fspecial("gaussian", round(6*sigma+1), sigma);
M11 = imfilter(Ixx, W);
M12 = imfilter(Ixy, W);
M22 = imfilter(Iyy, W);
 
% Calculating R (Harris Corner Response Function)
alpha = 0.05;               % Constant from 0.04-0.06
det_M = M11.*M22 - M12.^2;  % Determinant
trace_M = M11 + M22;        % Trace = sum of diagonals
R = det_M - alpha*trace_M.^2;
 
% Maximum suppression
threshold = 130;
Lmax = (R==imdilate(R, strel('disk', 100)) & R>threshold); % Neighborhood to compare against
[rows cols] = find(Lmax);   % Find interest points
 
figure
imshow(check) 
hold on
for k = 1:length(rows)
    x = cols(k);      % Adjust top left corner x
    y = rows(k);      % Adjust top left corner y
    drawrectangle('Position', [x-2 y-2 4 4], 'Color','r');  % Draw rectangle
end
hold off

%% Feature Description

close all
clear all
img = im2gray(imread("bikes1.ppm"));
imshow(img)
corners = detectFASTFeatures(img);

s = 100;
keypoints = corners.selectStrongest(s);
hold on
plot(keypoints);
hold off
extracted_features = zeros(size(keypoints, 1), 2);
locations = keypoints.Location(:,:);
% Get window of pixels for each keypoint
key_win = cell(size(keypoints, 1), 1);
pad_img = padarray(img, [8 8], 255, 'both');

for k = 1:s                 % For each keypoint
   pt = locations(k,:);    % Gets row of keypoint coords
   idy1 = pt(2)-8;
   idy2 = pt(2)+8;
   idx1 = pt(1)-8;
   idx2 = pt(1)+8;
   key_win{k} = pad_img(idy1:idy2,idx1:idx2);
end
% Get features from each pixel window
for k = 1:s                 % For each keypoint
   [Gmag, Gdir] = imgradient(key_win{k},'prewitt');    % Gets mag+dir
   Gmag_avg = mean(Gmag, 'all');
   Gdir_avg = mean(Gdir, 'all');
   extracted_features(k, 1) = Gmag_avg;    % Store magnitude
   extracted_features(k, 2) = Gdir_avg;    % Store direction
end

function extracted_features = extractFeatures(image, detected_pts)
   extracted_features = zeros(size(detected_pts, 1), 2);
   s = size(detected_pts, 1);
   % Get window of pixels for each keypoint
   pad_img = padarray(image, [8 8], 255, 'both');
   key_win = cell(s, 1);
   for k = 1:s                     % For each keypoint
       pt = detected_pts(k,:);     % Gets row of keypoint coords
       idy1 = pt(2)-8;
       idy2 = pt(2)+8;
       idx1 = pt(1)-8;
       idx2 = pt(1)+8;
       key_win{k} = pad_img(idy1:idy2,idx1:idx2);
   end
  
   % Get features from each pixel window
   for k = 1:s                 % For each keypoint
       [Gmag, Gdir] = imgradient(key_win{k},'prewitt');    % Gets mag+dir
       Gmag_avg = mean(Gmag, 'all');
       Gdir_avg = mean(Gdir, 'all');
       extracted_features(k, 1) = Gmag_avg;    % Store magnitude
       extracted_features(k, 2) = Gdir_avg;    % Store direction
   end
   end



