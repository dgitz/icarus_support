%Main
close all
if exist('loop')
    keep loop
end
clc
%User Variables
SHOW_IMAGES = false;
DRONESERVER_IP = '192.168.0.2';
DRONESERVER_PORT = 5005;
CLASSNET_NAME = 'classnet_02-26-2014_07-12-11';
COLNET_NAME = '';
ROWNET_NAME = '';
FLUSHIMAGE_BUFFER = true;
SCRIPT = 'Script4';
CLASSES = {'ChiefSecurity';'MinistryTorture';'SecurityCompound';'None'};
DEBUGGING = true;
ROWS = 4;
COLS = 4;


%Program Variables
droneserver_socket = tcpip(DRONESERVER_IP,DRONESERVER_PORT,'NetworkRole','server');
set(droneserver_socket,'InputBufferSize',1000);
set(droneserver_socket,'Terminator','*');
imageprocess_folder = ['Z:\ImagesToProcess'];
net_folder = [pwd '\..\..\..\icarus_drone_server\trained_nets\'];


%Local Variables
main_run = true;

%Program
while(main_run)
    choice = input('\nWhat would you like to do? \n[L]ive Run \n[P]lot Data \n[E]xit \n>>>>','s');
    switch choice
        case 'E'
            main_run = false;
        case 'P'
            PlotData;
        case 'L'
            clear loop
            tempstr = ['Trying to Connect to Drone Server at ' DRONESERVER_IP ':' num2str(DRONESERVER_PORT) ];
            disp(tempstr);
            if (dos(['ping ' DRONESERVER_IP]) == 0)
                tempstr = ['Waiting for Connection'];
                disp(tempstr);
                fopen(droneserver_socket);
                LiveMode;
            else
                tempstr = ['Cannot find Host ' DRONESERVER_IP];
                disp(tempstr);
            end
    end
end
fclose(droneserver_socket);
