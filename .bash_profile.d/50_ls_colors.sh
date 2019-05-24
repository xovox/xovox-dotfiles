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
# ls_colors :: an easier way to manage your shell's LS_COLORS variable
#
# di = directory
# fi = file
# ln = symbolic link
# pi = fifo file
# so = socket file
# bd = block (buffered) special file
# cd = character (unbuffered) special file
# or = symbolic link pointing to a non-existent file (orphan)
# mi = non-existent file pointed to by a symbolic link (visible when you type ls -l)
# ex = file which is executable (ie. has 'x' set in permissions).
##############################################################################

# standard files
default_file_color="00"
executable_color="01;32"
script_color="${executable_color}"
archive_color="01;31"
image_color="01;35"
video_color="01;37"

# special files
fifo_file_color="40;33"
symlink_color="01;36"
orphaned_symlink_color="01;05;37;41"

directory_color="01;34"

if ls --color=auto > /dev/null 2>&1 ; then
	alias ls='ls --color=auto'

	export LS_COLORS="no=00:fi=${default_file_color}:di=${directory_color}:ln=${symlink_color}:pi=${fifo_file_color}:so=01;35:bd=40;33;01:cd=40;33;01:or=${orphaned_symlink_color}:mi=01;05;37;41:ex=${executable_color}:*.cmd=${script_color}:*.exe=${script_color}:*.com=${script_color}:*.btm=${script_color}:*.bat=${script_color}:*.sh=${script_color}:*.csh=${script_color}:*.tar=${archive_color}:*.tgz=${archive_color}:*.arj=${archive_color}:*.taz=${archive_color}:*.lzh=${archive_color}:*.zip=${archive_color}:*.z=${archive_color}:*.Z=${archive_color}:*.gz=${archive_color}:*.bz2=${archive_color}:*.bz=${archive_color}:*.tz=${archive_color}:*.deb=${archive_color}:*.rpm=${archive_color}:*.cpio=${archive_color}:*.jpg=${image_color}:*.gif=${image_color}:*.bmp=${image_color}:*.xbm=${image_color}:*.xpm=${image_color}:*.png=${image_color}:*.tif=${image_color}:*.mpg=${video_color}:*.avi=${video_color}:*.fli=${video_color}:*.flv=${video_color}:*.divx=${video_color}:"
fi
