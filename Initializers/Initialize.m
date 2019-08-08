%Initialize
LoadGlobalVariables;
Load_GlobalDefines;

if(exist('Data_Loaded') == 0)
    Load_Data = 1;
elseif(Data_Loaded == 0)
  Load_Data = 1;
else
  Load_Data = 0;
end
if(Save_Images == 1)
  if(exist('output','dir') > 0)
    delete('output/*')
    rmdir('output')
  end
  mkdir('output')
end


if(Load_Data == 1)
  Signals = [];
  data_path = what(datapath_directory);
  [Data_Loaded,Signals] = LoadData(data_path.path);
else
  disp(['[NOTICE] Data already loaded.']);
end