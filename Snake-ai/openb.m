
clear;


%Initialize Serial Port
        ser_obj=serial('COM13','BaudRate', 9600, 'DataBits', 8, 'Parity', 'none','StopBits',1,'TimeOut',0.5);
         ser_obj.terminator = 'CR';
         ser_obj.RequestToSend='off';
         ser_obj.OutputBufferSize=1024;
         if ser_obj.Status=='closed'
                fopen(ser_obj);
         end
         ser_obj.DataTerminalReady='on';
