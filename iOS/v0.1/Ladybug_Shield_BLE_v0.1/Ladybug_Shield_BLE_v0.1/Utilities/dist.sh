#!/bin/bash

#
# embedXcode
# ----------------------------------
# Embedded Computing on Xcode
#
# Copyright © Rei VILO, 2010-2015
# http://embedxcode.weebly.com
# All rights reserved
#
#
# Last update: Oct 26, 2014 release 223

# Uncomment to keep main.cpp
#
#KEEP_MAIN_CPP=1

echo 'Creating Distribution folder'
if [ ! -d ../Distribution ] ; then mkdir ../Distribution ; fi

rm -fr ../Distribution/*
mkdir ../Distribution/$@

# Copy all
echo 'Copying files'
cp -R . ../Distribution/$@

# Remonce unwanted files
FILE=../Distribution/$@/About/
if [ -d "$FILE" ] || [ -f "$FILE" ] ; then  rm -r "$FILE" ; fi ;

FILE=../Distribution/$@/Builds/
if [ -d "$FILE" ] || [ -f "$FILE" ] ; then  rm -r "$FILE" ; fi ;

FILE=../Distribution/$@/Makefiles/
if [ -d "$FILE" ] || [ -f "$FILE" ] ; then  rm -r "$FILE" ; fi ;

FILE=../Distribution/$@/Makefile
if [ -d "$FILE" ] || [ -f "$FILE" ] ; then  rm -r "$FILE" ; fi ;

FILE=../Distribution/$@/Configurations/
if [ -d "$FILE" ] || [ -f "$FILE" ] ; then  rm -r "$FILE" ; fi ;

FILE=../Distribution/$@/Sketchbook/
if [ -d "$FILE" ] || [ -f "$FILE" ] ; then  rm -r "$FILE" ; fi ;

FILE=../Distribution/$@/Utilities/
if [ -d "$FILE" ] || [ -f "$FILE" ] ; then  rm -r "$FILE" ; fi ;

FILE=../Distribution/$@/ReadMe.txt
if [ -f "$FILE" ] ; then  mv "$FILE" ../Distribution/ ; fi ;

# Remove main.cpp
if [ -z "$KEEP_MAIN_CPP" ] ;
then
    FILE=../Distribution/$@/main.cpp
    if [ -d "$FILE" ] || [ -f "$FILE" ] ;
    then
        echo "Removing main.cpp" ;
        rm -r "$FILE" ;
    fi ;
fi

# Copy PDF if exists
if [ -f Utilities/latex/refman.pdf ] ;
then
    echo 'Copying documentation';
    cp Utilities/latex/refman.pdf ../Distribution/$@' - Reference Manual.pdf' ;
else
    echo "No documentation";
fi

echo '---- List ----'
find ../Distribution
