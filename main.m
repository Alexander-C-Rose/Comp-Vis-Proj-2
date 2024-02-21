clear;

%% Read in the image
%per the document, only need to read in the green channel.
I1=imread('retina1.jpg'); 
I2=imread('retina2.jpg'); 
J1(:,:)=I1(:,:,2); % I1 in height x width x RGB value
J2(:,:)=I2(:,:,2);

imshow(J1);

%% Create matched filter group



%% Apply Kernel to the image (i.e. filter)



%% Fuse all filtered images
%  assign the pixel value to be the maximum one across all filtered images



%% Find the appropriate threshold
%  (MATLAB "GRAYTHRESH")



%% Binarize the image data
%  (Matlab "IM2BW")



%% Length Filtering



%% Edge Detection