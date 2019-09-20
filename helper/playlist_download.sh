#!/usr/bin/env bash

# Download .m3u8 playlists.

NO_COLOR='\033[0m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'

function download_ts_file() {
	local url="$1"
	local url_basename=$(basename "$url")
	local tmp_file="${url_basename}.tmp"
	if [[ ! -f "$url_basename" ]]; then
		echo -e "${GREEN} -> download ts file: '$url'${NO_COLOR}"
		#cp "$url" "$tmp_file"
		wget -O "$tmp_file" "$url"
		mv "$tmp_file" "$url_basename"
	else
		echo -e "${YELLOW} -> WARNING: file already exists: '${url_basename}'${NO_COLOR}"
	fi
}

function download_playlist() {
	local tmp_dir="$1"
	local url="$2"
	local url_dirname=$(dirname "$url")
	
	echo -e "${GREEN}download playlist: '$url'${NO_COLOR}"
	# sleep 1
	
	local pl_file1=$(mktemp "$tmp_dir/pl1.XXXXXXXXXXXXX")
	
	#cp "$url" "$pl_file1"
	wget -O "$pl_file1" "$url"
	
	# echo "pl_file1: $pl_file1"
	# echo '----- pl1 -----'
	# head -10 "$pl_file1"
	# echo '---------------'
	# sleep 1
	
	local pl_file2=$(mktemp "$tmp_dir/pl2.XXXXXXXXXXXXX")
	if [[ -f "$pl_file1" ]]; then
		grep -v '^#' "$pl_file1" > "$pl_file2"
	else
		echo "${RED}ERROR: download failed: '$url'${NO_COLOR}"
		exit 1
	fi
	
	# echo "pl_file2: $pl_file2"
	# echo '----- pl2 -----'
	# head -10 "$pl_file2"
	# echo '---------------'
	# sleep 1
	
	local m3u_file1=$(mktemp "$tmp_dir/m3u1.XXXXXXXXXXXXX")
	local ts_file1=$(mktemp "$tmp_dir/ts1.XXXXXXXXXXXXX")
	
	grep .m3u8 "$pl_file2" > "$m3u_file1"
	grep .ts "$pl_file2" > "$ts_file1"
	
	# echo "m3u_file1: $m3u_file1"
	# echo '----- m3u file -----'
	# head -10 "$m3u_file1"
	# echo '--------------------'
	# sleep 1
	
	# echo "ts_file1: $ts_file1"
	# echo '----- ts file -----'
	# tail -10 "$ts_file1"
	# echo '-------------------'
	# sleep 1
	
	first_ts_file=$(head -1 "$ts_file1")
	last_ts_file=$(tail -1 "$ts_file1")
	
	while read -r line ; do
		echo " -> m3u line: $line"
		download_playlist "$tmp_dir" "${url_dirname}/${line}"
		sleep 0.3
	done < "$m3u_file1"
	
	while read -r line ; do
		echo " -> ts line: $line/$last_ts_file"
		download_ts_file "${url_dirname}/${line}"
		sleep 0.3
	done < "$ts_file1"
	
	if [[ $(wc -l "$ts_file1" | awk '{ print $1 }') -gt 1 ]]; then
		echo -e "${YELLOW} -> first ts file: $first_ts_file${NO_COLOR}"
		echo -e "${YELLOW} -> last  ts file: $last_ts_file${NO_COLOR}"
	fi
}

which grep &> /dev/null || { echo 'ERROR: grep not found in PATH'; exit 1; }
which awk &> /dev/null || { echo 'ERROR: awk not found in PATH'; exit 1; }
which wget &> /dev/null || { echo 'ERROR: wget not found in PATH'; exit 1; }
which mktemp &> /dev/null || { echo 'ERROR: mktemp not found in PATH'; exit 1; }
which head &> /dev/null || { echo 'ERROR: head not found in PATH'; exit 1; }
which rm &> /dev/null || { echo 'ERROR: rm not found in PATH'; exit 1; }

url="$1"

tmp_dir=$(mktemp -d -t 'playlist_downloader')
echo "tmp dir: $tmp_dir"

download_playlist "$tmp_dir" "$url"

echo 'clean up'
rm -rf "$tmp_dir"
