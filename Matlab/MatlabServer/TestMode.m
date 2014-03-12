global gOperatingMode
gOperatingMode = 'Test';
LoadObject;
clear testitems Answers
if loaded
    testitems(1).class = '';
    testitems(1).path = '';
    testitems(1).origimage = [];
    testitems(1).procimage = [];
    testitems(1).vector = [];
    testcomplete = false;
    
    
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
            testitems(index).class = folderlist(i).name;
            testitems(index).path = [mydir '/' mylist(j).name];
            tempstr = mylist(j).name(11:length(mylist(j).name));
            %                 trainitems(index).centery = str2num(tempstr(1:findstr(tempstr,'_')-1));
            %                 trainitems(index).centerx = str2num(tempstr(findstr(tempstr,'_')+1:findstr(tempstr,'.')-1));
            
            
        end
    end
    mylist = dir(ENVIRONIMAGE_DIR);
    mylist(1) = [];
    mylist(1) = [];
    Answers{length(Answers)+1} = 'None';
    index = length(testitems);
    for j = 1:length(mylist)
        index = index + 1;
        testitems(index).class = 'None';
        testitems(index).path = [ENVIRONIMAGE_DIR '/' mylist(j).name];
        
    end
    sumA = 0;
    for index = 1:length(testitems)
        testitems(index).origimage = imread(testitems(index).path);
        [testitems(index).procimage,testitems(index).rects] = preprocess(testitems(index).origimage,'Train');
        
        testitems(index).vector = double(reshape(testitems(index).procimage,[],1));
        
        sample = prtDataSetClass(testitems(index).vector');
            [a,y] = max(id_knn.run(id_pca.run(sample)).data);
            
            if strcmp(Answers(y),testitems(index).class)
                sumA = sumA + 1;
            end
            success = 100*sumA/index;
            if DEBUG
                tempstr = ['Calc Class: ' Answers{y} ' Actual Class: ' testitems(index).class ' Success Rate: ' num2str(success) '%'];
                disp(tempstr)
            end
        if SHOW_IMAGES_TEST
            figure(1)
            clf
            subplot(2,1,1)
            
            imshow(testitems(index).origimage);
            subplot(2,1,2)
            imshow(testitems(index).procimage,[]);
            hold on
            %plot(trainitems(index).centerx/gRESIZE,trainitems(index).centery/gRESIZE,'r.','MarkerSize',20)
            if testitems(index).rects(1).Area > 0
                plot(testitems(index).rects(1).Centroid(1),testitems(index).rects(1).Centroid(2),'b.','MarkerSize',20)
            end
            
        end
        if DEBUG
            disp(['Loaded: ' num2str(index) '/' num2str(length(testitems)) ' patterns.']);
        end
    end
    disp(['Tested ID ' ID_NAME ' with Success Rate: ' num2str(success) '%']);
    fprintf(resultfile_id,[ID_NAME ',' gSCRIPT ',' num2str(gTHRESHOLD) ',' num2str(gLOWERSIZE) ',' num2str(gUPPERSIZE) ','  num2str(success) '\r\n']);
    
    
    
    
end