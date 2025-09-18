#!/bin/sh

prev_pwd=$(pwd)

monitor=$2

current_pwd=$(cd "$(dirname "$0")" && pwd -P)

cd $current_pwd 
source ${current_pwd}/test/bin/activate

y=$(python cfg.py $monitor | tr \' \" | jq '.workspace.y')
#x=$(python cfg.py | tr \' \" | jq '.workspace.x')

i=$((y+1))

case $1 in
y) echo $y ;;
x) echo $x ;;
i) echo $i ;;
esac

cd $prev_pwd
