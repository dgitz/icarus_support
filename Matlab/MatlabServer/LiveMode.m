%LiveMode
%Program Variables
global gOperatingMode
gOperatingMode = 'Live';
global ORIG_WIDTH
Answers = {'ChiefSecurity','MinistryOfTorture','SecurityCompound','None'};
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

livemode_run = true;
killtimer = 0;
image_id = 0;
col = -1;
row = -1;
centerx = -1;
centery = -1;
total_time = 0;
total_rate = 0;
l = 0;
class_certainty = 1;
col_certainty = 1;
row_certainty = 1;
disp('starting')
while(livemode_run)
    l = l + 1;
    %try
    t1 = tic;
    tA = t1;
    packet_type = strcat(char(fread(droneserver_socket,8))');
    packet_length = str2num(strcat(char(fread(droneserver_socket,8)')));
    if strcmp(packet_type,'$CAM,DFV')
        image_vector = fread(droneserver_socket,packet_length);
        cur_image = reshape(fliplr(reshape(image_vector,3,numel(image_vector)/3).'),[64 36 3])/255;
        cur_image = imrotate(cur_image,-90);
    end
    loop(l).readtime = toc(t1);
    t1 = tic;
    for i = 1:length(id_classifiers)
        [proc_image,rects]  = preprocess(cur_image,'Live',id_classifiers(i).script,id_classifiers(i).threshold,id_classifiers(i).uppersize,id_classifiers(i).lowersize);
        vector = reshape(proc_image,[],1);
        sample = prtDataSetClass(vector');
        [a,y] = max(id_classifiers(i).knn.run(id_classifiers(i).pca.run(sample)).data);
        id_classifiers(i).y = y;
        %     if rects(1).Area > 0
        %         centerx = ceil(rects(1).Centroid(1));
        %         centery = ceil(rects(1).Centroid(2));
        %     else
        %         centerx = -1;
        %         centery = -1;
        %     end
        
        
    end
    values = unique([id_classifiers(:).y]);
    
    if length(values) > 1 %Democracy Classifier
        instances = histc([id_classifiers(:).y],values);
        for i = 1:length(values)
            [count_max,index_max] = max(instances);
            if count_max > floor(CONSENSUS * length(id_classifiers))
                y = values(index_max);
                last_y = y;
            else
                y = length(Answers);
            end
        end
    else
        y = id_classifiers(1).y;
    end
    class = Answers{y};
    loop(l).proctime = toc(t1);
    t1 = tic;
    class_certainty = 1;
    if strcmp(class,'None')
        certainty = class_certainty;
    else
        certainty = class_certainty * row_certainty * col_certainty;
    end
    if certainty < 0
    end
    header = '$TGT,DFV';
    %msg = strcat(class,',',num2str(col),',',num2str(row),',',num2str(round(100*certainty)));
    
    msg = strcat(class,',',num2str(centerx),',',num2str(centery),',',num2str(round(100*certainty)));
    send_len = length(msg);
    fwrite(droneserver_socket,header);
    fwrite(droneserver_socket,sprintf('%08d',send_len));
    fwrite(droneserver_socket,msg);
    if DEBUG
        disp([header sprintf('%08d',send_len) msg '\r\n'])
    end
    loop(l).sendtime = toc(t1);
    t1 = tic;
    if SHOW_IMAGES_RUN
        figure(1)
        clf
        subplot(2,1,1)
        imshow(cur_image)
        if rects(1).Area > 0
            hold on
            plot(centerx,centery,'b.','MarkerSize',20)
        end
        subplot(2,1,2)
        imshow(proc_image)
    end
    loop(l).showtime = toc(t1);
    total_time = toc(tA);
    total_rate = (1/total_time + total_rate)/2;
    loop(l).totalrate = total_rate;
    tempstr = ['Processing Image in: ' num2str(total_time) ' Seconds at a rate of ' num2str(total_rate) ' Hz'];
    %catch err
    %end
    %disp(tempstr)
end