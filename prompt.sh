#=================
# Prompt
#=================

__prompt_dir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Source the git-prompt script (based on https://github.com/lyze/posh-git-sh)
. "$__prompt_dir/git-prompt.sh"

# Define colours
# The \[...\] tell bash not to include the characters when calculating length.
# This helps the cursor stay in the right place when navigating history.
RESET='\[\e[0;0m\]'
RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
YELLOW='\[\e[0;33m\]'
BLUE='\[\e[0;34m\]'
PURPLE='\[\e[0;35m\]'
LIGHTRED='\[\e[1;31m\]'
LIGHTGREEN='\[\e[1;32m\]'
LIGHTYELLOW='\[\e[1;33m\]'
LIGHTBLUE='\[\e[1;34m\]'
LIGHTPURPLE='\[\e[1;35m\]'
LIGHTWHITE='\[\e[1m\]'
BGRED='\[\e[1;41m\]'
BGGREEN='\[\e[1;42m\]'
BGYELLOW='\[\e[1;43m\]'
BGBLUE='\[\e[1;44m\]'
BGPURPLE='\[\e[1;45m\]'

# If the last command failed, add the exit code to the prompt, e.g. " ✖130 "
__prompt_check_status() {
    if [[ $1 -ne 0 ]]; then
        echo -e "${RED} \xE2\x9C\x96${1}${RESET}"
    fi
}

# Truncate any parts of the path greater than the 2 closest bits
# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html#index-PROMPT_005fDIRTRIM
PROMPT_DIRTRIM=2

# Root and non-root get slightly different prompts.
# Specifically, root has a bright red background to remind you not to do anything dumb.
if [[ $UID -eq 0 ]]; then
    USERBGCOL=$BGRED
else
    USERBGCOL=$LIGHTBLUE
fi

# __post_git_ps1 comes from git-prompt. It's a function that takes two arguments: the first is the part that goes before
# the git prompt, the second is the part that comes after.
# This will produce something like:
#     [11:48:11] mike:~/.../testengine/tts [spine-sim ≡ +0 ~2 -0] ✖1 $
# where the parts are:
#     before git: [11:48:11] mike:~/.../testengine/tts
#     git:        [spine-sim ≡ +0 ~2 -0]
#     after git:   ✖1 $
#
# This could be used without git-prompt by simply concatenating the two arguments and assigning the result to PS1, i.e.:
# PROMPT_COMMAND='PS1="${YELLOW}[\t]${RESET} ${USERBGCOL}\u${RESET}${LIGHTWHITE}:${RESET}${LIGHTPURPLE}\w${RESET} $(__prompt_check_status $?)${LIGHTWHITE}\\\$${RESET} "'
PROMPT_COMMAND='__posh_git_ps1 "${YELLOW}[\t]${RESET} ${USERBGCOL}\u${RESET}${LIGHTWHITE}:${RESET}${LIGHTPURPLE}\w${RESET}" "$(__prompt_check_status $?) ${LIGHTWHITE}\\\$${RESET} "'

