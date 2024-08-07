function [BW, I_bank, Filter_Bank, Ker_pad] = Matched_Filter(image, sigma, filter_size, filter_num)
% This function filters the image, 

% This variable is used frequently for various operations.
% It represents the half of the filter_size (odd) rounded to zero. 
x = double(idivide(int64(filter_size), int64(2), 'fix'));

%% Create the Kernel
% preallocate matrix size with zeros
Ker = zeros(1, filter_size);
for j = -x:x % corresponding to the column
        % breaking the 1D Gaussian function down for readability
        G_c = -1/(sqrt(2*pi*(sigma^2)));
        e_c = exp(-(j^2)/(2*(sigma^2)));
        G = G_c * e_c;
        Ker(j+x+1) = G;
end

% Find the mean of the distribution.
m0 = mean(Ker);
% Subtract the distribution by the mean (bringing mean to 0).
Ker = Ker - m0;


% Form matrix rows which are all uniform.
% Use Ker_temp for appending rows. If Ker is used instead, the matrix row
% filter_size will double every iteration rather than linearly increase by +1 
Ker_temp = Ker; 
for i = 1:filter_size-1
    Ker = [Ker; Ker_temp];
end


%% Create a bank of filters at different rotations
% Pad filter kernel with zeros before rotation (the +1 keeps the matrix odd)
Ker_pad = zeros(filter_size*2+1); 
for j = 1:filter_size
    for i = 1:filter_size
        % Fill padded matrix with Gaussian matrix and align centers
        % by increasing index by a value of x+1
        Ker_pad(i+x+1,j+x+1) = Ker(i,j); 
    end
end

% Create Filter Bank
theta = 0;
Filter_Bank = [];
for i = 1:filter_num
    B = imrotate(Ker_pad, theta, 'bicubic', 'crop');
    Filter_Bank(:,:,i) = B;
    theta = theta + 180/filter_num; % increase rotation by 180/number of filters
end


%% Apply Kernel to the image (i.e. filter)

% create a bank of filtered images
for i = 1:filter_num
    I = conv2(Filter_Bank(:,:,i), image);
    I_bank(:,:,i) = I; % I_bank stores the images 
end


%% Fuse all filtered images

%  assign the pixel value to be the maximum one across all filtered images
s = size(image);

m = s(:,1);
n = s(:,2);
for i = 1:filter_num
    for y = 1:n
        for x = 1:m
            I(x,y) = max(I_bank(x,y,i), I(x,y));
        end
    end
end


%% Find the appropriate threshold and binarize the image data
%  (MATLAB "GRAYTHRESH")
T = graythresh(I);
BW = imbinarize(I, T);

end

