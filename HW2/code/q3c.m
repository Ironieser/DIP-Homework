clear;close all;clc;
swan = imread('../images/swan.jpg');
% kiener = imread('../images/Kiener.jpg');
result_path = "../result/q3/";
HSV = rgb2hsv(swan);
% HSV = rgb2hsv(kiener);
figure;
subplot(121);imshow(swan);
% subplot(121);imshow(kiener);
V = HSV(:,:,3);
[row,column] = size(V);
V_le = zeros(row,column);

%% calculate L
VX1 = (V*255>150);
L1 = sum(VX1(:))/(513*385);
VX2 = (V*255<50);
L2 = sum(VX2(:))/(513*385);

%%
for i=1:1:row
    for j=1:1:column
        if L1>=0.9
            x=1;
        elseif L2>=0.1
            x=0;
        else
            v = V(i,j)*255;
            x = (v-50)/100;
        end
        V_le(i,j)=cal_vle(V(i,j),x);
    end
end
HSV(:,:,3)=V_le;

subplot(122);imshow(hsv2rgb(HSV));


function vle = cal_vle(V,x)
    vle = (V^(0.75*x+0.25)+0.4*(1-x)*(1-V)+V*(1-x))/2;
end
