#!/bin/bash
trial=/etc/openvpn/server/hfn-vpn/trial
payment=/etc/openvpn/server/hfn-vpn/payment
temp=/etc/openvpn/server/hfn-vpn/temp
client="$1"
perioada="$2"



if [ "$perioada" = "" ]; then
echo lipese perioada
echo adauga :
echo 0 pentru nelimitat
echo 1 pentru 1 luna
echo 3 pentru 3 luni
echo 6 pentru 6 luni
echo 12 pentru 12 luni
exit 0
fi
if [ $client = "" ]; then
echo campul client lipseste
fi

######        Verifica daca clientul este trial sau nu
check_trial_user(){
ls /etc/openvpn/server/hfn-vpn/trial
}


if [ "$perioada" = "0" ]; then
payment_time=3650
fi

if [ "$perioada" = "1" ]; then
payment_time=$(grep '^payment ' /etc/openvpn/server/hfn-vpn/config.conf | cut -d " " -f 2)
fi
if [ "$perioada" = "3" ]; then
payment_time=$(grep '^payment_1 ' /etc/openvpn/server/hfn-vpn/config.conf | cut -d " " -f 2)
fi
if [ "$perioada" = "6" ]; then
payment_time=$(grep '^payment_2 ' /etc/openvpn/server/hfn-vpn/config.conf | cut -d " " -f 2)
fi
if [ "$perioada" = "12" ]; then
payment_time=$(grep '^payment_3 ' /etc/openvpn/server/hfn-vpn/config.conf | cut -d " " -f 2)
fi


if_trial(){
if [ "$(check_trial_user)" != "" ]; then
add_list_trialuser="/tmp/if_trial_listuser.txt"
echo "$(check_trial_user)" > $add_list_trialuser
client2=$(grep '^'$client'' /tmp/if_trial_listuser.txt | cut -d " " -f 1)
if [ "$client" = "$client2" ]; then
trial_yn="y"
else
trial_yn="n"
fi
fi
if [ -e /tmp/if_trial_listuser.txt ]; then
rm -f /tmp/if_trial_listuser.txt
fi
if [ "$trial_yn" = "y" ]; then
time_remaining=`cat  "$trial"/"$client"| grep ^$1 | awk 'NR==1 {print $2}'`
	the_present_time=`date +"%s"`
	date="$time_remaining"
    old_date=$(date -d @"$date")
    new_date=$(date -d "$old_date + $payment_time days")
    renew=$(date -d "$new_date" +%s)
 	rm -f "$trial"/"$client"


echo "$client $renew (renew set at $the_present_time)" >> $payment/$client
echo alerta Valy reactualizare license : "$client" cu "$payment_time" zile
else
echo renew_time_payment
fi
}

if_trial

if [ -f "$temp"/"$client".0 ]; then
rm -f "$temp"/"$client".0
fi
if [ -f "$temp"/"$client".1 ]; then
rm -f "$temp"/"$client".1
fi
if [ -f "$temp"/"$client".2 ]; then
rm -f "$temp"/"$client".2
fi
if [ -f "$temp"/"$client".3 ]; then
rm -f "$temp"/"$client".3
fi
