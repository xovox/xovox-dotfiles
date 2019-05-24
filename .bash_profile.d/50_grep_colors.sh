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
# grep_colors : for use with grep --color
##############################################################################

export GREP_COLOR="1;30;47"
export GREP_COLOR='1;31'
export GREP_COLOR='4;32;40'

echo test | grep --color=auto test > /dev/null 2>&1 && {
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	alias zgrep='zgrep --color=auto'
	alias bzgrep='bzgrep --color=auto'
	alias xzgrep='xzgrep --color=auto'
}
