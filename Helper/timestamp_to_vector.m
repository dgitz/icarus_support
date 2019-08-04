function [t] = timestamp_to_vector(sig)
  t = [];
  for i = 1:length(sig)
    t(i) = sig(i).timestamp;
  end
