%
%
%           K - O M E G A   By Emad Hasan
%           
%           Masters Project - RPI Fall 2007
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [komega_path,ts, e_time,dist] = komegaA(Astar_coord, Astar_connect, s, d, k , b, n)
tic;
dist=inf;
komega_path=[];
%%
global exec or co crn;
openlist = [];
closedlist = [];
c=[]; ct=[];
stuck=0;
ts=0; nk=0;
%1. Add the source node to the open list
% G=0; H
if n==0
    H_s=abs(Astar_coord(2,s)-Astar_coord(2,d))+abs(Astar_coord(1,s)...
        -Astar_coord(1,d));
    openlist = [s s 0 H_s 0+H_s]';
    closedlist=[s s 0 H_s 0+H_s]';
    komega_path=[];
else
    c_crn=abs(Astar_coord(2,crn)-Astar_coord(2,crn))+abs(Astar_coord(1,s)...
        -Astar_coord(1,d));
    openlist = [crn crn 0 c_crn c_crn]';
    closedlist=[crn crn 0 c_crn c_crn]';
    komega_path=crn;
end
%% *************************************************************************


    % Do loop until,
    %     * Add the target square to the closed list, in which case the path
    %     has been found (see note below), or * Fail to find the target square,
    %     and the open list is empty. In this case, there is no path.


while (isempty(find(closedlist(1,:)==d, 1)) && ~isempty(openlist))

%%
    %%
    ts=ts+1;
    nk=nk+1;
    

    ct=[];
    x=find(openlist(5,:)==min(openlist(5,:)),1);
    curnode=openlist(1,x); % the node that has the lowest cost

    olindex=find(openlist(1,:)==curnode);
    
    ct=openlist(:,olindex);
    
    % Find out parents
    potcl=[];
    [potcl]=findparents(ct,c);
    [pw,pl]=size(potcl);
    
    olchk=1;
    if ~isempty(closedlist)
        while (isempty(find(closedlist(1,:)==ct(2,1), 1)) && isempty(potcl) && olchk<length(openlist(1,:)))
            % a) Look for the lowest F cost square on the open list. We refer to
            % this as the current square.
            x=find(openlist(5,:)==min(openlist(5,:)),1);
            curnode=openlist(1,x); % the node that has the lowest cost

            olindex=find(openlist(1,:)==curnode);
            ct=openlist(:,olindex);

            % Find out parents
            potcl=[];
            [potcl]=findparents(ct,c);
            [pw,pl]=size(potcl);

            % If parent of node not found in closed list or current tree, drop it
            % from the openlist and find next cost option
            if (isempty(find(closedlist(1,:)==ct(2,1))) && pl==0)
                openlist(:,olindex)=[];
            end
        end
    end
  
   
    
    % b 1) Switch it to the closed list.%
    [clw,lencl]=size(closedlist);
    % add node and its parent to closed list
    closedlist(:,lencl+1)=ct;
    if isempty(potcl)~=1
    closedlist(:,(lencl+2):((lencl+2)+pl-1))=potcl;
    end
    % Remove it from the open list
    openlist(:,olindex)=[];

    % If nk=n, then execute if capable
    
    % If at nth iteration excecute NXT if availabe
    if nk==n
        npath=[]; steps=[];
        nk=0;
        steps(1)=ct(1);
        nd=ct(1);
        npl=2;
        [r,l]=size(closedlist);
        while (nd~=crn && (npl-1)<l);
            x=find(closedlist(1,:)==nd, 1,'last');
            nd=closedlist(2,x);
            steps(npl)=nd;
            if size(steps)>k*n
                stuck=1;
            end
            npl=npl+1;
        end
        if ~isempty(find(steps==crn, 1))
            npath=fliplr(steps);
            [done]=execnxt(npath);
            npath(1)=[];
            komega_path=cat(2,komega_path,npath);
        else
            npath=[];
        end
       openlist=[];
       c_crn=abs(Astar_coord(2,crn)-Astar_coord(2,crn))+abs(Astar_coord(1,s)...
                -Astar_coord(1,d));
            if stuck
       closedlist=[crn crn 0 c_crn c_crn]';
       stuck=0;
       Astar_connect(:,crn)=0;
            end
    end

   
    %if ~isempty(openlist)
        clear c;
        c{1}=ct;
        % c) For b of the squares adjacent to this current square …
        %       If it is not walkable or if it is on the closed list, ignore it.
        %     *
        [cand,c]=expand(c,k,b,d,Astar_coord,Astar_connect);
        [w,l]=size(cand(1,:));
        cnn=length(cand(1,:));
        while (cnn>0)   % Remove from list if on closed list already
%             if cnn>length(cand(1,:))
%                 break;
%             end
            cndl=find(cand(1,cnn)==closedlist(1,:), 1);
            if ~isempty(cndl)
                cand(:,cnn)=[];
            end
            cnn=cnn-1;
        end

    

    %%


    %%
    % Otherwise do the following.
    [w,l]=size(cand(1,:));
    for cn2=1:l

        if ~isempty(openlist)
        isinol=find(openlist(1,:)==cand(1,cn2));
        else
            isinol=[];
        end
        %       If it isn’t on the open list, add it to the open list. Make the
        %       current square the parent of this square. Record the F, G, and H
        %       costs of the square.
        if isempty(isinol)==1
            [widop,lenol]=size(openlist);
            openlist(:,lenol+1)=cand(:,cn2);
        end
            %
            %       If it is on the open list already, check to see if this path to
            %       that square is better, using G cost as the measure. A lower G cost
            %       means that this is a better path. If so, change the parent of the
            %       square to the current square, and recalculate the G and F scores of
            %       the square. If you are keeping your open list sorted by F score,
            %       you may need to resort the list to account for the change.

            if cand(3,cn2)<openlist(3,isinol)
                openlist(:,isinol)=cand(:,cn2);
            end
            
            if (cand(1,cn2)==openlist(1,isinol) & cand(3:5,cn2)==openlist(3:5,isinol))
                    % Caculate H for the open list
            
                    cndc=abs(Astar_coord(1,d)-Astar_coord(1,cand(2,cn2)))...
                            +abs(Astar_coord(2,d)-Astar_coord(2,cand(2,cn2)));
                   
                    olc=abs(Astar_coord(1,d)-Astar_coord(1,openlist(2,isinol)))...
                                +abs(Astar_coord(2,d)-Astar_coord(2,openlist(2,isinol)));
                    if cndc<olc
                        openlist(:,isinol)=cand(:,cn2);
                    end
            end
    end
    
%%


  

end  % End While
% ************************************************************************



% % 3) Save the path. Working backwards from the target square, go from
% each square to its parent square until you reach the starting square.
% That is your path. 
if ~(isempty(openlist))
    dist=closedlist(3,find(closedlist(1,:)==d, 1));
    if (n==0)
        steps(1)=d;
        nd=d;
        npl=2;
        while nd~=s
            x=find(closedlist(1,:)==nd, 1);
            nd=closedlist(2,x);
            steps(npl)=nd;
            npl=npl+1;
        end
        komega_path=fliplr(steps);
    else
        if crn~=d
                npath=[]; steps=[];
        nk=0;
        steps(1)=ct(1);
        nd=ct(1);
        npl=2;
        [r,l]=size(closedlist);
        while (nd~=crn && (npl-1)<l);
            x=find(closedlist(1,:)==nd, 1,'last');
            nd=closedlist(2,x);
            steps(npl)=nd;
            if size(steps)>k*n
                stuck=1;
            end
            npl=npl+1;
        end
        if ~isempty(find(steps==crn, 1))
            npath=fliplr(steps);
            [done]=execnxt(npath);
            npath(1)=[];
            komega_path=cat(2,komega_path,npath);
        else
            npath=[];
        end
        end
    end
end

e_time=toc;
return;
    


