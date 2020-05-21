#!/bin/bash

INTERVAL=60
MULTIPLIER=1

while getopts "hi:m" OPTION; do
        case "$OPTION" in
                i)
			INTERVAL="$OPTARG"
                        ;;
                m)
			MULTIPLIER=60
                        ;;
                h)
			echo "Usage: texstudio-autobuild"
		        echo "   or: texstudio-autobuild -i NUMBER"
		        echo "Recompile texstudio every NUMBER seconds (or minutes). Default value for NUMBER is 60 seconds (or minutes), must be an integer."
		        echo "   -i     set interval between compilations"
		        echo "   -m     set interval to minutes, default becomes 60 minutes"
		        echo "   -h     display this help and exit"
		        exit 0
		        ;;
		[?])	echo "Usage: $0 [-i interval] [-h]"
			exit 1
			;;
        esac
done

INTERVAL=$[ INTERVAL*MULTIPLIER ]
COUNTER=$INTERVAL

echo "Recompilation interval set to: $(( INTERVAL/60 )) minutes $[ INTERVAL%60 ] seconds."
echo 
while true
do
	sleep 1
	tex_window_id=$(xdotool search --name "tex - TeXstudio")
	focused_window_id=$(xdotool getwindowfocus)
	if test "$focused_window_id" == "$tex_window_id"
	then
		((COUNTER-=1))
		
		echo -en "\e[1A"
		echo -e "\e[0K\r$(( COUNTER/60 )) minutes $[ COUNTER%60 ] seconds until next build attempt."
		if [[ $COUNTER -eq 0 ]]
		then
			echo -en "\e[1A"
			echo -e "\e[0K\rBuilding..."
			xdotool windowactivate --sync $tex_window_id key F5
			sleep 1
			xdotool windowactivate --sync $focused_window_id
			COUNTER=$INTERVAL
		fi
	else
		echo -en "\e[1A"
		echo -e "\e[0K\rWindow not in focus, suspending until focus is restored."
	fi
	
done

