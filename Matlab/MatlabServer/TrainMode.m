global gSCRIPT
global gTHRESHOLD
global gLOWERSIZE
global gUPPERSIZE
success = false;
iterationcounter = 0;
ID_NAME = datestr(now,'mm-dd-yyyy_HH-MM-SS');
PCA_NAME = ['PCA_ID_' ID_NAME];
KNN_NAME = ['KNN_ID_' ID_NAME];
CONFIG_NAME = ['CONFIG_ID_' ID_NAME];
disp(['Training with ' gSCRIPT ', Threshold: ' num2str(gTHRESHOLD),' Lower Size: ' num2str(gLOWERSIZE), ' Upper Size: ' num2str(gUPPERSIZE)])
limitreached = false;
while(~success && ~limitreached)
    iterationcounter = iterationcounter + 1;
    try
        LoadTrainingSamples;
        mytimer = tic;
        
        
        
        train_dataSet = prtDataSetClass([TrainClassMatrix ]',[TargetClassTrainMatrix ]');
        test_dataSet = prtDataSetClass(TestClassMatrix',TargetClassTestMatrix');
        train_dataSet.classNames = Answers';
        
        
        % Generate a data set and a PCA pre-processing function:
        id_pca = prtPreProcPca;
        id_pca.nComponents = length(Answers)-1;  %I'd like to use the first 2 principal components
        
        % Train the PCA to learn the principal components of the data:
        id_pca = id_pca.train(train_dataSet);
        dsPca = id_pca.run(train_dataSet);   %Run the PCA analysis on the data
        
        % plot the data.
        if SHOW_HELP_IMAGES
            figindex = figure(figindex) + 1;
            hold on
            plot(train_dataSet);
            title([SCRIPT ' Training Vectors'])
            figindex = figure(figindex) + 2;
            plot(dsPca);
            title([SCRIPT ' PCA'])
        end
        id_knn = prtClassKnn;
        id_knn = id_knn.train(dsPca);
        if SHOW_HELP_IMAGES
            plot(id_knn)
            title([SCRIPT ' kNN Classifier'])
        end
        truth = dsPca.getTargets; %the true class labels
        yOutKfolds = id_knn.kfolds(dsPca,10); %10-Fold cross-validation
        
        %     We need to parse the output of the KNN classifier to turn vote counts into
        %     class guesses - for each observation, our guess is the column with the
        %     most votes!
        [nVotes,guess] = max(yOutKfolds.getObservations,[],2);
        if SHOW_HELP_IMAGES
            figindex = figure(figindex) + 1;
            subplot(1,1,1); %don't plot in the last figure window.
            prtScoreConfusionMatrix(guess,truth,dsPca.uniqueClasses,dsPca.getClassNames);
            title([gSCRIPT ' Classification Confusion Matrix']);
        end
        %     algo = prtPreProcPca('nComponents',myPca.nComponents) + prtClassKnn + prtDecisionMap;
        %     yOutAlgoKfolds = algo.kfolds(train_dataSet,10);
        %     figindex = figure(figindex) + 1;
        %     prtScoreConfusionMatrix(yOutAlgoKfolds,train_dataSet);
        %     title('Training Classification Confusion Matrix');
        
        %     yOutAlgoKfolds = algo.kfolds(test_dataSet,10);
        %     figindex = figure(figindex)+1;
        %     prtScoreConfusionMatrix(yOutAlgoKfolds,test_dataSet);
        %     title('Testing Classification Confusion Matrix');
        
        if SHOW_HELP_IMAGES
            figindex = figure(figindex)+1;
            train_dataSet.imagesc;
            
            title([gSCRIPT ' Training Classification Feature Selection'])
            figindex = figure(figindex)+1;
            test_dataSet.imagesc;
            title([gSCRIPT ' Testing Classification Feature Selection'])
        end
        sumA = 0;
        tempsumtimer = 0;
        for i = 1:length(TrainClassMatrix(1,:))
            mytimer = tic;
            sample = prtDataSetClass(TrainClassMatrix(:,i)');
            [a,y] = max(id_knn.run(id_pca.run(sample)).data);
            if y == TargetClassTrainMatrix(:,i)
                sumA = sumA + 1;
            end
            tempsumtimer = tempsumtimer + toc(mytimer);
        end
        success_train = 100*sumA/(length(TrainClassMatrix(1,:)));
        sumB = 0;
        for i = 1:length(TestClassMatrix(1,:))
            mytimer = tic;
            sample = prtDataSetClass(TestClassMatrix(:,i)');
            [a,y] = max(id_knn.run(id_pca.run(sample)).data);
            if y == TargetClassTestMatrix(:,i)
                sumB = sumB + 1;
            end
            tempsumtimer = tempsumtimer + toc(mytimer);
        end
        success_test = 100*sumB/(length(TestClassMatrix(1,:)));
        success_total = 100*(sumA+sumB)/(length(TestClassMatrix(1,:)) + length(TrainClassMatrix(1,:)));
        tempstr = ['Iteration: ' num2str(iterationcounter) ' Total Success: ' num2str(success_total) '%/' num2str(train_limit)];
        disp(tempstr)
        myitems(iterationcounter).pca = id_pca;
        myitems(iterationcounter).knn = id_knn;
        myitems(iterationcounter).success_train = success_train;
        myitems(iterationcounter).success_test = success_test;
        myitems(iterationcounter).success_total = success_total;
        if success_total < 10
            limitreached = true;
            success = false;
        end
        if success_total > train_limit
            
            success = true;
        else
            train_limit = train_limit * .95;
        end
        if train_limit < MIN_TRAIN_LIMIT
            limitreached = true;
        end
    catch err
        limitreached = true;
        success = false;
    end
    
end
if success == true
    SaveObjects;
end
