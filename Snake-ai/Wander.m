function nextstep = Wander(food,snake)
global box_w box_h
i=snake(end,1);  
j=snake(end,2);  
iserror=0;
if i>2
    iserror = Is_wrong(i-1,j,food,snake);
end
if iserror ~= 1 && i<box_w-1
    iserror = Is_wrong(i+1,j,food,snake);
elseif iserror == 1 
    nextstep = [i-1,j];
    return;
end
if iserror ~= 1 && j>2
    iserror = Is_wrong(i,j-1,food,snake);
elseif iserror >= 1 
    nextstep = [i+1,j];
    return;
end
if iserror ~= 1 && j<box_h-1
    iserror = Is_wrong(i,j+1,food,snake);
elseif iserror == 1
    nextstep = [i,j-1];
    return;
end
if iserror == 1
    nextstep = [i,j+1];
    return;
end