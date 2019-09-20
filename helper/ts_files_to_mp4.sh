#!/usr/bin/env bash

FORMAT="$1"
SEQ_START="$2"
SEQ_END="$3"
DEST_PATH="$4"

NO_COLOR='\033[0m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

which ffmpeg &> /dev/null || { echo 'ERROR: ffmpeg not found in PATH'; exit 1; }
which mktemp &> /dev/null || { echo 'ERROR: mktemp not found in PATH'; exit 1; }

tmp_dir=$(mktemp -d -t 'ts_to_mp4')
echo " -> tmp dir: $tmp_dir"

input_file="${tmp_dir}/input.ts"
echo -e " -> input file: '${input_file}'"

# Reset input file.
> "${input_file}"

# Concat files.
echo -e "${GREEN} -> concat files: ${SEQ_START} to ${SEQ_END}${NO_COLOR}"
for n in $(seq ${SEQ_START} ${SEQ_END}) ; do
	file=$(printf "$FORMAT" $n)
	if [[ -f "${file}" ]] ; then
		#echo "input file: ${file}"
		cat "${file}" >> "${input_file}"
	else
		echo -e "${RED}ERROR: file missing: '${file}'${NO_COLOR}"
		exit 1
	fi
done

echo -e " -> input file: $(ls -lah ${input_file})"

# Convert ts to .mp4
echo -e "${GREEN} -> convert ts to mp4 (x264)${NO_COLOR}"
ffmpeg -i "${input_file}" -c:v libx264 "${DEST_PATH}"
# ffmpeg -i ./input.ts -acodec copy -vcodec copy ./output.mp4

echo ' -> clean up'
rm -rf "$tmp_dir"

echo 'done'
