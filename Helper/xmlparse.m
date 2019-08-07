%%% NOT WORKING
function [obj] = xmlparse(file)
obj = [];
fid = fopen(file);
if(fid < 0)
  obj = fid;
  return 
end
obj.children = [];
empty_child.name = "";
empty_child.parent = [];
empty_child.text = "";
empty_child.attrib = "";
empty_child.children = [];
current_tag_name = "";
level = 0;
line = fgetl(fid);
while ischar(line)
  if(strfind(line,"<?")) %Version number, ignore
  elseif(strfind(line,"<")) %Some tag entry (either start or end)
    index_of_tag = strfind(line,"<");
    if(length(index_of_tag) == 1)
      if(line(index_of_tag+1) == "/") %It is an end tag
        level = level -1;
      else %It is a start tag
        level = level + 1;
        current_tag_name = line(index_of_tag+1:strfind(line,">")-1);
        obj_field = "obj";
        for i = 1:(level-1)
          obj_field = [obj_field ".children{:}"];
        end
        new_obj_field = [obj_field ".children{length(" obj_field ")+1}"];
        %cur_obj_field = [obj_field ".children{length(" obj_field ".children)}"];
        eval([new_obj_field ".name = current_tag_name"]);
        
      end
    else
      disp(["LINE: " line  " NOT SUPPORTED"]);
    end
  else
  end
  
  if(strfind(line,"</")) %line also contains end tag
  end
  %disp(line)
  line = fgetl(fid);
end
fclose(fid);
