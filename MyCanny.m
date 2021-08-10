function edges = MyCanny(img, sigma, tau)

[row, col] = size(img);

% Smooth with Seperable gausian filter
sz = 5;
k_d1 = [sz 1];
k_d2 = rot90(k_d1, 2);

k_horizontal = fspecial('gaussian',k_d1,sigma); 
k_vertical = fspecial('gaussian',k_d2,sigma);

conv_horizontal = imfilter(img, k_horizontal);
img_smoothe = imfilter(conv_horizontal, k_vertical);

% Compute gradient
h = fspecial('sobel');
im_dy = imfilter(double(img_smoothe), h, 'conv');
im_dx = imfilter(double(img_smoothe), h', 'conv');

% Estimate gradient magnitude and direction
grad = sqrt(im_dx.^2 + im_dy.^2);
dir = atan2(im_dy, im_dx) * (180/pi);

% Non-maximum suppression
img_nms = zeros(row, col);

for i=2:row-1
    for j=2:col-1
       angle = dir(i,j);
       if (angle < 0)
          angle = angle + 180; 
       end
       
       %nearest 45 degree angle 
       n =  45 * round(angle / 45);
       
       switch n
           case 45
               pixel_1 = grad(i+1, j-1);
               pixel_2 = grad(i-1, j+1);
           case 90
               pixel_1 = grad(i+1, j);
               pixel_2 = grad(i-1, j);
           case 135
               pixel_1 = grad(i+1, j+1);
               pixel_2 = grad(i-1, j-1);
           otherwise %0
               pixel_1 = grad(i, j-1);
               pixel_2 = grad(i, j+1);
       end
       
       if (grad(i,j) > pixel_1 && grad(i,j) > pixel_2)
           img_nms(i,j) = img_smoothe(i, j);
       else
           img_nms(i,j) = 0;
       end
    end
end

%thresholding
for i=1 :row
    for j=1 :col
        if (grad(i,j) > tau)
            img_nms(i,j) = 255;
        else
             img_nms(i,j) = 0;
        end
    end
end

edges = img_nms;

end

