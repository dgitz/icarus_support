function [ newim,rects ] = preprocess( im,mode,script,threshold,uppersize,lowersize,erodesize )
global gRESIZE;
global gROW_SECTORS;
global gCOL_SECTORS;
global gSCRIPT;
global gTHRESHOLD;
global gLOWERSIZE;
global gUPPERSIZE;
global gSHOW_HELP_IMAGES_PREPROCESS;
global gERODE_SIZE
if strcmp(mode,'Sim') || strcmp(mode,'Live')
    resizeim = imresize(im,1/gRESIZE);
    mythreshold = threshold;
    myuppersize = uppersize;
    mylowersize = lowersize;
    myscript = script;
    myerodesize = erodesize;
elseif strcmp(mode,'Train')
    mythreshold = gTHRESHOLD;
    myuppersize = gUPPERSIZE;
    mylowersize = gLOWERSIZE;
    myscript = gSCRIPT;
    myerodesize = gERODE_SIZE;
else
    return
end
% mythreshold = .5;
% myuppersize = 2000;
% mylowersize = 10;
% myscript = 'Script1';
if strcmp(myscript,'Script1')
    
    if strcmp(mode,'Live')
        resizeim = im;
    elseif strcmp(mode,'Train')
        resizeim = im;%imresize(im,1/gRESIZE);
    elseif strcmp(mode,'Init')
        return
    elseif strcmp(mode,'Sim')
        resizeim = im;%imresize(im,1/gRESIZE);
    end
    
    %newim = rgb2hsv(resizeim);
    
    gray = resizeim;%newim(:,:,2);
    bw = im2bw(gray,mythreshold);
    
    myfilter = zeros(size(bw));
    
    %se = strel('rectangle',[8,8]);
    %bw = imerode(bw,se);
    
    bw = imfill(bw,'holes');
    se = strel('rectangle',[myerodesize,myerodesize]);
    bw = imerode(bw,se);
    stats = [regionprops(bw);];% regionprops(not(bw));];% regionprops(not(bw))]
    Afields = fieldnames(stats);
    Acell = struct2cell(stats);
    sz = size(Acell);
    Acell = reshape(Acell,sz(1),[]);
    Acell = Acell';
    Acell = sortrows(Acell,1);
    Acell = reshape(Acell',sz);
    stats = cell2struct(Acell,Afields,1);
    stats = flipud(stats);
    index = 0;
    for i = 1:length(stats)
        boxarea = stats(i).BoundingBox(3)*stats(i).BoundingBox(4);
        if boxarea < myuppersize && boxarea > mylowersize
            if stats(i).BoundingBox(3) > stats(i).BoundingBox(4)
                index = index + 1;
                rects(index) = stats(i);
            end
        else
        end
        
    end
    if ~exist('rects')
        rects(1).Area = 0;
    end
    if gSHOW_HELP_IMAGES_PREPROCESS
            fig1 = figure(2);
            clf
            subplot(3,1,1)
        
            imshow(resizeim)
            title('Orig Image')
            hold on
    end
    if rects(1).Area > 0
        %disp(['Rects: ' num2str(length(rects))]);
        for i = 1:numel(rects)
            if gSHOW_HELP_IMAGES_PREPROCESS
                        rectangle('Position', rects(i).BoundingBox, ...
                            'Linewidth', 3, 'EdgeColor', 'r', 'LineStyle', '--');
            end
            myfilter(ceil(rects(i).BoundingBox(2)):floor(rects(i).BoundingBox(2)+rects(i).BoundingBox(4)),...
                ceil(rects(i).BoundingBox(1)):floor(rects(i).BoundingBox(1)+rects(i).BoundingBox(3))) = 1;
        end
        
        
    end
    
    
    
    newim = (double(gray)/256) .* bw;
    if gSHOW_HELP_IMAGES_PREPROCESS
        subplot(3,1,2)
        imshow(bw)
        title('BW Image')
        subplot(3,1,3)
    
        imshow(newim)
        title('Filtered Image')
    end
end

end

% %newim = imerode(newim,se);
%     stats = [regionprops(bw);];% regionprops(not(bw));];% regionprops(not(bw))]
%     Afields = fieldnames(stats);
%     Acell = struct2cell(stats);
%     sz = size(Acell);
%     Acell = reshape(Acell,sz(1),[]);
%     Acell = Acell';
%     Acell = sortrows(Acell,1);
%     Acell = reshape(Acell',sz);
%     stats = cell2struct(Acell,Afields,1);
%     stats = flipud(stats);
%     index = 0;
%
%     for i = 1:length(stats)
%         boxarea = stats(i).BoundingBox(3)*stats(i).BoundingBox(4);
%         if boxarea < myuppersize && boxarea > mylowersize
%             if stats(i).BoundingBox(3) > stats(i).BoundingBox(4)
%                 index = index + 1;
%                 rects(index) = stats(i);
%             end
%         else
%         end
%
%     end
%     if ~exist('rects')
%         rects(1).Area = 0;
%     end
%      if rects(1).Area > 0
%         disp(['Rects: ' num2str(length(rects))]);
%         for i = 1:numel(rects)
%                          rectangle('Position', rects(i).BoundingBox, ...
%                              'Linewidth', 3, 'EdgeColor', 'r', 'LineStyle', '--');
%             myfilter(ceil(rects(i).BoundingBox(2)):floor(rects(i).BoundingBox(2)+rects(i).BoundingBox(4)),...
%                 ceil(rects(i).BoundingBox(1)):floor(rects(i).BoundingBox(1)+rects(i).BoundingBox(3))) = 1;
%         end
%
%
%     end