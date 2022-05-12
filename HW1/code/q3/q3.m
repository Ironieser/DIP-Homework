clear; close all; clc;
img_path = 'images\bin.tif';
result='result\';
img = imread(img_path);

% subplot(1,3,1);
% imshow(img);title('original img');   
I = img;
connect_type = 8;
[height,width] = size(I);
L=imbinarize(I);

L = uint8(L);
for i = 1:height
    for j = 1:width
        if L(i,j) == 1
            L(i,j) = 255;%把白色像素点像素值赋值为255
        end
    end
end
MAXSIZE = 999999;
Q = zeros(MAXSIZE,2);
front = 1;
rear = 1;
flag = 0;

for i = 1:height
    for j = 1:width
        if L(i,j) == 255
            if front == rear
                flag = flag+1;
            end
            L(i,j) = flag;
            Q(rear,1) = i;
            Q(rear,2) = j;
            rear = rear+1;
            while front ~= rear

                temp_i = Q(front,1);
                temp_j = Q(front,2);
                front = front + 1;

                
                if(connect_type==8)
                    if(((temp_i - 1)>0)&&((temp_j - 1)>0))

                        if L(temp_i - 1,temp_j - 1) == 255
                            L(temp_i - 1,temp_j - 1) = flag;
                            Q(rear,1) = temp_i - 1;
                            Q(rear,2) = temp_j - 1;
                            rear = rear + 1;
                        end
                    end
                    if(((temp_i - 1)>0)&&((temp_j + 1)<=width))
                        %右上方的像素点
                        if L(temp_i - 1,temp_j + 1) == 255
                            L(temp_i - 1,temp_j + 1) = flag;
                            Q(rear,1) = temp_i - 1;
                            Q(rear,2) = temp_j + 1;
                            rear = rear + 1;
                        end
                    end
                    if(((temp_i + 1)<=height)&&((temp_j - 1)>0))

                        if L(temp_i + 1,temp_j - 1) == 255
                            L(temp_i + 1,temp_j - 1) = flag;
                            Q(rear,1) = temp_i + 1;
                            Q(rear,2) = temp_j - 1;
                            rear = rear + 1;
                        end
                    end
                    if(((temp_i + 1)<=height)&&((temp_j + 1)<=width))
    
                        if L(temp_i + 1,temp_j + 1) == 255
                            L(temp_i + 1,temp_j + 1) = flag;
                            Q(rear,1) = temp_i + 1;
                            Q(rear,2) = temp_j + 1;
                            rear = rear + 1;
                        end
                    end
                end
                
                
                if(((temp_i - 1)>0)&&((temp_j )>0))
                    %正上方的像素点
                    if L(temp_i - 1,temp_j) == 255
                        L(temp_i - 1,temp_j) = flag;
                        Q(rear,1) = temp_i - 1;
                        Q(rear,2) = temp_j;
                        rear = rear + 1;
                    end
                end
                if(((temp_i )>0)&&((temp_j - 1)>0))
             
                    if L(temp_i,temp_j - 1) == 255
                        L(temp_i,temp_j - 1) = flag;
                        Q(rear,1) = temp_i;
                        Q(rear,2) = temp_j - 1;
                        rear = rear + 1;
                    end
                end
                if(((temp_i )>0)&&((temp_j + 1)<=width))
       
                    if L(temp_i,temp_j + 1) == 255
                        L(temp_i,temp_j + 1) = flag;
                        Q(rear,1) = temp_i;
                        Q(rear,2) = temp_j + 1;
                        rear = rear + 1;
                    end
                end
                if(((temp_i + 1)<=height)&&((temp_j )>0))
          
                    if L(temp_i + 1,temp_j) == 255
                        L(temp_i + 1,temp_j) = flag;
                        Q(rear,1) = temp_i + 1;
                        Q(rear,2) = temp_j;
                        rear = rear + 1;
                    end
                end
            end
        end
    end
end


index= 1+1;
figure(index);
for i=1:151
    pos = mod(i,51);
    if pos == 0
        index = index + 1;
        figure(index);
        pos = 1;
    end
    subplot(5,10,pos);
    imshow(L == i);title(num2str(i));
end

