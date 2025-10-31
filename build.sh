#!/bin/bash
 
# This script updates the information of version in description.xml
# and  the update information.xml
# and build (compress) the extension

Ext=AltSearch
RootExt=Code
ZIP_CMD='7z -tzip a '

# I use 7zip, but you can use zip:
#ZIP_CMD='zip -ru ' 


SubstVersion() {
	echo
	echo "### updating  $2"
	sed -i 's#<version value.*#<version value="'$1'"/>#' $2
}

if [[ ! $1 =~ ^[0-9]+(\.[0-9]+)+$ ]]
then
	cat <<__USAGE
  Usage:
  $0 Version.Subversions...   (using dot separated digits)
  example: $0 12.2.3
__USAGE

else
    SubstVersion $1 $RootExt/description.xml

    cd $RootExt
    rm ../$Ext.oxt
    echo "### Compiling " $Ext
    ${ZIP_CMD} ../$Ext.oxt .
    cd ..
	SubstVersion $1 $Ext.update.xml
       #The next line is if the .OXT is in releases, if is in root dir will break the updates.
       #sed -i s'/raw.*/raw\/'$1'\/'$Ext'.oxt"\/>/' $Ext.update.xml
    echo "### Done, Version " $1 " of " $Ext 
fi
