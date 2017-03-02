function mapshow = plot_snake(snake , food)
global box_w box_h
mapshow = zeros(box_w,box_h);

for i = 1:size(snake)
    mapshow(snake(i,1),snake(i,2)) = 1;
end

if nargin == 2
    mapshow(food(1,1),food(1,2)) = 2;
end