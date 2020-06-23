if [[ $OSTYPE =~ [Dd]arwin.* ]]; then
	alias ppwd='echo "$(pwd)" | pbcopy'
	export BASH_SILENCE_DEPRECATION_WARNING=1
fi
