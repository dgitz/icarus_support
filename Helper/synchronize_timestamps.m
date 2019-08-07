function [signals] = synchronize_timestamps(timebase,rate,signals)
max_time = 0.0;
global SIGNAL_STATUS;
for i = 1:length(signals)
  if(signals(i).timestamp(end) > max_time)
    max_time = signals(i).timestamp(end);
  end
end
master_timebase = 0:1/rate:max_time;
for i = 1:length(signals)
  new_value = [];
  new_rms = [];
  new_status = [];
  old_index = 1;
  for t = 1:length(master_timebase)
    if(old_index < length(signals(i).timestamp))
      if(master_timebase(t) > signals(i).timestamp(old_index+1))
        old_index = old_index +1;
        new_status(t) = SIGNAL_STATUS.UPDATED;
      else
        new_status(t) = SIGNAL_STATUS.HOLD;
      end
    else
      new_status(t) = SIGNAL_STATUS.HOLD;
    end
    new_value(length(new_value)+1) = signals(i).value(old_index);
    new_rms(length(new_rms)+1) = signals(i).rms(old_index);
   
  end
  signals(i).timestamp = master_timebase;
  signals(i).value = new_value;
  signals(i).status = new_status;
  signals(i).rms = new_rms;
end
for i = 1:length(signals)
  if(length(timebase) > length(signals(i).timestamp))
    a = 1;
  elseif(length(timebase) < length(signals(i).timestamp))
    signals(i).timestamp(length(timebase)+1:end) = [];
    signals(i).value(length(timebase)+1:end) = [];
    signals(i).status(length(timebase)+1:end) = [];
    signals(i).rms(length(timebase)+1:end) = [];
  end
end