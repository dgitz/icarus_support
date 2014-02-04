%mavgen.m
%David Gitz, 2013
%To Do:  mavlink_rcv, mavlink_xmit
close all
clear variables
clc
mavlinkref_file = [pwd '\message_definitions\v1.0\common.xml'];
mavlinkglobal_file = [pwd '\mavlink_global.m'];
mavlinkparser_file = [pwd '\mavlink_parser.m'];

global_list = [];
firstmessage = true;
firstinnermessage = true;
tree = xmlread(mavlinkref_file);
if ~exist('mystruct')
    mystruct = parseChildNodes(tree);
end
mavlinkglobal_fid = fopen(mavlinkglobal_file,'wt');
mavlinkparser_fid = fopen(mavlinkparser_file,'wt');
fprintf(mavlinkglobal_fid,['%%This file is generated automatically.\r']);
fprintf(mavlinkparser_fid,['%%This file is generated automatically.\r']);
fprintf(mavlinkparser_fid,['function [ SystemID,ComponentID,MsgType,Error ] = mavlink_parser( msg )\r']);
fprintf(mavlinkparser_fid,['Error = false;\r']);
fprintf(mavlinkparser_fid,['PayloadLength = msg(2);\r']);
fprintf(mavlinkparser_fid,['Sequence = msg(3);\r']);
fprintf(mavlinkparser_fid,['SystemID = msg(4);\r']);
fprintf(mavlinkparser_fid,['ComponentID = msg(5);\r']);
fprintf(mavlinkparser_fid,['MsgType = msg(6);\r']);
%Check for Packet Start
%Get Payload Length
%Get Packet Sequence
%Get System ID
%Get Component ID
%Message Type
%Error
for i1 = 1:length(mystruct)
    for i2 = 1:length(mystruct(i1).Children)
        
        if strcmp(mystruct(i1).Children(i2).Name,'version')
            fprintf(mavlinkglobal_fid,['MAVLINK_VERSION = ' mystruct(i1).Children(i2).Children.Data ';\r']);
        elseif strcmp(mystruct(i1).Children(i2).Name,'enums')
            fprintf(mavlinkglobal_fid,['%%Enumerations\r']);
            for i3 = 1:length(mystruct(i1).Children(i2).Children)
                if strcmp(mystruct(i1).Children(i2).Children(i3).Name,'enum')
                    fprintf(mavlinkglobal_fid,['%%' mystruct(i1).Children(i2).Children(i3).Attributes.Value '\r']);
                    for i4 = 1:length(mystruct(i1).Children(i2).Children(i3).Children)
                        if strcmp(mystruct(i1).Children(i2).Children(i3).Children(i4).Name,'entry')
                            if length(mystruct(i1).Children(i2).Children(i3).Children(i4).Attributes) > 1
                                if strcmp(mystruct(i1).Children(i2).Children(i3).Children(i4).Attributes(1).Name,'name') && (strcmp(mystruct(i1).Children(i2).Children(i3).Children(i4).Attributes(2).Name,'value'))
                                    fprintf(mavlinkglobal_fid,['global ' mystruct(i1).Children(i2).Children(i3).Children(i4).Attributes(1).Value ';\r']);
                                    fprintf(mavlinkglobal_fid,[mystruct(i1).Children(i2).Children(i3).Children(i4).Attributes(1).Value ' = ' mystruct(i1).Children(i2).Children(i3).Children(i4).Attributes(2).Value ';\r']);
                                    global_list{length(global_list)+1} = mystruct(i1).Children(i2).Children(i3).Children(i4).Attributes(1).Value;
                                end
                            end
                            
                        end
                    end
                end
            end
        elseif strcmp(mystruct(i1).Children(i2).Name,'messages')
            fprintf(mavlinkglobal_fid,['%%Messages\r']);
            for i3 = 1:length(mystruct(i1).Children(i2).Children)
                
                if strcmp(mystruct(i1).Children(i2).Children(i3).Name,'message')
                    if length(mystruct(i1).Children(i2).Children(i3).Attributes) > 1
                        if strcmp(mystruct(i1).Children(i2).Children(i3).Attributes(1).Name,'id') && (strcmp(mystruct(i1).Children(i2).Children(i3).Attributes(2).Name,'name'))
                            if firstmessage
                                firstmessage = false;
                                fprintf(mavlinkparser_fid,['switch msg(6)\r']);
                                
                            end
                            
                            fprintf(mavlinkparser_fid,['case ' mystruct(i1).Children(i2).Children(i3).Attributes(2).Value '_ID\r']);
                            global_list{length(global_list)+1} =  [mystruct(i1).Children(i2).Children(i3).Attributes(2).Value '_ID'];
                            global_list{length(global_list)+1} =  mystruct(i1).Children(i2).Children(i3).Attributes(2).Value;
                            fprintf(mavlinkglobal_fid,['global ' mystruct(i1).Children(i2).Children(i3).Attributes(2).Value '_ID;\r']);
                            fprintf(mavlinkglobal_fid,[mystruct(i1).Children(i2).Children(i3).Attributes(2).Value '_ID = ' mystruct(i1).Children(i2).Children(i3).Attributes(1).Value ';\r']);
                            fprintf(mavlinkglobal_fid,['global ' mystruct(i1).Children(i2).Children(i3).Attributes(2).Value ';\r']);
                            name = mystruct(i1).Children(i2).Children(i3).Attributes(2).Value;
                            index = 7;
                            start = 0;
                            stop = 0;
                            firstinnermessage = true;
                            for i4 = 1:length(mystruct(i1).Children(i2).Children(i3).Children)
                                
                                if strcmp(mystruct(i1).Children(i2).Children(i3).Children(i4).Name,'field')
                                    
                                    attr = mystruct(i1).Children(i2).Children(i3).Children(i4).Attributes(1).Value;
                                    for i = 1:length(mystruct(i1).Children(i2).Children(i3).Children(i4).Attributes)
                                        if strcmp(mystruct(i1).Children(i2).Children(i3).Children(i4).Attributes(i).Name,'type')
                                            class = mystruct(i1).Children(i2).Children(i3).Children(i4).Attributes(i).Value;
                                        end
                                    end
                                    myclass = '';
                                    switch class %These are all wrong
                                        case 'char'
                                            myclass = 'char';
                                        case 'uint8_t'
                                            start = index;
                                            stop = index;
                                            myclass = 'uint8';
                                        case 'int8_t'
                                             start = index;
                                            stop = index;
                                            myclass = 'int8';
                                        case 'uint16_t'
                                             start = index;
                                            stop = index + 1;
                                            myclass = 'uint16';
                                        case 'int16_t'
                                             start = index;
                                            stop = index + 1;
                                            myclass = 'int16';
                                        case 'uint32_t'
                                             start = index;
                                            stop = index + 3;
                                            myclass = 'uint32';
                                        case 'int32_t'
                                             start = index;
                                            stop = index + 3;
                                            myclass = 'int32';
                                        case 'uint64_t'
                                             start = index;
                                            stop = index + 7;
                                            myclass = 'uint64';
                                        case 'int64_t'
                                             start = index;
                                            stop = index + 7;
                                            myclass = 'int64';
                                        case 'float' 
                                            start = index;
                                            stop = index + 3;
                                            myclass = 'float';
                                        case 'double' 
                                            start = index;
                                            stop = index + 1;
                                            myclass = 'double';
                                        case 'uint8_t_mavlink_version' 
                                            start = index;
                                            stop = index;
                                            
                                    end
                                    fprintf(mavlinkglobal_fid,[name '{1}.' attr   ' = 0;\r']);
                                    if firstinnermessage
                                        fprintf(mavlinkparser_fid,[name '{length(' name ')+1']);
                                        firstinnermessage = false;
                                    else
                                        fprintf(mavlinkparser_fid,[name '{length(' name ')']);
                                    end
                                    %fprintf(mavlinkparser_fid,['}.' attr ' = ' myclass '(msg(' num2str(start) ':' num2str(stop) '));\r']);
                                    fprintf(mavlinkparser_fid,['}.' attr ' = typecast(uint8(msg(' num2str(start) ':' num2str(stop) ')),''' myclass ''');\r']);
                                    index = stop+1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
fprintf(mavlinkparser_fid,['otherwise\r']);
fprintf(mavlinkparser_fid,['Error = false;\r']);
fprintf(mavlinkparser_fid,['end\r']);
fprintf(mavlinkparser_fid,['end\r']);

fclose(mavlinkglobal_fid);
fclose(mavlinkparser_fid);
mavlinkparser_fid = fopen(mavlinkparser_file,'r+');
text = fread(mavlinkparser_fid);
quitme = false;
i = 0;
count = 0;
maxcount = 2;
while ~quitme
    i = i + 1;
    if text(i) == 13
        count = count + 1;
    end
    if count == maxcount
        quitme = true;
    end
end
fseek(mavlinkparser_fid,i,'bof');
%global_list = global_list(1:4);
fprintf(mavlinkparser_fid,['global ' global_list{1}]);
for g = 2:length(global_list)
    fprintf(mavlinkparser_fid,[' ' global_list{g}]);
end
fprintf(mavlinkparser_fid,[';\r']);
rest = char(text(i:length(text)));
fprintf(mavlinkparser_fid,rest);
fclose(mavlinkparser_fid);

runchecks;