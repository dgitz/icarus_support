close all
figure(1)
hold on
plot([loop(:).loadtime],'b')
plot([loop(:).proctime],'r')
plot([loop(:).sendtime],'y')
plot([loop(:).showtime],'g')
plot([loop(:).flushtime],'k')
legend('Load Time','Proc Time','Send Time','Show Time','Flush Time')
figure(2)
plot([loop(:).totalrate],'Color',[0 1 .75])
legend('Total Rate')
figure(3)
plot([loop(:).bufferlength],'c')
legend('Buffer Length')

tempstr = ['Avg Rate: ' num2str(sum([loop(:).totalrate])/length(loop)) ' Hz'];
disp(tempstr)
tempstr = ['Avg Buffer Length: ' num2str(sum([loop(:).bufferlength])/length(loop)) ' images'];
disp(tempstr)
tempstr = ['Avg Proc Time: ' num2str(sum([loop(:).proctime])/length(loop)) ' sec'];
disp(tempstr)
tempstr = ['Avg Load Time: ' num2str(sum([loop(:).loadtime])/length(loop)) ' sec'];
disp(tempstr)