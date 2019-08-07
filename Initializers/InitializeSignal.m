function [signal] = InitializeSignal(name,units)
  addpath(genpath('eROS_Definitions'));
  eROS_Definitions
  global SignalState
  signal.name = name;
  signal.units = units;
  signal.timestamp = 0;
  signal.value = 0;
  signal.rms = 0;
  signal.status = SignalState.SIGNALSTATE_UNDEFINED;
  
  