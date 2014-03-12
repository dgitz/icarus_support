%LoadTrainingSamples
global gSCRIPT;
global gTHRESHOLD;
SampleName = 'IARC';
clear Answers;
RATIO = .75;
clear trainitems
trainitems(1).class = '';
trainitems(1).path = '';
trainitems(1).origimage = [];
trainitems(1).procimage = [];
trainitems(1).vector = [];
switch SampleName
    case 'IARC'
        t1 = tic;
        VectorClassCount = 0;
        VectorLength = 0;
        
        folderlist = dir(TRAINIMAGE_DIR);
        folderlist(1) = [];
        folderlist(1) = [];
        filelist = [];
        index = 0;
        for i = 1:length(folderlist)
            mydir = [TRAINIMAGE_DIR folderlist(i).name];
            Answers{i} = folderlist(i).name;
            mylist = dir(mydir);
            mylist(1) = [];
            mylist(1) = [];
            for j = 1:length(mylist)
                index = index + 1;
                trainitems(index).class = folderlist(i).name;
                trainitems(index).path = [mydir '/' mylist(j).name];
                tempstr = mylist(j).name(11:length(mylist(j).name));
                %                 trainitems(index).centery = str2num(tempstr(1:findstr(tempstr,'_')-1));
                %                 trainitems(index).centerx = str2num(tempstr(findstr(tempstr,'_')+1:findstr(tempstr,'.')-1));
                
                
            end
        end
        mylist = dir(ENVIRONIMAGE_DIR);
        mylist(1) = [];
        mylist(1) = [];
        Answers{length(Answers)+1} = 'None';
        index = length(trainitems);
        for j = 1:length(mylist)
            index = index + 1;
            trainitems(index).class = 'None';
            trainitems(index).path = [ENVIRONIMAGE_DIR '/' mylist(j).name];
            
        end
        VectorLocalizingCount = 0;
        for index = 1:length(trainitems)
            trainitems(index).origimage = imread(trainitems(index).path);
            [trainitems(index).procimage,trainitems(index).rects] = preprocess(trainitems(index).origimage,'Train');
            
            trainitems(index).vector = reshape(trainitems(index).procimage,[],1);
            if ~strcmp(trainitems(index).class,'None') && (trainitems(index).rects(1).Area > 0)
                VectorLocalizingCount = VectorLocalizingCount + 1;
                [height,width,c] = size(trainitems(index).origimage);
                %                 trainitems(index).row = ceil(gROW_SECTORS*trainitems(index).centery/height);
                %                 trainitems(index).col = ceil(gCOL_SECTORS*trainitems(index).centerx/width);
            end
            if SHOW_IMAGES_LOAD
                figure(1)
                subplot(2,1,1)
                
                imshow(trainitems(index).origimage);
                subplot(2,1,2)
                imshow(trainitems(index).procimage,[]);
                hold on
                %plot(trainitems(index).centerx/gRESIZE,trainitems(index).centery/gRESIZE,'r.','MarkerSize',20)
                if trainitems(index).rects(1).Area > 0
                    plot(trainitems(index).rects(1).Centroid(1),trainitems(index).rects(1).Centroid(2),'b.','MarkerSize',20)
                end
                
            end
            if DEBUG
            disp(['Loaded: ' num2str(index) '/' num2str(length(trainitems)) ' patterns.']);
            end
        end
        if SHUFFLE
            trainitems = randomizelist(trainitems);
        end
        VectorClassCount = length(trainitems);
        VectorLength = length(trainitems(1).vector);
        TrainVectorClassCount = round(RATIO*VectorClassCount);
        TestVectorClassCount = VectorClassCount-TrainVectorClassCount;
        TrainVectorLocalizingCount = round(RATIO*VectorLocalizingCount);
        TestVectorLocalizingCount = VectorLocalizingCount-TrainVectorLocalizingCount;
        
        TrainClassMatrix = zeros(VectorLength,1);
        TestClassMatrix = zeros(VectorLength,1);
        TargetClassTrainMatrix = zeros(1,1);
        TargetClassTestMatrix = zeros(1,1);
        
        %         TrainLocalizingRowMatrix = zeros(VectorLength,TrainVectorLocalizingCount);
        %         TestLocalizingRowMatrix = zeros(VectorLength,TestVectorLocalizingCount);
        %         TargetLocalizingRowTrainMatrix = zeros(gROW_SECTORS,TrainVectorLocalizingCount);
        %         TargetLocalizingRowTestMatrix = zeros(gROW_SECTORS,TestVectorLocalizingCount);
        %         TrainLocalizingColMatrix = zeros(VectorLength,TrainVectorLocalizingCount);
        %         TestLocalizingColMatrix = zeros(VectorLength,TestVectorLocalizingCount);
        %         TargetLocalizingColTrainMatrix = zeros(gCOL_SECTORS,TrainVectorLocalizingCount);
        %         TargetLocalizingColTestMatrix = zeros(gCOL_SECTORS,TestVectorLocalizingCount);
        
        trainindex = 0;
        testindex = 0;
        for i = 1:length(trainitems)
            if (~strcmp(trainitems(i).class,'None') && trainitems(i).rects(1).Area > 0) || (strcmp(trainitems(i).class,'None')) && (trainitems(i).rects(1).Area == 0)
                trainitems(i).Added = true;
                if i <= TrainVectorClassCount
                    trainindex = trainindex + 1;
                    TrainClassMatrix(:,trainindex) = trainitems(i).vector;
                    
                    for j = 1:length(Answers)
                        if strcmp(Answers{j}, trainitems(i).class)
                            TargetClassTrainMatrix(trainindex) = j;
                        end
                    end
                    
                else
                    testindex = testindex + 1;
                    TestClassMatrix(:,testindex) = trainitems(i).vector;
                    for j = 1:length(Answers)
                        if strcmp(Answers{j}, trainitems(i).class)
                            TargetClassTestMatrix(testindex) = j;
                        end
                    end
                end
            else
                trainitems(i).Added = false;
            end
        end

      
        
end

