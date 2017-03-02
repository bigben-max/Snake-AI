

disp('Initializing Robot... ');

% Write Rob Id to Common memmory
[xlsstat]=xlswrite(a,idRob, 'Rob',strcat('A',num2str(idRob+1)));

if idRob==1
    crn=s(idRob);
    co=or;
    disp('Performing K omega optimization ... ')
    [komega_path,cost_komega,ko_time,komega_dist]=komegaA(Astar_coord,...
        Astar_connect, s(idRob), d, k , b, n);
    disp('Writing Information to file...')
    % Open file for writing
    [xlsstat]=xlswrite(a, 1, 'GRD','A4');
    % Write Current node to file
    [xlsstat]=xlswrite(a,crn, 'Rob',strcat('C',num2str(idRob+1)));
    % Write Current node to file
    [xlsstat]=xlswrite(a,s(idRob), 'Rob',strcat('D',num2str(idRob+1)));
    % Write Destination node to file
    %[xlsstat]=xlswrite(a,d, 'Rob',strcat('E',num2str(idRob+1);
    % Write Current Path to file
    %[xlsstat]=xlswrite(a,strcat(num2str(komega_path)), 'Rob',...
    %strcat('H',num2str(idRob+1)),'':'',strcat('H',num2str(idRob+1));
    % Write Current Path to file
    [xlsstat]=xlswrite(a,cost_komega, 'Rob',strcat('F',num2str(idRob+1)));

    for i=1:(length(s)-1)% Write Current Path to file
        [xlsstat]=xlswrite(a,komega_dist, 'Rob',strcat('G',num2str(idRob+1)));
    end

    %Initialization Completed
    [xlsstat]=xlswrite(a,1, 'Rob',strcat('B',num2str(idRob+1)));
    % Close write on file
    [xlsstat]=xlswrite(a, 0, 'GRD','A4');

    % Plot Leader Path
    disp('Plotting leader path...')
    line(Astar_coord(1,komega_path),Astar_coord(2,komega_path),...
        'Color','g','LineWidth', 2, 'LineStyle', '-');
    hold on;

    % Waiter for followers to be ready
    disp('Waiting for follower robots... ')
    x=xlsread(a,'Rob',strcat('B2:B',num2str(nRob+1)))';
    while ~isempty(find(x==0))
        % Debuging Code ----
        disp(' ###Your input is required for simulating robots ####')
        pause;
        % --------Debuging Code
        pause(.25);
    end
    disp('... Done ')

    % Read where everyone is for updating display
    cnode=cell(1,length(komega_path));
    cnode{1}=xlsread(a,'Rob',strcat('C2:C',num2str(nRob+1)))';

    disp(strcat('Total Steps =',num2str(length(komega_path))));
    %Excecute One move at a time NXT
    for cored=1:(length(komega_path)-1)
        execnxt(komega_path(cored:cored+1));
        % Wait until able to write to file
        disp(strcat('Step',num2str(cored),' Completed, writing to file...'))
                    % Debuging Code ----
            disp(' ###Your input is required for simulating robots ####')
            disp(' Update position');
            figure(gcf);
            pause;
            % --------Debuging Code
        while (xlsread(a,'GRD','A4'))
            % Debuging Code ----
            disp(' ###Your input is required for simulating robots ####')
            disp(' Set finuse to 0 to pass');
            pause;
            % --------Debuging Code
            pause(1);
        end
        % Open file for writing
        [xlsstat]=xlswrite(a, 1, 'GRD','A4');
        % Write Current node to file
        [xlsstat]=xlswrite(a,crn, 'Rob',strcat('C',num2str(idRob+1)));
        % Close write on file
        [xlsstat]=xlswrite(a, 0, 'GRD','A4');
        disp(strcat('Step',num2str(cored),'... done'))
        % Read where everyone is now
        cnode{cored+1}=xlsread(a,'Rob',strcat('C2:C',num2str(nRob+1)))';

        %updating display markers
        
        for dxl=1:nRob
            figure(gcf);
        set(findobj('Marker','square','XData',...
            Astar_coord(1,cnode{cored}(dxl)),'YData',...
            Astar_coord(2,cnode{cored}(dxl))),...
            'XData',Astar_coord(1,cnode{cored+1}(dxl)),...
            'YData',Astar_coord(2,cnode{cored+1}(dxl)));
        end
    end

    dsint=cnode{cored+1};
    clear cnode;
    % Wait at Desitination Until all robots are done
    disp('Leader at destination, waiting for followers...')
    %Update Display in the mean time
    while ~isempty(find(dsint~=d))
        dsnow=xlsread(a,'Rob',strcat('C2:C',num2str(nRob+1)))';%updating display markers
       
        for dxl=1:nRob
             figure(gcf);
        set(findobj('Marker','square','XData',...
            Astar_coord(1,dsint(dxl)),'YData',...
            Astar_coord(2,dsint(dxl))),...
            'XData',Astar_coord(1,dsnow(dxl)),...
            'YData',Astar_coord(2,dsnow(dxl)));
        end
        dsnow=dsint;
        % Debuging Code ----
        disp(' ###Your input is required for simulating robots ####')
        disp(' Update Remote robot CRN')
        pause;
        % --------Debuging Code
        
    end

else
    % Perfrom Code for Follower
    % 1. Wait till Leader has initialized
end

return;

% Check if File is in Use already
finuse=xlsread(a,'GRD','A4');