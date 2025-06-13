#!/bin/bash
 
# This file update the information of versions in description.xml
# and  the update information.xml
# and build (compress) the extension

Ext="AltSearch"
RotExt="Code"

if [[ ! $1 ]]
then
	echo "Usage:"
	echo "./build.sh [version]"
	echo "example: ./build.sh 12.2.3"
	exit
	else
	echo
    echo "### updating " $RotExt"/description.xml"
   cd $RotExt
	sed -i s'/<version value.*/<version value="'$1'"\/>/' description.xml
    echo "### Compiling " $Ext
    # I use 7zip but you can use zip:
    # zip -r $Ext.oxt .
     7z a ./$Ext.oxt . -tzip
     cd ..
    mv $RotExt/$Ext.oxt ./
    echo 
    echo "### updating " $Ext".update.xml"
	sed -i s'/<version value.*/<version value="'$1'"\/>/' $Ext.update.xml
#only if oxt is in the release 	sed -i s'/raw.*/raw\/'$1'\/'$Ext'.oxt"\/>/' $Ext.update.xml
    echo "### Done"
fi
