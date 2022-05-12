clear; close all; clc;
img_path = 'images\fog.jpg';
result='result\';
img = imread(img_path);

subplot(1,3,1);
imshow(img);title('original img');   

Irggb=RGGB(img);
subplot(1,3,2);
imshow(Irggb,[]);title(['Processed Image:RGGB bayer filter']);

defog_img = histeq_impt(Irggb);
subplot(1,3,3);imshow(defog_img,[]);title(['final: by HE']);
function[Ibayer] = RGGB(Irgb)
 
%     Irgb = double(Irgb)/255;
     
    Ibayer = zeros(size(Irgb,1),size(Irgb,2));
     
    Ibayer(1:2:end,1:2:end) = Irgb(1:2:end,1:2:end,1); % copy red(R)
     
    Ibayer(1:2:end,2:2:end) = Irgb(1:2:end,2:2:end,2); % copy green(G)
     
    Ibayer(2:2:end,1:2:end) = Irgb(2:2:end,1:2:end,2); % copy green(G)
     
    Ibayer(2:2:end,2:2:end) = Irgb(2:2:end,2:2:end,3); % copy blue(B)
    return
end
function[I_out] = histeq_impt(I)
    [m,n] = size(I);
    L = 0:255;
    C = zeros(1,256);
    for i = 1:m
        for j = 1:n
            k = I(i,j); 
            C(k+1) = C(k+1)+1;       
        end
    end
    % probability of each inetnsity
    c_prob = C/(m*n);
    % Cummulative sum of probabilities
    cc_prob = cumsum(c_prob);
    % converting these cumulative intensities into integers
    out_int = zeros(1,256);
    for i = 1:256
        out_int(i) = floor(((cc_prob(i) - min(cc_prob))/(1 - min(cc_prob)))*255 + 0.5);
    end
    I_out = zeros(m,n);
    for i = 1:m
        for j = 1:n
            I_out(i,j) = out_int(I(i,j) + 1);
        end
    end
    return 
end