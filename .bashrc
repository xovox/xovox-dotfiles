# .bashrc

##############################################################################
# i had to use this high-weirdness because screen DIDN'T have bash read
# .bash_profile, it only read .bashrc
#
# i didn't want a endless loop, and i needed everything to work the way i
# wanted... hence this ugly hack.
##############################################################################

# --( begin ugly hack )--------------------------------------------------------
export bashrc_sourced=$$

# Get the aliases and functions
if [ "$bash_profile_sourced" != "$$" ] && [ -f ~/.bash_profile ]; then
	. ~/.bash_profile
fi
# --( end ugly hack )----------------------------------------------------------
