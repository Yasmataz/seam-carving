function new_img = MySeamCarving(img)

    [row, col, dim] = size(img);
    img_grey = rgb2gray(img);

    % Compute Energy
    h = fspecial('sobel');
    im_dy = imfilter(double(img_grey), h, 'conv');
    im_dx = imfilter(double(img_grey), h', 'conv');
    E = sqrt(im_dx.^2 + im_dy.^2);
    
    % Create scoreing matrix
    M = E;
    for i = 2:row
        for j = 1:col
            if j == 1 %edge case
                M(i,j) = E(i,j) + min(M(i-1,j+1), M(i-1,j));
            elseif j == col %edge case
                M(i,j) = E(i,j) + min(M(i-1,j), M(i-1,j-1));
            else 
                M(i,j) = E(i,j) + min(M(i-1,j-1),min(M(i-1,j), M(i-1,j+1)));     
            end
        end
    end
    
    new_img = CarvingHelper(img, M);
      
end

