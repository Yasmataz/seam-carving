function [outputArg1] = MyConv(img,kernel)

[row, col] = size(img);
[row_k, col_k] = size(kernel);

% flip the kernel
kernel = rot90(kernel, 2);

% pad the image
x_pad = fix(row_k/2);
y_pad = fix(col_k/2);

img_pad = padarray(img, [y_pad,x_pad], 0, 'both');

img_conv = img;
total = 0;
for i = 1 : row
    for j = 1 : col
        for k = 1: row_k
            for m = 1 : col_k
                x = kernel(k, m) * img_pad(i + k - 1 , j + m - 1);
                total = total + x;
            end;
        end;
        img_conv(i, j) = total;
        total = 0;
    end;
end

outputArg1 = img_conv;
