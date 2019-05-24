##############################################################################
#
# this bashrc file is (c) 2013 duncan brown (http://duncanbrown.org)
#
# this and my other bash environment files can be downloaded directly from
# my webserver.  http://files.duncanbrown.org/linux/dotfiles/
#
# all are released under the creative commons license
#
##############################################################################

##############################################################################
# information we'll add to the window title
##############################################################################

# load average
prepend_loadavg=false

# outdoor temperature (requires my 'weather' file in your ~/.bash_profile.d/
prepend_weather_temperature=false

# outdoor summary (requires my 'weather' file in your ~/.bash_profile.d/
prepend_weather_summary=false

banner_background="17"
banner_text="46"
##############################################################################
# do not modify beyond this point unless you know what you're doing!
##############################################################################

# add items to the window title
build_window_title() {
	prepend_title=""
	if [ "$prepend_weather_temperature" = "true" ]; then
		prepend_title="${prepend_title}weather:$(status_weather_temperature) | "
	fi
	if [ "$prepend_loadavg" = "true" ] && [[ "$OSTYPE" =~ [Ll]inux ]]; then
		prepend_title="${prepend_title}la:$(cut -d' ' -f1 /proc/loadavg) | "
	fi
}

set_window_title() {
	if [[ $TERM =~ .*xterm.* ]]; then
		echo -ne "\033]0;$@\007"
	elif [[ $TERM =~ .*screen.* ]]; then
		echo -ne "\033_$@\033\\"
	fi
}

prompt_command_top() {
	if [[ "$OSTYPE" =~ [Ll]inux ]]; then
		pct_load="$(cut -d' ' -f1-3 /proc/loadavg)"
		pct_mem=$(awk '/MemTotal:/{total=$2} /MemFree:/{free=$2} END {printf ("%2.2f\n", (total-free)*100/total)}' /proc/meminfo)
		pct_bio=$(grep '^procs_blocked' /proc/stat | cut -d' ' -f2)
		printf "load: $pct_load | mem pct: $pct_mem  | blocked io: $pct_bio"
	fi
	#IFS=' ' read -a statsArray <<< $(/bin/df -h . | tail -1)
	#printf " $USER@$HOSTNAME:$PWD (${statsArray[2]}/${statsArray[1]})"
	#uptime
}

[ "$PS1" ] && {

	#export PROMPT_COMMAND='printf "\033[0;0H\033[38;5;${banner_text}m\033[48;5;${banner_background}m%${COLUMNS}s\033[0:0H$(prompt_command_top)\033[1;0H\033[${LINES};0H\033[0m"'
	if [[ $TERM =~ .*xterm.* ]]; then
		export PROMPT_COMMAND='echo -ne "\033]0;${prepend_title}${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
	elif [[ $TERM =~ .*screen.* ]]; then
		export PROMPT_COMMAND='echo -ne "\033_${prepend_title}${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
	fi 


}
