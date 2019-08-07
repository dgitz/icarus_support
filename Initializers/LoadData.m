%LoadSensorData
function [loaded,signals] = LoadData(directory)
global OPERATION_MODE;
global SIGNAL_STATUS;
global VARIANCE_BUFFER_SIZE;
global SIGNALTYPES;
signals = [];
listing = dir(directory);
listing(1) = [];
listing(1) = [];
for i = 1:length(listing)
  current_directory = [directory '/' listing(i).name];
  disp(['--- Loading Data Directory: ' current_directory ' ---']);
  files = dir(current_directory);
  for j = 1:length(files)
    if(isempty(strfind(files(j).name,'.csv')) == false)
      disp(['Loading Data File: ' files(j).name]);
      fid = fopen([current_directory '/' files(j).name]);
      line = fgetl(fid);
      fclose(fid);
      cols = strsplit(line,',');
      timestamp_col_seconds = -1;
      timestamp_col_nsecs = -1;
      for k = 1:length(cols)
        if(strcmp(cols(k),'stamp.secs'))
          timestamp_col_seconds = k;
        elseif(strcmp(cols(k),'stamp.nsecs') == 1)
          timestamp_col_nsecs = k;
        end
      end
      if((timestamp_col_seconds == -1) || (timestamp_col_nsecs == -1))
        disp(['[WARNING] File: ' files(j).name ' is not currently supported.  Not loading this.']);
        continue;
      else
        data = csvread([current_directory '/' files(j).name],1,0);
        raw_timestamps = data(:,timestamp_col_seconds) + data(:,timestamp_col_nsecs)/1000000000.0;
        signal = [];
        
        
        [easy_processing,signal_type,signal_type_str,struct,name] = determine_signaltype(files(j).name);
        signal.name = name;
        
        if(signal_type != SIGNALTYPES.UNKNOWN)
          if(easy_processing == 1)
            signal.type = signal_type;
            signal.type_str = signal_type_str;
            for (k = 1:length(struct))
              signal.data{k}.name = struct(k).name;
              signal.data{k}.values = data(:,(struct(k).column));
              signal.data{k}.datatype = struct(k).datatype;
            end
          else
            a = 1;
          end
          
        else
          disp(['[WARNING] Unable to determine Signal Type file: ' files(j).name '. Not loading this.']);
          continue;
        end
        signal_exists = 0;
        for k = 1:length(signals)
          if(strcmp(signals{k}.name,signal.name) == 1)
            signal_exists = k;
          end
        end
        if(signal_exists == 0)
          timestamp = raw_timestamps-raw_timestamps(1);
          signal.starttime = raw_timestamps(1);
          signal.timestamp = timestamp;
          signals{length(signals)+1} = signal;
        else
          timestamp = raw_timestamps-signals{signal_exists}.starttime;
          signals{signal_exists}.timestamp = [signals{signal_exists}.timestamp; timestamp];
          for k = 1:length(signals{signal_exists}.data)
            signals{signal_exists}.data{k}.values = [signals{signal_exists}.data{k}.values; signal.data{k}.values];
          end
        end      
        a = 1;   
      end
      a = 1;
    end
    a = 1;
  end
  a = 1;
end
loaded = 1;