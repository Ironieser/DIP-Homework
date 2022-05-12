clear; close all; clc;
img_path = 'images\city.tif';
result='result\';
img = imread(img_path);
figure;
subplot(4,5,1);
imshow(img);title('original img');
img_gray = mat2gray(img);
a= 1;
Gamma = 0;
for i=1:16
    Gamma = 0 + i*0.5;
    gamma_img = a*(img_gray.^Gamma);
    subplot(4,5,i+1);imshow(gamma_img,[0 1]);title(['\gamma=',num2str(Gamma)]);
end
log_img=log(1+img_gray);
figure;
subplot(1,2,1);imshow(img_gray,[0,1]);title('original image');
subplot(1,2,2);imshow(log_img,[0,1]);title('Log');