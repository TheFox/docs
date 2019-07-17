#!/usr/bin/env bash

FORMAT="seg-%d-v1-a1.ts"

which ffmpeg &> /dev/null || { echo 'ERROR: ffmpeg not found in PATH'; exit 1; }

#set -x

#cat ./*.ts
> ./input.ts
for n in $(seq 0 9999) ; do
	file=$(printf $FORMAT $n)
	if [[ -f $file ]] ; then
		echo "$file"
		cat $file >> ./input.ts
	fi
done

ffmpeg -i ./input.ts -c:v libx264 ./output_x264.mp4
ffmpeg -i ./input.ts -acodec copy -vcodec copy ./output.mp4

ls -lah ./input.ts ./output_x264.mp4 ./output.mp4
