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

# copy ssh key over to remote host

pusshkey() {
	unset pussh_public pussh_hosts
	while [ "$1" ]; do
		if [ -f "$1" ]; then
			pussh_public="$pussh_public $1"
		else
			pussh_hosts="$(sed -e 's/\b\([a-z]\+\)[ ,\n]\1/\1/g' <<< "$pussh_hosts $1")"
		fi
		shift
	done

	for key in $pussh_public ; do
		for ssh_host in $pussh_hosts ; do
			cat $key | ssh $pussh_host 'mkdir -pv $HOME/.ssh && cat >> $HOME/.ssh/authorized_keys && chmod -Rc go= $HOME/.ssh'
		done
	done
}

##############################################################################
# why use a standard boring diff when vim can colorize it for you!  all that &
# you get the fun of using vim to manipulate a diff.  it's the small things
# that make me happy
##############################################################################

vdiff() {
	if [ "$2" ]; then
		if [ -f "$1" ] && [ -f "$2" ]; then
			output=/tmp/diff.$USER.$(date +%Y%m%d%H%M%S)
			diff "$1" "$2" > $output
			echo -ne "\033]0;vdiff: $1 <-> $2\007" 
			$(which vim) $output
		else
			echo "either \"$1\" or \"$2\" doesn't exist"
		fi
	else
		echo vdiff [file1] [file2]
	fi
}
pong() { 
	ping $@ 2>&1 | while read line; do
		echo "[ $(date +"%Y%m%d %H:%M:%S") ] $line";
	done
}
