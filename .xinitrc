# exec dwm

#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus
export XIM_PROGRAM=/usr/bin/ibus-daemon

export XMODIFIERS="@im=ibus"
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="xim"

#export GTK_IM_MODULE=fcitx 
#export XMODIFIERS=@im=fcitx 
#export QT_IM_MODULE=fcitx 
#export XIM_PROGRAM=/usr/bin/fcitx 

myDate(){
	myDate="$(date +"%H:%M %a, %d %B")"
	echo "$myDate"
}

myBattery(){
	## get the battery info from acpi, then cut where there is a '%'
	# get the frist half of that string, then get the last 3 bytes using tail
	myBatteryPercentage="$(acpi | cut -d'%' -f 1 | tail -c -3)"

	echo "$(checkPlugStatus)"
	#echo "$myBatteryPercentage% $(checkPlugStatus)"
}

#vol="$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))"
vol="$(amixer get Master | awk '$0~/%/{print $4}' | tr -d '[]')"   

while true; do
	#xsetroot -name " kybrd: $(checkIbusLang) | $(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))  | $(myDate) | Btry:$(myBattery)"
	#vol="$(amixer get Master | awk '$0~/%/{print $4}' | tr -d '[]')" 
	#xsetroot -name " $(checkIbusLang) | 🔈 $vol | $(myBattery) | $(myDate)"
	dwmStatusBar &	
		
	sleep 1s # grab the time every 5 seconds
done &

#exec compton
xbindkeys &
xwallpaper --zoom ~/.config/wallpaper.jpg &
xrdb ~/.Xresources &
setxkbmap -option caps:swapescape &
ibus-daemon -drx &
exec ~/suckless/dwm/dwm 
 
#exec xbindkeys

