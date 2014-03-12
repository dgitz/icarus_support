new_name = 'ID_Objects';
old_name = 'Objects';

if strcmp(new_name,old_name)
    error('Need to pick a different name.')
    
end
old_dir = [pwd '/' old_name '/'];
new_dir = [pwd '/' new_name '/'];
if exist(new_dir)
    rmdir(new_dir,'s');
end
mkdir(new_dir)
type_dirs = dir(old_dir);
type_dirs(1) = [];
type_dirs(1) = [];
for i = 1:length(type_dirs)

end