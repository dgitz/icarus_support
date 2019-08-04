function [signal] = get_signalbyname(Signals,name)
signal = [];
for i = 1:length(Signals)
  if(strcmp(Signals(i).name,name) == 1)
    signal = Signals(i);
    break;
  end
end