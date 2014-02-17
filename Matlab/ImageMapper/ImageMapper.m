%Main
%This Program allows the user to specify a folder of images, and the
%program shows each image in succession and prompts the user to click a
%bounding box of the target interest.  The program then saves the image
%with the target's center point in the filename, in the format:
%TargetName_Index_CenterY_CenterX.xyz

close all
clear all
clc

originfolder = [pwd '../../../../icarus_drone_server/media/UnmappedImages'];
%originfolder = [cd '..\..\icarus_drone_server\media\UnmapedImages'];
finishfolder = [pwd '../../../../icarus_drone_server/media/RealImages'];
folderlist = dir(originfolder);
for i = 3:length(folderlist)
    tempstr = [num2str(i-2) '. ' folderlist(i).name];
    disp(tempstr)
end
pick = input('Select a directory to process: ','s');
if isempty(pick)
    pick = length(folderlist);
else
    pick = str2num(pick)+2;
end
processfolder = [originfolder '\' folderlist(pick).name '\'];
finishfolder = [finishfolder '\' folderlist(pick).name '\'];
pics = dir(processfolder);
pics(1) = [];
pics(1) = [];
if exist(finishfolder,'file') > 0
    str = input('This directory already exists.  Proceed? [Y/N] ','s');
    if (str == 'Y')
        rmdir(finishfolder,'s');
        mkdir(finishfolder);
    else
        return
    end
else
    mkdir(finishfolder);
end
tempstr = ['Now ' num2str(length(pics)) ' images will be shown to you.  For each image, pick a bounding box designating the desired target.'];
disp(tempstr)
for p =1:length(pics)
    imfile = [processfolder '\' pics(p).name];
    figure(p)
    imshow(imfile)
    rect = getrect;
    xmin = rect(1);
    ymin = rect(2);
    width = rect(3);
    height = rect(4);
    xcenter = floor(xmin + width/2);
    ycenter = floor(ymin + height/2);
    hold on;
    plot(xcenter,ycenter,'r.','MarkerSize',20)
    pause(.1)
    close(p);
    source = imfile;
    newfile = [pics(p).name(1:findstr(pics(p).name,'.')-1) '_' num2str(ycenter) '_' num2str(xcenter) pics(p).name(findstr(pics(p).name,'.'):length(pics(p).name))];
    dest = [finishfolder newfile];
    copyfile(source,dest);
    %dest = [finishfolder '
end
rmdir(processfolder,'s');
