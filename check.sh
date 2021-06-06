#check if pincode and date is correct 
a=$(curl -sX GET "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=$1&date=$2" -H  "accept: application/json" -H  "Accept-Language: hi_IN")
if echo $a | grep -q "error" ; 
then
echo "Invalid pincode or date. Try again"
exit
fi
#function to check retrieve data and check 
check_vac () {
#get the data
a=$(curl -sX GET "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=$1&date=$2" -H  "accept: application/json" -H  "Accept-Language: hi_IN")
#get the available doses
b=$(jq -e '.sessions[].available_capacity_dose1'<<<"$a")
age=$(jq -e '.sessions[].min_age_limit'<<<"$a")

#if its empty then no centre is open
if [ -z "$b" ];
then
#if running only once print output 
	if [ "$4" = "1" ]; 
	then
		echo "slot not open"
	fi
	 
#depending on the number of centres for that pincode b can be string separated by spaces , split string into array
else 
	IFS=' ' read -r -a barray <<< "$b"
	IFS=' ' read -r -a garray <<< "$age"

	for index in "${!barray[@]}"
	do
	if [ "${garray[index]}" -le "$3" ];then
	if [ "${barray[index]}" != "0" ];
	then
		echo "Doses found"
		echo "Book now :D "
		zenity --info --width=400 --height=200  --text "Doses available.\nClose this box and end the script (Ctrl+C) if its on loop mode" --title="Book NOW !"

		return 1
	fi
	fi
	done
	
	if [ "$4" = "1" ];
	then
		echo ${#barray[@]} "centres open"
		echo "0 doses found"
	fi
fi
}


if [ "$4" = "1" ];
then
echo "checking only once"
#arguments 1 and 2 are pincode and date respectively , 3 is once 
check_vac $1 $2 $3 $4
else
echo "looping"
	while true
	do
		check_vac $1 $2 $3
		sleep 1
	done 
	
fi
