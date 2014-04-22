%tcptest
close all
clear variables
clc

droneserver_socket = tcpip('0.0.0.0',5005,'NetworkRole','server');
droneserver_socket.InputBufferSize = 1000000;
fopen(droneserver_socket)
orig_width = 179;
orig_height = 179;
resize = 1;
channels = 1;
method = 2;
loopcount = 0;
disp('working')
while(1)
    
    packet_type = strcat(char(fread(droneserver_socket,8))');
    packet_length = str2num(strcat(char(fread(droneserver_socket,8)')));
    
    if strcmp(packet_type,'$CAM,DFV')
        loopcount = loopcount+1;
        timerA = tic;
        image_vector = fread(droneserver_socket,packet_length);
        loop(loopcount).readtime = toc(timerA);
        timerB = tic;
        switch method
            
            case 1
                cur_image = reshape(fliplr(reshape(image_vector,3,numel(image_vector)/3).'),[orig_width/resize orig_height/resize channels])/256;
                cur_image = imrotate(cur_image,-90);
            case 2
                cur_image = reshape(fliplr(reshape(image_vector,1,numel(image_vector)/1).'),[orig_width/resize orig_height/resize])/256;
                cur_image = imrotate(cur_image,-90);
        end
        loop(loopcount).proctime = toc(timerB);
        timerC = tic;
%         figure(1)
%         clf
%         subplot(2,1,1)
%         imshow(cur_image)
        loop(loopcount).showtime = toc(timerC);
        loop(loopcount).etime = loop(loopcount).readtime + loop(loopcount).proctime + loop(loopcount).showtime;
        loop(loopcount).rate = 1/loop(loopcount).etime;
    end
    
end
