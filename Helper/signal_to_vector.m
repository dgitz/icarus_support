function [v] = signal_to_vector(sig)
  v = [];
  for i = 1:length(sig)
    v(i) = sig(i).value;
  end
