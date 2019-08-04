%Initialize
LoadGlobalVariables;
SaveResults = 0;
Load_GlobalDefines;
Load_Data = 0;
%Load_Data = 1;  %Load every time
if(exist('Data_Loaded') == 0)
    Load_Data = 1;
elseif(Data_Loaded == 0)
  Load_Data = 1;
end


if(Load_Data == 1)
  Signals = [];
  data_path = what(datapath_directory);
  [Data_Loaded,Signals] = LoadData(data_path.path);
else
  disp(['[NOTICE] Data already loaded.']);
end