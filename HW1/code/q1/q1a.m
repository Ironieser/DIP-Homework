clear; close all; clc;
img_path = 'images/lena.tif';
result='result\';
img = imread(img_path);

subplot(3,3,1);
imshow(img);title('original img');

for i=1:1:8
    img_bitplane = bitshift(bitget(img,i),i-1);
    subplot(3, 3, i+1);
    imshow(img_bitplane);
    title(['bit plane:',num2str(i)]);
end 