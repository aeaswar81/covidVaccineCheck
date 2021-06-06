
check_vac () {
a=$(curl -sX GET "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=$1&date=$2" -H  "accept: application/json" -H  "Accept-Language: hi_IN")


b=$(jq -e '.sessions[].available_capacity_dose1'<<<"$a")
echo "$b"
if [ ! -z "$b" ] && [ "$b" != "0" ] ;
then
echo "found with doses " $b
else
echo "not found"
fi
}
if [ "$3" = "1" ];
then
echo "checking only once"
check_vac $1 $2 $3
else
echo "looping"
fi
