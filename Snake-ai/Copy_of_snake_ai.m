% Map = zeros(200,200);
clear 
close all

global box_w box_h
box_w = 100;
box_h = 100;
snake = [1,1;2,1];
orient = 0;
tempo = 0;
food = food_position(snake);
Map = plot_snake(snake , food);
figure('keypressfcn','fprintf('' ·½Ïò¼üÎª%c¼ü\n'',get(gcf,''currentcharacter''))')
axis equal
hold on 
imshow(Map);
title(['ó«òë°æÌ°³ÔÉß£¡µÃ·Ö£º',num2str(size(snake,1)-2)]);
while 1
%     if strcmpi(get(gcf,'CurrentCharacter'),'a')
%         tempo = 1;
%     elseif strcmpi(get(gcf,'CurrentCharacter'),'s')
%         tempo = 2;
%     elseif strcmpi(get(gcf,'CurrentCharacter'),'w')
%         tempo = 3;
%     elseif strcmpi(get(gcf,'CurrentCharacter'),'d')
%         tempo = 4;
%     elseif strcmpi(get(gcf,'CurrentCharacter'),'q')
%         break;
    if strcmpi(get(gcf,'CurrentCharacter'),'')
        disp('stop');
        while 1
            if strcmpi(get(gcf,'CurrentCharacter'),'')
                pause(1);
            else
                break;
            end
        end
        disp('begin');
    elseif strcmpi(get(gcf,'CurrentCharacter'),'q')
        break;
    end
    pause(0.001);
%     if orient==1 
%         if tempo~=4
%             orient = tempo;
%         end
%     elseif orient==2
%         if tempo~=3
%             orient = tempo;
%         end
%     elseif orient==3
%         if tempo~=2
%             orient = tempo;
%         end
%     elseif orient==4
%         if tempo~=1
%             orient = tempo;
%         end
%     elseif orient==0
%         orient = tempo;
%     end
%     if orient == 1
    [path,Is] = BFS(Map,snake(end,:),food);
    if Is==2
        vMap = plot_snake(snake ,snake(1,:));
        [path,Is] = BFS(vMap,snake(end,:),snake(1,:));
        if Is==2
            path = Wander(food,snake);
            tempsanke_x = path(1,1);
            tempsanke_y = path(1,2);
        else
            tempsanke_x = path(end-1,1);
            tempsanke_y = path(end-1,2);
        end
    else
        length = size(snake,1);
        flippath = flip(path);
        pathsnake = [snake;flippath(2:end,:)];
        vsnake = pathsnake(end-length:end,:);
        vMap = plot_snake(vsnake ,vsnake(1,:));
        [path2,Is2] = BFS(vMap,vsnake(end,:),vsnake(1,:));
        if Is2==2
            vMap = plot_snake(snake ,snake(1,:));
            [path3,Is3] = BFS(vMap,snake(end,:),snake(1,:));
            if Is3==2
                path3 = Wander(food,snake);
                tempsanke_x = path3(1,1);
                tempsanke_y = path3(1,2);
            else
                tempsanke_x = path3(end-1,1);
                tempsanke_y = path3(end-1,2);
            end
        else
            tempsanke_x = path(end-1,1);
            tempsanke_y = path(end-1,2);
        end
    end
        tsnake = snake(2:end,:);
        is_error = Is_wrong(tempsanke_x,tempsanke_y,food,tsnake);
        if is_error == 0
            break;
        elseif is_error == 1
            snake = [snake(2:end,:);tempsanke_x,tempsanke_y];
        elseif is_error == 2
            snake = [snake;tempsanke_x,tempsanke_y];
            food = food_position(snake);
        elseif is_error == 3
            if tempsanke_x>box_w 
                tempsanke_x = tempsanke_x - box_w;
            elseif tempsanke_x<1
                tempsanke_x = tempsanke_x + box_w;
            end 
            if tempsanke_y>box_h 
                tempsanke_y = tempsanke_y - box_h;
            elseif tempsanke_y<1
                tempsanke_y = tempsanke_y + box_h;
            end 
            snake = [snake(2:end,:);tempsanke_x,tempsanke_y];
        end
%     elseif orient == 2
%         tempsanke_x = snake(end,1)+1;
%         tempsanke_y = snake(end,2);
%         is_error = Is_wrong(tempsanke_x,tempsanke_y,food,snake);
%         if is_error == 0
%             break;
%         elseif is_error == 1
%             snake = [snake(2:end,:);tempsanke_x,tempsanke_y];
%         elseif is_error == 2
%             snake = [snake;tempsanke_x,tempsanke_y];
%             food = food_position(snake);
%         elseif is_error == 3
%             if tempsanke_x>box_w 
%                 tempsanke_x = tempsanke_x - box_w;
%             elseif tempsanke_x<1
%                 tempsanke_x = tempsanke_x + box_w;
%             end 
%             if tempsanke_y>box_h 
%                 tempsanke_y = tempsanke_y - box_h;
%             elseif tempsanke_y<1
%                 tempsanke_y = tempsanke_y + box_h;
%             end 
%             snake = [snake(2:end,:);tempsanke_x,tempsanke_y];
%         end
%     elseif orient == 3
%         tempsanke_x = snake(end,1)-1;
%         tempsanke_y = snake(end,2);
%         is_error = Is_wrong(tempsanke_x,tempsanke_y,food,snake);
%         if is_error == 0
%             break;
%         elseif is_error == 1
%             snake = [snake(2:end,:);tempsanke_x,tempsanke_y];
%         elseif is_error == 2
%             snake = [snake;tempsanke_x,tempsanke_y];
%             food = food_position(snake);
%         elseif is_error == 3
%             if tempsanke_x>box_w 
%                 tempsanke_x = tempsanke_x - box_w;
%             elseif tempsanke_x<1
%                 tempsanke_x = tempsanke_x + box_w;
%             end 
%             if tempsanke_y>box_h 
%                 tempsanke_y = tempsanke_y - box_h;
%             elseif tempsanke_y<1
%                 tempsanke_y = tempsanke_y + box_h;
%             end 
%             snake = [snake(2:end,:);tempsanke_x,tempsanke_y];
%         end
%     elseif orient == 4
%         tempsanke_x = snake(end,1);
%         tempsanke_y = snake(end,2)+1;
%         is_error = Is_wrong(tempsanke_x,tempsanke_y,food,snake);
%         if is_error == 0
%             break;
%         elseif is_error == 1
%             snake = [snake(2:end,:);tempsanke_x,tempsanke_y];
%         elseif is_error == 2
%             snake = [snake;tempsanke_x,tempsanke_y];
%             food = food_position(snake);
%         elseif is_error == 3
%             if tempsanke_x>box_w 
%                 tempsanke_x = tempsanke_x - box_w;
%             elseif tempsanke_x<1
%                 tempsanke_x = tempsanke_x + box_w;
%             end 
%             if tempsanke_y>box_h 
%                 tempsanke_y = tempsanke_y - box_h;
%             elseif tempsanke_y<1
%                 tempsanke_y = tempsanke_y + box_h;
%             end 
%             snake = [snake(2:end,:);tempsanke_x,tempsanke_y];
%         end
%     end
    Map = plot_snake(snake , food);
    hold on 
    imshow(Map);
    title(['ó«òë°æÌ°³ÔÉß£¡µÃ·Ö£º',num2str(size(snake,1)-2)]);
    
end
