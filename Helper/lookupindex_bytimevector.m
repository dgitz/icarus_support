function [v] = lookupindex_bytimevector(time_vector,t)
for i = 1:length(time_vector)
  if(time_vector(i) >= t)
    v = i;
    return;
  end
end
v = 0;
return;