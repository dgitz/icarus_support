%Test
%Test Connection to Remote Client
xmitmode = 'TCP';
if xmitmode == 'UDP'
    rport = 9091;
    myport = 9090;
    rhost = '192.168.0.111';
    s = udp(rhost,rport,'LocalPort',myport)
elseif xmitmode == 'TCP'
    rport = 5005;
    rhost = '192.168.0.111';
    s = tcpip(rhost,rport,'NetworkRole','server');
    set(s, 'InputBufferSize', 3500000);
    set(s,'Terminator','*')
    %ss.InputBufferSize = 1000000;
end

fopen(s);
while 1
    A = fscanf(s);
    length(A)
    
    
end

fclose(s);