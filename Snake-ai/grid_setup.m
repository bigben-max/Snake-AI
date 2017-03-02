%
%       Setup Common grid for multi robot K Omega
%
%
%
%**************************************************************************

%%
% 1. Check Common Memory if grid has already beeen setup.

curd=pwd;
cd('../');
global a;
a=strcat(pwd,'\GRD.xls');
cd(curd);
disp('Initializing ... ')
%%
ginuse=xlsread(a,'GRD','A2');

if ginuse~=1
%%
    [xlsstat]=xlswrite(a, 1, 'GRD','A2');
    if follead==1
        disp(' #### Follow Leader Mode  ###');
        o2=randint(1,nrandnodes,[0,nooc*noor]);
        o=cat(2,o,o2);
        [noOfNodes,Astar_coord,Astar_connect,s,d,o]=selnodes2(nooc,noor,R,GTS,o,nRob,plot_nodenum);
      
        Astar_coord=Astar_coord';
        for xx=1:length(ss)
            xts=find(o==ss(xx));  %Starting node cannot be an obstacle
            o(xts)=[];

        end
        xts=find(o==d);  % Destination node cannot be obstacle
        o(xts)=[];
    end
%%
    disp(' Writing Grid info to Common Memory... ')
    [xlsstat]=xlswrite(a, ' ', 'GRD', strcat('D2:D',num2str(nrandnodes+noor*nooc)));
    [xlsstat]=xlswrite(a, ' ', 'GRD', strcat('B2:C10'));
    [xlsstat]=xlswrite(a, s', 'GRD', strcat('B2:B',num2str(1+length(s))));
    [xlsstat]=xlswrite(a, o', 'GRD', strcat('D2:D',num2str(1+length(o))));
    [xlsstat]=xlswrite(a, d, 'GRD','C2');
    disp('...................................Done')
else
    if idRob==1
        hh=msgbox('Common Memory in Use','ERROR');
        uiwait(hh);
        [xlsstat]=xlswrite(a, 0, 'GRD','A2');
        dbstop;
    end
end

return;

