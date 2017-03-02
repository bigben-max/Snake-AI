function [path,isright] = BFS(A,start,goal)
global box_w box_h
head=1;             %队列头
tail=1;             %队列尾，开始队列为空，tail==head
queue=start;      %向头中加入图第一个节点
head=head+1;        %队列扩展

flag=start;             %标记某个节点是否访问过了
re=[];              %最终结果
while tail~=head    %判断队列是否为空
    i=queue(tail,1);  %取队尾节点
    j=queue(tail,2);
    if i==goal(1) && j==goal(2)
        break;
    end
    if i>1 && A(i-1,j)~=1 && D2Ddist(queue,[i-1,j])>0     %如果节点相连并且没有访问过
        queue(head,:)=[i-1,j];                          %新节点入列
        head=head+1;                            %扩展队列
%         flag=[flag;i-1,j];                          %对新节点进行标记
        re=[re;i j i-1 j];                            %将边存入结果
    end
    if i<box_w && A(i+1,j)~=1 && D2Ddist(queue,[i+1,j])>0   %如果节点相连并且没有访问过
        queue(head,:)=[i+1,j];                          %新节点入列
        head=head+1;                            %扩展队列
%         flag=[flag; i+1,j];                          %对新节点进行标记
        re=[re;i j i+1 j];                            %将边存入结果
    end
    if j>1 && A(i,j-1)~=1 && D2Ddist(queue,[i,j-1])>0     %如果节点相连并且没有访问过
        queue(head,:)=[i,j-1];                          %新节点入列
        head=head+1;                            %扩展队列
%         flag=[flag; i,j-1];                          %对新节点进行标记
        re=[re;i j i j-1];                            %将边存入结果
    end
    if j<box_h && A(i,j+1)~=1 && D2Ddist(queue,[i,j+1])>0     %如果节点相连并且没有访问过
        queue(head,:)=[i,j+1];                          %新节点入列
        head=head+1;                            %扩展队列
%         flag=[flag; i,j+1];                          %对新节点进行标记
        re=[re;i j i j+1];                            %将边存入结果
    end
    tail=tail+1;            
end
path=[goal];
temp = goal;
isright = 0;
if i~=goal(1) || j~=goal(2)
    isright = 2;
end
while isright==0
    if temp==start
        isright = 1;
        break;
    end
    index = find(re(:,3)==temp(1) & re(:,4)==temp(2));
    path = [path;re(index,1) re(index,2)];
    temp = [re(index,1) re(index,2)];
    
end




