	; test whether loops need to be a multiple of 4 uops to sustain uop
	; throughput

%use smartalign	
	
	iters EQU 100_000_000
	
default rel

;; just a dummy function used to subtract out the startup overhead while profiling
GLOBAL dummy1:function
dummy1:	ret


times 1234 nop
;; this macro uses short (i.e., 1 byte) nops - meaning that the uops generally won't
;; enter the uop cache because they exceed the limit of 18 instructions in a 32-byte region
%macro short_nop_test 3
GLOBAL short_nop_%3%1:function
short_nop_%3%1:
	mov rax, iters
ALIGN 32
	times %2 nop
.top:
	dec eax
	times %1-2 nop
	jnz .top
	ret
%endmacro

%assign i 3
%rep 200
	short_nop_test i, 0, aligned
	short_nop_test i, 30, misaligned
%assign i i+1
%endrep
	
	
;; macro that makes a test loop of N instructions, without macro-fusion (the nops
;; go in-between the decrement and the test)
%macro long_nop_test 3
GLOBAL long_nop_%3%1:function
long_nop_%3%1:
	mov rax, iters
ALIGN 32
	times %2 xchg ax, ax
.top:
	dec eax
	times %1-2 xchg ax, ax
	jnz .top
	ret	
%endmacro

%assign i 3
%rep 2000
	long_nop_test i, 0, aligned
	long_nop_test i, 30, mis30
	long_nop_test i, 2, mis2
%assign i i+1
%endrep

;; as above, except that this macro allows macro-fusion by placing the decrement
;; immediately before the jnz
%macro fused_nop_test 1
GLOBAL fused_nop_test%1:function
	fused_nop_test%1:
	mov rcx, iters
ALIGN 32
.top:
	times %1-1 nop
	dec rcx
	jnz .top
	ret	
%endmacro

%assign i 2
%rep 100
	fused_nop_test i
%assign i i+1
%endrep


	
	

