# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

red='\[\e[0;31m\]'
RED='\[\e[1;31m\]'
blue='\[\e[0;34m\]'
BLUE='\[\e[1;34m\]'
cyan='\[\e[0;36m\]'
CYAN='\[\e[1;36m\]'
green='\[\e[0;32m\]'
GREEN='\[\e[1;32m\]'
yellow='\[\e[0;33m\]'
YELLOW='\[\e[1;33m\]'
PURPLE='\[\e[1;35m\]'
purple='\[\e[0;35m\]'
nc='\[\e[0m\]'
if [ "$UID" = 0 ]; then
    PS1="$red\u$nc@$red\H$nc:$CYAN\w$nc\\n$red#$nc "
else
    PS1="$PURPLE\u$nc@$CYAN\H$nc:$GREEN\w$nc\\n$GREEN\$$nc "
fi
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias pr='vim -p *.c *.h  Makefile'
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias up='sudo apt update -y && sudo apt upgrade -y'
alias ins='sudo apt install -y'
alias rem='sudo apt remove -y'
alias arem='sudo apt autoremove -y'
alias sc='screen'
alias gc='git clone'
alias gcom='git commit -m'
alias gp='git push'
alias sc='screen'
X_KEY="rtmp://de.pscp.tv:80/x/jkzidi63crvn"
TWITCH_KEY="rtmp://live.twitch.tv/app/live_961057132_6trHMfGAX3Av2j8aCamMLCks2LQAcB"
YOUTUBE_KEY="rtmp://a.rtmp.youtube.com/live2/fqe4-3wpz-1rd8-wtgy-2hcz"
KICK_KEY="rtmps://fa723fc1b171.global-contribute.live-video.net/app/sk_us-west-2_Lo515Ph4dlp3_z63K0EN32cUXXoIsRuG5E7gFkNNyxU"
RESOLUTION=1366x768
alias STRTWITCH='ffmpeg -f x11grab -s $RESOLUTION -r 30 -i :0.0 \
  -f alsa -i hw:0,0 \
  -c:v libx264 -preset veryfast -b:v 3000k -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 60 \
  -af "highpass=f=200, lowpass=f=3000, afftdn, volume=5dB" \
  -c:a aac -b:a 160k -ar 44100 -f flv $TWITCH_KEY'

alias STRKICK='ffmpeg -f x11grab -s $RESOLUTION -r 30 -i :0.0 \
  -f alsa -i hw:0,0 \
  -c:v libx264 -preset veryfast -crf 22 -b:v 3000k -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 60 \
  -vf "scale=$RESOLUTION:flags=lanczos,unsharp=5:5:1.0" \
  -af "highpass=f=200, lowpass=f=3000, afftdn, volume=5dB" \
  -c:a aac -b:a 160k -ar 44100 -f flv $KICK_KEY'

alias STRYOUTUBE='ffmpeg -f x11grab -s $RESOLUTION -r 30 -i :0.0 \
  -f alsa -i hw:0,0 \
  -c:v libx264 -preset veryfast -crf 22 -b:v 3000k -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 60 \
  -vf "scale=$RESOLUTION:flags=lanczos,unsharp=5:5:1.0" \
  -af "highpass=f=200, lowpass=f=3000, afftdn, volume=5dB" \
  -c:a aac -b:a 160k -ar 44100 -f flv $YOUTUBE_KEY'

alias STRTYT='ffmpeg -f x11grab -video_size "$RESOLUTION" -framerate 30 -i :0.0 \
  -f alsa -i hw:0,0 \
  -c:v libx264 -preset veryfast -crf 22 -b:v 3000k -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 60 \
  -vf "scale=$RESOLUTION:flags=lanczos,unsharp=5:5:1.0" \
  -af "highpass=f=200,lowpass=f=3000,afftdn,volume=5dB" \
  -c:a aac -b:a 160k -ar 44100 -f flv "$YOUTUBE_KEY" -f flv "$TWITCH_KEY"'


alias STRKTW='ffmpeg -f x11grab -s $RESOLUTION -r 30 -i :0.0 \
  -f alsa -i hw:0,0 \
  -c:v libx264 -preset veryfast -crf 22 -b:v 3000k -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 60 \
  -vf "scale=$RESOLUTION:flags=lanczos,unsharp=5:5:1.0" \
  -af "highpass=f=200, lowpass=f=3000, afftdn, volume=5dB" \
  -c:a aac -b:a 160k -ar 44100 -f flv $TWITCH_KEY -f flv $KICK_KEY'

alias STRKICKYT='ffmpeg -f x11grab -s $RESOLUTION -r 30 -i :0.0 \
  -f alsa -i hw:0,0 \
  -c:v libx264 -preset veryfast -crf 22 -b:v 3000k -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 60 \
  -vf "scale=$RESOLUTION:flags=lanczos,unsharp=5:5:1.0" \
  -af "highpass=f=200, lowpass=f=3000, afftdn, volume=5dB" \
  -c:a aac -b:a 160k -ar 44100 -f flv $KICK_KEY -f flv $YOUTUBE_KEY'

alias STRYTICK='ffmpeg -f x11grab -s $RESOLUTION -r 30 -i :0.0 \
  -f alsa -i hw:0,0 \
  -c:v libx264 -preset veryfast -crf 22 -b:v 3000k -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 60 \
  -vf "scale=$RESOLUTION:flags=lanczos,unsharp=5:5:1.0" \
  -af "highpass=f=200, lowpass=f=3000, afftdn, volume=5dB" \
  -c:a aac -b:a 160k -ar 44100 -f flv $YOUTUBE_KEY -f flv $TWITCH_KEY'

alias rec='ffmpeg -video_size 1280x720 -framerate 30 -f x11grab -i $DISPLAY -f pulse -ac 2 -i 0 -af "anlmdn=s=10,lanczos,unsharp=5:5:1.0" -c:v libx264 -crf 18 -preset veryfast sample_$(date "+%Y-%m-%d").mkv'
alias brb='cowsay -f daemon "BRB – Grabbing coffee and recharging!" | lolcat'
alias hm='cowsay -f tux "Starting Soon... 🐧 Keep the Focus!" | lolcat'
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
alias phd='cd  ~/ASMLab/phd'
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Default parameter to send to the "less" command
# -R: show ANSI colors correctly; -i: case insensitive search
LESS="-R -i"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Add sbin directories to PATH.  This is useful on systems that have sudo
echo $PATH | grep -Eq "(^|:)/sbin(:|)"     || PATH=$PATH:/sbin
echo $PATH | grep -Eq "(^|:)/usr/sbin(:|)" || PATH=$PATH:/usr/sbin

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
eval "$(starship init bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
