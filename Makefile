CC = gcc
CFLAGS = -O3 -Wall

hw3: mysh.o
	gcc mysh.o -o mysh
mysh.o: mysh.c
	gcc mysh.c -c
clean:
	rm -rf mysh.o mysh
