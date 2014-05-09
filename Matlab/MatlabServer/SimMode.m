global gOperatingMode
gOperatingMode = 'Sim';

mode = 'democracy'; %average, democracy
democracy_count = 0;
for i = 1:length(BEST_IDS)
    ID_NAME = BEST_IDS{i};
    LoadObject;
    id_classifiers(i).id_name = ID_NAME;
    id_classifiers(i).pca = id_pca;
    id_classifiers(i).knn = id_knn;
    id_classifiers(i).script = gSCRIPT;
    id_classifiers(i).threshold = gTHRESHOLD;
    id_classifiers(i).lowersize = gLOWERSIZE;
    id_classifiers(i).uppersize = gUPPERSIZE;
end
clear simitems Answers
if loaded
    simitems(1).class = '';
    simitems(1).path = '';
    simitems(1).origimage = [];
    simitems(1).procimage = [];
    simitems(1).vector = [];
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
            simitems(index).class = folderlist(i).name;
            simitems(index).path = [mydir '/' mylist(j).name];
            tempstr = mylist(j).name(11:length(mylist(j).name));
            %                 trainitems(index).centery = str2num(tempstr(1:findstr(tempstr,'_')-1));
            %                 trainitems(index).centerx = str2num(tempstr(findstr(tempstr,'_')+1:findstr(tempstr,'.')-1));
            
            
        end
    end
    mylist = dir(ENVIRONIMAGE_DIR);
    mylist(1) = [];
    mylist(1) = [];
    Answers{length(Answers)+1} = 'None';
    index = length(simitems);
    for j = 1:length(mylist)
        index = index + 1;
        simitems(index).class = 'None';
        simitems(index).path = [ENVIRONIMAGE_DIR '/' mylist(j).name];
        
    end
    sumA = 0;
    last_y = 1;
    loopcount = 0;
    for index = 1:length(simitems)
        loopcount = loopcount + 1;
        timer_read = tic;
        simitems(index).origimage = imread(simitems(index).path);
        %preprocess( im,mode,script,threshold,uppersize,lowersize )
        
        loop(loopcount).readtime = toc(timer_read);
        timer_proc = tic;
        rect_x = 0;
        rect_y = 0;
        counter = 0;
        for i = 1:length(id_classifiers)
            %[proc_image,rects] =
            [proc_image,rects] = preprocess(simitems(index).origimage,'Train',id_classifiers(i).script,id_classifiers(i).threshold,id_classifiers(i).uppersize,id_classifiers(i).lowersize);
            vector = double(reshape(proc_image,[],1));
            
            sample = prtDataSetClass(vector');
            [a,y] = max(id_classifiers(i).knn.run(id_classifiers(i).pca.run(sample)).data);
            id_classifiers(i).y = y;
            my_rects(i).rect = rects(1);
            if rects(1).Area > 0
                counter = counter + 1;
                rect_x = rect_x + rects(1).Centroid(1);
                rect_y = rect_y + rects(1).Centroid(2);
            end
            
        end
        rect_x = rect_x/counter;
        rect_y = rect_y/counter;
        if strcmp(mode,'democracy')
            values = unique([id_classifiers(:).y]);
            
            if length(values) > 1 %Democracy Classifier
                instances = histc([id_classifiers(:).y],values);
                for i = 1:length(values)
                    [count_max,index_max] = max(instances);
                    if count_max > floor(CONSENSUS * length(id_classifiers))
                        y = values(index_max);
                        last_y = y;
                    else
                        y = length(Answers);%last_y;
                        democracy_count = democracy_count + 1;
                    end
                end
            end
        elseif strcmp(mode,'average')
            
            y = ceil(sum([id_classifiers(:).y])/length(id_classifiers)); %Averaging Method
        end
        loop(loopcount).proctime = toc(timer_proc);
        loop(loopcount).sendtime = 0;
        timer_measure = tic;
        if strcmp(Answers(y),simitems(index).class)
            sumA = sumA + 1;
        end
        success = 100*sumA/index;
        if DEBUG
            tempstr = ['Calc Class: ' Answers{y} ' Actual Class: ' simitems(index).class ' Success Rate: ' num2str(success) '%'];
            disp(tempstr)
        end
        loop(loopcount).measuretime = toc(timer_measure);
        timer_show = tic;
        if SHOW_IMAGES_SIM
            figure(1)
            clf
            %subplot(2,1,1)
            
            imshow(simitems(index).origimage);
            hold on
            plot(rect_x,rect_y,'b.','MarkerSize',20)
            if strcmp(Answers(y),simitems(index).class)
                color = 'g';
            else
                color = 'r';
            end
            tempstr = [Answers{y} ' ' num2str(success) '%'];
            text('units','pixels','position',[25 25],'fontsize',10,'color',color,'string',tempstr) 
            
        end
        loop(loopcount).showtime = toc(timer_measure);
        loop(loopcount).etime = loop(loopcount).readtime + loop(loopcount).proctime + loop(loopcount).measuretime + loop(loopcount).showtime;
        loop(loopcount).totalrate = 1/loop(loopcount).etime;
        if DEBUG
            disp(['Testing: ' num2str(index) '/' num2str(length(simitems)) ' patterns at a rate of ' num2str(loop(loopcount).totalrate) ' Hz.']);
        end
    end
    disp(['Tested ID ' ID_NAME ' with Success Rate: ' num2str(success) '%']);
    %fprintf(resultfile_id,[ID_NAME ',' gSCRIPT ',' num2str(gTHRESHOLD) ',' num2str(gLOWERSIZE) ',' num2str(gUPPERSIZE) ','  num2str(success) '\r\n']);
    
    
    
    
end