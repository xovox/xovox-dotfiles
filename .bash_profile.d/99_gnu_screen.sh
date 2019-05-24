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
# functions and updates to $PROMPT_COMMAND to work better with gnu screen
##############################################################################

screen_binary=$(which screen)

screen_hostname=$(hostname -s)

screen() {
	# if our variable hasn't been set
	if [ ! "$screen_executed" ]; then
		# set our var before entering screen
		export screen_executed=true
		# set our window title to show we're in screen
		echo -ne "\033]0;$(hostname -s) :: $($screen_binary -v)\007" 
		# run the actual screen binary
		$screen_binary $*
		# if we've left screen, unset our var
		export screen_executed=''
	else
		# if we're already in screen
		echo "you're already in screen, fool!"
	fi
}

gnu_screen_title() {
	if [ "$1" ]; then
		printf '\033k%s\033\\' "$1"
	fi
}

if [ "$PS1" ] && [[ "$TERM" =~ screen ]]; then
	export PROMPT_COMMAND="$PROMPT_COMMAND ; gnu_screen_title \"$screen_hostname:\$(basename \"\$PWD\")\""
	export TERM="screen-256color"
fi
