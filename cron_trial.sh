#!/bin/bash


folder=/etc/openvpn/server/hfn-vpn/trial
temp=/etc/openvpn/server/hfn-vpn/temp
client=$1

alert_0=5
alert_1=4
alert_2=3
alert_3=2

check_time(){
if [ ! -d /etc/openvpn/server/hfn-vpn/temp ]; then
mkdir /etc/openvpn/server/hfn-vpn/temp
fi

time_remaining=`cat  "$folder"/"$client"| grep ^$1 | awk 'NR==1 {print $2}'`
if [ "$time_remaining" = "" ]; then
echo alerta Valy
else
	already_protected_yn=y
	the_present_time=`date +"%s"`
	if [ "$the_present_time" > "$time_remaining"  ] ; then
		out_of_time_yn=y;
	else
		out_of_time_yn=n;
	fi
fi

((time_remaining>the_present_time)) && out_of_time_yn=n
((time_remaining<the_present_time)) && out_of_time_yn=y
if [ "$already_protected_yn" = "y" ] && [ "$out_of_time_yn" = "n" ] ; then
echo "OpenVPN client [$client] mai este valabil $(((the_present_time-time_remaining)/-86400)) zile ..."

timp_ramas="$(((the_present_time-time_remaining)/-86400))"

if (( "$timp_ramas" < "$alert_0" )); then
if [ -f "$temp"/"$client".0 ]; then
echo
else
echo "I sent the first notice on: $the_present_time" >> "$temp"/"$client".0
echo trimite notificarea 0
fi
fi

if (( "$timp_ramas" < "$alert_1" )); then
if [ -f "$temp"/"$client".0 ]; then
echo
fi
if [ -f "$temp"/"$client".1 ]; then
echo
else
echo "I sent the second notice on: $the_present_time" >> "$temp"/"$client".1
echo trimite notificarea 1
fi
fi

if (( "$timp_ramas" < "$alert_2" )); then
if [ -f "$temp"/"$client".0 ]; then
echo
fi
if [ -f "$temp"/"$client".1 ]; then
echo
fi
if [ -f "$temp"/"$client".2 ]; then
echo
else
echo "I sent the third notice on: $the_present_time" >> "$temp"/"$client".2
echo trimite notificarea 2
fi
fi

if (( "$timp_ramas" < "$alert_3" )); then
if [ -f "$temp"/"$client".0 ]; then
echo
fi
if [ -f "$temp"/"$client".1 ]; then
echo
fi
if [ -f "$temp"/"$client".2 ]; then
echo
fi
if [ -f "$temp"/"$client".3 ]; then
echo
else 
echo "I sent the fourth notice on: $the_present_time" >> "$temp"/"$client".3
echo trimite notificarea 3
fi
fi

fi
if [ "$already_protected_yn" = "y" ] && [ "$out_of_time_yn" = "y" ]; then
already_protected_yn=n
times=`cat  "$folder"/"$client"| grep ^$1 | awk 'NR==1 {print $2}'`
rm -f "$folder"/"$client"
if [ -f "$temp"/"$client".0 ]; then
rm "$temp"/"$client".0
fi
if [ -f "$temp"/"$client".1 ]; then
rm "$temp"/"$client".1
fi
if [ -f "$temp"/"$client".2 ]; then
rm "$temp"/"$client".2
fi
if [ -f "$temp"/"$client".3 ]; then
rm "$temp"/"$client".3
fi
#touch "$client"
# remove client
/usr/bin/bash /etc/openvpn/server/hfn-vpn/client.sh del "$client"
fi
}



if [ "$client" != "" ]; then
if [ ! -f "$folder"/"$client" ]; then
echo fisierul "$folder"/"$client" nu exista
else
check_time
sterge_time=`cat  "$folder"/"$client"| grep ^$1 | awk 'NR==1 {print $2}'`
rm -f $sterge_time
fi
fi