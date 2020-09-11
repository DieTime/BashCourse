#!/bin/bash
#Exercise 1.2
#gcc -o fred.c bill.c
#ls *.o
#gcc -c program.c
#gcc -o program program.o bill.o
#./program
#ar crv libfoo.a fred.o bill.o
#ranlib libfoo.a
#gcc -o program program.o libfoo.a
#./program
gcc -o program program.o -L. -lfoo
./program
