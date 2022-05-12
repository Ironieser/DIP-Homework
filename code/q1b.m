clear;close all;clc;

load('../images/F_data.mat')
result_path = "../result/q1/";

F_data = fftshift(F_data);

figure;
DFT = log(abs(F_data));
imshow(DFT,[])
title('(1)F data.mat ');
saveas(gcf,result_path + 'q1b_1','png')
[H,W] = size(F_data);

figure;
re_image =abs(ifft2(F_data));
imshow(re_image)
title('(2)reconstructed image: inverted DFT on the original F data.mat');
saveas(gcf,result_path + 'q1b_2','png')
or_img = im2double(imread('../images/low_contrast.tif'));
img_f = fftshift(fft2(or_img));
F_data(166,166)=img_f(166,166);
mid = F_data(166+1,166+1)+F_data(166+1,166)+F_data(166+1,166-1)+F_data(166,166+1)+F_data(166,166-1)+F_data(166-1,166+1)+F_data(166-1,166)+F_data(166-1,166-1);
mig = mid/9;
figure;
DFT = log(abs(F_data));
imshow(DFT,[])
title('(3)the modified data: F data(166,166)=0');
saveas(gcf,result_path + 'q1b_3','png')

figure;
% F_data = norm(F_data,2);
re_image = abs(ifft2(F_data));
imshow(re_image)
title('(4)reconstructed image: inverted DFT on the result of the modified data: F data(166,166)=0');
saveas(gcf,result_path + 'q1b_4','png')

or_img = im2double(imread('../images/low_contrast.tif'));
img_f = fftshift(fft2(or_img));
mse = norm(re_image-or_img,2);
for i=1:313
    for j=1:313
        if img_f(i,j)~= F_data(i,j)
            fprintf('i=%f,j=%f\n',i,j);
        end
    end
end


    