# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

alias 1='xrandr --output eDP-1 --brightness 0.1'
alias 2='xrandr --output eDP-1 --brightness 0.25'
alias 3='xrandr --output eDP-1 --brightness 0.3'
alias 5='xrandr --output eDP-1 --brightness 0.5'
alias 10='xrandr --output eDP-1 --brightness 1'
function aw {
    local url="https://duckduckgo.com/?q=arch+wiki+"
	for arg in $@; do
		url+="$arg+"
	done
    url+="&t=brave&ia=web"
    firefox $url
}
alias ca='cat /sys/class/power_supply/BAT1/capacity'
alias dh='df -h'
alias f='free -m'
function gw {
    local url="https://duckduckgo.com/?q=gentoo+wiki+"
	for arg in $@; do
		url+="$arg+"
	done
    url+="&t=brave&ia=web"
    firefox $url
}
function i {
    url="https://duckduckgo.com/?q=wiki+"
	for arg in $@; do
		url+="$arg+"
	done
    url+="&t=brave&ia=web"
    firefox $url
}
function ii {
	url="https://duckduckgo.com/?q=wiki+"
	for arg in $@; do
		url+="$arg+"
	done
	firefox $url
	url+="+pixiv"
	firefox $url
	url=`echo "$url" | sed 's/pixiv/dic.nicovideo/'`
	firefox $url
}
alias li='clisp'
alias md='sudo mount /dev/sda2 /mnt/usb'
alias mk='mkdir'
alias n='neofetch'
alias op='vim ~/.bashrc; source ~/.bashrc'
alias p='python3 -O'
alias r='ranger'
alias rr='rm -rf'
alias si='yay -Sc --noconfirm; yay -Syu --noconfirm; sudo pacman -Sc --noconfirm; sudo pacman -Syu --noconfirm'
alias sr='sudo pacman -R --noconfirm;sudo pacman -Rns $(pacman -Qdtq) --noconfirm
'
alias ud='sudo umount /dev/sda2'
alias v='vim'
alias va='vim ~/a; xc ~/a'
alias vb='vim ~/b; xc ~/b'
alias vc='vim ~/.config/i3/config'
alias vv='vim ~/.vimrc'
alias x='firefox'
alias xc='xclip -sel c <'

PROMPT_COMMAND="printf '\n';$PROMPT_COMMAND"
PS1='\W $'

xmodmap ~/.Xmodmap
xrandr --output eDP-1 --brightness 0.3
xrandr --output HDMI-1 --auto --left-of eDP-1
xrandr --output HDMI-1 --rotate left
