%%  A Star and K Omega Opitmization - Simulation/Workshop

% Master's Final Project 
% Muhammad Hasan
% RPI - Fall 2007
%
%%   Test Parameters & Setup 
% This section describes variables that are tunable for this simulation
clear all; 
close all; clc;

%**************************************************************************
%****************  Choose System Architecture   ***************************
%**************************************************************************
%  Here you can choose the hardware architecture implementation
%     1 . Single Robot mode
%     2 . Dual Robot Single Computer
%     3 . Dual Roboto Dual Computer
%     4 . Multi Robot Single Computer
%     5 . Multi Robot Ethernet Based

Architecture=1;


%****************  Architecture properties    ****************************
%   
%   This section allows you to modify properties for each architecuter
%
%**************** 1. Single Robot Mode properties  ***********************
%
%
AnalysisMode=0;  % If set to 1, will perform analysis for various k and 
                 % and b values as specified below
    minb=5;      % Minimum b values, usually depends on Range 
                 % (R defined below)
    maxk=15;     % Maximum values of b to analyze
    maxb=15;     % Maximum values of b to analyze
    
%**************** 2 . Dual Robot Single Computer **************************
%
%
follead = 1;     % In this colaborative scheme only one robot knows the 
                 % desitination, the other robots have to follow the leader
    nRob= 3;     % Number of robots in this mode
    Leader=1;    % Id of the lead robot
    
%**************************************************************************
%****************      Grid properties    *********************************
%**************************************************************************
%
%                 Node Layout
%                 1   2    3   .... n
%                 n+1 n+2  .........p
%                 .
%                 .
%  

nooc=20;        % Number of Columns in Manhattan Simulation Grid
noor=20;        % Number of Rows in Manhattan Simulation Grid


R = 250;         % maximum range,graphic property;
GTS=100;         % Grid spacing between each node
s = 42;         % source node
d = 378;           % destination node

% s=randint(1,1,[0,nooc*noor]); % Generate Random Start node
% d=randint(1,1,[0,nooc*noor]); % Generate Random Destination node


o =[];           % obstacle nodes
nrandnodes=400;  % Number of Random nodes to add this one
defoman=1;       % Define Obstrctions manually
selnman=1;


%*************************************************************************
%****************  Display properties    *********************************
%*************************************************************************
%
%  plot_flag: Displays grid at end of each simulation
%
plot_flag = 1;  % Set to 1, if you want to plot simulation 
disp_summary=1; % Set to 1 to display paths generated costs associated
global plot_nodenum;  
plot_nodenum=0;   % Set to 1 to display numbers on the nodes

%*************************************************************************
%****************   Robot Properties     *********************************
%*************************************************************************

global or exec co crn;
or='N';  % Robot's initial Orientation (N,S,E or W)
idRob=1;  % Robot ID if running multiple robots

exec=0;  % If exec = 1, program will execute robot at
         %  the end of search algorithm or when called by k-omega
         
%*************************************************************************
%****************  K - Omega Parameters  *********************************
%*************************************************************************

k=3;            % Search Depth
b=inf;            % Number of Branches to expand per iteration
n=0;            % Execute robot every n iteration


%% 

%*************************************************************************
%#########################################################################
% Do not edit any properties below this line 
%#########################################################################
%*************************************************************************


if exec==1
    msgs=msgbox('Make sure you have Established BT connection with NXT');
    uiwiat(msgs)
end


switch Architecture
    case 1
        disp('********************************************************');
        disp('******************  single_m  **************************');
        disp('********************************************************');
        disp('********************************************************');
        % Call Manual Obstacle definition if flag is set
        if defoman==1 && selnman~=1
            o2=randint(1,nrandnodes,[0,nooc*noor]);
            o=cat(2,o,o2);
            xts=find(o==s);  %Starting node cannot be an obstacle
            o(xts)=[];
            xts=find(o==d);  % Destination node cannot be obstacle
            o(xts)=[];
            disp('Generating Editable Grid...');
            o=cat(2,o,defobs(nooc,noor,R,GTS,s,d,o));
            % Setup Random Obtacles elsewhere
        else
            % Else: Setup Random Obtacles
            o2=randint(1,nrandnodes,[0,nooc*noor]);
            o=cat(2,o,o2);
            xts=find(o==s);  %Starting node cannot be an obstacle
            o(xts)=[];
            xts=find(o==d);  % Destination node cannot be obstacle
            o(xts)=[];
            if selnman==1
                [s,d,o]=selnodes(nooc,noor,R,GTS,o);
            end
        end
        single_m;

     case 2
        disp('********************************************************');
        disp('******************  Dual Robot *************************');
        disp('********************************************************');
        disp('********************************************************');
        grid_setup;
        followlead;
        % Once done, clean up Grid Info & Robot info
        if idRob==1
        [xlsstat]=xlswrite(a, 0, 'GRD','A2');
        [xlsstat]=xlswrite(a, ' ', 'GRD','A2:I15');
        end

    otherwise
        disp('********************************************************');
        disp('**********  Architecture does not exist yet ************');
        disp('************* Select another architecture **************');
        disp('********************************************************');
end
%%
       

 
    


    