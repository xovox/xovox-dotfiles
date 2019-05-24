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
#
# the following section covers the following shell functionality
#
# - colorize $PS1
#   - if your last command returns anything other than a 0 exit code the '$/#'
#     in your prompt will turn red
#
# - set PROMPT_COMMAND to update your terminal titlebar & prompt end color
#
# i've also included the ability to add additional information to the title
# window, set with a true|false setting.
#
##############################################################################

shopt -s checkwinsize

# colors for PS1, PS2, PS3 & PS4
ps1_color="35"
ps2_color="32"
ps3_color="32"
ps4_color="36"

# if set to true, the prompt will be a random color after every command
ps1_random="false"

# uncomment if you want a static random color per terminal
#ps1_color=$[ $((RANDOM%7)) + 31 ]

##############################################################################
# update the prompt to show you general system information
##############################################################################

# % cpu spread across multiple cores
med_load=50
high_load=75

# % mem
med_mem=75
high_mem=90

# % swap
med_swap=10
high_swap=33

# count of blocked processes
med_blocked=2
high_blocked=4

##############################################################################
# do not modify beyond this point unless you know what you're doing!
##############################################################################

# this function adds colored strings to the prompt
# ps1 [ansi color] [string]
ps1() {
	if [ "$1" ]; then
		color=$1
		shift
		string=$@
		export ps1="$ps1\[\033[${color}m\]$string\[\033[00m\]"
	else
		export ps1="$ps1 "
	fi
}

# set prompt color a number between 30-37
ps1_random() {
	ps1_color=$[ $((RANDOM%7)) + 31 ]
}

# figure out what the load vs core count percentage is
ps1_load() {
	cpu_count=$(grep -c '^processor' /proc/cpuinfo)
	load_avg=$(cut -d' ' -f1 /proc/loadavg)
	load_percentage="( $load_avg / $cpu_count ) * 100"

	# add 1 for medium & 1 for high for a range of 0 to 2
	load_result=$(bc <<< "scale=3 ; ( $load_percentage >= $high_load ) + ( $load_percentage >= $med_load)")

	# ansi colors: 32 - green, 33 - yellow, 31 - red
	if [ "$load_result" = "2" ]; then
		ps1 "01;31" l
	elif [ "$load_result" = "1" ]; then
		ps1 "01;33" l
	else
		ps1 "01;32" -
	fi
}

# find how many processes are blocked on io
ps1_io() {
	blocked_count=$(grep '^procs_blocked' /proc/stat | cut -d' ' -f2)
	if [ "$blocked_count" -ge "$high_blocked" ]; then
		ps1 "01;31" i
	elif [ "$blocked_count" -ge "$med_blocked" ]; then
		ps1 "01;33" i
	else
		ps1 "01;32" -
	fi
}

# find out what percentage of memory is in use
ps1_mem() {
	# there might be a faster/cleaner way to do this than awk
	mem_percentage=$(awk '/MemTotal:/{total=$2} /MemFree:/{free=$2} END {printf ("%2.2f\n", (total-free)*100/total)}' /proc/meminfo)
	mem_result=$(bc <<< "scale=3 ; ( $mem_percentage >= $high_mem ) + ( $mem_percentage >= $med_mem)")

	# ansi colors: 32 - green, 33 - yellow, 31 - red
	if [ "$mem_result" = "2" ]; then
		ps1 "01;31" m
	elif [ "$mem_result" = "1" ]; then
		ps1 "01;33" m
	else
		ps1 "01;32" -
	fi
}

# find out what percentage of swap is in use
ps1_swap() {
	# there might be a faster/cleaner way to do this than awk
	swap_percentage=$(awk '/SwapTotal:/{total=$2} /SwapFree:/{free=$2} END {printf ("%2.2f\n", (total-free)*100/total)}' /proc/meminfo)
	swap_result=$(bc <<< "scale=3 ; ( $swap_percentage >= $high_swap ) + ( $swap_percentage >= $med_swap)")

	# ansi colors: 32 - green, 33 - yellow, 31 - red
	if [ "$swap_result" = "2" ]; then
		ps1 "01;31" s
	elif [ "$swap_result" = "1" ]; then
		ps1 "01;33" s
	else
		ps1 "01;32" -
	fi
}


# this is the function that's called by $PROMPT_COMMAND to build the prompt
build_ps1() {

	if [ "$ps1_random" = "true" ]; then
		ps1_random
	fi

#	if [[ $OSTYPE =~ [Ll]inux.* ]]; then
		# build the prompt status marks
#		ps1 "1;30" "("
#		ps1_load
#		ps1_mem
#		ps1_swap
#		ps1_io
#		ps1 "1;30" ")"
#		ps1
#	fi

	# (user@host:path)
	ps1 "1;30" "("
	ps1 "$ps1_color" "\u@\h:\W"
	ps1 "1;30" ")"
	ps1 "1;30" "$pe"

	ps1

	export PS1="$ps1"
	unset ps1
}

#ps1_top_banner() {
#	echo -n #	printf "\033[0;0H${COLUMNS}s\033[0:0H$(uptime)\033[1;0H\033[${LINES};0H\033[0m"
#}

if [ "$PS1" ]; then
	export PS2="\[\033[1;30m\]>\[\033[00m\]\[\033[${ps2_color}m\]>\[\033[00m\]\[\033[1;${ps2_color}m\]>\[\033[00m\] "
	export PS3="$(echo -e "\033[1;30m(\033[00m\033[${ps3_color}m?\033[00m\033[1;30m)\033[00m") "
	export PS4="\[\033[1;30m\]+\[\033[00m\]\[\033[${ps4_color}m\]+\[\033[00m\]\[\033[1;${ps4_color}m\]+\[\033[00m\] "

#	export PROMPT_COMMAND='[ $? != 0 ] && ps1_exit="1;31" || ps1_exit="1;32" ; ps1_top_banner'
#	export PROMPT_COMMAND="ps1_top_banner"
	
	# last character of our prompt
	if [ "$UID" = "0" ]; then
		pe="#"
	else
		pe='$'
	fi
	build_ps1
fi
