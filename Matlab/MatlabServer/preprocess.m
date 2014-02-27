function [ newim ] = preprocess( im,script,factor,mode )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if script == 'Script1'
newim = rgb2gray(im);
newim = imresize(newim,.5);
elseif script == 'Script2'
    if mode == 'Live'
         newim = im;
    elseif mode == 'Train'
         newim = imresize(im,.5);
    end
    newim = imresize(im,.5);
    newim = rgb2hsv(newim);
    newim = newim(:,:,3);
    newim = im2bw(newim,.8);
elseif script == 'Script3'
    
    filter = rgb2hsv(im);

    filter = filter(:,:,3);
    filter = im2bw(filter,.8);
    filter = double(filter)/255;
    newim = zeros(size(im));
    
    newim(:,:,1) = double(im(:,:,1)) .* filter;
    newim(:,:,2) = double(im(:,:,2)) .* filter;
    newim(:,:,3) = double(im(:,:,3)) .* filter;
    newim = 255*newim;
    newim = rgb2gray(newim);
elseif script == 'Script4'
    if mode == 'Live'
         newim = im;
    elseif mode == 'Train'
         newim = imresize(im,.1);
    end
   
    newim = rgb2hsv(newim);
    newim = newim(:,:,3);
    newim = im2bw(newim,.8);
end
end

