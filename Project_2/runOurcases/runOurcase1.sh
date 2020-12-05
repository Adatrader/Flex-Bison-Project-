#!/bin/bash
cd ../
rm -f a.out
rm -f lex.yy.c
rm -f toy.tab.c
rm -f toy.tab.h
rm -f toy.output
flex toy.l
bison -vd toy.y &>/dev/null
cc lex.yy.c toy.tab.c -lfl
./a.out < ourcases/ourcase1.toy > ourcases/outputs/ourcase1output.txt
./a.out < ourcases/ourcase1.toy
