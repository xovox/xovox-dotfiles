#!/bin/bash

pwgen() {
	curl -s "http://files.duncanbrown.org/pwgen/"
}

ppwgen() {
	pwgen | pbcopy
}

pw() {
	pw_file=$HOME/.passwords/"$1"
	pw_account="$2"
	if [ "$1" ]; then
		if [ -f "$pw_file" ]; then
			if [ "$pw_account" ]; then
				echo -n 'account notes : '
				grep "^$pw_account" "$pw_file" | cut -d'	' -f3-
				grep "^$pw_account" "$pw_file" | cut -d'	' -f2 | tr -d '\n' | pbcopy
				echo -en "\nclearing clipboard in ["
				for i in {1..10} ; do
					echo -n '-'
				done
				echo -ne ']\b'
				pw_sleep_count=10
				while [ "$pw_sleep_count" -ge "1" ]; do
					echo -ne "\b"
					sleep 1
					pw_sleep_count=$[ $pw_sleep_count - 1 ]
				done
				pbcopy < /dev/null
				echo
			else
				cut -d'	' -f1 $pw_file | sort -nb
			fi
		fi
	else
		ls "$pw_file"
	fi
}
	
