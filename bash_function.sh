function _mkbash () {
	echo "#!/bin/bash" > "$1" && chmod +x "$1" && vim "$1"
}
function addalias () {
	if [ -z "$1" ] || [ -z "$2" ]
	then
		echo "Usage: addalias <alias_name> <command>"
		return 1
	fi
	alias_name=$1 
	command=$2 
	echo "alias $alias_name=\"$command\"" >> ~/.bashrc
	source ~/.bashrc
	echo "Alias '$alias_name' added and sourced successfully!"
}
