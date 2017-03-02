%
%       k-omega expansion - E Hasan
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [cand,c]=expand(c,k,b,d,Astar_coord,Astar_connect)

for n=1:k
    try
    [x y]=size(c{n});
    catch
        c{n-1}=[];
        break
    end
    for xc=1:y;
        c{n+1,xc}=find(Astar_connect(c{n}(1,xc),:),b);
        if isempty(c{n+1,xc})
            c{n+1,xc}=[];
            break
        end

        c{n+1,xc}(2,:)=c{n}(1,xc);
        c{n+1,xc}(3,:)=c{n}(3,xc)+round(sqrt((Astar_coord(1,c{n+1,xc}(2,:))-...
            Astar_coord(1,c{n+1,xc}(1,:))).^2+abs(Astar_coord(2,c{n+1,xc}(2,:))...
            -Astar_coord(2,c{n+1,xc}(1,:))).^2));

        c{n+1,xc}(4,:)=abs(Astar_coord(1,d)-Astar_coord(1,c{n+1,xc}(1,:)))...
            +abs(Astar_coord(2,d)-Astar_coord(2,c{n+1,xc}(1,:)));
        c{n+1,xc}(5,:)=c{n+1,xc}(3,:)+c{n+1,xc}(4,:);

    end

end

cand=cat(2,c{:,:});
return;