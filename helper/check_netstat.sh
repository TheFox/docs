#!/usr/bin/env bash

# Nagios Plugin for netstat.
# 2010-07-23 Created by Christian Mayer <https://fox21.at>

ECHO="/bin/echo"
GREP="/bin/egrep"
DIFF="/usr/bin/diff"
TAIL="/usr/bin/tail"
CAT="/bin/cat"
RM="/bin/rm"
CHMOD="/bin/chmod"
TOUCH="/bin/touch"

PROGNAME=`/usr/bin/basename $0`
PROGPATH=`echo $0 | sed -e 's,[\\/][^\\/][^\\/]*$,,'`

. $PROGPATH/utils.sh

print_usage(){
	echo "Usage: $PROGNAME -p PATTERN"
	echo "Usage: $PROGNAME -h|--help"
}

if [ $# -lt 1 ]; then
	print_usage
	exit $STATE_UNKNOWN
fi

EXITSTATUS=$STATE_UNKNOWN
QUERY=""
while test -n "$1"; do
	case "$1" in
		--help)
			print_help
			exit $STATE_OK
			;;
		-h)
			print_help
			exit $STATE_OK
			;;
		-p)
			QUERY=$2
			shift
			;;
		*)
			echo "Unknown argument: $1"
			print_usage
			exit $STATE_UNKNOWN
			;;
	esac
	shift
done

( netstat -rn | grep "$QUERY" &> /dev/null ) && echo "ROUTE OK" && exit $STATE_OK

echo "ROUTE NOT FOUND: '$QUERY'"
exit $STATE_CRITICAL
