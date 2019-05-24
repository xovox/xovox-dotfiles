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
# set some variables the way i like them
##############################################################################

which vim > /dev/null 2>&1 && export EDITOR=$(which vim)

unset PATH

# this ugliness expands to the standard PATH dirs
for path_dir in {/usr{/local,},}/{s,}bin ; do
	export PATH="$path_dir:$PATH"
done

# if we have a $HOME/bin directory, let's add all the things to $PATH
if [ -d $HOME/bin ]; then
	export PATH="$(find -L $HOME/bin -not -iwholename '*.svn*' -type d -exec printf "{}:" \;)$PATH"
fi

export ROWS COLUMNS
