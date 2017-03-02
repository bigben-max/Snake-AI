function [path,isright] = BFS(A,start,goal)
global box_w box_h
head=1;             %����ͷ
tail=1;             %����β����ʼ����Ϊ�գ�tail==head
queue=start;      %��ͷ�м���ͼ��һ���ڵ�
head=head+1;        %������չ

flag=start;             %���ĳ���ڵ��Ƿ���ʹ���
re=[];              %���ս��
while tail~=head    %�ж϶����Ƿ�Ϊ��
    i=queue(tail,1);  %ȡ��β�ڵ�
    j=queue(tail,2);
    if i==goal(1) && j==goal(2)
        break;
    end
    if i>1 && A(i-1,j)~=1 && D2Ddist(queue,[i-1,j])>0     %����ڵ���������û�з��ʹ�
        queue(head,:)=[i-1,j];                          %�½ڵ�����
        head=head+1;                            %��չ����
%         flag=[flag;i-1,j];                          %���½ڵ���б��
        re=[re;i j i-1 j];                            %���ߴ�����
    end
    if i<box_w && A(i+1,j)~=1 && D2Ddist(queue,[i+1,j])>0   %����ڵ���������û�з��ʹ�
        queue(head,:)=[i+1,j];                          %�½ڵ�����
        head=head+1;                            %��չ����
%         flag=[flag; i+1,j];                          %���½ڵ���б��
        re=[re;i j i+1 j];                            %���ߴ�����
    end
    if j>1 && A(i,j-1)~=1 && D2Ddist(queue,[i,j-1])>0     %����ڵ���������û�з��ʹ�
        queue(head,:)=[i,j-1];                          %�½ڵ�����
        head=head+1;                            %��չ����
%         flag=[flag; i,j-1];                          %���½ڵ���б��
        re=[re;i j i j-1];                            %���ߴ�����
    end
    if j<box_h && A(i,j+1)~=1 && D2Ddist(queue,[i,j+1])>0     %����ڵ���������û�з��ʹ�
        queue(head,:)=[i,j+1];                          %�½ڵ�����
        head=head+1;                            %��չ����
%         flag=[flag; i,j+1];                          %���½ڵ���б��
        re=[re;i j i j+1];                            %���ߴ�����
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




