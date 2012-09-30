#!/bin/bash

for i in `ls *.asm`;
do
NAME=`echo $i|sed 's/\.asm$//'`;
echo "as -g --gestabs+ -o temp/$NAME\.o $i";
as $i -o temp/$NAME\.o;
done;
