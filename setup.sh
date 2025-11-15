rc-update add iwd default
rc-service iwd start

rfkill unblock bluetooth wlan
#iwctl

packages=(
  exfatprogs
  firefox-bin
  ranger
  screenfetch
  vim
)

for i in "${packages[@]}";
  do emerge -q1 "$i";
done
