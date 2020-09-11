# Chapter 1

#### Exercise 1.1

main.c
```C
#include <stdio.h>
#include <stdlib.h>

int main() {
    printf("Hello world\n");
    exit(0);
}
```

bash
```bash
gcc main.c -o main
./main
```

output
```text
Hello world
```

#### Exercise 1.2

fred.c
```C
#include <stdio.h>

void fred(int arg) {
    printf("fred: you passed %d\n", arg);
}
```

bill.c
```C
#include <stdio.h>

void bill(char* arg) {
    printf("bill: you passed %s\n", arg);
}
```

bash
```bash
gcc -o fred.c bill.c
ls *.o
```

output
```text
bill.o
fred.o
```

lib.h
```C
void bill(char*);
void fred(int);
```

program.c
```C
#include <stdio.h>
#include <stdlib.h>
#include "lib.h"

int main() {
    bill("Hello world");
    exit(0);
}
```

bash
```bash
gcc -c program.c
gcc -o program program.o bill.o
./program
```

output
```text
bill: you passed Hello world
```

bash
```bash
ar crv libfoo.a fred.o bill.o
```

output
```text
a - fred.o
a - bill.o
```

bash
```bash
ranlib libfoo.a
gcc -o program program.o libfoo.a
./program
```

output
```text
bill: you passed Hello world
```

bash
```bash
gcc -o program program.o -L. -lfoo
./program
```

output
```text
bill: you passed Hello world
```

#### Exercise 1.3

bash
```bash
man gcc
```

output
```text
GCC(1)                                                                        GNU                                                                       GCC(1)

NAME
       gcc - GNU project C and C++ compiler

SYNOPSIS
       gcc [-c|-S|-E] [-std=standard]
           [-g] [-pg] [-Olevel]
           [-Wwarn...] [-Wpedantic]
           [-Idir...] [-Ldir...]
 Manual page gcc(1) line 1 (press h for help or q to quit)
```

bash
```bash
info gcc
```

output
```text
Next: G++ and GCC

Introduction
************

This manual documents how to use the GNU compilers, as well as their
features and incompatibilities, and how to report bugs.  It corresponds
to the compilers version 8.3.0.  The internals of the GNU compilers,
including how to port them to new targets and some information about how
-----Info: (gcc-8)Top, 42 lines --Top-------------------------------------
```

# Chapter 2

#### Exercise 2.1

2_1.sh
```bash
myvar="Hi there"
echo $myvar
echo "$myvar"
echo '$myvar'
echo \$myvar

echo Enter myvar value
read myvar

echo '$myvar' equals $myvar
```

bash
```bash
sudo chmod +x 2_1.sh
./2_1.sh
```

output
```text
Hi there
Hi there
$myvar
$myvar
Enter myvar value
123
$myvar equals 123
```

#### Exercise 2.2

2_2.sh
```bash
echo "The program $0 is running"
echo "The first parameter was $1"
echo "The second parameter was $2"
```

bash
```bash
sudo chmod +x 2_1.sh
./2_1.sh foo bar
```

output
```text
The program ./2_2.sh is running
The first parameter was foo
The second parameter was bar
```

#### Exercise 2.3

2_3.sh
```bash
echo "Is it morning? yes or no."
read timeofday

if [ "$timeofday" = "yes" ]
then
        echo "Good morning"
elif [ "$timeofday" = "no" ]
then
        echo "Good afternoon"
else
        echo "Sorry, $timeofday not recognized"
        exit 1
fi
exit 0
```

bash
```bash
sudo chmod +x 2_3.sh
./2_3.sh
```

output
```
Is it morning? yes or no.
yes
Good morning
```

#### Exercise 2.4

bash
```bash
for foo in bar fud 41
do
	echo $foo
done
exit 0
```

output
```text
bar
fud
41
```

#### Exercise 2.5

bash
```bash
for file in $(ls *.sh)
do
	echo $file
done
exit 0
```

output
```text
1_1.sh
1_2.sh
1_3.sh
2_1.sh
2_2.sh
2_3.sh
2_4.sh
2_5.sh
example.sh
```

#### Exercise 2.6

2_6.sh
```bash
echo "Is it morning? Enter yeas or no"
read timeofday

case "$timeofday" in
	yes) echo "Good Morning";;
	no ) echo "Good Afternoon";;
	y  ) echo "Good Morning";;
	n  ) echo "Good Afternoon";;
	*  ) echo "Sorry, answer not recognized";;
esac
exit 0

```

bash
```bash
sudo chmod +x 2_6.sh
./2_6.sh
no
```

output
```text
Is it morning? Enter yeas or no
Good Afternoon
```

#### Exercise 2.7

2_7.sh
```bash
echo "Is it morning? Enter yeas or no"
read timeofday

case "$timeofday" in
	yes | Yes | YES | y) echo "Good Morning";;
	n* | N* )            echo "Good Afternoon";;
	*  )                 echo "Sorry, answer not recognized";;
esac
exit 0
```

bash
```bash
sudo chmod +x 2_7.sh
./2_7.sh
nine
```

output
```text
Is it morning? Enter yeas or no
Good Afternoon
```

#### Exercise 2.8

2_8.sh
```bash
echo "Is it morning? Enter yeas or no"
read timeofday

case "$timeofday" in
	yes | Yes | YES | y)
		echo "Good Morning"
		echo "Up bright and early this morning"
		;;
	[nN]* )
		echo "Good Afternoon"
		;;
	*  )
		echo "Sorry, answer not recognized"
		echo "Please answer yes or no"
		exit 1
		;;
esac
exit 0

```

bash
```bash
sudo chmod +x 2_8.sh
./2_8.sh
YES
```

output
```text
Is it morning? Enter yeas or no
Good Morning
Up bright and early this morning
```

#### Exercise 2.9

bash
```bash
touch file_one
rm -f file_two

if [ -f file_one ] && echo "hello" && [ -f file_two ] && echo " there"
then
	echo "in if"
else
	echo "in else"
fi
exit 0

```

output
```text
hello
in else
```

#### Exercise 2.10

bash
```bash
rm -f file_one

if [ -f file_one ] || echo "hello" || echo " there"
then
	echo "in if"
else
	echo "in else"
fi
exit 0

```

output
```text
hello
in if
```


#### Exercise 2.11

bash
```bash
foo() {
	echo "Function foo running"
}

echo "script starting"
foo
echo "script ended"
exit 0
```

output
```text
script starting
Function foo running
script ended
```

#### Exercise 2.12

2_12.sh
```bash
yes_or_no() {
        echo "Is your name $*?"
        while true
        do
                echo -n "Enter yes or no: "
                read x
                case "$x" in
                        y | yes ) return 0;;
                        n | no  ) return 1;;
                        *       ) echo "Answer yes or no";;
                esac
        done
}

if yes_or_no "$1"
then
        echo "Hi $1, nice name"
else
        echo "Never mind"
fi
exit 0
```

bash
```bash
sudo chmod +x ./2_12.sh
./2_12.sh Denis Glazkov
```

output
```text
Is your name Denis?
Enter yes or no: yes
Hi Denis, nice name

```

#### Exercise 2.14

2_14_1.sh
```bash
#!/bin/bash
echo "$foo"
echo "$bar"
```

2_14_2.sh
```bash
#!/bin/bash
foo="The first meta variable"
export bar="The second meta variable"
2_14_1.sh
```

bash
```bash
sudo chmod +x ./2_14_1.sh
sudo chmod +x ./2_14_2.sh
./2_14_2.sh
```

output
```text

The second meta variable
```

#### Exercise 15

2_15.sh
```bash
trap 'rm -f /tmp/my_tmp_file_$$' INT
echo Creating file /tmp/my_tmp_file_$$
date > /tmp/my_tmp_file_$$

echo "Press CTRL-C to interrupt..."
while [ -f /tmp/my_tmp_file_$$ ]; do
        echo File exists
        sleep 1
done

trap INT
echo Creating file /tmp/my_tmp_file_$$
date > /tmp/my_tmp_file_$$

echo "Press CTRL-C to interrupt..."
while [ -f /tmp/my_tmp_file_$$ ]; do
        echo File exists
        sleep 1
done

echo We never get here
exit 0
```

output
```text
Creating file /tmp/my_tmp_file_15864
Press CTRL-C to interrupt...
File exists
File exists
File exists
File exists
^C
Creating file /tmp/my_tmp_file_15864
Press CTRL-C to interrupt...
File exists
File exists
File exists
^C
```
#### Exercise 2.16

bash
```bash
find . -newer 2_14_1.sh -type f -print
```

output
```text
./2_14_2.sh
./2_15.sh
./2_16.sh
./README.md
```

#### Exercise 2.17

bash
```bash
grep \# 2_16.sh
grep -c \# 2_16.sh
grep -v -c \# 2_16.sh
```

output
```text
#!/bin/bash
#Exercise 2.16
./2_15.sh:2
./2_15.sh:1
```

#### Exercise 2.18

bash
```bash
unset foo
echo ${foo:-bar}

foo=fud
echo ${foo:-bar}

foo=/usr/bin/X11/startx
echo ${foo#*/}
echo ${foo##*/}

bar=/usr/local/etc/local/networks
echo ${bar%local*}
echo ${bar%%local*}

exit 0
```

output
```text
bar
fud
usr/bin/X11/startx
startx
/usr/local/etc/
/usr/
```

#### Exercise 2.19

bash
```bash
cat << !FUNKY!
hello
this is a here
document
!FUNKY!
```

output
```text
hello
this is a here
document
```

#### Exercise 2.20

text_file
```text
That is line 1
That is line 2
That is line 3
That is line 4
```

bash
```bash
ed text_file <<!FunkyStuff!
3
d
., \$s/is/was/
w
q
!FunkyStuff!
exit 0
```

text_file
```text
That is line 1
That is line 2
That was line 4
```