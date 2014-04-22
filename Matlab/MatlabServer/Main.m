%Main
close all
if exist('loop')
    keep loop
else
    clear variables
end
clc
%User Variables
global gSHOW_HELP_IMAGES_PREPROCESS;
gSHOW_HELP_IMAGES_PREPROCESS = false;
SHOW_IMAGES_TEST = false;
SHOW_IMAGES_SIM = false;
SHOW_IMAGES_RUN = false;
DEBUG = true;
DRONESERVER_IP = '192.168.0.100';
DRONESERVER_PORT = 5005;
MATLABSERVER_PORT = 5006;
MAX_TRAIN_LIMIT = 95;
MIN_TRAIN_LIMIT = 65;
FLUSHIMAGE_BUFFER = true;
THRESHOLDS = [.5:.025:.75];
CONSENSUS = .51; %Require 75% agreement on ID Classifiers

global gTHRESHOLD;
%gTHRESHOLD = .15;
%SCRIPTS = {'Script6';'Script7'};
SCRIPTS = {'Script1'};
global gSCRIPT
gSCRIPT = 'Script1';
LOWERSIZES = [100:200:1000];

global gLOWERSIZE
gLOWERSIZE = 25;
UPPERSIZES = [500:500:2500];
%UPPERSIZES = [100:200:500];
global gERODE_SIZE
gERODE_SIZE = 4;
ERODE_SIZES = [5:15];
global gUPPERSIZE
gUPPERSIZE = 2500;
CLASSES = {'ChiefSecurity';'MinistryTorture';'SecurityCompound';'None'};
global gORIG_WIDTH
global gORIG_HEIGHT
global gRESIZE
gRESIZE = 1;
gORIG_WIDTH = 179;
gORIG_HEIGHT = 179;
COM_MODE = 'TCP';
TRAINIMAGE_DIR = [pwd '/../../../icarus_drone_server/media/RealImages/'];
ENVIRONIMAGE_DIR = [pwd '/../../../icarus_drone_server/media/EnvironmentImages/'];
SHUFFLE = true;
%TEST_IDS = {'03-09-2014_15-55-53','03-09-2014_15-57-17','03-09-2014_15-58-12','03-09-2014_15-59-05','03-09-2014_15-59-59','03-09-2014_16-00-52'};
ID_NAME = '04-19-2014_11-30-09';
%BEST_IDS = {'03-14-2014_02-02-10','03-14-2014_02-41-59','03-14-2014_03-02-33','03-14-2014_03-54-30','03-14-2014_04-25-34','03-14-2014_03-21-06','03-14-2014_03-03-45'};
%BEST_IDS = {'04-19-2014_11-30-09','04-19-2014_06-58-14','04-19-2014_20-55-41','04-19-2014_11-04-42','04-19-2014_11-08-25',...
%    '04-19-2014_19-02-00','04-19-2014_09-38-55','04-19-2014_16-20-31','04-19-2014_08-27-36','04-19-2014_18-26-39'};
BEST_IDS = {'04-19-2014_11-30-09','04-19-2014_06-58-14','04-19-2014_20-55-41'};
tempstr = datestr(now,'mm-dd-yyyy_HH-MM-SS');


%Program Variables
if strcmp(COM_MODE,'TCP')
    droneserver_socket = tcpip('0.0.0.0',DRONESERVER_PORT,'NetworkRole','server');
elseif strcmp(COM_MODE,'UDP')
    droneserver_socket = udp(DRONESERVER_IP,DRONESERVER_PORT,'LocalPort',MATLABSERVER_PORT);
    
end
set(droneserver_socket,'InputBufferSize',60000);



%Local Variables
main_run = true;

%Program
while(main_run)
    choice = input('\nWhat would you like to do? \n[L]ive Run \n[S]im Mode\n[T]rain Mode\nT[E]st Mode\n[P]lot Data \n[C]opy Objects\n[Q]uit \n>>>>','s');
    switch choice
        case 'C'
            choice = input('Are you Sure Y/[N]','s');
            if strcmp(choice,'Y')
                CopyObjects;
            end
        case 'Q'
            main_run = false;
        case 'P'
            PlotData;
        case 'T'
            choice2 = input('\n[B]atch Mode\n[S]ingle Mode\n>>>>','s');
            
            switch choice2
                case 'S'
                    clear loop
                    close all
                    gSCRIPT = 'Script1';
                    gUPPERSIZE = 2000;
                    gLOWERSIZE = 500;
                    gTHRESHOLD = .65;
                    gERODE_SIZE = 3;
                    train_limit = MAX_TRAIN_LIMIT;
                    TrainMode;
                case 'B'
                    clear loop
                    close all
                    resultfile_id = fopen([pwd '/Objects/RESULTS/' 'RESULTS_TRAIN_' tempstr '.csv'],'wt');
                    figindex = 1;
                    l = 0;
                    for l1 = 1:length(SCRIPTS)
                        for l2 = 1:length(THRESHOLDS)
                            for l3 = 1:length(LOWERSIZES)
                                for l4 = 1:length(UPPERSIZES)
                                    for l5 = 1:length(ERODE_SIZES)
                                        totalitems = length(SCRIPTS) * length(THRESHOLDS) * length(LOWERSIZES) * length(UPPERSIZES) * length(ERODE_SIZES);
                                        disp(['Items Remaining: ' num2str(totalitems-l)]);
                                        mytimer = tic;
                                        l = l + 1;
                                        gSCRIPT = SCRIPTS{l1};
                                        gTHRESHOLD = THRESHOLDS(l2);
                                        gLOWERSIZE = LOWERSIZES(l3);
                                        gUPPERSIZE = UPPERSIZES(l4);
                                        gERODE_SIZE = ERODE_SIZES(l5);
                                        train_limit = MAX_TRAIN_LIMIT;
                                        TrainMode;
                                        etime = toc(mytimer);
                                        
                                        
                                    end
                                end
                            end
                        end
                    end
                    
                    fclose(resultfile_id);
            end
        case 'E'
            clear loop
            configfile_list = dir([pwd '/Objects/CONFIG/']);
            configfile_list(1) = [];
            configfile_list(1) = [];
            for i = 1:length(configfile_list)
                TEST_IDS{i} = configfile_list(i).name(11:findstr(configfile_list(i).name,'.')-1);
            end
            resultfile_id = fopen([pwd '/Objects/RESULTS/' 'RESULTS_TEST_' tempstr '.csv'],'wt');
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
                fopen(droneserver_socket)
                LiveMode;
            else
                tempstr = ['Cannot find Host ' DRONESERVER_IP];
                disp(tempstr);
            end
    end
end
fclose(droneserver_socket);
