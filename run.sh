#!/bin/bash
# Usage:
# run.sh ITERATIONS TEST [perf flags]...

. event-masks.sh

binary=./test.out

test=${3-long_nop_test}

#perf=../pmu-tools/ocperf.py
perf=perf
#mask=task-clock,cycles,instructions,\
#cpu/event=0xb1,umask=0x1,name=uops_executed_thread/,\
#cpu/event=0xe,umask=0x1,name=uops_issued_any/,\
#cpu/event=0xc2,umask=0x2,name=uops_retired_retire_slots/

#mask=cycles,instructions,lsd.uops,idq.dsb_uops,idq.dsb_uops,lsd.cycles_active

mask=cycles:u,instructions:u,cpu/event=0xa8,umask=0x1,name=lsd_uops/,cpu/event=0x79,umask=0x8,name=idq_dsb_uops/


start=${1-3}
end=${2-10}


echo "Running $test from $start to $end"

for i in $(seq $start $end); do
	$perf stat $4 $5 -e $mask $binary $test $i
done



