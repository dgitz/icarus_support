function [v] = get_signalindexbyname(Signals,name)
v = 0;
for i = 1:length(Signals)
  if(strcmp(Signals(i).name,name) == 1)
    v = i;
    break;
  end
end