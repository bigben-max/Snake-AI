function food_pos = food_position(snake)
global box_w box_h
flag = 0;
while flag == 0
    food_x = round(rand(1,1)*(box_w-1))+1;
    food_y = round(rand(1,1)*(box_h-1))+1;
    flag = 1;
    for i = 1:size(snake)
        if snake(i,1) == food_x && snake(i,2) == food_y
            flag = 0;
        end
    end
end
food_pos = [food_x, food_y];