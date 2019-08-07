error_list = [];
info_list = [];
if(length(Signals) == 0)
  tempstr = ['[ERROR] No Signals Present.'];
  error_list{length(error_list)+1} = tempstr;
end
%Check for timestamp issues
max_timestamp = [];
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
  max_timestamp(length(max_timestamp)+1) = Signals{s}.timestamp(end);
end
max_time = max(max_timestamp);
for v = 1:length(max_timestamp)
  duration_perc = 100.0*(max_timestamp(v)/max_time);
  if(duration_perc < 80.0)
    tempstr = ['[WARNING] Signal: ' Signals{v}.name ' has a last timestamp of ' num2str(max_timestamp(v)) ' sec which is much less than the max timestamp of all available Signals: ' num2str(max_time) 'sec.'];
    error_list{length(error_list)+1} = tempstr;
  end
end
%Check Resource Signals
for s = 1:length(Signals)
  if(Signals{s}.type == SIGNALTYPES.RESOURCE)
    diff_pid = diff(Signals{s}.data{1}.values);
    v = find(diff_pid != 0);
    for i = 1:length(v)
      tempstr = ['[WARNING] Signal: ' Signals{s}.name ' has indicated a PID change at timestamp: ' num2str(Signals{s}.timestamp(v(i))) 'sec (' num2str(Signals{s}.timestamp(v(i))+Signals{s}.starttime) ')'];
      error_list{length(error_list)+1} = tempstr;
    end
  end
end

for e = 1:length(error_list)
  disp(error_list{e});
end
if(length(error_list) == 0)
  disp(['All Signals Checked OK.']);
end