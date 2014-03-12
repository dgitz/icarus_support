new_name = 'ID_Objects';
old_name = 'Objects';

if strcmp(new_name,old_name)
    error('Need to pick a different name.')
    
end
old_dir = [pwd '/' old_name '/'];
new_dir = [pwd '/' new_name '/'];
if exist(new_dir)
    rmdir(new_dir,'s');
    %error('New Directory is not empty.');
end
mkdir(new_dir)
type_dirs = dir(old_dir);
type_dirs(1) = [];
type_dirs(1) = [];
for i = 1:length(type_dirs)
    old_file_dir = [old_dir type_dirs(i).name '/'];
    new_file_dir = [new_dir type_dirs(i).name '/'];
    mkdir(new_file_dir);
    if strcmp(type_dirs(i).name,'RESULTS')
     file_list = dir(old_file_dir);
        file_list(1) = [];
        file_list(1) = [];  
        for f = 1:length(file_list)
            copyfile([old_file_dir file_list(f).name],[new_file_dir file_list(f).name]);
        end
    else
        file_list = dir(old_file_dir);
        file_list(1) = [];
        file_list(1) = [];
        for f = 1:length(file_list)
            [tok,rem] = strtok(file_list(f).name,'_');
            [tok,rem] = strtok(rem,'_');
            filename = rem(2:findstr(rem,'.')-1);
            for b = 1:length(BEST_IDS)
                if strcmp(BEST_IDS{b},filename)
                    copyfile([old_file_dir file_list(f).name],[new_file_dir file_list(f).name])
                end
                
            end
        end
    end
    
end