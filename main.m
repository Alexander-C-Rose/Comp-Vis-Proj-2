clear;

%% Read in the image
%  per the document, only need to read in the green channel.
I1=imread('retina1.jpg'); 
I2=imread('retina2.jpg'); 
J1(:,:)=I1(:,:,2); % I1 in height x width x RGB value
J2(:,:)=I2(:,:,2);


%% Run the Matched Filtering

%


%% Length Filtering



%% Edge Detection


[I_Canny, threshOut_C] = edge(J1, "canny", [0.0935, 0.0936]); % [0.0935, 0.0936] thresh tried
[I_LoG, threshOut_L] = edge(J1, "log");
% display image: "montage" for side-by-side; "falsecolor" for layered image; 
% imshowpair(J1, I_Canny, I_LoG, "montage");

I_list = {J1, I_Canny, I_LoG};
montage(I_list);