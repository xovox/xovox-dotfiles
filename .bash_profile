# .bash_profile

##############################################################################
# i had to use this high-weirdness because screen DIDN'T have bash read
# .bash_profile, it only read .bashrc
#
# i didn't want a endless loop, and i needed everything to work the way i
# wanted... hence this ugly hack.
##############################################################################

# --( begin ugly hack )--------------------------------------------------------
export bash_profile_sourced=$$

# Get the aliases and functions
if [ "$bashrc_sourced" != "$$" ] && [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
# --( end ugly hack )----------------------------------------------------------

##############################################################################
# here i grab my various files in ~/.bash_profile.d containing my prompts,
# aliases, and whatever else i want in my shell
##############################################################################

for i in ~/.bash_profile.d/* ; do
 source "$i"
done
