#!/bin/bash

cat /etc/passwd > user-pw.lst
cat /etc/group > group-pw.lst

dscl . -list Users UniqueID > user-dscl.lst
dscl . -list Groups PrimaryGroupID > group-dscl.lst

cat user-dscl.lst | sort -n -k2 > userbynum-dscl.lst
cat group-dscl.lst | sort -n -k2 > groupbynum-dscl.lst
 
