#function to check retrieve data and check 
check_vac () {
#get the data
a=$(curl -sX GET "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=$1&date=$2" -H  "accept: application/json" -H  "Accept-Language: hi_IN")
#get the available doses
b=$(jq -e '.sessions[].available_capacity_dose1'<<<"$a")
#if its empty then no centre is open
if [ -z "$b" ];
then
#if running only once print output 
	if [ "$3" = "1" ]; 
	then
		echo "slot not open"
	fi
	 
#depending on the number of centres for that pincode b can be string separated by spaces 
else 
	for i in $b
	do
	if [ "$i" != "0" ];
	then
		echo "Doses found"
		echo "Book now :D "
		zenity --info --width=400 --height=200  --text "Doses available.\nClose this box and end the script if its on loop mode" --title="Book NOW !"

		return 1
	fi
	done
	
	if [ "$3" = "1" ];
	then
		echo $((${#b}-${#b}/2)) "centres open"
		echo "0 doses found"
	fi
fi
}


if [ "$3" = "1" ];
then
echo "checking only once"
#arguments 1 and 2 are pincode and date respectively , 3 is once 
check_vac $1 $2 $3
else
echo "looping"
	while true
	do
		check_vac $1 $2
		sleep 1
	done 
	
fi
