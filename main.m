clear;

%% Read in the image
%  per the document, only need to read in the green channel.
I1=imread('retina1.jpg'); 
I2=imread('retina2.jpg'); 
J1(:,:)=I1(:,:,2); % I1 in height x width x RGB value
J2(:,:)=I2(:,:,2);

%% Run the Matched Filtering

[BW, I_bank, Filter_Bank, Ker_pad] = Matched_Filter(J1, 4, 5, 12);
[B2, I_ban2, Filter_Bank2, Ker_pad2] = Matched_Filter(J2, 4, 5, 12);


%% Length Filtering
connectivity = 4; % Must be 4 or 8
L = bwlabel(BW, connectivity);

% Go through and find all groups and assign to different groups.
% Then filter out the groups 
for i = 1:max(max(L))
    [r, c] = find(L == i); % XY coordinates
    for j = 1:size(r)
        if(size(r) < 100)
            x = r(j);
            y = c(j);
            New(x,y) = false;
        else
            x = r(j);
            y = c(j);
            New(x,y) = true;
        end
    end
end


%% Display Image 1 (J1)


[I_Canny, threshOut_C] = edge(J1, "canny", [0.0935, 0.0936]); % [0.0935, 0.0936] thresh tried
[I_LoG, threshOut_L] = edge(J1, "log");
% display image: "montage" for side-by-side; "falsecolor" for layered image; 
% imshowpair(J1, I_Canny, I_LoG, "montage");
figure(1);
I_list = {J1, I_Canny, I_LoG, BW};
montage(I_list);

%Filters
figure(2);
montage(mat2gray(Filter_Bank));

%images after filtering
figure(3);
montage(I_bank);

figure(4);
imshowpair(BW, New, "montage");

%% Display Image 2 (J2)

