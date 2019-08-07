function [] = print_signals(signals)
for i = 1:length(signals)
  tempstr = ["Signal: " signals{i}.name " Type: " signals{i}.type_str " Index: " num2str(i) ' Contains data: '];
  for j = 1:length(signals{i}.data)
    tempstr = [tempstr signals{i}.data{j}.name '[' num2str(j) ']' ];
    if(j < length(signals{i}.data))
      tempstr = [tempstr ', '];
    end
  end
  disp(tempstr)
end