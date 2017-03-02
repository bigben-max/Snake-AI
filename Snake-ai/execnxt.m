%% Exceute Path for Robot 
%  Emad Hasan - Master's Project code
%
%%


function [done]=execnxt(srch_path)
if ~isempty(srch_path)



done=0;
global co crn exec;
% Perform transformations for the robot

cp=[];
for ii=1:(length(srch_path)-1)
    moves=srch_path(ii+1)-srch_path(ii);
    switch moves
        case 1 % Desired = East
            switch co
                case 'N'
                 cp(ii)='R';
                case 'E'
                 cp(ii)='F';
                case 'W'
                    cp(ii)='B';
                case 'S'
                    cp(ii)='L';
            end
            co='E';   
        case -1  % Desired = West
            switch co
                case 'N'
                 cp(ii)='L';
                case 'E'
                 cp(ii)='B';
                case 'W'
                    cp(ii)='F';
                case 'S'
                    cp(ii)='R';
            end
            co='W';
        case -1   % Desired = North
            switch co
                case 'N'
                 cp(ii)='F';
                case 'E'
                 cp(ii)='L';
                case 'W'
                    cp(ii)='R';
                case 'S'
                    cp(ii)='B';
            end
            co='N';
        case 4  % Desired = South
            switch co
                case 'N'
                 cp(ii)='B';
                case 'E'
                 cp(ii)='R';
                case 'W'
                    cp(ii)='L';
                case 'S'
                    cp(ii)='F';
            end
            co='S';
    end
end


            



if exec==1
    Start Send recieve loop
    for si=1:length(cp);
        % Wait for NXT to be ready
        pause(1);
        nxtready=false;
        while nxtready==false
            astr=char(fread(ser_obj,64))'; % receive sensor data
            if length(astr)>=3
                rrl=length(astr)-2;
                for rcs=1:rrl
                    if (astr(rcs:rcs+2)=='MWE')
                        nxtready=true;
                    end
                end
            end
        end

        % Send Command until NXT recieved
        nxtexe=false;
        while nxtexe==false
            astra=char(fread(ser_obj,64))'; % receive sensor data
            if length(astra)>=3
                rl=length(astra)-2;
                for rcc=1:rl
                    if (astra(rcc:rcc+2)=='MEE')
                        nxtexe=true;
                    end
                end
            end
            cmd=strcat('M',c(si),'E');
            for sc=1:8
                cmd=strcat(cmd,cmd);
            end
            fprintf(ser_obj,'%s',cmd, 'async');
            pause(0.05);
        end
        crn=srch_path(si+1);
    end
else
    crn=srch_path(length(srch_path));
end

done=1;
end

done=-1;
