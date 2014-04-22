close all

avgreadtime = sum([loop(:).readtime])/loopcount;
avgproctime = sum([loop(:).proctime])/loopcount;
avgshowtime = sum([loop(:).showtime])/loopcount;
avgtime = sum([loop(:).etime])/loopcount; 
avgrate = sum([loop(:).rate])/loopcount;
tempstr=['Read: ' num2str(avgreadtime) ' Proc: ' num2str(avgproctime) ' Show: ' num2str(avgshowtime) ...
    ' Time: ' num2str(avgtime) ' Rate: ' num2str(avgrate)];
disp(tempstr)
figure(1)
hold on
plot([loop(:).readtime],'b')
plot([loop(:).proctime],'r')
plot([loop(:).showtime],'g')
plot([loop(:).etime],'k')
legend('Read Time','Proc Time','Show Time','Total Time')
figure(2)
plot([loop(:).rate],'k')
legend('Rate')