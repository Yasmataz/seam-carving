function new_img = CarvingHelper(img,M)
    
    [row, col] = size(M);
    bottom_row = M(row, :);
    [min_bottom, index_min] = min(bottom_row);
    
    %remove seam from bottom row of image
    bottom_row_red = img(row, :, 1);
    bottom_row_green = img(row, :, 2);
    bottom_row_blue = img(row, :, 3);

    bottom_row_red(index_min) = [];
    bottom_row_green(index_min) = [];
    bottom_row_blue(index_min) = [];

    seam(row, :, 1) = bottom_row_red;
    seam(row, :, 2) = bottom_row_green;
    seam(row, :, 3) = bottom_row_blue;
    
    for i = row:-1:2
        comp_arr = [M(i-1, index_min)];
        
        % Find minimum neighbour value
        if (index_min - 1 >= 1)
            top_left_pixel = M(i-1, index_min - 1);
            comp_arr = [comp_arr, top_left_pixel];
        else
            comp_arr = [comp_arr, comp_arr]; % dummy value :(
        end
        
        if (1 + index_min <= col)
            top_right_pixel = M(i-1, index_min + 1);
            comp_arr = [comp_arr, top_right_pixel];
        end
                
        [min_value, neighbour_index] = min(comp_arr);
        
        % Get index of minimum neighbour from row above
        switch neighbour_index               
            case 2
                index_min = index_min - 1;
            case 3
                index_min = index_min + 1;
        end
        
        % Remove seam - delete element at min_index from row and add new row to new image
        upper_row_red = img(i-1, :, 1);
        upper_row_green = img(i-1, :, 2);
        upper_row_blue = img(i-1, :, 3);

        % Remove element at min index
        upper_row_red(index_min) = [];
        upper_row_green(index_min) = [];
        upper_row_blue(index_min) = [];

        % New image
        seam(i-1, :, 1) = upper_row_red;
        seam(i-1, :, 2) = upper_row_green;
        seam(i-1, :, 3) = upper_row_blue;
    end
    
    new_img = seam;
end

