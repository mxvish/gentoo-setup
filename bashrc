# /etc/skel/.bashrc
if [[ $- != *i* ]] ; then
	return
fi

alias 2='xrandr --output eDP-1 --brightness 0.25'
alias 3='xrandr --output eDP-1 --brightness 0.3'
alias 10='xrandr --output eDP-1 --brightness 1'
function aw {
    local url="https://duckduckgo.com/?q=arch+wiki+"
	for arg in $@; do
		url+="$arg+"
	done
    url+="&t=brave&ia=web"
    brave $url
}
alias ca='cat /sys/class/power_supply/BAT1/capacity'
alias dh='df -h'
alias f='free -m'
function i {
    url="https://duckduckgo.com/?q=wiki+"
	for arg in $@; do
		url+="$arg+"
	done
    url+="&t=brave&ia=web"
    brave $url
}
alias li='clisp'
alias ls='ls --color=auto'
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
alias vc='vim ~/.config/i3/config'
alias vv='vim ~/.vimrc'
alias x='brave-bin'
alias xc='xclip -sel c <'

PROMPT_COMMAND="printf '\n';$PROMPT_COMMAND"
PS1='\W \# $'

xmodmap ~/.Xmodmap
xrandr --output eDP-1 --brightness 0.3
xrandr --output HDMI-1 --auto --left-of eDP-1
#xrandr --output HDMI-1 --rotate left
