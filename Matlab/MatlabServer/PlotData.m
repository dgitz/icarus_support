close all
figure(1)
hold on
plot([loop(:).readtime],'b')
plot([loop(:).proctime],'r')
plot([loop(:).sendtime],'y')
plot([loop(:).showtime],'g')
legend('Read Time','Proc Time','Send Time','Show Time')
figure(2)
plot([loop(:).totalrate],'Color',[0 1 .75])
legend('Total Rate')


tempstr = ['Avg Rate: ' num2str(sum([loop(:).totalrate])/length(loop)) ' Hz'];
disp(tempstr)
tempstr = ['Avg Proc Time: ' num2str(sum([loop(:).proctime])/length(loop)) ' sec'];
disp(tempstr)
tempstr = ['Avg Read Time: ' num2str(sum([loop(:).readtime])/length(loop)) ' sec'];
disp(tempstr)