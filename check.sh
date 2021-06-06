
check_vac () {
a=$(curl -sX GET "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=$1&date=$2" -H  "accept: application/json" -H  "Accept-Language: hi_IN")


b=$(jq -e '.sessions[].available_capacity_dose1'<<<"$a")
#echo "$b"
if [ -z "$b" ];
then
	if [ "$3" = "1" ]; 
	then
		echo "slot not open"
	fi
	 
else 
	if [ "$b" != "0" ] ;
	then
		echo $b "doses found"
		echo "Book now \! \! "
	else
		if [ "$3" = "1" ];
		then
			echo "slot open"
			echo "0 doses found"
		fi
	fi
fi
}
if [ "$3" = "1" ];
then
echo "checking only once"
check_vac $1 $2 $3
else
echo "looping"
	while true
	do
		check_vac $1 $2 
		sleep 1
	done 
	
fi
