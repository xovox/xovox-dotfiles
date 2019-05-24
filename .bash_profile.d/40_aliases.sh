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

alias ssh="ssh -o SendEnv=TERM"
alias vi=vim
alias less='less -iwF'

alias rm='rm -vi'
alias mv='mv -vi'

alias rsync='rsync -avP --partial-dir .partial'

##############################################################################
# shortcuts for building from source
#
# cm = configure & make
# cmi = configure, make & install
##############################################################################

alias cm='[ -x configure ] && echo "configuring..." && ./configure > /dev/null && echo "compiling..." && make > /dev/null'
alias cmi='[ -x configure ] && echo "configuring..." && ./configure > /dev/null && echo "compiling..." && make > /dev/null && echo "installing..." && sudo make install'

##############################################################################
# directory traversal
##############################################################################

alias 'cd..'='cd ..'
alias '..'='cd ..'
alias '...'='cd ../..'
