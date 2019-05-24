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

grep_typos="Grep rep gre"

for grep_typo in $grep_typos ; do
	alias $grep_typo='grep'
done
