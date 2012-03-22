#!/bin/bash
# read more about shell script at http://ss64.com/bash/
clear
echo '----------------------------------------------------------'
echo 'Automation script for NME project "haXe NME skinnable UI"'
echo 'Make sure that you have all the sdk-s installed'
echo 'Read more about this:' 
echo '     http://www.haxenme.org/developers/get-started/'
echo ''
echo 'Start compiling different targets'
echo '----------------------------------------------------------'

BASEDIR=$(dirname $0)
# echo $BASEDIR

# set dir to the 'root' dir 
cd $BASEDIR

#remove the export folder (to make sure that the compile is fresh)
echo '------ remove/delete the android export folder'
rm -d -r Export/android 

echo '------ remove previous installed file'
nme uninstall "project.nmml" android

echo '------ compile flash'
nme test "project.nmml" flash

echo '------ compile android'
nme test "project.nmml" android

echo '------ end shell script'
echo -e '\a'
