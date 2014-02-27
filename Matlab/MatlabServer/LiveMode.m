%LiveMode
%Program Variables
classnet_ann = load([net_folder CLASSNET_NAME '.mat']);
classnet_ann = classnet_ann(1).classnet;
if ~isempty(COLNET_NAME)
    colnet_ann = load([net_folder COLNET_NAME '.mat']);
    colnet_ann = colnet_ann(1).colnet;
end
if ~isempty(ROWNET_NAME)
    
rownet_ann = load([net_folder ROWNET_NAME '.mat']);
rownet_ann = rownet_ann(1).rownet;
end
livemode_run = true;

image_id = 0;
col = -1;
row = -1;
total_time = 0;
total_rate = 0;
l = 0;
class_certainty = 1;
col_certainty = 1;
row_certainty = 1;
if FLUSHIMAGE_BUFFER
    images = dir(imageprocess_folder);
    if length(images) > 2
        images(1) = [];
        images(1) = [];
        for i = 1:length(images)
            path = [imageprocess_folder '\' images(i).name];
            force_delete(path);
        end
    end
    
end
while(livemode_run)
    l = l + 1;
    t1 = tic;
    tA = t1;
    images = dir(imageprocess_folder);
    if length(images) < 3 %Nothing in this Folder
        close
        tempstr = ['No Images in Buffer.  Waiting...'];
        disp(tempstr);
        pause(.5)
        continue;
    end
    images(1) = [];
    images(1) = [];
    if DEBUGGING
        tempstr = ['Images in Buffer: ' num2str(length(images))];
        disp(tempstr);
    end
    loop(l).bufferlength = length(images);
    cur_imagepath = [imageprocess_folder '\' images(length(images)).name];
    cur_imagename = images(length(images)).name;
    image_index = str2num(cur_imagename(6:findstr(cur_imagename,'.')-1));
    cur_image = imread(cur_imagepath); %Always process the latest image
    loop(l).loadtime = toc(t1);
    t1 = tic;
    proc_image = preprocess(cur_image,SCRIPT,0,'Live');
    vector = reshape(proc_image,[],1);
    for i = 1:3
        y = classnet_ann(vector);
        class = CLASSES(vec2ind(y));
        class = class{1};
        class_certainty = y(vec2ind(y));
    end
    if ~isempty(ROWNET_NAME)
        y = rownet_ann(vector);
        row_certainty = max(y);
        row = vec2ind(y);
    end
    if ~isempty(COLNET_NAME)
        y = colnet_ann(vector);
        col_certainty = max(y);
        col = vec2ind(y);
    end
    
    loop(l).proctime = toc(t1);
    t1 = tic;
    certainty = class_certainty * row_certainty * col_certainty;
    if certainty < 0
    end
    msg = strcat('$TGT,FV,',num2str(image_index),',',class,',',num2str(col),',',num2str(row),',',num2str(round(100*certainty)),'*');
    fwrite(droneserver_socket,msg);
    if DEBUGGING
        disp([msg '\r\n'])
    end
    loop(l).sendtime = toc(t1);
    t1 = tic;
    if SHOW_IMAGES
        figure(1)
        subplot(2,1,1)
        imshow(cur_image)
        subplot(2,1,2)
        imshow(proc_image)
    end
    loop(l).showtime = toc(t1);
    t1 = tic;
    if FLUSHIMAGE_BUFFER
        force_delete(cur_imagepath);
    end
    loop(l).flushtime = toc(t1);
    total_time = toc(tA);
    total_rate = (1/total_time + total_rate)/2;
    loop(l).totalrate = total_rate;
    tempstr = ['Processing Image in: ' num2str(total_time) ' Seconds at a rate of ' num2str(total_rate) ' Hz'];
    disp(tempstr)
    
end