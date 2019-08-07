%DrawGraphs
global SIGNALTYPES
%%System Performance Graphs - RESOURCE USED
for s = 1:length(Signals)
  if(Signals{s}.type == SIGNALTYPES.RESOURCE)
    fig_title = ['RESOURCES USED: ' Signals{s}.name];
    figure('Name',fig_title,'NumberTitle','off')
    title(fig_title,'Interpreter', 'none');
    fig_ax1 = subplot(2,1,1);
    hold on
    plot(Signals{s}.timestamp,Signals{s}.data{2}.values,'color','b');
    ylabel("RAM Used (MB)")
    xlabel("Time (s)")
    hold off
    fig_ax2 = subplot(2,1,2);
    hold on
    plot(Signals{s}.timestamp,Signals{s}.data{3}.values,'color','b');
    ylabel("CPU Used (%)")
    xlabel("Time (s)")
    hold off
  end
end

%%System Performance Graphs - RESOURCE AVAILABLE
for s = 1:length(Signals)
  if(Signals{s}.type == SIGNALTYPES.RESOURCE_AVAILABLE)
    fig_title = ['RESOURCES AVAILABLE: ' Signals{s}.name];
    figure('Name',fig_title,'NumberTitle','off')
    title(fig_title,'Interpreter', 'none');
    fig_ax1 = subplot(2,1,1);
    hold on
    plot(Signals{s}.timestamp,Signals{s}.data{1}.values,'color','b');
    ylabel("RAM Free (MB)")
    xlabel("Time (s)")
    hold off
    fig_ax2 = subplot(2,1,2);
    hold on
    plot(Signals{s}.timestamp,Signals{s}.data{2}.values,'color','b');
    ylabel("CPU Free (%)")
    xlabel("Time (s)")
    hold off
  end
end

%%System Performance Graphs - LOAD FACTOR
for s = 1:length(Signals)
  if(Signals{s}.type == SIGNALTYPES.LOAD_FACTOR)
    fig_title = ['LOAD FACTOR: ' Signals{s}.name];
    figure('Name',fig_title,'NumberTitle','off')
    title(fig_title,'Interpreter', 'none');
    fig_ax1 = subplot(1,1,1);
    hold on
    plot(Signals{s}.timestamp,Signals{s}.data{1}.values,'color','b');
    plot(Signals{s}.timestamp,Signals{s}.data{2}.values,'color','g');
    plot(Signals{s}.timestamp,Signals{s}.data{3}.values,'color','r');
    legend('1 Min','5 Min','15 Min')
    set(legend,'Interpreter','none')
    xlabel("Time (s)")
    hold off
  end
end

%%System Performance Graphs - UPTIME
for s = 1:length(Signals)
  if(Signals{s}.type == SIGNALTYPES.UPTIME)
    fig_title = ['UPTIME: ' Signals{s}.name];
    figure('Name',fig_title,'NumberTitle','off')
    title(fig_title,'Interpreter', 'none');
    fig_ax1 = subplot(2,1,1);
    hold on
    plot(Signals{s}.timestamp,Signals{s}.data{1}.values,'color','b');
    legend('Runtime')
    set(legend,'Interpreter','none')
    xlabel("Time (s)")
    ylabel("Time (s)")
    hold off
    
    fig_ax2 = subplot(2,1,2);
    hold on
    plot(Signals{s}.timestamp,Signals{s}.data{2}.values,'color','b');
    legend('Uptime')
    set(legend,'Interpreter','none')
    xlabel("Time (s)")
    ylabel("Time (s)")
    hold off
  end
end