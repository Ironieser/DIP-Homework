clear;close all;clc;
sino = imread('../images/sinogram.tif');
result_path = "../result/q2/";
load('../images/img.mat')
load('../images/scan.mat')
image = iradon(scan,0:179,'none','Hamming');
image_norm = iradon(sino,0:179,'none','Hamming');
image2 = iradon(scan,0:179,'none','Ram-Lak');
image_norm2 = iradon(sino,0:179,'none','Ram-Lak');
figure;
subplot(2,3,1);
imshow(img,[]);title('Original image of img.mat');
subplot(2,3,2);
imshow(image,[]);title('FBP by Hamming filter based on scan.mat');
subplot(2,3,3);
imshow(image_norm,[]);title('FBP by Hamming filter based on sinogram.tif');

subplot(2,3,4);
imshow(image2,[]);title('FBP by Ramp filter based on scan.mat');
subplot(2,3,5);
imshow(image_norm2,[]);title('FBP by Ramp filter based on sinogram.tif');
saveas(gcf,result_path + 'q2a1','png')
save image_norm

%%
function fbp_Hamming=FBP_Hamming(R)
M=729;
theta = deg2rad(1:180) + pi/2;
img_filtered = zeros(2^nextpow2(size(R,1)),180);
for i = 1:180
    temp = fft(R, 2^nextpow2(size(R,1)));
    filter = (1-hamming(2^nextpow2(size(R,1)))).*(2*[0:(2^nextpow2(size(R,1))/2-1), 2^nextpow2(size(R,1))/2:-1:1]'/2^nextpow2(size(R,1)));
    img_filtered(:,i) = temp(:,i).*filter;
end
%反投影到x轴，y轴
fbp = zeros(M);
temp = real(ifft(img_filtered)); 
for i = 1:180
    rad = theta(i);
    for x = 1:M
        for y = 1:M
            t_temp = (x-M/2) * cos(rad) + (y-M/2) * sin(rad)+M/2  ;
             %最近邻插值法
            t = round(t_temp) ;
            if t>0 && t<=729
                fbp(x,y)=fbp(x,y)+temp(t,i);
            end
        end
    end
end
fbp_Hamming = fbp;
end
%%
function fpb_Ram = FBP_Ram(R)
M=729;
sinogram =R;
size(sinogram,1);
theta = deg2rad(1:180) + pi/2;

W = 2^nextpow2(size(R,1));

p_fft = fft(R, W);

filter = 2*[0:(W/2-1), W/2:-1:1]'/W;

proj_filtered = zeros(W,180);
for i = 1:180
    proj_filtered(:,i) = p_fft(:,i).*filter;
end


p_ifft = real(ifft(proj_filtered));

fbp = zeros(M);
for i = 1:180
    rad = theta(i);
    for x = 1:M
        for y = 1:M
            t_temp = (x-M/2) * cos(rad) - (y-M/2) * sin(rad)+M/2  ;
            t = round(t_temp) ;
            if t>0 && t<=729
                fbp(x,y)=fbp(x,y)+p_ifft(t,i);
            end
        end
    end
end

fbp = (fbp*pi)/180;
fpb_Ram = fbp;
end