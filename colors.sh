#
# Kims bash extensions
# color.sh: set user friendly color names for escape codes.
#

if [ "$TERM" != "dumb" ]; then
	eval "`dircolors -b`"
fi

# Dark colors
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
BROWN='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
PURPLE='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
GRAY='\[\033[1;30m\]'

# Light colors
LTGRAY='\[\033[0;37m\]'
LTRED='\[\033[1;31m\]'
LTGREEN='\[\033[1;32m\]'
YELLOW='\[\033[1;33m\]'
LTBLUE='\[\033[1;34m\]'
LTPURPLE='\[\033[1;35m\]'
LTCYAN='\[\033[1;36m\]'
WHITE='\[\033[1;37m\]'

# No color
NOCOLOR='\[\033[0m\]'

export BLACK BLUE GREEN CYAN RED PURPLE BROWN GRAY LTGRAY LTBLUE LTGREEN LTCYAN LTRED LTPURPLE YELLOW WHITE NOCOLOR
