function [Image_out] = Length_Filter(BW, connectivity, pixel_filter)
%LENGTH_FILTER For Project 2 in Computer Vision
% This function filters out small, disconnected pixel clusters under
% a certain size determined by pixel_filter.

% connectivity must be 4 or 8
L = bwlabel(BW, connectivity);

% Go through and find all groups and assign to different groups.
% Then filter out the groups smaller than pixel_filter
for i = 1:max(max(L))
    % Find all pixels with label i; store coordinates in r and c
    [r, c] = find(L == i); 
    for j = 1:size(r)
        if(size(r) < pixel_filter)
            x = r(j);
            y = c(j);
            Image_out(x,y) = false; % place a 0 at x,y
        else
            x = r(j);
            y = c(j);
            Image_out(x,y) = true; % place a 1 at x,y
        end
    end
end
end

