clear;

%% Read in the image
%  per the document, only need to read in the green channel.
I1=imread('retina1.jpg'); 
I2=imread('retina2.jpg'); 
J1(:,:)=I1(:,:,2); % I1 in height x width x RGB value
J2(:,:)=I2(:,:,2);


%% Run the Matched Filtering
[BW1, I_bank1, Filter_Bank1, Ker_pad1] = Matched_Filter(J1, 8, 9, 10);
[BW2, I_bank2, Filter_Bank2, Ker_pad2] = Matched_Filter(J2, 11, 11, 5);


%% Length Filtering
[LF_1] = Length_Filter(BW1, 8, 300);
[LF_2] = Length_Filter(BW2, 8, 300);

% Trim the borders of the image
LF_1(627:633,:) = [];
LF_1(1:7,:) = [];
LF_1(:,1:3) = [];

% figure(1);
% imshowpair(BW1, LF_1, "falsecolor");
% figure(2);
% imshowpair(BW2, LF_2, "falsecolor");


%% Pick images to be displayed
Show_I1 = false; % show image 1
Show_I2 = true; % show image 2

% this counts which figure I'm at so I don't have to manually adjust
% figures each time I add a new one.
fig_num = 0;


%% Display Image 1 (J1)
if(Show_I1)
% default thresh = [0.0375, 0.0938]
% [I_Canny1_default, threshOut_C1] = edge(J1, "canny");
[I_Canny1] = edge(J1, "canny", [0.093549, 0.09355]); % Canny
[I_LoG1, threshOut_L1] = edge(J1, "log"); % LoG

%Image before filtering vs canny vs LoG vs matchfiltered/lengthfiltered
fig_num = fig_num+1;
figure(fig_num);
I_list1 = {J1, I_Canny1, I_LoG1, LF_1};
montage(I_list1);

%Filters used for image 1
fig_num = fig_num+1;
figure(fig_num);
montage(mat2gray(Filter_Bank1), Size=[2 5]);

%images after filtering
fig_num = fig_num+1;
figure(fig_num);
montage(I_bank1, Size=[2 5]);

%Show effect of length filtering on image
fig_num = fig_num+1;
figure(fig_num);
% display 2 images: "montage" for side-by-side; "falsecolor" for layered image; 
imshowpair(J1, LF_1, "montage");

%try length filtering on LoG and Canny
[LF_Canny] = Length_Filter(I_Canny1, 8, 25);
[LF_LoG] = Length_Filter(I_LoG1, 8, 25);
fig_num = fig_num+1;
figure(fig_num);
montage({J1, LF_Canny, LF_LoG, LF_1});

end % End of Display Image 1


%% Display Image 2 (J2)
if(Show_I2)
%  thresh seems to work best.
% default thresh = [0.025, 0.0625]
[I_Canny2, threshOut_C2] = edge(J2, "canny");
[I_Canny2] = edge(J2, "canny", [0.07 0.075]);
[I_LoG2, threshOut_L2] = edge(J2, "log");

%Image before filtering vs canny vs LoG vs matchfiltered/lengthfiltered
fig_num = fig_num+1;
figure(fig_num);
I_list2 = {J2, I_Canny2, I_LoG2, LF_2};
montage(I_list2);

%Filters used for image 2
fig_num = fig_num+1;
figure(fig_num);
montage(mat2gray(Filter_Bank2), Size=[1 5]);

%images after filtering
fig_num = fig_num+1;
figure(fig_num);
montage(I_bank2, Size=[1 5]);

%Show effect of length filtering on image
fig_num = fig_num+1;
figure(fig_num);
% display 2 images: "montage" for side-by-side; "falsecolor" for layered image; 
imshowpair(BW2, LF_2, "montage");

%try length filtering on LoG and Canny
[LF_Canny] = Length_Filter(I_Canny2, 8, 90);
[LF_LoG] = Length_Filter(I_LoG2, 8, 25);
fig_num = fig_num+1;
figure(fig_num);
montage({J2, LF_Canny, LF_LoG, LF_2});

end % End of Display Image 2 
