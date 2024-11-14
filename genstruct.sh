#!/bin/bash

get_random_words() {
	# generates '$1' words randomly
	random_words=$(shuf -n $1 /usr/share/dict/french)
}

get_random_text() {
	# generates text with random characters with a size of '$1'
	random_text=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c $1)
}

mk_random_files() {
	# generates random files into '$1' directory
	local target_dir=$1
	# generates text files with words 
	for nbfiles in $(seq 1 $((3 + $RANDOM % 2))) ; do
		get_random_text $(( 1 + $RANDOM % 16))
		local file_path="$target_dir/$random_text.txt"
		#echo $file_path
		for nbline in $(seq 1 $((5 + $RANDOM % 6))) ; do
			get_random_words $((5 + $RANDOM % 6))
			echo $random_words | tr '\n' ' ' >> $file_path
		done
	done
	# generates text files with random characters
	for nbfiles in $(seq 1 $((3 + $RANDOM % 2))) ; do
		get_random_text $(( 1 + $RANDOM % 16 ))
		local file_path="$target_dir/$random_text.dat"
		get_random_text $(( 1024 + 512 * $RANDOM % 513 ))
		echo $random_text > $file_path
	done
	# generates random binary files
	for nbfiles in $(seq 1 $((3 + $RANDOM % 2))) ; do
		get_random_text $(( 1 + $RANDOM % 16 ))
		local file_path="$target_dir/$random_text.bin"
		dd if=/dev/urandom of=$file_path bs=4k count=$((512 * ( 1 + $RANDOM %5 ))) 2> /dev/null
	done
}

target_dir=exserie002
for i in $(seq 1 $((3 + $RANDOM % 3))) ; do
	# generates directories and files on level 1
	get_random_text $(( 1 + $RANDOM % 16))
	dirname=$target_dir/$random_text
	mkdir -p $dirname
	mk_random_files $dirname
	for j in $(seq 1 $((3 + $RANDOM % 3))) ; do
		# generates directories and files on level 2
		get_random_text $(( 1 + $RANDOM % 16))
		subdirname=$dirname/$random_text
		mkdir -p $subdirname
		mk_random_files $subdirname
	done
done

