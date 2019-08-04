error_list = [];
%Check for timestamp issues
for s = 1:length(Signals)
  dt = diff(Signals{s}.timestamp);
  min_dt = min(dt);
  if(min_dt < 0.0)
    tempstr = ['[WARNING] Signal: ' Signals{s}.name ' has a non-monotomic timestamp.'];
    error_list{length(error_list)+1} = tempstr;
  end
  avg_dt = sum(dt)/length(dt);
  max_dt = max(dt);
  if(max_dt > 5*avg_dt)
    tempstr = ['[WARNING] Signal: ' Signals{s}.name ' is likely missing data.'];
    error_list{length(error_list)+1} = tempstr;
  end
  a = 1;
end

%Check Resource Signals
for s = 1:length(Signals)
  if(Signals{s}.type == SIGNALTYPES.RESOURCE)
  end
end

for e = 1:length(error_list)
  disp(error_list{e});
end
if(length(error_list) == 0)
  disp(['All Signals Checked OK.']);
end