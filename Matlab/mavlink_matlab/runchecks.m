%runchecks
close all
clear variables

mavlink_global;
%testfile = [pwd '\mavsimulate.mavlink'];
testfile = 'C:\SharedDrive\Dropbox\ICARUS\Operations Binder\Tab 2 - Checklists & Logs\Flight Log History\2013-12-6\2013-12-06 22-05-01.tlog';
testfile_fid = fopen(testfile);
filecontents = fread(testfile_fid);
fclose(testfile_fid);
Messages = '';
m = 0;
TotalCorrect = 0;
for i = 1:length(filecontents)
    try
        if filecontents(i) == 254
            m = m + 1;
            payloadlength = filecontents(i+1);
            msg = filecontents(i:(i+payloadlength+7))';
            Messages{m}.message = msg;
            if checksum_check(msg)
                [SystemID,ComponentID,MsgType,Error] = mavlink_parser(msg);
                Messages{m}.error = Error;
                if ~Error
                    TotalCorrect = TotalCorrect + 1;
                end
            end
        end
    catch err        
        Messages{m}.error = err;
    end
end
disp(['Messages Decoded Successfully: ' num2str(100*TotalCorrect/length(Messages)) '%']);
