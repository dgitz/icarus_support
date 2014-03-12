global gSCRIPT
global gLOWERSIZE
global gUPPERSIZE
global gTHRESHOLD
[a,index] = max([myitems(:).success_total]);
id_pca = myitems(index).pca;
id_knn = myitems(index).knn;
success_train = myitems(index).success_train;
success_test = myitems(index).success_test;
success_total = myitems(index).success_total;
save([pwd '/Objects/PCA/' PCA_NAME],'id_pca');
save([pwd '/Objects/KNN/' KNN_NAME],'id_knn');
configfile_id = fopen([pwd '/Objects/CONFIG/' CONFIG_NAME '.txt'],'wt');
fprintf(configfile_id,['PCA_ID:' PCA_NAME '\r\n']);
fprintf(configfile_id,['KNN_ID:' KNN_NAME '\r\n']);
fprintf(configfile_id,['SCRIPT:' gSCRIPT '\r\n']);
fprintf(configfile_id,['THRESHOLD:' num2str(gTHRESHOLD) '\r\n']);
%Add other config items
fprintf(configfile_id,['LOWER_SIZE:' num2str(gLOWERSIZE) '\r\n']);
fprintf(configfile_id,['UPPER_SIZE:' num2str(gUPPERSIZE) '\r\n']);

fprintf(configfile_id,['PCA_FEATURES:' num2str(length(id_pca.pcaVectors)) '\r\n']);
fprintf(configfile_id,['SUCCESS_RATE:' num2str(success_total) '\r\n']);


fclose(configfile_id);
fprintf(resultfile_id,[ID_NAME ',' gSCRIPT ',' num2str(gTHRESHOLD) ',' num2str(gLOWERSIZE) ',' num2str(gUPPERSIZE) ',' num2str(success_train) ',' num2str(success_test) ',' num2str(success_total) '\r\n']);