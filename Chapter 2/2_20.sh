#!/bin/bash
#Exercise 2.20
ed text_file <<!FunkyStuff!
3
d
., \$s/is/was/
w
q
!FunkyStuff!
exit 0
