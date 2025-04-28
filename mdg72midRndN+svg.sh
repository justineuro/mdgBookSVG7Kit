#!/bin/bash
#===================================================================================
#
#	 FILE:	mdg72midRndN+svg.sh
#
#	USAGE:	mdg72midRndN+svg.sh <num>
#
#		where <num> is the number of random MDG minuets to be generated, e.g., 20.
#		*** NOTE:  This script has to be in the same directory as mdg72mid+svg.sh. ***
#
# DESCRIPTION:	Used for generating ABC and SVG files of a particular 
#		Musical Dice Game (MDG) rondo based on A. Callegari's'
#		"L'art de composer de la musique sans en connaître les éléments"
#
#      AUTHOR:	J.L.A. Uro (justineuro@gmail.com)
#     VERSION:	0.0.0
#     LICENSE:	Creative Commons Attribution 4.0 International License (CC-BY)
#     CREATED:	2025/04/24 16:44:02
#    REVISION:	
#==================================================================================

#----------------------------------------------------------------------------------
# define the function genS() that randomly chooses an integer from 1 to 6, inclusive
#----------------------------------------------------------------------------------
genS() { # RANDOM randomly generates an integer from 0 to 32765
	rnd=32758
	until [ $rnd -lt 32758 ]
	do
		rnd=$[RANDOM]
		if [ $rnd -lt 32758 ]; then echo $[rnd%11+2]; fi
	done
}

#----------------------------------------------------------------------------------
# declare the variables "diceR" as an array
# diceS - array containing the 16 outcomes from input line
#----------------------------------------------------------------------------------
declare -a diceR

#----------------------------------------------------------------------------------
# generate the <num> random minuets
#----------------------------------------------------------------------------------
i=1
while [ $i -le $1 ]; do

#----------------------------------------------------------------------------------
# generate the random 32-sequence of outcomes of the 32 throws of a dice for 
# the measures of the rondo:
#		n1-32 are any of the 11 possible integers from the set {2,3,4,..., 10,11,12}; 
#		n1-n8 for 1st part of the aria (measures from Table 1, cols 1-8)
#		n9-n12 for ritornello (measures for the Table at the end of the Series)
#		n13-n20 for the 2nd part of the aria (measures from Table 2) 
#		n21-n28 for the 3rd part of the aria (measures from Table 3)
#		n29-n32 for the additional 4 measures of the optional 4th part of the aria
#							(measures from Tables 1, cols 9-12)
#----------------------------------------------------------------------------------
	for j in {0..31}; do
		diceR[$j]=`genS`
	done
echo ${diceR[*]}
	
#----------------------------------------------------------------------------------
# generate a rondo in ABC notation and corresponding MIDI and svg for the current 
# diceR using mdg72mid+svg.sh
#----------------------------------------------------------------------------------
	./mdg72mid+svg.sh ${diceR[*]}
	i=`expr $i + 1`
done
#
##
####
