%% Part 1
% 1
fprintf("PART 1.1\n\n")
table = [-5 0 0 0 0 0 0 0 0 0;
            0 0 0 0 0 0 0 0 0 0;
            0 0 -7 2 1 1 3 0 0 0;
            0 0 0 1 1 1 1 0 0 0;
            0 0 0 3 1 1 5 0 0 0;
            0 0 0 -1 -1 -1 -1 0 0 0;
            0 0 0 1 2 3 4 0 0 0;
            0 0 0 0 0 0 0 0 0 0;
            0 0 0 0 0 0 0 0 0 0];
        
result = [0 5 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0;
        0 -7 2 8 -1 2 -1 -3 0 0;
        0 0 1 1 0 0 -1 -1 0 0;
        0 0 3 1 -2 4 -1 -5 0 0;
        0 0 -1 -1 0 0 1 1 0 0;
        0 0 1 2 2 2 -3 -4 0 0;
        0 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0 0];
    
sz = size(result,2)-1;
fmt = [repmat('%2d ', 1, sz ), '%2d\n'];

fprintf("Hand calculated results for the convolution are:\n");
fprintf(fmt, result.'); 

fprintf("press Enter to continue..........\n\n");
pause;

% 2
fprintf("PART 1.2\n\n")

im_dy = imfilter(double(table), h, 'conv');
im_dx = imfilter(double(table), h', 'conv');
grad = sqrt(im_dx.^2 + im_dy.^2);

r1 = grad(3,4);
r2 = grad(5,4);
r3 = grad(5,7);

fprintf('gradient at [2,3] is %.3f\n',r1);
fprintf('gradient at [4,3] is %.3f\n',r2);
fprintf('gradient at [4,6] is %.3f\n',r3);

fprintf("press Enter to continue..........\n\n");
pause;

% 4
fprintf("PART 1.4\n\n")

img = imread('balls.png');
img_grey = rgb2gray(img);

k = fspecial('gaussian',13,2);

myConv = MyConv(img_grey, k);
figure;
imshow(myConv);
title('Convolution using MyConv');

realConv = imfilter(img_grey, k, 'conv');
figure;
imshow(realConv);
title('Convolution using imfilter');

conv_diff = abs(myConv - realConv);
figure;
imshow(conv_diff);
title('Difference between convolved images');

fprintf("The majority of the difference is 0. There are some 1 values, this can be attributed to rounding differences\n");

fprintf("press Enter to continue..........\n\n");
pause;

% 5
fprintf("PART 1.5\n\n")

img = imread("balls.png");
img_grey = rgb2gray(img);

sigma = 8;
sz = 49;

k_d1 = [sz 1];
k_d2 = rot90(k_d1, 2);

k = fspecial('gaussian',sz,sigma); 
k_horizontal = fspecial('gaussian',k_d1,sigma); 
k_vertical = fspecial('gaussian',k_d2,sigma); 

fprintf("Non-seperable filter convolution:\n");
tic;
imfilter(img_grey, k);
toc;

fprintf("\n\nSeperable filter convolution:\n");
tic;
conv_horizontal = imfilter(img_grey, k_horizontal);
conv_seperable = imfilter(conv_horizontal, k_vertical);
toc;

fprintf("\n\nThe time for the seperable filteris significantly smaller. This is because a seperable filter\n");
fprintf("requires (M+N)(n+m) operations vs. M x N x n x m operations in a non-seperable filter\n");


fprintf("press Enter to continue..........\n\n");
pause;

%% Part 2
% 1
fprintf("PART 2.1\n\n")

img = rgb2gray(imread("bowl-of-fruit.jpg"));
sigma = .5;
tau = 60;

img_edge = MyCanny(img, sigma, tau);
figure;
imshow(img_edge);
title("Edge detection - fruit bowl");

img = rgb2gray(imread("puppies.jpg"));
sigma = .5;
tau = 150;

img_edge = MyCanny(img, sigma, tau);
figure;
imshow(img_edge);
title("Edge detection - puppies");

fprintf("press Enter to continue..........\n\n");
pause;


%% Part 3 
fprintf("PART 3\n\n")

% Image 1
img = imread("ryerson.jpg");
figure;
imshow(img);
title("Original Image, 720X480")
verticle_seams = 80;
horizontal_seams = 0;

for i = 1 : verticle_seams
    new_img = MySeamCarving(img);
    img = new_img;
end

img = rot90(img);

for i = 1 : horizontal_seams
    new_img = MySeamCarving(img);
    img = new_img;
end

img = rot90(img,3);
figure;
imshow(img);
title("640X480 Image");


% Image 2
img = imread("ryerson.jpg");
verticle_seams = 0;
horizontal_seams = 160;

for i = 1 : verticle_seams
    new_img = MySeamCarving(img);
    img = new_img;
end

img = rot90(img);

for i = 1 : horizontal_seams
    new_img = MySeamCarving(img);
    img = new_img;
end

img = rot90(img,3);
figure;
imshow(img);
title("720X320 Image");

% Image 3
img = imread("puppies.jpg");
figure;
imshow(img);
title("Original Image - 640X480");

verticle_seams = 160;
horizontal_seams = 50;

for i = 1 : verticle_seams
    new_img = MySeamCarving(img);
    img = new_img;
end

img = rot90(img);

for i = 1 : horizontal_seams
    new_img = MySeamCarving(img);
    img = new_img;
end

img = rot90(img,3);
figure;
imshow(img);
title("480X640 resized to 430X480 Image");
