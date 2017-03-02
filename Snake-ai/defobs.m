%
%
%
%
%
function o=defobs(nooc,noor,R,GTS,s,d,o)

%%
%%

noOfNodes  = nooc*noor;
nodmat=ones(nooc,noor,3);
nodmat(1:noOfNodes)=1:noOfNodes;
nodmat(:,:,2)=(find(nodmat(:,2,2)==1))*ones(1,noor);
nodmat(:,:,3)=ones(nooc,1)*(find(nodmat(2,:,3)==1));
nodmat(:,:,1)=flipdim((nodmat(:,:,1)),2);
nodmat(:,:,2)=flipdim((nodmat(:,:,2)),2);
nodmat(:,:,3)=flipdim((nodmat(:,:,3)),2);
noddata=reshape(nodmat,noOfNodes,3);
scrsz = get(0,'ScreenSize');
 h=figure(gcf);
set(h,'Position',[scrsz(3)/8 scrsz(4)/8 scrsz(3)-2*scrsz(3)/8 ...
    scrsz(4)-2*scrsz(4)/8]);
    clf;
    hold on;
    
    
Astar_coor=noddata(:,2:3)*GTS;

% Astar_coor=[100 100; 100 200; 100 300; 100 400; 
%              200 100; 200 200; 200 300; 200 400;
%              300 100; 300 200; 300 300; 300 400;
%              400 100; 400 200; 400 300; 400 400;];

netXloc = Astar_coor(:,1)';
netYloc = Astar_coor(:,2)';
axis([min(netXloc)-20  max(netXloc)+30  min(netYloc)-20  max(netYloc)+30])
Astar_connect = zeros(noOfNodes, noOfNodes);
Astar_coord = zeros(noOfNodes, 2);
for i = 1:noOfNodes

    for j = 1:noOfNodes
        distance = sqrt((netXloc(i) - netXloc(j))^2 + (netYloc(i) - netYloc(j))^2);
        ll=isempty(find(o==i, 1));
        lm=isempty(find(o==j, 1));
        if (distance <= R && ll==1 && lm==1)
            matrix(i, j) = distance;   % if set to '1', Dijkstra computes Spath in terms of hops; if set to 'distance', it is the real shortest path
            if i~=j % must be satisfied
                Astar_connect(i, j) = 1;
            else
                Astar_connect(i, j) = 0;
            end
                line([netXloc(i) netXloc(j)], [netYloc(i) netYloc(j)], 'color',[.7 .7 .7],'LineStyle', ':');
        else
            matrix(i, j) = inf;
            Astar_connect(i, j) = 0;
        end;
    end;
end
for i = 1:noOfNodes
     
        if i==s
            plot(netXloc(i), netYloc(i),'square','MarkerSize',12,'MarkerFaceColor','g');
            hold on;

        end
        if i==d
             plot(netXloc(i), netYloc(i),'square','MarkerSize',12,'MarkerFaceColor','r');   
         end
            plot(netXloc(i), netYloc(i),'.');      

     
    Astar_coord(i,1) = netXloc(i);
    Astar_coord(i,2) = netYloc(i);
        text(netXloc(i)+4, netYloc(i), num2str(i));
        if (i~=s && i~=d && isempty(find(o==i)))
        plot(netXloc(i), netYloc(i),'diamond','MarkerSize',8,'MarkerFaceColor','b');
            hold on;
        end

end;
    
title('Select Osbtacle nodes using mouse and press ''ENTER'' on Keyboard when done')

dcm_obj = datacursormode(figure(gcf));
set(dcm_obj,'DisplayStyle','window',...
'SnapToDataVertex','on','Enable','on');

 w=0;
while w==0
    figure(gcf)
    w = waitforbuttonpress;
    if w==1
        break
    end
    c_info = getCursorInfo(dcm_obj);
    ot=find(Astar_coord(:,1)==c_info.Position(1)...
        & Astar_coord(:,2)==c_info.Position(2));
    o=cat(2,o,ot);

    set(c_info.Target,'MarkerFaceColor','r');
end
%%
%%
%%
%close figure(gcf)