%DrawGraphs

figlist = [];
global SIGNALTYPES
%%System Performance Graphs - RESOURCE USED
if(1)
for s = 1:length(Signals)
  if(Signals{s}.type == SIGNALTYPES.RESOURCE)
    fig_title = ['RESOURCES USED: ' Signals{s}.name];
    fig = figure('Name',fig_title,'NumberTitle','off');
    fig_ax1 = subplot(2,1,1);
    title(fig_title,'Interpreter', 'none');
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
    figlist{length(figlist)+1}.title = fig_title;
    figlist{length(figlist)}.figure = fig;
  end
end
end
%%System Performance Graphs - RESOURCE AVAILABLE
if(1)
for s = 1:length(Signals)
  if(Signals{s}.type == SIGNALTYPES.RESOURCE_AVAILABLE)
    fig_title = ['RESOURCES AVAILABLE: ' Signals{s}.name];
    fig = figure('Name',fig_title,'NumberTitle','off');
    fig_ax1 = subplot(3,1,1);
    title(fig_title,'Interpreter', 'none');
    hold on
    plot(Signals{s}.timestamp,Signals{s}.data{3}.values,'color','b');
    ylabel("RAM Free (%)")
    xlabel("Time (s)")
    hold off
    fig_ax2 = subplot(3,1,2);
    hold on
    plot(Signals{s}.timestamp,Signals{s}.data{2}.values,'color','b');
    ylabel("CPU Free (%)")
    xlabel("Time (s)")
    hold off
    fig_ax3 = subplot(3,1,3);
    hold on
    plot(Signals{s}.timestamp,Signals{s}.data{4}.values,'color','b');
    ylabel("DISK Free (%)")
    xlabel("Time (s)")
    hold off
    figlist{length(figlist)+1}.title = fig_title;
    figlist{length(figlist)}.figure = fig;
  end
end
end

%%System Performance Graphs - LOAD FACTOR
if(1)
for s = 1:length(Signals)
  if(Signals{s}.type == SIGNALTYPES.LOAD_FACTOR)
    fig_title = ['LOAD FACTOR: ' Signals{s}.name];
    fig = figure('Name',fig_title,'NumberTitle','off');
    fig_ax1 = subplot(1,1,1);
    title(fig_title,'Interpreter', 'none');
    hold on
    plot(Signals{s}.timestamp,Signals{s}.data{1}.values,'color','b');
    plot(Signals{s}.timestamp,Signals{s}.data{2}.values,'color','g');
    plot(Signals{s}.timestamp,Signals{s}.data{3}.values,'color','r');
    legend('1 Min','5 Min','15 Min')
    set(legend,'Interpreter','none')
    xlabel("Time (s)")
    hold off
    figlist{length(figlist)+1}.title = fig_title;
    figlist{length(figlist)}.figure = fig;
  end
end
end

%%System Performance Graphs - UPTIME
if(1)
for s = 1:length(Signals)
  if(Signals{s}.type == SIGNALTYPES.UPTIME)
    fig_title = ['UPTIME: ' Signals{s}.name];
    fig = figure('Name',fig_title,'NumberTitle','off');
    fig_ax1 = subplot(2,1,1);
    title(fig_title,'Interpreter', 'none');
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
    
    figlist{length(figlist)+1}.title = fig_title;
    figlist{length(figlist)}.figure = fig;
  end
end
end
if(Save_Images == 1)
  for f = 1:length(figlist)
    disp(['[' num2str(f) '] Saving Figure: ' figlist{f}.title]);
    %saveas(figlist{f}.figure,['output/' figlist{f}.title '.png']);
    print(figlist{f}.figure,['output/' figlist{f}.title],'-dpng')
  end
end