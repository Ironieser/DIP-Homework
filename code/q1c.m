clear;close all;clc;

load('../images/F_data.mat')
result_path = "../result/q1/";

F_data = fftshift(F_data);
F_data(166,166)=3;

img_f = F_data;
%% init
img = abs(ifft2(img_f));
img = im2double(imread('../images/low_contrast.tif'));
% img = im2double(imread('../images/demo.jpg'));
max0 = max(img(:));
min0 = min(img(:));
% figure;
% subplot(2, 1, 1);
% imshow(img);
% title('Raw Image');
% gamma_H = 0.5;
% gamma_L = 0.25;
% c = 0.25;
% D0 =100;
% f = double(img);
% f = log(f + 1);%取指数
% F = fft2(f);%傅里叶变换
% F=fftshift(F);%频谱搬移
% [height, width] = size(F);
% %% 设计一个同态滤波器
% [h,w] = size(img_f);
% [x,y] = meshgrid(-w/2:w/2,-h/2:h/2);
% H = h_generate_2d(gamma_H, gamma_L, c, D0, height, width);
% H = h_generate_2d(gamma_H,gamma_L,c,x,y,D0,D0)
% H = HomomorphicFiltering(gamma_H, gamma_L, c, D0, height, width);;
% 
% g=H.*F;%同态滤波
% figure;
% subplot(1,2,1);
% imshow(log(abs(F)),[]);
% subplot(1,2,2);
% imshow(log(abs(g)),[]);
% g = ifft2(ifftshift(g));%频谱搬移,傅里叶逆变换
% g = exp(g)-1;
% g = real(g);
% 
% % 拉伸像素值
% 
% img_out = g;
% img_out = (img_out-min(img_out(:)));
% img_out = img_out/(max(img_out(:))-min(img_out(:)));
% img_out = img_out*(max0-min0)+min0;
% new_img =  img_out;
% % 拉伸像素值
% new_img = Expand(g);
% 
% %
% figure;
% subplot(2,1,2);
% imshow(new_img);
% title('Homomorphic Filtered Image(D0 = 100)');


% function new_img = Expand( img ) 
%     [height, width] = size(img);
%     max_pixel = max(max(img));
%     min_pixel = min(min(img));
%     new_img=zeros(height,width);
%     for i = 1 : height
%         for j = 1 : width
%             new_img(i, j) = 255 * (img(i, j) - min_pixel) / (max_pixel - min_pixel);
%         end
%     end
%     new_img = uint8(new_img);
% end
% gamma_H = 0.5;
% gamma_L = 0.25;
% c = 0.25;
% D0 =10;
% [height, width] = size(F_data);
% H = HomomorphicFiltering(gamma_H, gamma_L, c, D0, height, width);
% figure;
% imshow(H,[]);

% 
% 
% % comment
% max0 = max(img(:));
% min0 = min(img(:));
% img = log(img+1);
% % img = (img-min0)/(max0-min0);
% img_f = fftshift(fft2(img));
% %% 设置滤波器参数
r_h = 0.4;
r_l = 0.35;
D_0 = 10;
c = 0.25;
%% 获取滤波器
[h,w] = size(img_f);
[x,y] = meshgrid(-w/2:w/2,-h/2:h/2);
H = h_generate_2d(r_h,r_l,c,x,y,D_0,D_0);
H = imresize(H,[h,w]);
%% 进行频域滤波
img_f_filter = H.*img_f;
%% 显示频谱
figure,
set(gcf,'position',[100,100,1020*1,520*0.6]);
subplot(1,3,1);colormap gray;
imshow(log(abs(F_data)+1e-12),[]);
title('(1)the original magnitude')
subplot(1,3,2);colormap gray;
imshow(H,[]);
title('(2)the homomorphic filter')
subplot(1,3,3);colormap gray;
imshow(log(abs(img_f_filter)+1e-12),[]);
title('(3)the magnitude by the filter')
saveas(gcf,result_path + 'q1c_1','png')
%% 反变换到空域
img_out = real(ifft2(ifftshift(img_f_filter)));
% img_out=img;
img_out = exp(img_out)-1;
img_out = (img_out-min(img_out(:)));
img_out = img_out/(max(img_out(:))-min(img_out(:)));
% img_out=img_out*(max0-min0)+min0;
img = exp(img)-1;
% img = (img-min(img(:)));
% img = img/(max(img(:))-min(img(:)));
%% 显示结果图片
figure,
set(gcf,'position',[100,100,1020*0.8,520*0.6]);
subplot(1,2,1);
imshow(img);colormap gray;colorbar
title('origial image')
subplot(1,2,2);
imshow(img_out);colormap gray;colorbar
title('the result by using the homomorphic filter')
saveas(gcf,result_path + 'q1c_2','png')
%% 滤波器计算函数
function h = h_generate_2d(r_h,r_l,c,x,y,D_0,D_1)
    h = (r_h-r_l)*(1-exp(-c*(x.^2+y.^2)/(D_0^2+D_1^2)))+r_l;
end
function H = HomomorphicFiltering( gamma_H, gamma_L, c, D0, height, width )
    for i = 1 : height
        x = i - (height / 2);
        for j = 1 : width
            y = j - (width / 2);
            H(i, j) = (gamma_H - gamma_L) * (1 - exp(-c * ((x ^ 2 + y ^ 2) / D0 ^ 2))) + gamma_L;
        end
    end
end
% %% output
% % figure;
% % re_image = abs(ifft2(F_data));
% % imshow(re_image,[])
% % title('the output image by using homomorphic filter');
% 
