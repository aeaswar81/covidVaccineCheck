# covidVaccineCheck
Check for free slots with pin ,date,age and 1st/2nd dose <br/>
To run the script give the permissions using chmod <br/>
-->To run it only once give the 5th argument as 1, if you wish to run it in a loop just give pin, date, age and 1st/2nd dose<br/>
Examples: <br/>
Here 560023 is the pincode and 07-06-2021 is the date, 18 is the age , 2 is the second dose <br/>
-->To run it only once: <br/>
./check.sh 560023 07-06-2021 18 2 1 <br/>
--> To put it in an infinite loop and keep on checking, will notify when any non zero number of doses are found: <br/>
./check.sh 560023 07-06-2021 18 2

