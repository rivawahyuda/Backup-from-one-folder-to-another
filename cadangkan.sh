#!/bin/sh
#
###################################################################################################################################
# Company : PT.Boer Technology
# ScriptName: cadangkan.sh
# Author: Riva Wahyuda as Freelance Designer
# Function: Backup from one folder to another, reference by date modified of the folder
###################################################################################################################################
#
#

###################################################################################################################################
#  FUNGSI
###################################################################################################################################

weekOfMonth () {

	#echo $dateValue
	
	minus=$(echo $(date -d "$dateValue" +%d) - 1 | bc)
	#echo $minus
	
	weekNumberNow=$(date +%V)
	#echo $weekNumberNow
	
	weekNumberDate1=$(date -d "-$minus days" +%V)
	#echo $weekNumberDate1
	
	weekOfMonth=$(echo $weekNumberNow - $weekNumberDate1 + 1 | bc)  #fungsi kalkulator
	echo $weekOfMonth
}

###################################################################################################################################
#  KONSTAN
###################################################################################################################################

dateNow=$(date +%Y-%m-%d)
dateModified=$(date +%Y-%m-%d)
#dateModified=$(echo $(stat -c %y sunday/ | cut -d ' ' -f1))

###################################################################################################################################
#  EKSEKUSI
###################################################################################################################################

dateValue=$dateNow
womDateNow=`weekOfMonth $dateValue`

dateValue=$dateModified
womDateModified=`weekOfMonth $dateValue`

#echo $womDateNow
#echo $womDateModified

#weekOfMonth
if [ $womDateNow -eq $womDateModified ]
	then
		echo "Sama, $womDateNow, $womDateModified"
		rsync -avzr /share/Backup/sunday/* /share/Backup/week$womDateNow     #menyesuaikan
	else
		echo "Tidak Sama, $womDateNow, $womDateModified"
fi
