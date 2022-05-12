clear;close all;clc;
load('../images/img.mat');
result_path = "../result/q2/";
% img=image_norm;

figure;imshow(img,[]);saveas(gcf,result_path + 'q2c_1','png')

[H ,W]=size(img);
[LL, LH, HL, HH]=haar_dwt2D(img);
img=[LL LH;HL HH];
imgn=img;
figure;imshow(imgn,[]);saveas(gcf,result_path + 'q2c_2','png')
i=0;j=0;
[LL, LH ,HL, HH]=haar_dwt2D(LL);
imgn(i+1:i+H/2,j+1:j+W/2)=[LL LH;HL HH];
figure;imshow(imgn,[]);saveas(gcf,result_path + 'q2c_3','png')
[LL, LH, HL, HH]=haar_dwt2D(LL);
imgn(i+1:i+H/4,j+1:j+W/4)=[LL LH;HL HH];
figure;imshow(imgn,[]);saveas(gcf,result_path + 'q2c_4','png')
function [LL, LH, HL, HH]=haar_dwt2D(img)
    [H, W]=size(img);
    for i=1:H
        [Low, High]=haar_dwt(img(i,:));
        img(i,:)=[Low High];
    end
    for j=1:W
        [Low, High]=haar_dwt(img(:,j));
        img(:,j)=[Low High];
    end
    LL=mat2gray(img(1:H/2,1:W/2));
    LH=mat2gray(img(1:H/2,W/2+1:W));
    HL=mat2gray(img(H/2+1:H,1:W/2));
    HH=mat2gray(img(H/2+1:H,W/2+1:W));

end
function [Low, High]=haar_dwt(f)
    n=length(f);
    n=n/2;
    Low=zeros(1,n);
    High=zeros(1,n);
    for i=1:n
        Low(i)=(f(2*i-1)+f(2*i))/sqrt(2);
        High(i)=(f(2*i-1)-f(2*i))/sqrt(2);
    end

end
