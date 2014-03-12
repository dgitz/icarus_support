global gSCRIPT
global gLOWERSIZE
global gUPPERSIZE
global gTHRESHOLD
global gOperatingMode
if strcmp(gOperatingMode,'Sim') || strcmp(gOperatingMode,'Live')
    operating_dir = '/ID_Objects';
else
    operating_dir = '/Objects';
end
KNN_NAME = ['KNN_ID_' ID_NAME];
PCA_NAME = ['PCA_ID_' ID_NAME];
CONFIG_NAME = ['CONFIG_ID_' ID_NAME];
knn_file = [pwd operating_dir '/KNN/' KNN_NAME '.mat'];
pca_file = [pwd operating_dir '/PCA/' PCA_NAME '.mat'];
config_file = [pwd operating_dir '\CONFIG\' CONFIG_NAME '.txt'];

loaded = false;
if exist(knn_file) && exist(pca_file) && exist(config_file)
    load(knn_file);
    load(pca_file);
    configfile_id = fopen(config_file);
    
    while ~feof(configfile_id)
        tempstr = fgetl(configfile_id);
        [token,remain] = strtok(tempstr,':');
        remain = remain(2:length(remain));
        switch token
            case 'SCRIPT'
                gSCRIPT = remain;
            case 'PCA_FEATURES'
                PCA_FEATURES = str2num(remain);
            case 'THRESHOLD'
                gTHRESHOLD = str2num(remain);
            case 'LOWER_SIZE'
                gLOWERSIZE = str2num(remain);
            case 'UPPER_SIZE'
                gUPPERSIZE = str2num(remain);
            case 'SUCCESS_RATE'
                successrate = str2num(remain);
        end
    end
    
    fclose(configfile_id);
    loaded = true;
else
    disp(['Can''t find Files for ' ID_NAME]);
end