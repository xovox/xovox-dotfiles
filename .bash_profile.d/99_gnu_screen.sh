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

gnu_screen_title() {
	if [ "$1" ]; then
		printf '\033k%s\033\\' "$1"
	fi
}

if [ "$PS1" ] && [[ "$TERM" =~ screen ]]; then
	export PROMPT_COMMAND="$PROMPT_COMMAND ; gnu_screen_title \"$screen_hostname:\$(basename \"\$PWD\")\""
	export TERM="screen-256color"
fi
