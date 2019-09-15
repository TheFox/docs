#!/usr/bin/env bash

FORMAT=$1
SEQ_START=$2
SEQ_END=$3

which ffmpeg &> /dev/null || { echo 'ERROR: ffmpeg not found in PATH'; exit 1; }

# Reset input file.
> ./input.ts

# Concat files.
for n in $(seq $SEQ_START $SEQ_END) ; do
	file=$(printf $FORMAT $n)
	if [[ -f $file ]] ; then
		echo "$file"
		cat $file >> ./input.ts
	fi
done

# Convert ts to .mp4
ffmpeg -i ./input.ts -c:v libx264 ./output_x264.mp4
ffmpeg -i ./input.ts -acodec copy -vcodec copy ./output.mp4

ls -lah ./input.ts ./output_x264.mp4 ./output.mp4
