clear; close all; clc;
img_path = 'images\woman.tif';
result='result\';
img = imread(img_path);

subplot(2,2,1);
imshow(img);title('original img');
lap_mask=[0,1,0;
        1,-4,1;
        0,1,0];
sobel_mask= [ 1,2,1;
              0,0,0;
             -1,-2,-1];
lap_img=imfilter(img,lap_mask,'replicate');
subplot(2,2,2);imshow(lap_img);title('Laplacian Filter Mask');

gas_img=imgaussfilt(img,2);
subplot(2,2,3);imshow(gas_img);title('Gaussian Filter');

sobel_img=imfilter(img,sobel_mask,'replicate');
subplot(2,2,4);imshow(sobel_img);title('Sobel Filter Mask');
