% function [outputArg1,outputArg2] = Matched_Filter(image, size, sigma)
%% Create matched filter Group
sigma = 1;
size = 5;
B = int64(2);
x = idivide(int64(size), B, 'fix');
x = -x:x;
m0 = 1;
% breaking the G(x,y) function down for readability
G_c = 1/(sqrt(2*pi*(sigma^2))); % Constant used
e_c = exp(-(size^2)/(2*(sigma^2)));
G = -G_c * e_c -m0;

%% Apply Kernel to the image (i.e. filter)



%% Fuse all filtered images
%  assign the pixel value to be the maximum one across all filtered images



%% Find the appropriate threshold
%  (MATLAB "GRAYTHRESH")



%% Binarize the image data
%  (Matlab "IM2BW")

%end

