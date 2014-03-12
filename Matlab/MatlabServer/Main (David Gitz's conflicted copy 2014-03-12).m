%Main
close all
if exist('loop')
    keep loop
else
    clear variables
end
clc
%User Variables
SHOW_IMAGES_LOAD = false;
SHOW_HELP_IMAGES = false;
SHOW_IMAGES_TEST = false;
SHOW_IMAGES_SIM = false;
DEBUG = true;
DRONESERVER_IP = '192.168.0.103';
DRONESERVER_PORT = 5005;
MATLABSERVER_PORT = 5006;
MAX_TRAIN_LIMIT = 95;
MIN_TRAIN_LIMIT = 65;
FLUSHIMAGE_BUFFER = true;
THRESHOLDS = [.05:.1:.9];
CONSENSUS = .51; %Require 75% agreement on ID Classifiers
%THRESHOLDS = [.05:.05:.1];
global gTHRESHOLD;
gTHRESHOLD = .15;
%SCRIPTS = {'Script6';'Script7'};
SCRIPTS = {'Script7'};
global gSCRIPT
gSCRIPT = 'Script6';
LOWERSIZES = [5:20:200];

global gLOWERSIZE
gLOWERSIZE = 25;
UPPERSIZES = [100:400:4000];
%UPPERSIZES = [100:200:500];
global gUPPERSIZE
gUPPERSIZE = 2500;
CLASSES = {'ChiefSecurity';'MinistryTorture';'SecurityCompound';'None'};
DEBUGGING = true;
ORIG_WIDTH = 640;
ORIG_HEIGHT = 360;
COM_MODE = 'TCP';
TRAINIMAGE_DIR = [pwd '/../../../icarus_drone_server/media/RealImages/'];
ENVIRONIMAGE_DIR = [pwd '/../../../icarus_drone_server/media/EnvironmentImages/'];
SHUFFLE = true;
%TEST_IDS = {'03-09-2014_15-55-53','03-09-2014_15-57-17','03-09-2014_15-58-12','03-09-2014_15-59-05','03-09-2014_15-59-59','03-09-2014_16-00-52'};
ID_NAME = '03-09-2014_14-55-35';
BEST_IDS = {'03-09-2014_18-13-09','03-09-2014_19-19-11','03-09-2014_19-17-05','03-09-2014_18-05-49','03-09-2014_18-06-46','03-09-2014_18-04-52','03-09-2014_18-14-06'}
%BEST_IDS = {'03-09-2014_18-13-09'};
tempstr = datestr(now,'mm-dd-yyyy_HH-MM-SS');


%Program Variables
if strcmp(COM_MODE,'TCP')
    droneserver_socket = tcpip(DRONESERVER_IP,DRONESERVER_PORT,'NetworkRole','server');
elseif strcmp(COM_MODE,'UDP')
    droneserver_socket = udp(DRONESERVER_IP,DRONESERVER_PORT,'LocalPort',MATLABSERVER_PORT);
    
end
set(droneserver_socket,'InputBufferSize',1000000);
net_folder = [pwd '\..\..\..\icarus_drone_server\trained_nets\'];


%Local Variables
main_run = true;

%Program
while(main_run)
    choice = input('\nWhat would you like to do? \n[L]ive Run \n[S]im Mode\n[T]rain Mode\nT[E]st Mode\n[P]lot Data \n[Q]uit \n>>>>','s');
    switch choice
        case 'Q'
            main_run = false;
        case 'P'
            PlotData;
        case 'T'
            clear loop
            close all
            resultfile_id = fopen([pwd '/Objects/RESULTS/ ' 'RESULTS_TRAIN_' tempstr '.csv'],'wt');
            figindex = 1;
            l = 0;
            for l1 = 1:length(SCRIPTS)
                for l2 = 1:length(THRESHOLDS)
                    for l3 = 1:length(LOWERSIZES)
                        for l4 = 1:length(UPPERSIZES)
                            mytimer = tic;
                            l = l + 1;
                            gSCRIPT = SCRIPTS{l1};
                            gTHRESHOLD = THRESHOLDS(l2);
                            gLOWERSIZE = LOWERSIZES(l3);
                            gUPPERSIZE = UPPERSIZES(l4);
                            train_limit = MAX_TRAIN_LIMIT;
                            TrainMode;
                            etime = toc(mytimer);
                            totalitems = length(SCRIPTS) * length(THRESHOLDS) * length(LOWERSIZES) * length(UPPERSIZES);
                            disp(['Estimated Time Remaining: ' num2str(((totalitems-l)*etime)/60) ' minutes. ' num2str(totalitems-l) ' Items Left.'])
                        end
                    end
                end
            end
                
            fclose(resultfile_id);
        case 'E'
            clear loop
            configfile_list = dir([pwd '/Objects/CONFIG/']);
            configfile_list(1) = [];
            configfile_list(1) = [];
            for i = 1:length(configfile_list)
                TEST_IDS{i} = configfile_list(i).name(11:findstr(configfile_list(i).name,'.')-1);
            end
            resultfile_id = fopen([pwd '/Objects/RESULTS/ ' 'RESULTS_TEST_' tempstr '.csv'],'wt');
            for l = 1:length(TEST_IDS)
                ID_NAME = TEST_IDS{l};
                disp(['Testing: ' ID_NAME])
                TestMode;
            end
            fclose(resultfile_id);
            
        case 'S'
            SimMode;
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
