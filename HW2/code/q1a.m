clear;close all;clc;

load('../images/F_data.mat')
result_path = "../result/q1/";

F_data = fftshift(F_data);
[m,n]=size(F_data);
I2=zeros(m,n);
F = F_data;
for x=1:m
    for y=1:n
        for u=1:m
            for v=1:n
                I2(x,y)=I2(x,y)+double(F(u,v))*exp(2*pi*i*(u*x/m+v*y/n))/(m*n);
            end
        end
    end
end

for x=1:m
    for y=1:n
        for u=1:m
            for v=1:n
                I2(x,y)=I2(x,y)+double(I(u,v))*exp(2*pi*i*(u*x/m+v*y/n))/(m*n);
            end
        end
    end
end
 
% subplot(122),imshow(I2);
figure;
subplot(121),imshow(I2);
subplot(122);
re_image =abs(ifft2(F_data));
imshow(re_image,[])
title('(1) 2D inverse DFT function by myself ');
saveas(gcf,result_path + 'q1a_1','png')

[H,W] = size(F_data);