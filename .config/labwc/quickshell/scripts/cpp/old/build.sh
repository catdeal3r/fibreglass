#!/bin/bash

function build_test()
{
	g++ -o ./fb.out ./fibreglass.cpp ./class_pri.hpp ./class_pub.hpp && compiled=true
	if [[ "$1" == "--run" ]] && [[ "$complied" == "true" ]]; then
		./fb.out $2
	fi
}

function build_fin()
{
	killall quickshell
	g++ -o ../fibreglass ./fibreglass.cpp ./class_pri.hpp ./class_pub.hpp && compiled=true
	if [[ "$1" == "--run" ]] && [[ "$complied" == "true" ]]; then
		../fb.out $2
	fi

	$(which quickshell) > /dev/null 2>&1 & disown
}

case $1 in
release) build_fin $2 $3 ;;
debug) build_test $2 $3 ;;
esac
