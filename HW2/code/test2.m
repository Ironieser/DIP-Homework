%读入图片
img = imread('../images/low_contrast.tif');
img = imread('../images/demo.jpg');
figure(1);
subplot(2, 1, 1);
imshow(img);
title('Raw Image');
gamma_H = 0.5;
gamma_L = 0.25;
c = 0.25;
D0 =100;
f = im2double(img);
max0 = max(f(:));
min0 = min(f(:));
f = log(f + 1);%取指数
F = fft2(f);%傅里叶变换
F=fftshift(F);%频谱搬移
[height, width] = size(F);
%设计一个同态滤波器
H = HomomorphicFiltering(gamma_H, gamma_L, c, D0, height, width);
g=H.*F;%同态滤波
g = ifft2(ifftshift(g));%频谱搬移,傅里叶逆变换
g = exp(g)-1;
g = real(g);
%拉伸像素值
% new_img = Expand(g);
% new_img=new_img*(max0-min0)+min0;
subplot(2,1,2);
imshow(new_img);
title('Homomorphic Filtered Image(D0 = 100)');


function new_img = Expand( img ) 
    [height, width] = size(img);
    max_pixel = max(max(img));
    min_pixel = min(min(img));
    new_img=zeros(height,width);
    for i = 1 : height
        for j = 1 : width
            new_img(i, j) = 255 * (img(i, j) - min_pixel) / (max_pixel - min_pixel);
        end
    end
    new_img = uint8(new_img);
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
