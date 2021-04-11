get_prompt() {

	local LAST="$?"

	PROMPT_COLOR='\[\033[1m\]'
	ERROR_COLOR='\[\033[1;31m\]'
	GIT_COLOR='\[\033[1;32m\]'
	PROMPT_RESET='\[\033[0m\]'

	PS1="[$PROMPT_COLOR"
	PS1+='\u@\h \W'
	PS1+="$PROMPT_RESET]"

	git rev-parse --is-inside-work-tree > /dev/null 2> /dev/null
	if [ "$?" -eq 0 ]; then

		GIT_BRANCH="`git branch --show-current 2> /dev/null`"
		if [ "$?" -ne 0 ]; then
			GIT_BRANCH_RAW="`git branch 2> /dev/null`"
			GIT_BRANCH="`echo "$GIT_BRANCH_RAW" | \
				     sed -n 's/^\*\s\+\(.*\)$/\1/p'`"
		fi

		echo "$GIT_BRANCH" | grep -v '^(.*)$' > /dev/null
		if [ "$?" -ne 0 ]; then
			GIT_BRANCH_OUT="`git rev-parse --short HEAD`"
		else
			GIT_BRANCH_OUT="$GIT_BRANCH"
		fi

		PS1+=" [${GIT_COLOR}${GIT_BRANCH_OUT}${PROMPT_RESET}]"
	fi

	if [ "$LAST" -ne 0 ]; then
		PS1+=" [${ERROR_COLOR}${LAST}${PROMPT_RESET}]"
	fi

	PS1+="${PROMPT_COLOR}$ ${PROMPT_RESET}"

}

PROMPT_COMMAND=get_prompt

alias ls="ls --color"
alias ll="ls -lah"
alias grep="grep --color"

set -o vi
