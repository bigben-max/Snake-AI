%
%
%           A - S T A R   By Emad Hasan
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Astar_path, ts, e_time] = Astar(Astar_coord, Astar_connect, s, d);
tic;
%%
openlist = [];

closedlist = [];

%1. Add the source node to the open list

openlist = [s s 0]';




% Define what is targe is in closed list (tiscl)
tiicl=0;
openlempty=0; ts=0;
%%



while ( tiicl==0 || openlempty==0)
    
%%
    ts=ts+1;
    [widop,lenol]=size(openlist);
    olcst=zeros(4,lenol);
    % Generate Cost function for Open list (open list cost) storing G H F
    olcst(1,:)=openlist(1,:);
    % Calculate G for the Open list
    d2cost=abs(Astar_coord(:,openlist(2,:))-Astar_coord(:,openlist(1,:)));
    olcst(2,:)=d2cost(1,:)+d2cost(2,:)+openlist(3,:);
    % Caculate H for the open list
    d2cost=Astar_coord(:,d)*ones(1,lenol)-Astar_coord(:,openlist(1,:));
    olcst(3,:)=abs(d2cost(1,:)+d2cost(2,:));
    % Calculate F = G + H
    olcst(4,:)=olcst(2,:)+olcst(3,:);
 
    
    % a) Look for the lowest F cost square on the open list. We refer to
    % this as the current square. 
    x=find(olcst(4,:)==min(olcst(4,:)),1);
    curnode=olcst(1,x); % the node that has the lowest cost
    
    olindex=find(openlist(1,:)==curnode);
    curnodecst=openlist(3,olindex);
    
  % b) Switch it to the closed list.% 
    [clw,lencl]=size(closedlist);
    % add node and its parent to closed list
    closedlist(:,lencl+1)=[olcst(1,x) openlist(2,olindex) openlist(3,olindex)]';
    % Remove it from the open list
    openlist(:,olindex)=[];
    
        
% c) For each of the squares adjacent to this current square …
%       If it is not walkable or if it is on the closed list, ignore it.            
%     *        
       [cand]=find(Astar_connect(curnode,:)); % Walkable nodes from cur node
      
       for cnn=1:length(cand)   % Remove from list if on closed list already
           if cnn>length(cand)
               break;
           end
           cndl=find(cand(cnn)==closedlist(1,:), 1); 
           if isempty(cndl)~=1
               cand(cnn)=[];
           end
       end


% Otherwise do the following.
        for cn2=1:length(cand)
        
        isinol=find(openlist(1,:)==cand(cn2));
%       If it isn’t on the open list, add it to the open list. Make the
%       current square the parent of this square. Record the F, G, and H
%       costs of the square. 
        if isempty(isinol)==1
            candcst=curnodecst+abs(Astar_coord(2,cand(cn2))-...
                Astar_coord(2,curnode)+Astar_coord(1,cand(cn2))-...
                Astar_coord(1,curnode))+abs(Astar_coord(2,cand(cn2))...
                -Astar_coord(2,d)+Astar_coord(1,cand(cn2)...
                )-Astar_coord(1,d));
            [widop,lenol]=size(openlist);
            openlist(:,lenol+1)=[cand(cn2) curnode candcst]';
        end 
% 
%       If it is on the open list already, check to see if this path to
%       that square is better, using G cost as the measure. A lower G cost
%       means that this is a better path. If so, change the parent of the
%       square to the current square, and recalculate the G and F scores of
%       the square. If you are keeping your open list sorted by F score,
%       you may need to resort the list to account for the change.
        gcurnode=abs(Astar_coord(2,curnode)...
                -Astar_coord(2,d)+Astar_coord(1,curnode...
                )-Astar_coord(1,d));
        goldp=abs(Astar_coord(2,openlist(2,isinol))...
                -Astar_coord(2,d)+Astar_coord(1,openlist(2,isinol)...
                )-Astar_coord(1,d));
        if gcurnode<=goldp
            openlist(2,isinol)=curnode;
            openlist(3,isinol)=curnodecst+abs(Astar_coord(2,cand(cn2))-...
                Astar_coord(2,curnode)+Astar_coord(1,cand(cn2))-...
                Astar_coord(1,curnode))+abs(Astar_coord(2,cand(cn2))...
                -Astar_coord(2,d)+Astar_coord(1,cand(cn2)...
                )-Astar_coord(1,d));
        end
        
        end 
%%
        
% Do loop until,
%     * Add the target square to the closed list, in which case the path
%     has been found (see note below), or * Fail to find the target square,
%     and the open list is empty. In this case, there is no path.
   
    if ~isempty(find(closedlist(1,:)==d, 1))
        tiicl=1;
    end
    if ~isempty(openlist==0)
        openlempty=1;
    end
end
% % 3) Save the path. Working backwards from the target square, go from
% each square to its parent square until you reach the starting square.
% That is your path. 
steps(1)=d;
nd=d;
n=2;
while nd~=s
    x=find(closedlist(1,:)==nd, 1);
    nd=closedlist(2,x);
    steps(n)=nd;
    n=n+1;
end
Astar_path=fliplr(steps);
e_time=toc;
    
