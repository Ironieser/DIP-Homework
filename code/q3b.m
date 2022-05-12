clear;close all;clc;
swan = imread('../images/diana.jpg');
% kiener = imread('../images/Kiener.jpg');
result_path = "../result/q3/";
HSV = rgb2hsv(swan);
% HSV = rgb2hsv(kiener);
figure;
subplot(421);imshow(swan);title('original image');
subplot(422);imshow(HSV);title('HSV image');
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
subplot(324);imshow(HSV);title('HSV: After Luminance Enhancement');
subplot(323);imshow(hsv2rgb(HSV));title('RGB: After Luminance Enhancement');

%%
% temp_V = V;
% sigma = 1.5;  
% G = fspecial('gaussian', 3, sigma);
% Vc = imfilter(V,G,'conv','replicate','same');
% sigma = std(V(:));
% if sigma <=3
%     p=3;
% elseif sigma>3 && sigma<10
%     p=(27-2*sigma)/7;
% else
%     p =1;
% end
% E = (Vc./temp_V).^p;
% Vce = V_le.^E;
% HSV(:,:,3) = Vce;
% subplot(326);imshow(HSV);title('HSV: After Luminance and Contrast');
% subplot(325);imshow(hsv2rgb(HSV));title('RGB: After Luminance and Contrast');
% saveas(gcf,result_path + 'q3_demo','png');
%% by myself
% gas
sigma1=2;
k=5;    % kernel大小
pai=3.1415926;
kernel=zeros(k);
m=(k+1)/2;
sigma=2*sigma1*sigma1;
for i=-1*(k-1)/2:(k-1)/2
   for j=-1*(k-1)/2:(k-1)/2
      kernel(i+m,j+m)=(-1/(pai*sigma))*exp(-1*(i^2+j^2)/(sigma));
   end
end
kernel=kernel./sum(kernel,'all');

temp_V = V;
sigma = 1.5;  %设定标准差值，该值越大，滤波效果（模糊）愈明显
window = double(uint8(3*sigma)*2 + 1);  %设定滤波模板尺寸大小
%fspecial('gaussian', hsize, sigma)产生滤波掩模
G = fspecial('gaussian',5, sigma);
Vc = conv2D(G,V);
% Vc = imfilter(V,G,'conv','replicate','same');
V_std = std(V(:));
if V_std <=3
    p=3;
elseif V_std>3 && V_std<10
    p=(27-2*V_std)/7;
else
    p =1;
end
E = (Vc./temp_V).^p;
Vce = V_le.^E;
HSV(:,:,3) = Vce;
figure;
subplot(326);imshow(HSV);title('HSV: After Luminance and Contrast');
subplot(325);imshow(hsv2rgb(HSV));title('RGB: After Luminance and Contrast');
saveas(gcf,result_path + 'q3_demo','png');
%%

function result=conv2D(x,data)
    [row_x,col_x] = size(x);
    [row_data,col_data] = size(data);


    % 核的中心元素:
    centerx_row = round(row_x/2);
    centerx_col = round(col_x/2);
    centerx = x(centerx_row,centerx_col);
    % 对原始数据扩边:
    data_tmp = zeros(row_data+row_x-1,col_data+row_x-1);
    data_tmp(centerx_row:centerx_row+row_data-1,centerx_col:centerx_col+col_data-1) = data;
    data_k = data_tmp;
    % 扩边后新数据矩阵尺寸:
    size_data_k = size(data_k);
    row_data_k = size_data_k(1);
    col_data_k = size_data_k(2);

    % m = centerx_row:row_data+row_x-2
    % 开始卷积计算: m n 是新数据矩阵的正常索引
    result = zeros(row_data_k,col_data_k);
    % m n一般卷积步长都是1
    for m = centerx_row:centerx_row+row_data-1
        for n = centerx_row:centerx_row+col_data-1
            % tt是临时与卷积核大小相同的数据中的部分矩阵:
            tt = data_k(m-(centerx_row-1):m+(centerx_row-1),n-(centerx_col-1):n+(centerx_col-1));
            % juan是中间每一次卷积计算求和的中间量:
            juan = sum(x.*tt);
            result(m,n) = sum(juan(:));
        end
    end

    % 求掉之前扩边的0:
    result = result(centerx_row:centerx_row+row_data-1,centerx_col:centerx_col+col_data-1);

end
function rgb = H2R(hsv)
    rgb = hsv2rgb(hsv);
end
%% 
function vle = cal_vle(V,x)
    vle = (V^(0.75*x+0.25)+0.4*(1-x)*(1-V)+V*(1-x))/2;
end
