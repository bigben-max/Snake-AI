function flag = Is_wrong(x,y,food,snake)
global box_w box_h
if x == food(1) && y == food(2)
    flag = 2;
else
    flag = 1;
    for i=1:size(snake)
        if x == snake(i,1) && y == snake(i,2)
            flag = 0;
        end
    end
    if x>box_w || y>box_h || x<1 || y<1
        flag = 3;
    end
end