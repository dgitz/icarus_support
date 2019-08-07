function [angle] = wrapangle(angle)
if(angle > 180)
  angle -= 360;
end
if(angle < -180)
  angle += 360;
end