# definitions and masks for Intel PMU events not natively included in perf (from ocperf)
mite_uops='cpu/event=0x79,umask=0x4,name=idq_mite_uops/'
lds_uops='cpu/event=0xa8,umask=0x1,name=lsd_uops/'
dsb_uops='cpu/event=0x79,umask=0x8,name=idq_dsb_uops/'
