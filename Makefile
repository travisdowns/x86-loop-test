.PHONY: all run run-skylake test clean

all: test.out

clean:
	rm -f *.o test.out

run: all
	./run.sh

test.out: loop-main.o loop-test.o
	gcc loop-main.o loop-test.o -ldl -rdynamic -o test.out

loop-test.o: loop-test.s
	nasm -w+all -f elf64 -l loop-test.list loop-test.s

loop-main.o: loop-main.c
	gcc -c -O2 loop-main.c

test: test.out
	./test.out
