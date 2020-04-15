#!/bin/bash

DTS=$(date "+%Y%m%d-%H%M%S")
CLAMFILE=clamd.conf
FRESHFILE=freshclam.conf

diff $CLAMFILE.sample $CLAMFILE > conf-$CLAMFILE.$DTS.diff
diff $FRESHFILE.sample $FRESHFILE > conf-$FRESHFILE.$DTS.diff
diff -U 1 $CLAMFILE.sample $CLAMFILE > conf-$CLAMFILE.$DTS.patch
diff -U 1 $FRESHFILE.sample $FRESHFILE > conf-$FRESHFILE.$DTS.patch
