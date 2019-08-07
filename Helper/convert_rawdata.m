function input = convert_rawdata(tov,state,value,rms)
  
input.timestamp = tov;
    input.status = state;
    input.value = value;
    input.rms = rms;
