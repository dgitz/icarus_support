%Load_GlobalDefines
eROS_Definitions;
global RINGBUFFER_SIZE;
RINGBUFFER_SIZE = 500;

global RATES;
RATES.POSE_RATE = 100;

global TIMINGCOMPENSATION_METHOD;
TIMINGCOMPENSATION_METHOD.SampleAndHold = 1;
TIMINGCOMPENSATION_METHOD.LinearExtrapolate = 2;

global SIGNALTYPES;
SIGNALTYPES.UNKNOWN = 0;
SIGNALTYPES.RESOURCE = 1;
SIGNALTYPES.RESOURCE_AVAILABLE = 2;
SIGNALTYPES.UPTIME = 3;
SIGNALTYPES.LOAD_FACTOR = 4;