
if [ -f $HOME/.aws ]; then
	aws_completer="$(which aws_completer)"

	if [ "$aws_completer" ]; then
		complete -C $aws_completer aws
	fi

	awsout() {
		if [ "$1" ]; then
			export AWS_DEFAULT_OUTPUT="$1"
		else
			echo "text table json"
		fi
	}

	awsp() {
		while read -p "aws> " line ; do
			aws $line
		done
	}
fi
