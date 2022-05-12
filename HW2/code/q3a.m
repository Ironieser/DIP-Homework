clear;close all;clc;
swan = imread('../images/swan.jpg');
result_path = "../result/q3/";
HSV = rgb2hsv(swan);
figure;
subplot(133);
imshow(HSV,[]);title('HSV with using rgb2hsv ');

img = swan;
% figure;
subplot(131);
imshow(img); title('Original RGB image');

img = im2double(img);

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

[row,column] = size(img);
% row = imgsize(1);
% column = imgsize(2);

%%Calculation Of V
% maxMatrix=zeros(row,column);
% minMatrix=zeros(row,column);
maxMatrix = max(img,[],3);
minMatrix = min(img,[],3);
V = maxMatrix;
% figure, imshow(V), title('V image without using rbg2hsv ')

%% Calculation Of S
S = zeros(row,column);
for i=1:1:row
    for j=1:1:column
        if V(i,j) == 0
            S(i,j) = 0;
        else
            S(i,j) = (maxMatrix(i,j)- minMatrix(i,j)) / maxMatrix(i,j);
        end
    end
end

% figure, imshow(S), title('S image without using rgb2hsv ')

%% Calculation Of H
H = zeros(row,column);
for i=1:1:row
    for j=1:1:column
        if maxMatrix(i,j) == R(i,j)
            H(i,j) = (1/6)*(0 + ((G(i,j) - B(i,j)) / (maxMatrix(i,j)- minMatrix(i,j))));
            
        elseif maxMatrix(i,j) == G(i,j)
            H(i,j) = (1/6)*(2 + ((B(i,j) - R(i,j)) / (maxMatrix(i,j)- minMatrix(i,j))));
            
        elseif maxMatrix(i,j) == B(i,j)
            H(i,j) = (1/6)*(4 + ((R(i,j) - G(i,j)) / (maxMatrix(i,j)- minMatrix(i,j))));
        end
        
        if H(i,j) < 0
            H(i,j) = H(i,j) + 360;
        end
    end
end

% figure, imshow(H), title('H image without using rgb2hsv ')
HSV = cat(3,H,S,V);
subplot(132); imshow(HSV); title('HSV without using rgb2hsv ');
saveas(gcf,result_path + 'q3a_swan','png');