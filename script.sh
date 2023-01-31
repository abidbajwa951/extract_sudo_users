#!/bin/bash
FILEPATH="/tmp"
USRFILE=$FILEPATH/userlist.txt
GRPFILE=$FILEPATH/grouplist.txt
USRSD=$FILEPATH/userrights.txt
GRPSD=$FILEPATH/grouprights.txt
SUDOUSERS=$FILEPATH/adminuser.txt
#rm -rf $SUDOUSERS 2>&1
grep -v '#' /etc/sudoers | awk '{print $1}' | sed 's/Defaults//g' | sed '/^$/d' >> $USRFILE
for id in `cat $USRFILE`;do
echo "$id" >> $USRSD
done
sed -i '/%/d' $USRSD
grep "[] % []" $USRFILE | tr -d '%' >> $GRPFILE
for grp in `cat $GRPFILE`;do
groupmems -g $grp -l >> $GRPSD
done

cat $USRSD $GRPSD >> $SUDOUSERS
rm -rf $USRFILE $GRPFILE $USRSD $GRPSD 2>&1
