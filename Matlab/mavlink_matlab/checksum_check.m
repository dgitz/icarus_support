function [ ok ] = checksum_check( msg )
%msg should be entire message, i.e. start with 0xFE and end with checksum
ok = true;
%payloadlength = msg(2);

%msg = msg(2:payloadlength+6);
%orig_cksum = msg(payloadlength+7:payloadlength+8);

end

