function [x_new,y_new] = leverarm_2D(La,theta)
th = theta*pi/180;
R = [cos(th) -sin(th);...
     sin(th) cos(th)];
A = [La.x La.y]';
V = R*A;
x_new = V(1);
y_new = V(2);
