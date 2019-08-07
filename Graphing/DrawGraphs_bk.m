%DrawGraphs
%Sensor Inputs: blue ('b'),cyan ('c')
%Truth: black ('k')
%Pose Outputs (from task): green ('g')
%Model Outputs: red,magenta ('r'),('m')
%Analysis: yellow ('y')
close all
%%Pose Signal Graphs

Plot_Jerk = 1;
Plot_Acceleration = 1;
Plot_AngularRate = 1;
Plot_MagneticField = 1;
Plot_Angle = 1;

if(Plot_Jerk == 1)
  fig_title = 'Pose-Jerk-X';
  figure('Name',fig_title,'NumberTitle','off')
  title(fig_title);
  fig_ax1 = subplot(1,1,1);
  hold on
  plot(Analysis_Signals.Sensor_Signals.timestamp,Analysis_Signals.System_Signals.LinearJerk.x.value,'color','r'); 
  legend("System Output")
  set(legend,'Interpreter','none')
  ylabel("Jerk (m/s^3)")
  xlabel("Time (s)")
  hold off
  
  fig_title = 'Pose-Jerk-Y';
  figure('Name',fig_title,'NumberTitle','off')
  title(fig_title);
  fig_ax1 = subplot(1,1,1);
  hold on
  plot(Analysis_Signals.Sensor_Signals.timestamp,Analysis_Signals.System_Signals.LinearJerk.y.value,'color','r'); 
  legend("System Output")
  set(legend,'Interpreter','none')
  ylabel("Jerk (m/s^3)")
  xlabel("Time (s)")
  hold off
  
  fig_title = 'Pose-Jerk-Z';
  figure('Name',fig_title,'NumberTitle','off')
  title(fig_title);
  fig_ax1 = subplot(1,1,1);
  hold on
  plot(Analysis_Signals.Sensor_Signals.timestamp,Analysis_Signals.System_Signals.LinearJerk.z.value,'color','r'); 
  legend("System Output")
  set(legend,'Interpreter','none')
  ylabel("Jerk (m/s^3)")
  xlabel("Time (s)")
  hold off

end

if(Plot_Acceleration == 1)
fig_title = 'Pose-Acceleration-X';
figure('Name',fig_title,'NumberTitle','off')
title(fig_title);
fig_ax1 = subplot(2,1,1);
hold on
[sz,~] = size(Analysis_Signals.Sensor_Signals.Acceleration.x.value);
cm = jet(sz);
leg = [];
for i = 1:sz
  plot(Analysis_Signals.Sensor_Signals.timestamp,Analysis_Signals.Sensor_Signals.Acceleration.x.value(i,:),'color',cm(i,:));
  leg{i} = Analysis_Signals.Sensor_Signals.Acceleration.x.source{i};
end  
legend(leg)
set(legend,'Interpreter','none')
ylabel("Acceleration (m/s^2)")
hold off
fig_ax2 = subplot(2,1,2);
hold on
plot(Analysis_Signals.Pose_Signals.timestamp,Analysis_Signals.Filt_Signals.LinearAcceleration.x.value,'color','r');
legend('Model Output')
xlabel("Time (s)")
ylabel("Acceleration (m/s^2)")
hold off

fig_title = 'Pose-Acceleration-Y';
figure('Name',fig_title,'NumberTitle','off')
title(fig_title);
fig_ax1 = subplot(2,1,1);
hold on
[sz,~] = size(Analysis_Signals.Sensor_Signals.Acceleration.y.value);
cm = jet(sz);
leg = [];
for i = 1:sz
  plot(Analysis_Signals.Sensor_Signals.timestamp,Analysis_Signals.Sensor_Signals.Acceleration.y.value(i,:),'color',cm(i,:));
  leg{i} = Analysis_Signals.Sensor_Signals.Acceleration.y.source{i};
end  
legend(leg)
set(legend,'Interpreter','none')
ylabel("Acceleration (m/s^2)")
hold off
fig_ax2 = subplot(2,1,2);
hold on
plot(Analysis_Signals.Pose_Signals.timestamp,Analysis_Signals.Filt_Signals.LinearAcceleration.y.value,'color','r');
legend('Model Output')
xlabel("Time (s)")
ylabel("Acceleration (m/s^2)")
hold off


fig_title = 'Pose-Acceleration-Z';
figure('Name',fig_title,'NumberTitle','off')
title(fig_title);
fig_ax1 = subplot(2,1,1);
hold on
[sz,~] = size(Analysis_Signals.Sensor_Signals.Acceleration.z.value);
cm = jet(sz);
leg = [];
for i = 1:sz
  plot(Analysis_Signals.Sensor_Signals.timestamp,Analysis_Signals.Sensor_Signals.Acceleration.z.value(i,:),'color',cm(i,:));
  leg{i} = Analysis_Signals.Sensor_Signals.Acceleration.z.source{i};
end  
legend(leg)
set(legend,'Interpreter','none')
ylabel("Acceleration (m/s^2)")
hold off
fig_ax2 = subplot(2,1,2);
hold on
plot(Analysis_Signals.Pose_Signals.timestamp,Analysis_Signals.Filt_Signals.LinearAcceleration.z.value,'color','r');
legend('Model Output')
xlabel("Time (s)")
ylabel("Acceleration (m/s^2)")
hold off

end


if(Plot_MagneticField == 1)
fig_title = 'Pose-MagneticField-X';
figure('Name',fig_title,'NumberTitle','off')
title(fig_title);
fig_ax1 = subplot(1,1,1);
hold on
[sz,~] = size(Analysis_Signals.Sensor_Signals.MagneticField.x.value);
cm = jet(sz);
leg = [];
for i = 1:sz
  plot(Analysis_Signals.Sensor_Signals.timestamp,Analysis_Signals.Sensor_Signals.MagneticField.x.value(i,:),'color',cm(i,:));
  leg{i} = Analysis_Signals.Sensor_Signals.MagneticField.x.source{i};
end  
legend(leg)
set(legend,'Interpreter','none')
ylabel("Magnetic Field (uTesla)")
xlabel("Time (s)")
hold off

fig_title = 'Pose-MagneticField-Y';
figure('Name',fig_title,'NumberTitle','off')
title(fig_title);
fig_ax1 = subplot(1,1,1);
hold on
[sz,~] = size(Analysis_Signals.Sensor_Signals.MagneticField.y.value);
cm = jet(sz);
leg = [];
for i = 1:sz
  plot(Analysis_Signals.Sensor_Signals.timestamp,Analysis_Signals.Sensor_Signals.MagneticField.y.value(i,:),'color',cm(i,:));
  leg{i} = Analysis_Signals.Sensor_Signals.MagneticField.y.source{i};
end  
legend(leg)
set(legend,'Interpreter','none')
ylabel("Magnetic Field (uTesla)")
xlabel("Time (s)")
hold off

fig_title = 'Pose-MagneticField-Z';
figure('Name',fig_title,'NumberTitle','off')
title(fig_title);
fig_ax1 = subplot(1,1,1);
hold on
[sz,~] = size(Analysis_Signals.Sensor_Signals.MagneticField.z.value);
cm = jet(sz);
leg = [];
for i = 1:sz
  plot(Analysis_Signals.Sensor_Signals.timestamp,Analysis_Signals.Sensor_Signals.MagneticField.z.value(i,:),'color',cm(i,:));
  leg{i} = Analysis_Signals.Sensor_Signals.MagneticField.z.source{i};
end  
legend(leg)
set(legend,'Interpreter','none')
ylabel("Magnetic Field (uTesla)")
xlabel("Time (s)")
hold off
end

if(Plot_AngularRate == 1)
fig_title = 'Pose-Angle Rate-X Axis';
figure('Name',fig_title,'NumberTitle','off')
title(fig_title);
fig_ax1 = subplot(2,1,1);
hold on
[sz,~] = size(Analysis_Signals.Pose_Signals.AngleRate.x.value);
cm = jet(sz);
leg = [];
for i = 1:sz
  plot(Analysis_Signals.Pose_Signals.timestamp,Analysis_Signals.Pose_Signals.AngleRate.x.value(i,:),'color',cm(i,:));
  leg{i} = Analysis_Signals.Pose_Signals.AngleRate.x.source{i};
end  
legend(leg)
set(legend,'Interpreter','none')
ylabel("Angle Rate (deg/s)")
hold off
fig_ax2 = subplot(2,1,2);
hold on
plot(Analysis_Signals.Pose_Signals.timestamp,Analysis_Signals.Filt_Signals.AngleRate.x.value,'color','r');
legend('Model Output')
xlabel("Time (s)")
ylabel("Angle Rate (deg/s)")
hold off

fig_title = 'Pose-Angle Rate-Y Axis';
figure('Name',fig_title,'NumberTitle','off')
title(fig_title);
fig_ax1 = subplot(2,1,1);
hold on
[sz,~] = size(Analysis_Signals.Pose_Signals.AngleRate.y.value);
cm = jet(sz);
leg = [];
for i = 1:sz
  plot(Analysis_Signals.Pose_Signals.timestamp,Analysis_Signals.Pose_Signals.AngleRate.y.value(i,:),'color',cm(i,:));
  leg{i} = Analysis_Signals.Pose_Signals.AngleRate.y.source{i};
end  
legend(leg)
set(legend,'Interpreter','none')
ylabel("Angle Rate (deg/s)")
hold off
fig_ax2 = subplot(2,1,2);
hold on
plot(Analysis_Signals.Pose_Signals.timestamp,Analysis_Signals.Filt_Signals.AngleRate.y.value,'color','r');
legend('Model Output')
xlabel("Time (s)")
ylabel("Angle Rate (deg/s)")
hold off

fig_title = 'Pose-Angle Rate-Z Axis';
figure('Name',fig_title,'NumberTitle','off')
title(fig_title);
fig_ax1 = subplot(2,1,1);
hold on
[sz,~] = size(Analysis_Signals.Pose_Signals.AngleRate.z.value);
cm = jet(sz);
leg = [];
for i = 1:sz
  plot(Analysis_Signals.Pose_Signals.timestamp,Analysis_Signals.Pose_Signals.AngleRate.z.value(i,:),'color',cm(i,:));
  leg{i} = Analysis_Signals.Pose_Signals.AngleRate.z.source{i};
end  
legend(leg)
set(legend,'Interpreter','none')
ylabel("Angle Rate (deg/s)")
hold off
fig_ax2 = subplot(2,1,2);
hold on
plot(Analysis_Signals.Pose_Signals.timestamp,Analysis_Signals.Filt_Signals.AngleRate.z.value,'color','r');
legend('Model Output')
xlabel("Time (s)")
ylabel("Angle Rate (deg/s)")
hold off
end

if(Plot_Angle == 1)
fig_title = 'Pose-Angle-Roll';
figure('Name',fig_title,'NumberTitle','off')
title(fig_title);
fig_ax1 = subplot(1,1,1);
hold on
[sz,~] = size(Analysis_Signals.Sensor_Signals.Angle.roll.value);
cm = jet(sz);
leg = [];
for i = 1:sz
  plot(Analysis_Signals.Sensor_Signals.timestamp,Analysis_Signals.Sensor_Signals.Angle.roll.value(i,:),'color',cm(i,:));
  leg{i} = Analysis_Signals.Sensor_Signals.Angle.roll.source{i};
end  
legend(leg)
set(legend,'Interpreter','none')
ylabel("Angle (deg)")
xlabel("Time (s)")
hold off

fig_title = 'Pose-Angle-Pitch';
figure('Name',fig_title,'NumberTitle','off')
title(fig_title);
fig_ax1 = subplot(1,1,1);
hold on
[sz,~] = size(Analysis_Signals.Sensor_Signals.Angle.pitch.value);
cm = jet(sz);
leg = [];
for i = 1:sz
  plot(Analysis_Signals.Sensor_Signals.timestamp,Analysis_Signals.Sensor_Signals.Angle.pitch.value(i,:),'color',cm(i,:));
  leg{i} = Analysis_Signals.Sensor_Signals.Angle.pitch.source{i};
end  
legend(leg)
set(legend,'Interpreter','none')
ylabel("Angle (deg)")
xlabel("Time (s)")
hold off

fig_title = 'Pose-Angle-Yaw';
figure('Name',fig_title,'NumberTitle','off')
title(fig_title);
fig_ax1 = subplot(1,1,1);
hold on
[sz,~] = size(Analysis_Signals.Sensor_Signals.Angle.yaw.value);
cm = jet(sz);
leg = [];
for i = 1:sz
  plot(Analysis_Signals.Sensor_Signals.timestamp,Analysis_Signals.Sensor_Signals.Angle.yaw.value(i,:),'color',cm(i,:));
  leg{i} = Analysis_Signals.Sensor_Signals.Angle.yaw.source{i};
end  
legend(leg)
set(legend,'Interpreter','none')
ylabel("Angle (deg)")
xlabel("Time (s)")
hold off
end

%plot(Sensor_Signals(get_signalindexbyname(Sensor_Signals,'Sim Left Encoder')).timestamp,
    %     Sensor_Signals(get_signalindexbyname(Sensor_Signals,'Sim Left Encoder')).value,'b');
    %plot(Sensor_Signals(get_signalindexbyname(Sensor_Signals,'Sim Right Encoder')).timestamp,
    %     Sensor_Signals(get_signalindexbyname(Sensor_Signals,'Sim Right Encoder')).value,'c');
    %ylabel('Encoder value (rad/s)')
    %legend({'Left Encoder Speed','Right Encoder Speed'})
    %xlim([0 master_timebase(end)])
    %hold off
    %fig1_ax2 = subplot(2,1,2);
    %hold on
    %plot(Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose Wheelspeed')).timestamp,
    %     Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose Wheelspeed')).value,'r');
    %ylabel('Speed (m/s');
    %legend({'Model Wheelspeed'})
    %xlabel('Time (s)')  
    %xlim([0 master_timebase(end)])
    %linkaxes([fig1_ax1,fig1_ax2],'x')
    %hold off

if(0)

close all
if(Op_Mode == OPERATION_MODE.ICARUS)

  if(0)
    east_min = min([min(Truth_Signals(get_signalindexbyname(Truth_Signals,'Sim Pose East')).value),...
                   min(Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose East')).value),...
                   min(Output_Signals(get_signalindexbyname(Output_Signals,'Pose East')).value)]); 
    east_max = max([max(Truth_Signals(get_signalindexbyname(Truth_Signals,'Sim Pose East')).value),...
                   max(Output_Signals(get_signalindexbyname(Output_Signals,'Pose East')).value),...
                   max(Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose East')).value)]);   
    north_min = min([min(Truth_Signals(get_signalindexbyname(Truth_Signals,'Sim Pose North')).value),...
                    min(Output_Signals(get_signalindexbyname(Output_Signals,'Pose North')).value),...
                   min(Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose North')).value)]); 
    north_max = max([max(Truth_Signals(get_signalindexbyname(Truth_Signals,'Sim Pose North')).value),...
                    max(Output_Signals(get_signalindexbyname(Output_Signals,'Pose North')).value),...
                    max(Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose North')).value)]);    
    x_min = min(east_min,north_min);
    x_max = max(east_max,north_max);
    graph_max = max(abs(x_min),abs(x_max));
    graph_min = -graph_max;  
  end
  
  if(1)
    figure('Name','Encoder','NumberTitle','off')
    fig1_ax1 = subplot(2,1,1);
    hold on
    plot(Sensor_Signals(get_signalindexbyname(Sensor_Signals,'Sim Left Encoder')).timestamp,
         Sensor_Signals(get_signalindexbyname(Sensor_Signals,'Sim Left Encoder')).value,'b');
    plot(Sensor_Signals(get_signalindexbyname(Sensor_Signals,'Sim Right Encoder')).timestamp,
         Sensor_Signals(get_signalindexbyname(Sensor_Signals,'Sim Right Encoder')).value,'c');
    ylabel('Encoder value (rad/s)')
    legend({'Left Encoder Speed','Right Encoder Speed'})
    xlim([0 master_timebase(end)])
    hold off
    fig1_ax2 = subplot(2,1,2);
    hold on
    plot(Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose Wheelspeed')).timestamp,
         Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose Wheelspeed')).value,'r');
    ylabel('Speed (m/s');
    legend({'Model Wheelspeed'})
    xlabel('Time (s)')  
    xlim([0 master_timebase(end)])
    linkaxes([fig1_ax1,fig1_ax2],'x')
    hold off
  end
  
  if(1)
    figure('Name','Yaw Rate','NumberTitle','off')
    fig2_ax1 = subplot(2,1,1);
    hold on
    plot(Truth_Signals(get_signalindexbyname(Truth_Signals,'Sim Pose Yaw Rate')).timestamp,
         Truth_Signals(get_signalindexbyname(Truth_Signals,'Sim Pose Yaw Rate')).value*180/pi,'k');
    plot(Sensor_Signals(get_signalindexbyname(Sensor_Signals,'Sim Yaw Rate')).timestamp,
         Sensor_Signals(get_signalindexbyname(Sensor_Signals,'Sim Yaw Rate')).value*180/pi,'b');
    plot(Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose Yaw Rate')).timestamp,
         Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose Yaw Rate')).value*180/pi,'r');     
    ylabel('Yaw Rate(deg/s)')
    legend({'Truth Yaw Rate','Sensor Yaw Rate','Model Yaw Rate'})
    xlim([0 master_timebase(end)])
    hold off
    fig2_ax2 = subplot(2,1,2);
    hold on
    plot(Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose Wheelspeed')).timestamp,
         Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose Wheelspeed')).value,'r');
    ylabel('Speed (m/s');
    legend({'Model Wheelspeed'})
    xlabel('Time (s)')  
    xlim([0 master_timebase(end)])
    linkaxes([fig2_ax1,fig2_ax2],'x')
    hold off
  end
  
  if(0)
    figure('Name','Yaw','NumberTitle','off')
    fig3_ax1 = subplot(1,1,1);
    hold on
    plot(Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose Yaw')).timestamp,
         Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose Yaw')).value,'r');
    
    xlabel('Time (s)')
    ylabel('Yaw (deg)')
    legend({'Model Yaw'})
    xlim([0 master_timebase(end)])
    hold off
  end
  
  if(0)
    figure('Name','2D Pose','NumberTitle','off')
    fig4_ax1 = subplot(1,1,1);
    hold on
    plot(Truth_Signals(get_signalindexbyname(Truth_Signals,'Sim Pose East')).value,
         Truth_Signals(get_signalindexbyname(Truth_Signals,'Sim Pose North')).value,'k');
    plot(Sensor_Signals(get_signalindexbyname(Sensor_Signals,'Sim GPS East')).value,
         Sensor_Signals(get_signalindexbyname(Sensor_Signals,'Sim GPS North')).value,'b');
    plot(Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose East')).value,
         Pose_Signals(get_signalindexbyname(Pose_Signals,'Pose North')).value,'r');
    plot(Output_Signals(get_signalindexbyname(Output_Signals,'Pose East')).value,
         Output_Signals(get_signalindexbyname(Output_Signals,'Pose North')).value,'g');
    
    
    xlabel('East (m)')
    ylabel('North (m)')
    legend({'Truth Pose','GPS Pose','Model Pose','Pose Output'})
    axis square
    xlim([x_min x_max]);
    ylim([x_min x_max]);
    hold off
  end
  
  if(0)
    figure('Name','Pose Easting Error','NumberTitle','off')
    fig5_ax1 = subplot(2,1,1);
    hold on
    hist(Analysis_Signals(get_signalindexbyname(Analysis_Signals,'Model Easting Error')).value,50,'r');
    hist(Analysis_Signals(get_signalindexbyname(Analysis_Signals,'Pose Easting Error')).value,50,'g');
    ylabel('Count');
    legend({'Model East','Pose Output East'});
    hold off
    fig5_ax2 = subplot(2,1,2);
    hold on
    hist(Analysis_Signals(get_signalindexbyname(Analysis_Signals,'Model Northing Error')).value,50,'r');
    hist(Analysis_Signals(get_signalindexbyname(Analysis_Signals,'Pose Northing Error')).value,50,'g');
    xlabel('Error (m)')
    ylabel('Count')
    legend({'Model North','Pose Output North'})
    hold off
  end
  

  
end
end