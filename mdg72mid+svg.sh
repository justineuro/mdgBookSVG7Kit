#!/bin/bash
#===================================================================================
#
#	 FILE:	mdg72mid+svg.sh
#
#	USAGE:	mdg72mid+svg.sh n1 n2 n3 n4 n5 n6 n7 n8 n9 n10 n11 n12 n13 n14 n15 n16 \
#									n17 n18 n19 n20 n21 n22 n23 n24 n25 n26 n27 n28 n29 n30 n31 n32
#
#		where n1-32 are any of the 11 possible integers from the set {2,3,4,..., 10,11,12}; 
#		n1-n8 for 1st part of the aria (measures from Table 1, cols 1-8)
#		n9-n12 for ritornello (measures for the Table at the end of the Series)
#		n13-n20 for the 2nd part of the aria (measures from Table 2) 
#		n21-n28 for the 3rd part of the aria (measures from Table 3)
#		n29-n32 for the additional 4 measures of the optional 4th part of the aria
#							(measures from Tables 1, cols 9-12)
#
# DESCRIPTION:	Used for generating ABC and SVG files of a particular 
#		Musical Dice Game (MDG) rondo based on A. Callegari's'
#		"L'art de composer de la musique sans en connaître les éléments"
#
#      AUTHOR:	J.L.A. Uro (justineuro@gmail.com)
#     VERSION:	0.0.0
#     LICENSE:	Creative Commons Attribution 4.0 International License (CC-BY)
#     CREATED:	2025/04/23 09:35:22
#    REVISION:	
#==================================================================================

#----------------------------------------------------------------------------------
# declare the variables "diceS" and "measNR" as arrays
# diceR - array of 32 two-dice tosses given in the command line or randomly generated
# diceS - array of 76-sequence of measures based on 32 tosses from diceR
# measNR - array of all possible measure notes for a specific outcome
#----------------------------------------------------------------------------------
declare -a diceR diceS measNR

# input diceR and diceS 
diceR=( $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} ${28} ${29} ${30} ${31} ${32} )
diceS=( $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${21} ${22} ${23} ${24} ${25} ${26} ${27} ${28} $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} ${29} ${30} ${31} ${32} $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} )

#----------------------------------------------------------------------------------
# input rule table to determine corresponding S/I/G/F measures for each toss outcome
#----------------------------------------------------------------------------------
# aria part 1; optional aria part 4 (use last 4 columns)
ruletabA() {
	case $1 in
	2) measNR=( 19  79 176 307 272  ""  88 138 185  73 118  52);;
	3) measNR=( 68 303 206  83 244  35 246  48  43 130 248  62);;
	4) measNR=(305 219  "" 257 251  78 299 261 258 294 250  22);;
	5) measNR=(308 218 201 283 210  42  57  ""   2 165  91 211);;
	6) measNR=( 46 240 169 173 268  36 271 259 238 204  72  24);;
	7) measNR=(252 145 134 304 228  66  60  77 253 161  44 164);;
	8) measNR=(195 217 104 216 141 214 235  84 279 224 188 186);;
	9) measNR=( 75  14 160 213 297 243  47  64  86  10 149 106);;
	10) measNR=( 58  63 156 150 127 105 153 233  96  90 125  89);;
	11) measNR=( 49  50 142 306 171 137  41  81   3 245 263 116);;
	12) measNR=( 54 205  94  13 302  15  85 144  99 135  65  82);;
	esac
}

# ritornello
ruletabRit() {
	case $1 in
	2) measNR=(10 15 21 12);;
	3) measNR=( 4  9 16 30);;
	4) measNR=(22 31 33 42);;
	5) measNR=(27 41  1 37);;
	6) measNR=(26 40 43 17);;
	7) measNR=(18  2 11 28);;
	8) measNR=(23 19 25 36);;
	9) measNR=(44  7 35 38);;
	10) measNR=( 6 24  3 29);;
	11) measNR=( 5 20 34 14);;
	12) measNR=(13  8 32 39);;
	esac
}

# aria part 2
ruletabB() {
	case $1 in
	2) measNR=( 11   9  12 200  17 133 107  40);;
	3) measNR=(212 225  20 182  55 114 110  93);;
	4) measNR=( 34 152  67 199 276 296 262  37);;
	5) measNR=(220 154 236 227 300 180 198 168);;
	6) measNR=( 23 231 179 301 289 232   5 177);;
	7) measNR=(119 285  ""  18 163 196  92 117);;
	8) measNR=(223 229 288 241  "" 166 140 189);;
	9) measNR=(136 270 290  28 146  98 222 274);;
	10) measNR=(267 120 265 247  95 167  76 295);;
	11) measNR=(155 178 293   1 183  87 124 115);;
	12) measNR=(256 102 226  "" 292   8 264 260);;
	esac
}

# aria part 3
ruletabC() {
	case $1 in
	2) measNR=(111 275  21   6  71  70 242  38);;
	3) measNR=(207 112 203 221 126  97 249 143);;
	4) measNR=(187 280 175 172  51 147 284  27);;
	5) measNR=(281 103 184 215 159  45 266  33);;
	6) measNR=(181 239  59 254 148 298 129 278);;
	7) measNR=(  4  53 162 194  56  16 230  25);;
	8) measNR=( 39 269 237 128 234 123 282 151);;
	9) measNR=( 29 157 202 286  74 209 287 170);;
	10) measNR=(100 208 158 122 197 255 273  30);;
	11) measNR=(101 108 139 277  26 193 113 109);;
	12) measNR=(190 174  61 192   7 121  69  80);;
	esac
}

#----------------------------------------------------------------------------------
# input notes for Arias
# declare arrays "notesAriaSup", "notesAriaInf", "notesAriaHG" and "notesAriaFH"
# notesAriaSup - array for possible measures for the aria's Superior Chant
# notesAriaInf - array for possible measures for the aria's Inferior Chant
# notesAriaHG - array for possible G-clef measures for the harp/pianoforte
# notesAriaHF - array for possible F-clef measures for the harp/pianoforte
#----------------------------------------------------------------------------------
declare -a notesAriaSup notesAriaInf notesAriaHG notesAriaFH 

#----------------------------------------------------------------------------------
# define notesAriaSup, array of 308 possible measures
#----------------------------------------------------------------------------------
notesAriaSup=( "c/A/B/d/ c2z2" "[M:7/8] ze2f A G c [M:3/4]" "[M:7/8] ze/d/ f/d/ c3G [M:3/4]" "[M:7/8] zf3/d/ B B d B [M:3/4]" " {d/}cz B/ A/ G3/z/ A/B/" "{B/}AG/A/ F2 z2" "dd2^c d e" "g/f/e/d/c2z2" "c2f2z2" "A/F/G/A/B/c/d/e/f f" "[M:7/8] z BB2 d/c/ B/c/ d/c/ [M:3/4]" " BB2 d/c/ B/c/ d/c/" "G/F/E/D/C2 z2" "G/F/E/D/C2 z2" "e2f c d B" "d3/e/ f/g/e/f/ dz" " fc2 d/c/ B/A/ G/F/" "c/f/e/f/c2z2" "AF2 f/e/ d/c/ B/A/" "{c/}=B/A/B/c/ B B c c" "{c/}BA/B/ G d c B" "(G4A) z" "zFf2e d c" "(G4F)z" "[M:5/8]A4 !fermata!z [M:3/4]" "ff2d e ^c" "[M:5/8] (B2A2)!fermata!z [M:3/4]" "c/d/e/f/c2z2" "[M:7/8] zB/(c/d/c/) B B A G [M:3/4]" " [M:5/8] (B2A2)!fermata!z [M:3/4]" "(G3/A/) B c d f" "c/d/e/f/F2z2" "[M:5/8] A4!fermata!z [M:3/4]" "[M:7/8] z{B}A/G/A/B/ A A B d [M:3/4]" " c/d/e/d/ c/d/B/c/ A G" "e/g/f/e/ c/e/d/B/ A/c/B/G/" "[M:5/8] [Cc]4!fermata!z [M:3/4]" "[M:5/8] A4!fermata!z [M:3/4]" "[M:7/8] zFf e dc B [M:3/4]" " [M:5/8] {d}c4!fermata!z [M:3/4]" "A/G/A/B/ cd ef" "e3/f/ g/f/e/d/ c/B/A/G/" "[M:7/8] zd c2B A G [M:3/4]" " ^c2d B G E" "[M:7/8] d/e/f/e/ d/^c/d/B/ A2z [M:3/4]" "c/B/A/G/ F F A A" "f/e/f/e/ d/c/d/c/ B/A/B/A/" "G/B/G/E/(G2F)z" "f3/c/ A A d B" "B/(A/B/G/)E2z2" "^c2d c d e" "(G4F2)" "A/B/G/A/F2z2" "[M:7/8] zF/A/G/A/ F B A d [M:3/4]" " =B/c/d/e/ f G G G" "E E2A ^c e" "A/c/B/d/ cde f" "[M:7/8] zF/A/G/B/ A A G A [M:3/4]" " {c}=BA/B/ c _B A G" "A/F/G/A/ B/G/A/B/ c/A/B/c/" "c/=B/c/d/ c G _B G" "(G4F)z" "B/d/c/e/ d2z2" "G/B/ A/G/(G2F)z" " f/d/ B/G/ F3E" "^F G2A B G" "{B}A/G/A/B/ A A B d" "[M:7/8] z{G}F/E/F/G/ A B c d [M:3/4]" " c/=B/ c/ d/e3^G" "F/A/G/B/ A2z2" "A A2A ^c e" "f f2 e/d/ c/B/ A/G/" "A c2 faf" "G f2 e ^c c" "[M:7/8] zc/d/B/c/ A A F A [M:3/4]" " f/e/ d/ c/ d/c/B/A/ B/A/G/F/" "d/f/ e/g/(g2f)z" "g3/f/ e d c B" " B/(c/d/B/) G2 z2" "[M:5/8] (B2A2)z [M:3/4]" "f/d/ B/G/(G2F)z" "(G4F)z" "A/(B/c/A/)G2z2" "d/B/ B/G/(G2F)z" "A/G/F/G/ F/G/A/B/c f" "[M:7/8] ze2f e/d/ c/B/ A/G/ [M:3/4]" " {d}c/=B/c/d/ e2z2" "f/g/a/b/ a/g/f/e/ d/c/B/A/" "(G4F)z" "A/c/B/d/c f f f" "GG2d c E" "f/e/f/g/ f F A F" "[M:5/8] {d}c4!fermata!z [M:3/4]" "d {c}B/A/4B/4 ef2A" "A/c/B/d/ c g d =B" "[M:7/8] zff2 f e/d/ c/B/ [M:3/4]" " f3/e/ d2z2" "{d}c=B/A/G2z2" "[M:7/8] zf/d/ B/ G/F3E [M:3/4]" "[M:7/8] zc/(d/f/d/) c c c/B/ A/G/ [M:3/4]" "[M:7/8] zFB A d c B [M:3/4]" " c/d/e/f/F2z2" "A/G/A/G/F2z2" "g G2 d c B" " e/g/f/d/(c2c/)B/A/G/" "(G4F)z" "A/F/ A/ c/ fc AF" "A/B/G/A/F2z2" "[M:5/8] (B2A2)!fermata!z [M:3/4]" "A/f/ e/ d/ c/e/d/c/ =B/d/c/B/" "[M:7/8] z{c}BA/B/ G d c B [M:3/4]" " A/B/G/A/F2z2" "f/d/ c/ =B/ e/c/B/A/ d/B/A/^G/" "c/d/e/f/g2z2" "[M:5/8] [Cc]4!fermata!z [M:3/4]" "(G4F)z" "[M:5/8] [Ce]4!fermata!z [M:3/4]" "d/e/f/d/ B/c/d/B/ G/A/B/G/" "[M:7/8] zG c2 G A B [M:3/4]" " (c3/f/)c2z2" "(f3/e/)d2z2" "A/B/A/G/F2z2" "dc/B/A/G/F/E/D2" "a A/ A/ G3 A/=B/" "a2 g/f/e/d/ c/B/A/G/" "AA2A A A" "=B/d/c/A/ G G G G" "A/B/G/A/F2z2" "c c c/e/ d/c/ =B/d/ c/B/" "{_B/}A/G/A/B/ cdef" "(B/c/B/)A/ G E B G" "G c2 G A B" "(G3/E/) C2 z2" " e3/g/ B d G B" "A/c/B/d/ c/f/e/g/ f f" "E/F/G/A/ B G A B" "g/f/e/d/ c/d/f/d/ c/B/A/G/" "f/d/ B/G/ (G2A)z" "FB A d c B" "A/c/B/d/ c F {B/}A G/F/" "_e ^F2 G B d" "G/A/B/c/ d e f F" "[M:5/8] (B2A2)!fermata!z [M:3/4]" "d/f/ e/g/ (g2f)z" "{c/}BA/B/ G2z2" "{c/}=BA/G/ G G G G" "f3/e/ d2 z2" "{A/}^G^F/G/ A A A A" "e2 f e/d/ c/B/ A/G/" "A/(B/c/)A/ G2 z2" "[M:5/8] (B2A2) !fermata!z [M:3/4]" "c3/A/ F2 z2" "A/B/G/A/ F/G/A/B/ c/d/e/f/" "c/A/B/G/ F2 z2" "[M:7/8] z c/f/e/f/ c c d B [M:3/4]" "e/d/ e/ f/ g/f/e/d/ c/B/A/G/" "(A/G/A/)G/ F2 z2" "c/(d/e/d/) c c c/B/ A/G/" "=B2 c c ^c e" "E{c/}B/A/4B/4 G d d B" " e2 f/g/a/g/ f/e/d/c/" "f3/d/ B B d B" "c/B/A/G/ F F A F" "(G4F)z " "F/G/A/B/c f2f" "G/c/=B/c/ G2 z2" "c/e/d/f/ e2 z2" "[M:5/8] [Ee]4 !fermata!z [M:3/4]" "B/A/G/F/ E F B B" "[M:5/8] {B}A4 !fermata!z [M:3/4]" "{A/}G/^F/G/A/ G G c e" "F/A/G/B/ A2 z2" "(B3/c/) A2 z2" "A f zz2z" "G/B/A/B/ G B/d/ c/B/ A/G/" "Ed2 G A B" " [M:5/8] {d2}c4 !fermata!z [M:3/4]" "(c/A/B/)d/ c2 z2" "F f2 e d c" "(G3/c/) c2z2" "[M:7/8] z {c/}=BA/B/ c _B A G [M:3/4]" " c/(B/A/G/) F2 z2" "{c/}=B/A/B/c/ e e/d/ c/B/ A/G/" "A A2 B/A/ A/G/ F/E/" "[M:7/8] z f G2 A B G [M:3/4]" " (G4F) !fermata!z z" "[M:7/8] z G/(B/A/B/) G B/d/ c/B/ A/G/ [M:3/4]" " (f2 f/)e/ d/ c/ c/B/ A/G/" "[Cc]4 !fermata!z z" "c/=B/c/d/ c G _B G" "A/c/ B/G/ (G2F) z" "A/c/ B/G/ F2 z2" "d/f/e/f/ d2 z2" "(A3/G/) F2 z2" "[M:7/8] z F f2 B c d [M:3/4]" " G/F/E/D/ C2 z2" "A A2 g f e" "A/c/B/d/ c d/c/ B/A/ G/F/" "(c3/A/) F2 z2" "(c3/A/)F2 z2" "A/^G/A/B/ A B A B" "B/(c/d/c/) B B A G" "A/d/^c/d/ A A B G" "c/B/A/G/ F/G/A/B/ c/d/e/f/" "c/d/e/f/ B2 z2" "{f/}e/d/e/f/ g G A B" "[M:7/8] z A/d/^c/d/ A A B G [M:3/4]" " AF f2 z2" "^c2 d2 z2" "_e d2 ^c c d" "(G4F) z z" "{c/}=B/A/B/c/ B B c c" "c/d/e/f/ F2 z2" "(c3/B/)A c B G" "AF f2 z2" "(c/=B/c/)A/ F2 z f" " (d/^c/d/)B/ G2 z2" "e/(f/g/e/) B2 z2" "B/(A/G/F/) E2 z2" "[M:7/8] z f F2 f e d [M:3/4]" " A/B/G/A/ F2 z2" "A/f/ e/ d/ c g2 G" "[M:7/8] z =B/(c/d/c/) B F _B F [M:3/4]" " (B2A) f f f" "c/B/A/G/ F2 z2" "F/G/A/B/ c B/d/ c/A/ B/d/" "c/A/B/G/ F2 z2" "A A2 B c d" "(c/d/c/)B/ A2 z2" "B3 B A ^G" "{c/}BA/G/ A2 z2" "c/G/E/G/ C2 z2" "d/B/ B/G/ (G2F) z" "G G2 _B A A" "A/f/e/f/ B/f/e/f/ c/f/e/f/" "F f2 e d c" "Ff e d c B" "f f2 =B c c" "A/B/G/A/ F2 z2" "(A3/B/) G2 z2" "(c/d/c/)B/ A2 z2" "dA A F F D" "c/d/e/f/ g3 c" "=B f2 G/A/ B/c/ d/B/" "Ad cB Af" "F f2 ^c d/(c/d/B/)" "c3/f/ c2 z2" "d c2 B A G" "d/e/ f/ d/ c/d/e/c/ =B/c/d/B/" "(fd) d B B E" "A d2 e e f" "[M:7/8] z FA F c A f [M:3/4]" "[M:7/8] z ^c c2 d B G [M:3/4]" " A f z2 z2" "d/(e/f/e/)d2 z2" "[M:7/8] z F/G/A/B/ c B/d/ c/A/ B/d/ [M:3/4]" " c/(B/A/G/) F2 z2" "[M:7/8] z d2 d/c/ B/A/G c [M:3/4]" "G/A/ B/G/ (G2F2)" "[M:5/8] {d2}c4 !fermata!z [M:3/4]" "B/G/ G/E/ (G2F) z" "A =B/ c/ c/B/A/G/ G/F/E/D/" "e/d/ f/ d/ c3 E" "a/f/ e/ d/ g/e/d/c/ f/d/c/=B/" "c c2 d/c/ =B/c/ d/c/" "[M:7/8] c c2 c =B/c/ d/B/ z [M:3/4]" "c c2 d/c/ =B/c/ d/c/" "^c d2 B =c d" "A/B/G/A/ F2 z2" "c/d/e/f/ c2 z2" "A c2 d/e/ f A" "A d2 c f F" "c/d/e/c/ A c =B ^G" "[M:5/8] {d2}c4 !fermata!z [M:3/4]" "{B/}AG/A/ F2 z2" "=B/c/d/B/ G B c d" "A/B/G/A/ F2 z2" "[M:5/8] A4 !fermata!z [M:3/4]" "[M:7/8] z _e2 d/c/ B/A/ G G [M:3/4]" "A/B/F/B/ A2 z2" "[M:7/8] z A A2 B/A/ A/G/ F/E/ [M:3/4]" " f2 e c d =B" "A/G/c/A/ G2 z2" "d d2 B A ^G" "c/f/e/f/ c2 z2" "A/G/A/G/ F2 z2" "^G2 G3/ f/ f3/ G/" "(=B/c/d/c/) B F _B G" "F/G/A/B/ B G A G" "E/F/G/A/ B G A B" "F/G/A/B/ c f G G" "f/(e/d/c/) =B G G G" "c/f/e/f/ c c d B" "_e2 d =e e f" "[M:5/8] [Cc]4 !fermata!z [M:3/4]" "c/(d/e/c/) G2 z2" "d c2 B A G" "(A3/=B/4^c/4)d2 z2" "A/c/B/d/ c f2 A" "c c2 e/c/ d G" "{c/}BA/G/ A2 z2" "e3/d/ c/B/ A/G/ ^F G" "G/(A/B/G/)A2 z2" "A/(B/c/A/)F2 z2" "[M:7/8] z A/B/A/B/ F f A d [M:3/4]" " A2 G2 z2" "A/(B/c/A/)F2z2" "[M:7/8] z F/G/A/B/ c d e f [M:3/4]" ) 

#----------------------------------------------------------------------------------
# define notesAriaInf, array of 308 possible measures
#----------------------------------------------------------------------------------
notesAriaInf=( "c/A/B/d/ c2zc" "[M:7/8] e e2f A G c [M:3/4]" "[M:7/8] f e/d/ f/d/ c3G [M:3/4]" "[M:7/8] f f3/d/ B B d B [M:3/4]" " {d/}cz B/A/ G3/z/ A/B/" "{B/}AG/A/ F2 zA" "d3^c d e" "g/f/e/d/c2zc" "c2f2zf" "A/F/G/A/B/c/d/e/f f" "[M:7/8] F B3 d/c/ B/c/ d/c/ [M:3/4]" " B3 d/c/ B/c/ d/c/" "G/F/E/D/C2 zc" "G/F/E/D/C2 zG" "e2f c d B" "d3/e/ f/g/e/f/ d d" " fc2 d/c/ B/A/ G/F/" "c/f/e/f/c2zc" "AF2 f/e/ d/c/ B/A/" "{c/}=B/A/B/c/ B B c c" "{c/}BA/B/ G dc B" "(G4A)z" "c Ff2e d c" "(G4F)z" "[M:5/8]A4 !fermata!z [M:3/4]" "f3 d e ^c" "[M:5/8] (B2A2)!fermata!z [M:3/4]" "c/d/e/f/c2zc" "[M:7/8] F B/(c/d/c/) B B A G [M:3/4]" " [M:5/8] (B2A2)!fermata!z [M:3/4]" "(G3/A/) B c d f" "c/d/e/f/F2zf" "[M:5/8] A4!fermata!z [M:3/4]" "[M:7/8] f {B}A/G/A/B/ A A B d [M:3/4]" " c/d/e/d/ c/d/B/c/ A G" "e/g/f/e/ c/e/d/B/ A/c/B/G/" "[M:5/8] [Cc]4!fermata!z [M:3/4]" "[M:5/8] A4!fermata!z [M:3/4]" "[M:7/8] F Ff e dc B [M:3/4]" " [M:5/8] {d}c4!fermata!z [M:3/4]" "A/G/A/B/ cd ef" "e3/f/ g/f/e/d/ c/B/A/G/" "[M:7/8] f (d c2)B A G [M:3/4]" " ^c2d B G E" "[M:7/8] d/e/f/e/ d/^c/d/B/ A d c [M:3/4]" "c/B/A/G/F F A A" "f/e/f/e/ d/c/d/c/ B/A/B/A/" "G/B/ G/E/(G2F) c" "f3 c d B" "B/(A/B/G/) EzG2" "^c2d c d e" "G4Fz" "A/B/G/A/F2z f" "[M:7/8] F F/A/G/A/ F B A d [M:3/4]" " =B/c/d/e/ f G G G" "E3A ^c e" "A/c/B/d/ cde f" "[M:7/8] c F/A/G/B/A A G A [M:3/4]" " {c}=BA/B/ c _BA G" "A/F/G/A/ B/G/A/B/ c/A/B/c/" "c/=B/c/d/c G _B G" "(G4F)z" "B/d/c/e/ d2zf" "G/B/ A/G/(G2F)z" " f/d/ B/G/ F3E" "^F G2A B G" "{B}A/G/A/B/A A B d" "[M:7/8] c {G}F/E/F/G/ A B c d [M:3/4]" " c/=B/ c/d/e3^G" "F/A/G/B/ A2zd" "A3A ^c e" "f f2 e/d/ c/B/ A/G/" "A c2 faf" "G f2 e ^c c" "[M:7/8] c c/d/B/c/ A A F A [M:3/4]" " f/e/ d/c/ d/c/B/A/ B/A/G/F/" "d/f/ e/g/(g2f)z" "g3/f/ e d c B" "B/(c/d/B/) G2 zB" "[M:5/8] (B2A2)z [M:3/4]" "f/d/ B/G/(G2F)z" "(G4F)z" "A/(B/c/A/)G2zc" "d/B/ B/G/(G2F)z" "A/G/F/G/ F/G/A/B/c f" "[M:7/8] f(e2f) e/d/ c/B/ A/G/ [M:3/4]" " {d}c/=B/c/d/ e2zc" "f/g/a/b/ a/g/f/e/ d/c/B/A/" "(G4F)z" "A/c/B/d/c f f f" "G3d c E" "f/e/f/g/ f F A F" "[M:5/8] {d}c4!fermata!z [M:3/4]" "d {c}B/A/4B/4 ef2A" "A/c/B/d/ c g d =B" "[M:7/8] f ff2 f e/d/ c/B/ [M:3/4]" " f3/e/ d2zd" "{d}c=B/A/G2zc" "[M:7/8] f f/d/ B/ G/F3E [M:3/4]" "[M:7/8] F c/d/f/d/ c c c/B/ A/G/ [M:3/4]" "[M:7/8] F FB A d c B [M:3/4]" " c/d/e/f/F2zF" "A/G/A/G/F2 z2" "g G2 d c B" " e/g/f/d/(c2c/)B/A/G/" "(G4F)z" "A/F/ A/c/ fc AF" "A/B/G/A/F2zF" "[M:5/8] (B2A2)!fermata!z [M:3/4]" "A/f/ e/d/ c/e/d/c/ =B/d/c/B/" "[M:7/8] A {c}BA/B/ G dc B [M:3/4]" " A/B/G/A/F2zA" "f/d/ c/=B/ e/c/B/A/ d/B/A/^G/" "c/d/e/f/g2zG" "[M:5/8] [Cc]4!fermata!z [M:3/4]" "(G4F)z" "[M:5/8] [Cc]4!fermata!z [M:3/4]" "d/e/f/d/ B/c/d/B/ G/A/B/G/" "[M:7/8] A G c2 GA B [M:3/4]" " (c3/f/)c2zd" "(f3/e/)d2zd" "A/B/A/G/F2zA" "dc/B/A/G/F/E/ D d" "a A G3 A/=B/" "a2 g/f/e/d/ c/B/A/G/" "A3A A A" "=B/d/c/A/ G G G G" "A/B/G/A/F2zA" "(c2 c/)e/ d/c/ =B/d/ c/B/" "{_B/}A/G/A/B/ cdef" "(B/c/B/)A/G E B G" "G c2 G A B" "(G3/E/) C2 zc" " e3/g/ Bd GB" "A/c/B/d/ c/f/e/g/f f" "E/F/G/A/B G A B" "g/f/e/d/ c/d/f/d/ c/B/A/G/" "f/d/ B/G/ (G2A)z" "FB (A d) c B" "A/c/B/d/cF {B/}A G/F/" "_e ^F2 (G B) d" "G/A/B/(c/ d) e f F" "[M:5/8] (B2A2)!fermata!z [M:3/4]" "d/f/ e/g/ (g2f2)" "{c/}BA/B/ G2zB" "{c/}=BA/G/ G G2 G" "f3/e/ d2 zd" "{A/}^G^F/G/ A A2 A" "(e2 f) e/d/ c/B/ A/G/" "A/(B/c/)A/ G2 zc" "[M:5/8] (B2A2) !fermata!z [M:3/4]" "c3/A/ F2 z f" "A/B/G/A/ F/G/A/B/ c/d/e/f/" "c/A/B/G/ F2 zf" "[M:7/8] c c/f/e/f/ c cd B [M:3/4]" "e/d/ e/f/ g/f/e/d/ c/B/A/G/" "(A/G/A/)G/ F2 zE" "c/(d/e/d/)c c c/B/ A/G/" "=B2 c c ^c e" "E{c/}B/A/4B/4 G d2 B" " e2 f/g/a/g/ f/e/d/c/" "f3/d/B B d B" "c/B/A/G/F F A F" "(G4F)z " "F/G/A/B/c f2f" "G/c/ =B/c/ G2 zG" "c/e/d/f/ e2 zc" "[M:5/8] [Ee]4 !fermata!z [M:3/4]" "B/A/G/F/E F B B" "[M:5/8] {B}A4 !fermata!z [M:3/4]" "{A/}G/^F/G/A/G G c e" "F/A/G/B/ A2 zA" "(B3/c/) A2 zf" "A f zf2z" "G/B/A/B/G B/d/ c/B/ A/G/" "Ed2 GA B" " [M:5/8] {d2}c4 !fermata!z [M:3/4]" "(c/A/B/)d/ c2 zc" "F f2 ed c" "(G3/c/) c2z c" "[M:7/8] f {c/}=BA/B/ c _B A G [M:3/4]" " c/(B/A/G/) F2 zc" "{c/}=B/A/B/c/ e e/d/ c/B/ A/G/" "A A2 B/A/ A/G/ F/E/" "[M:7/8] f f G2 A B G [M:3/4]" " (G4F) !fermata!z A" "[M:7/8] A G/(B/A/B/)G B/d/ c/B/ A/G/ [M:3/4]" " (f2 f/)e/d/ c/ c/B/ A/G/" "[Cc]4 !fermata!z F" "c/=B/c/d/ c G _B G" "A/c/ B/G/ (G2F) z" "A/c/ B/G/ F2 z A" "d/f/e/f/ d2 zd" "(A3/G/) F2 zF" "[M:7/8] c F f2 Bc d [M:3/4]" " G/F/E/D/ C2 zc" "A A2 gf e" "A/c/B/d/c d/c/ B/A/ G/F/" "(c3/A/) F2 zc" "(c3/A/)F2 zc" "A/^G/A/B/A B A B" "B/(c/d/c/)B B A G" "A/d/^c/d/ A (A B) G" "c/B/A/G/ F/G/A/B/ c/d/e/f/" "c/d/e/f/ B2 zB" "{f/}e/d/e/f/ g G A B" "[M:7/8] A A/d/^c/d/ A A B G [M:3/4]" " AF f2 zA" "^c2 d2 zd" "_e d2 ^c2 d" "(G4F) z c" "{c/}=B/A/B/c/ B Bc c" "c/d/e/f/ F2 zc" "(c3/B/)A (c B) G" "AF f2 zA" "(c/=B/c/)A/ F2 z f" " (d/^c/d/)B/ G2 zB" "e/(f/g/e/) B2 zB" "B/(A/G/F/) E2 zB" "[M:7/8] F f F2 f e d [M:3/4]" " A/B/G/A/ F2 zA" "A/f/ e/ d/ c g2 G" "[M:7/8] c =B/c/d/c/ B F _B F [M:3/4]" " B2A f f f" "c/B/A/G/ F2 z2" "F/G/A/B/c  B/d/ c/A/ B/d/" "c/A/B/G/ F2 zc" "A A2 Bc d" "(c/d/c/)B/ A2 zc" "B3 B A ^G" "{c/}BA/G/ A2 zc" "c/G/E/G/ C2 zc" "d/B/ B/G/ (G2F) z" "G3 _B A A" "A/f/e/f/ B/f/e/f/ c/f/e/f/" "F f2 e d c" "Ff e dc B" "f f2 =B c c" "A/B/G/A/ F2 zf" "(A3/B/) G2 zB" "(c/d/c/)B/ A2 zF" "d A2 F F D" "c/d/e/f/ g3 c" "=B f2 G/A/ B/c/ d/B/" "Ad cB Af" "F f2 ^c d/(c/d/B/)" "c3/f/ c2 zc" "d c2 BA G" "d/e/ f/d/ c/d/e/c/ =B/c/d/B/" "(fd) dB B E" "A d2 e2 f" "[M:7/8] c FA F c A f [M:3/4]" "[M:7/8] f ^c c2 d B G [M:3/4]" " A f z z2 A" "d/(e/f/e/)d2 zd" "[M:7/8] F F/G/A/B/c B/d/ c/A/ B/d/ [M:3/4]" " c/(B/A/G/) F2 zA" "[M:7/8] f d2 d/c/ B/A/G c [M:3/4]" "G/A/ B/G/ (G2F2)" "[M:5/8] {d2}c4 !fermata!z [M:3/4]" "B/G/ G/E/ (G2F) z" "A =B/ c/ c/B/A/G/ G/F/E/D/" "e/d/ f/d/ c3 E" "a/f/ e/d/ g/e/d/c/ f/d/c/=B/" "c3 d/c/ =B/c/ d/c/" "[M:7/8] c3 c =B/c/ d/B/ c [M:3/4]" "c3 d/c/ =B/c/ d/c/" "^c d2 B=c d" "A/B/G/A/ F2 zF" "c/d/e/f/ c2 zF" "A c2 f2 A" "A d2 c f F" "c/d/e/c/ A c=B ^G" "[M:5/8] {d2}c4 !fermata!z [M:3/4]" "{B/}AG/A/ F2 zA" "=B/c/d/B/ G Bc d" "A/B/G/A/ F2 zF" "[M:5/8] A4 !fermata!z [M:3/4]" "[M:7/8] f _e2 d/c/B/A/ G G [M:/3/4]" "A/B/F/B/ A2 zA" "[M:7/8] A A A2 B/A/ A/G/ F/E/ [M:3/4]" " f2 e cd =B" "A/G/c/A/ G2 zc" "d3 B A ^G" "c/f/e/f/ c2 zc" "A/G/A/G/ F2 z2" "^G3 f f G" "(=B/c/d/c/)B F _B G" "F/G/A/B/ A F =B F" "E/F/G/A/ B G A B" "F/G/A/B/ c f G G" "f/(e/d/c/) =B G G G" "c/f/e/f/ c c d B" "_e2 d =e e f" "[M:5/8] [Cc]4 !fermata!z [M:3/4]" "c/(d/e/c/) G2 z2" "d c2 BA G" "(A3/=B/4^c/4)d2 zd" "A/c/B/d/ c f2 A" "c3 e/c/ d G" "{c/}BA/G/ A2 zF" "e3/d/ c/B/A/G/ ^F G" "G/(A/B/G/)A2 zf" "A/(B/c/A/)F2 zf" "[M:7/8] A A/B/A/B/ F fA d [M:3/4]" " A2 G2 zG" "A/(B/c/A/)F2z2" "[M:7/8] c F/G/A/B/c d e f [M:3/4]"  )

#----------------------------------------------------------------------------------
# define notesAriaHG, array of 308 possible measures
#----------------------------------------------------------------------------------
notesAriaHG=( "[FAc]2z2z/F/A/c/" "[M:7/8] z([Ge]2[Af]) [FA][FG][EG] [M:3/4]" "[M:7/8] zz[Fd]z [FA]z [EG] [M:3/4]" "[M:7/8] zz[FBd][FBd][FBd][FBd][FBd] [M:3/4]" " z[CFA] z[EG] z[D=B]" "[FA]2z[FA]f[FA]" "z[Ad]2[B^c] [Ad][Ae]" "[cg]2c/d'/g/e/ cz" "z[FAc][FAc][FAc][FAc][FAc]" "[CFA]2z2z[FAcf]" "[M:7/8] z [FBd][FBd][FBd][FBd][FBd][FBd] [M:3/4]" " [FBd][FBd][FBd][FBd][FBd][FBd]" "[CEG]3zz2" "z[CEG][CEG][CEG][CEG]2" "[Ge]2[Af] [Ac][Bd][GB]" "[Fd]3/[Ge]/ [Af][Ge] [Fd]z" " z[FAc] z[FAc] z[FAc]" "[Ac]2z[FA]/[GB]/ [Ac]z" "z [FAc][FAc][FAc][FAc][FAc]" "[DGB]3[DG=B][CGc][CGB]" "[CEGB]3[Bd][Ac][GB]" "[CEG]4[A,CF]z" "zz[FAcf]2[ce][Bd][Ac]" "([B,CEG]4[A,CE])z" "[M:5/8]A2z2!fermata!z [M:3/4]" "z[Af]2[Fd][Ge][E^c]" "[M:5/8] z2A2!fermata!z [M:3/4]" "[Fc]2z[Fc][Fc]z" "[M:7/8] z[DB]4[DB][EG] [M:3/4]" " [M:5/8] z2A2!fermata!z [M:3/4]" "[EG]3/[FA]/[GB][Ac][Bd][ce]" "[Fc]2z[Fc][Fc]z" "[M:5/8] [CA]4!fermata!z [M:3/4]" "[M:7/8] z[CFA]3[CFA][FB][FBd] [M:3/4]" " c3B[FA][EG] & G4z2" "[eg][df] [ce][Bd] [Ac][GB]" "[M:5/8] [Cc]4!fermata!z [M:3/4]" "[M:5/8] A4!fermata!z [M:3/4]" "[M:7/8] zz[df][ce][Bd][Ac][GB] [M:3/4]" " [M:5/8] z2[Cc]2 !fermata!z [M:3/4]" "[FA]3/[GB]/ [GB][Ac] [Bd][ce]" "[Ee]4[GB]2" "[M:7/8] zdc2BA[CEG] [M:3/4]" " ^c2dBGE & F3DB,G," "[M:7/8] [Ad]2[Ad]3/[GB]/ [FA]zz [M:3/4]" "[Ac]3z[FA][FA]" "[Af]3/[ce]/ [Bd]3/[Ac]/ [GB]3/[FA]/" "[DG][EG] [B,EG]2[A,CF]2" "[FAcf]3[Ac][Bd][GB]" "z[EGB] [EGB][EGB][EGB][EGB]" "[E^c]2[Fd] [Bc][Ad][Ae]" "[CEG]4[A,CF]z" "[FA]2z3/[Af]/[Af]2" "[M:7/8] z[A,F]3BAd [M:3/4]" " [DG=B]3[DGB][DGB][DGB]" "[EA^c][EA^c][EA^c][EA^c][EA^c][EA^c]" "[FA][GB] [Ac][Bd] [ce][df]" "[M:7/8] z[A,F]3[FA][EG][FA] [M:3/4]" " [F=B]2[Ec][G_B][FA][EG]" "[FA]2[GB]2[Ac]2" "[CGc]3[CG][CB][CG]" "([B,CEG]4[A,F])z" "[DB][Fc] [Bd][df] [Bd]z" "[DG][EG] ([G,CEG]2[A,CF]2)" " [GBdf]2[Acf]3[BGce]" "[_E^F][DG]2[^FA][GB][=EG]" "[CFA]3[CFA][FB][Fc]" "[M:7/8] z[A,F]3/[DG]/ [FA][GB][Ac][Bd] [M:3/4]" " [Ac]2z[G=B]z [^GB]" "[DF]2z3/[FAc]/[FAc]2" "[CEA][CEA]2[EA^c]2[Ace]" "[E_A=Bf]2[F=Acf]2[GBce]2" "[FA][FAc]2[FAcf]2[FAcf]" "z[Gdf] [Gce]z [EA^c]z" "[M:7/8] z[Ac][GB] [FA]2z[FA] [M:3/4]" " [Fcf]z [Fd]z [FB]z" "[Bd][Ge] ([Bceg]2[Acf]2)" "[ce]3/[Bd]/ [Ac][GB] [FA][EG]" "z[DB][DB][DB][DB][DB]" "[M:5/8] z2A2z[M:3/4]" "[GBdf][GBce][GBce]2[Acf]z" "([B,CFA]4[A,CF])z" "[FA]2[EG][EG] [EG]z" "[DB][EG][CEG]2[A,F]z" "[FA]2z2z[FAcf]" "[M:7/8] z[GBe]2[FAf]3/[Bd]/ [Ac]/[GB]/ [FA]/[EG]/ [M:3/4]" " z[EGc][EGc][EGc][EGc][EGc]" "[Fcf]6" " ([B,CEG]4[A,CA])z" "[FA][GB][Ac] [Af][cf][Af]" "[GBdf]4[GBce]2" "[FAcf]3[Ff][Aa][Ff]" "[M:5/8] [Cc]4!fermata!z [M:3/4]" "[Fd]z [Ge][Af]2[FA]" "ABCzz =B" "[M:7/8] z[F^ABf]2[F=Acf]2[GBce]2 [M:3/4]" " z[FAd][FAd][FAd][FAd]2" "z[CGc][CGc][CGc][CGc]2" "[M:7/8] z[GBdf]2z[Acf] z[GBce] [M:3/4]" "[M:7/8] z[CGc]3[EG][EG][EG] [M:3/4]" "[M:7/8] zFB GB cB [M:3/4]" " z[FAcf][FAcf][FAcf][FAcf]2" "[FA]2z[FA][FA][FA]" "z[GB]2[Bd][Ac][GB]" "[Ge][Fd] [Ec][EG][EG][GB]" "([B,CEG]4[A,CF])z" "[FAcf]3cAF" "[FA]2z/G/A/f/F2" "[M:5/8] z2A2!fermata!z [M:3/4]" "z3/[Fd]/[Ec]2[D=B]2" "[M:7/8] z[CEGB]3[Bd][Ac][GB] [M:3/4]" " [FA]2z/F/A/f/A2" "[F=Bd]z [EAc]z [EGB]z" "z2c/d/e/f/g2" "[M:5/8] [Cc]4!fermata!z [M:3/4]" "([B,CEG]4[ACF])z" "[M:5/8] [Cc]4!fermata!z [M:3/4]" "[Fd]z [DB]z [B,G]z" "[M:7/8] zz[CEGc]2[EG][FA][GB] [M:3/4]" " [Ac][Ac] [Ac]/[GB]/[FA]/[GB]/[Ac]2" "z[FAd][FAd][FAd] [FAd]2" "z2z[Af] [Af]2" "[DFAd]6" "z[ca] z[ce] z[=Bd]" "[Acfa]4[ABcf]z" "[CE][DF] [EG][DF] [EG][CE]" "[D=GB]3[GB][Bd][df]" "[FA]3[FA][FA][FA]" "z[Ac] z[Ac] z[^G=B]" "A3/B/ [Ac][Bd][Ge][Af]" "z[EGB][EGB][EGB][EGB][EGB]" "z[CEGc]2 [EG][FA][GB]" "z G/E/ C/D/E/F/ G/A/B/G/" "z[Bb]z[GB]z[GB]" "[FA][GB] [Ac][Bd] [ce][df]" "z2 z [CG][CA][CB]" "[cg]6" "[GBdf][GBce] [GBce]2 [Acf] z" "FB Ad cB" "[FA][GB][Ac]z [CFA]2" "[B_e] [_E^F]2 [DG][DB][Bd]" "[EG]3 [Ge][FAf][FA]" "[M:5/8] z2 A2 !fermata!z [M:3/4]" "[Bd][Ge] [GBce]2 [Acf] z" "z [CEB][CEB][CEB] [CEB] z" "[DG=B]3 [DGB][DGB][DGB]" "z [FAd][FAd][FAd] [FAd]2" "[D^G]2 [CG] [CG][CG][^CG]" "[GBe]2 [FAf]z/[Bd]/ [Ac]/[GB]/[FA]/[EG]/" "([FA]2[EG])[EGc] [EGC]2" "[M:5/8] z2 A2 !fermata!z [M:3/4]" "[Ac]2 z[Acf][Acf]z" "[FA][CG][A,F]z [Fc]z" "([Ac][EGB][FA]) [Acf][Acf]z" "[M:7/8] z[Ac]3 [Ac][Bd][GB] [M:3/4]" "[GBe]6" "z2 z [FAf][FAf]z" "[EGc]3 [EG][EG][EG]" "[DG=B]2 [DGc]z [EGA^c]z" "[CEGB]z z[Ad]2[GB]" " [Gce]2[Acf]z z2" "z[FBd][FBd][FBd][FBd][FBd]" "z[FAc][FAc][FAc][FAc][FAc]" "([GECB,]4[A,CF]) z" "[CF]3 [Af][cf][Af]" "z2 G/c/=B/c/ G2" "[EC][Gd][ce] [ec'][ec']z" "[M:5/8] [Cc]4 !fermata!z [M:3/4]" "[CGB]3 [GB][GB]z" "[M:5/8] z2 A2 !fermata!z [M:3/4]" "G3 [CEG][Gc][Gce]" "[FA]2 z[Af][Af]z" "([GB]2[FA]) [Af][Af]z" "z/F/A/f/ z/F/A/f/ z/F/A/f/" "[CEG]3 z[GB]z" " z [EGB][EGB][EGB][EGB][EGB]" " [M:5/8] [Cc]4 !fermata!z [M:3/4]" "[Ac][Bd] [Ac]2 z[Ac]" "z[FAcf]2 [ce][Bd][Ac]" "z/ C/E/G/ c/e/g/c'/ c z" "[M:7/8] z ([D=B]2c) [G_B][FA][EG] [M:3/4]" " z [FAc][FAc][FAcf][FAc] z" "[DG=B]6" "z [Aa]2 z [DG]z" "[M:7/8] z [GBdf]4 [GBdf][EGBce] [M:3/4]" " ([B,CEG]4[A,F]) !fermata!z z" "[M:7/8] z [CEG]3 z[GB] z [M:3/4]" " [FAcf]4[GBce]2" "[Cc]4 !fermata!z z" "[CFc]3 [CG][CB][CG]" "[FA][CG] ([B,CEG]2[A,CF]) z" "[FA]2 z [Af][Af] z" "[Ad]2 f/a/e/f/ d2" "[FA]2 z[FA][Af]z" "[M:7/8] zz [FACf]2 [GB][Ac][Bd] [M:3/4]" " z2 g/f/e/d/ c2" "z/ A/^c/e/g [eg][fd][ce]" "[FA][GB][Ac]z [FAc]z" "z[Ac]3/[FA]/ [Ac]f[Ac]" "z[Fc][Fc][Af] f z" "[EA]3 GFG" "([DB]4[DB]) [EG]" "[FA]3 [FA][GB][EG]" "[Fc]4z2" "[Ac]2 [DB][DB][DB]z" "[Gce]3 [EG][FA][GB]" "[M:7/8] z [FA]3 [FA][GB][EG] [M:3/4]" " [FA]2 z [FA][FA]z" "[EA^c]2 [FAd]a/f/ d2" "[F_e][Fd]2[F^c]2 [FB]" "([GBce]4[Acf]) zz" "[DG=B]3 [CGB][CGc][CGc]" "z2 c/(d/e/f/) F2" "(c3/B/) [FA]z[GB]z" "[FA]2 z [FA][FA]z" "z2 z/ F/A/c/ f z" " z [DB][DB][DB][DB][DB]" "z2 e/(f/g/e/) B2" "z2 b/a/g/f/ e2" "[M:7/8] z z [FAcf]2 [df][ce][Bd] [M:3/4]" " [FA]2 z [Af][FA]2" "z [Fd] z[Ec] z[D=B]" "[M:7/8] z [DG=B]4[CG=B]2 [M:3/4]" " ([GB]2[FA]) [FBf][FAf][Fdf]" "z2 c/B/A/G/ F2" "[Ac]3 [Bd][Ac][GB]" "[Ac][GB][FA][GB][Ac]z" "z [CFA]2 [FB][FC][Fd]" "z2 (c/d/c/)B/ A2" "B3 BA^G" "([CGB]2[FA])[Ac][Ac]z" "[CGc]2z [CGc][CGc]z" "[Bd][Ge] [GBce]2[Acf]z" "[DFG][DFG]2 [EG_B] [EGA][EGA]" "[Af]z [cf]z [cf]z" "z [FAcf]2 [ce][Bd][Ac]" "z[de][ce][Bd][Ac][GB]" "[F_A=Bf]3 [F_A=Bf][GBce][GBce]" "[FA]2 z [Af][Af] z" "[CFA]2 [CEG][CEG][CEG] z" "z2 (c/d/c/)B/ A2" "z [FAd]z [DFA]z [A,CF]" "z [ceg][ceg][ceg][ceg][ceg]" "z [DG=B][DG=B][DG=B][DG=B][DG=B]" "GdcBA [Af]" "F [Fcf]2 ^c [Fd][Fd]" "[Ac][Ac][Ac]/[GB]/[FA]/[GB]/ [Ac]2" "d c2 BA[CEG]" "[=Bd]z [Ac]z [^GB]z" "z[Bd] z[GB] z[Ge]" "[GA] [FAc]2 [A^ce]2 [Adf]" "[M:7/8] z z[FA]2 [Ac]2 [Af] [M:3/4]" "[M:7/8] z z[F^c]2 d[DB][EG] [M:3/4]" " z2 [FA][FA][FA]z" "z2 d/e/f/e/ d2" "[M:7/8] z [Ac]3 [Bd][Ac][Bd] [M:3/4]" " z2 c'/b/a/g/ f2" "[M:7/8] z z [Bd]2 [GB][EG][EG] [M:3/4]" "[DG][DG] [B,CEG]2[A,CF]2" "[M:5/8] [CEGc]4 !fermata!z [M:3/4]" "[DGB][EG] ([B,CEG]2[A,CF]) z" "[CFAc]2 [CEGc]2 [DFG=B]2" "z [Fd] z[FA] z[EG]" "z[Adf] z[Gce] z [G=Bd]" "[EG]C [EG]C [GB]C" "[M:7/8] [Ac]E [Ac]E [F=B][FB] z [M:3/4]" "[EG]C [EG]C [GB]C" "[F^c] [Fd]2 bfg" "[FA]2 z [FA][FA]z" "[Fc]2 z [Fc][Fc]z" "[FA] [Ac]2[Af]2 [FA]" "[FA] [Fd]2 [Fc][Fc][Fc]" " [EAc]3 [Ac][A=B][^GB]" "[M:5/8] [Cc]4 !fermata!z [M:3/4]" "[FA]2 [FA][FA][FA]z" "[D=B]3 [DB][Ec][Fd]" "[FA]2 [FA][Af] [FA][Af]" "[M:5/8] z2 A2 !fermata!z [M:3/4]" "[M:7/8] z [Gc_e]4 [Bd][Bg] [M:3/4]" "[FA][GB] [FA][Af] [FA][Af]" "[M:7/8] z [EA][EA]2[EA]2[EG] [M:3/4]" " [df]2 [ce][Ac][=Bd][^FB]" "([FA]2[EG])[EGc][EGc] z" "[D^Gd]3/[DGd]/ [DGd]3 ^G" "[Ac]2 z [FA]/[GB]/ [Ac]z" "[FA]2 Af Af" "[^Gdf][^Gdf]2[^Gdf]2 [DG]" "[DG=B]4 [DG_B]2" "[CFA]3 [DFA][DG=B][DGB]" "z2 z [CG][CA][CB]" "[CF]3 [CA][=B,DG][B,DG]" "[B,df]3 [B,DG][CEG][DFG]" "[Ac]3 [Ac][Bd][GB]" "[Fc_e]2[Fd][B=e]2[Af]" "[M:5/8] [Cc]4 !fermata!z [M:3/4]" "[Gc]2 G/c/e/g/ c2" "[Fd][Fc]2 [GB][FA][EG]" "[EG^c]2 [FAd][FAd][FAd]z" "[FA][GB][Ac] [Af]2 [FA]" "[Gd]4 [Gd]2" "[FB]2[FA]2 z2 & C6" "[^F_e]4 [FA][GB]" "[CG]2 [CA]/f/c/A/ Ff" "z [CFA][CFA][CFA][CFA][CFA]" "[M:7/8] z [CA]3 [CA][CA][DA] [M:3/4]" " [CFA]2 [CEG][CEG][CEG] z" "[CFA]6" "[M:7/8] z [FA]3/[GB]/ [Ac][Bd][ce][df] [M:3/4]" )

#----------------------------------------------------------------------------------
# define notesAriaHF, array of 308 possible measures
#----------------------------------------------------------------------------------
notesAriaHF=( "z[B,D][A,C][G,B,]F,z" "[M:7/8] zB,2A, DB,C [M:3/4]" "[M:7/8] z[B,,B,]2 Cz C,z [M:3/4]" "[M:7/8] z[F,,F,]6 [M:3/4]" " [F,,F,]z G,z G,,z" "z6" "[F,,F,]3G, F,E," "[E,C]4z/G,/E,/C,/" "[F,,F,]6" "[F,,F,]2z2z[F,,F,]" "[M:7/8] z[F,,F,]6 [M:3/4]" " [F,,F,]6" "z[C,,C,][C,,C,][C,,C,] [C,,C,]2" "[C,,C,]2z2z2" "[C,B,]2[A,,A,]2z2" "[D,,D,]6" " [F,,F,]z [F,,F,]z [F,,F,]z" "[F,,F,]4 z2" "[F,,F,]2z2z2" "[F,,F,]3 [F,,F,][E,,E,][E,,E,]" "[C,,C,]6" "([C,C,,]4F,,)z" "z[F,,F,]4z2" "[C,,C,]4F,,z" "[M:5/8] A,,2z2 !fermata!z [M:3/4]" "[D,,D,]6" "[M:5/8] [A,,A,]4!fermata!z [M:3/4]" "[A,,A,]2z2z/A,/F,/A,/" "[M:7/8] z[F,,F,]6 [M:3/4]" " [M:5/8] [A,,A,]4!fermata!z [M:3/4]" "[C,,C,]6" "[A,,A,]2z2z[A,,A,]" "[M:5/8] A,,4!fermata!z [M:3/4]" "[M:7/8] z[_E,,_E,]3E,D,B,, [M:3/4]" " E,4F,C," "[C,,C,]6" "[M:5/8] [C,,C,]4!fermata!z [M:3/4]" "[M:5/8] [A,,A,]4!fermata!z [M:3/4]" "[M:7/8] z[F,,F,]6 [M:3/4]" " [M:5/8] [C,,C,]4 !fermata!z [M:3/4]" "[F,,F,]6" "[C,,C,]6" "[M:7/8] z[F,B,][F,B,]2 [F,D][F,C][F,B,] [M:3/4]" " [B,,B,]4C,2" "[M:7/8] F,2z2z2z [M:3/4]" "[F,,F,]3zz2" "[F,,F,]6" "B,,C,[C,,C,]2F,,z" "[F,,F,]6" "G,6" "[G,,G,]2[F,,F,] G,F,^C," "([C,,C,]4F,,)z" "z2F,2z2" "[M:7/8] z[F,,F,]3DCB, [M:3/4]" " [F,,F,]3[F,,F,][F,,F,][F,,F,]" "[A,,A,][A,,A,][A,,A,][A,,A,][A,,A,][A,,A,]" "[F,,F,]2z2z2" "[M:7/8] z[F,,F,]4z2 [M:3/4]" " [G,,G,]2C,zz2" "[F,,F,]6" "[E,,E,]3E,G,E," "([C,,C,]4F,,)z" "[B,,B,]zz2z2" "B,,C,([C,,C,]2F,,)z" " [B,,B,]2[C,C]2[C,,C,]2" "DB,2zzC," "[_E,,_E,]3E,D,B,," "[M:7/8] z[F,,F,]4z2 [M:3/4]" " F2E z E,z" "[D,,D,]2z2z2" "[A,,A,]2[A,,A,]2[A,,A,]2" "[_D,_D]2[C,C]2[C,,C,]2" "[F,,F,]2[A,,A,]2[F,,F,]2" "[G,,G,]2=B,C A,z" "[M:7/8] z[F,,F,]4[F,,F,]2 [M:3/4]" " [A,,A,]z [B,,B,]z [D,D]z" "B, C ([C,C]2F,)z" "[C,,C,]6" "G,6" "[M:5/8] [A,,A,]4z [M:3/4]" "([C,,C,]4F,,)z" "([C,,C,]4F,,)z" "[C,C]2[C,C][C,C] [C,C]z" "B,,C, ([C,,C,]2F,,)z" "[F,C]2z2z[F,,F,]" "[M:7/8] z[^C,^C]2D,z/B,/ =C=C, [M:3/4]" " [C,C]6" " [A,,A,]6" "[C,,C,]4F,,z" "F,2z[F,,F,][A,,A,][F,,F,]" "zG,/A,/ B,G, CC," "[F,,F,]3[F,,F,][A,,A,][F,,F,]" "[M:5/8] [C,,C,]4!fermata!z [M:3/4]" "B,z B,A,F,A," "F,2z2zG," "[M:7/8] z[_D,_D]2[C,C]2[C,,C,]2 [M:3/4]" " [D,D]2z2z2" "[C,,C,]6" "[M:7/8] z[B,,B,]2Cz C,z [M:3/4]" "[M:7/8] z[C,C]6 [M:3/4]" "[M:7/8] zA,D CB, A,D [M:3/4]& zF,6" "[F,,F,]6" "z2F,2z2" "[E,,E,]6" "[C,,C,]6" "([C,,C,]4F,)z" "[F,,F,]3C,A,,F,," "z2[F,A,]2z2" "[M:5/8] [A,,A,]4!fermata!z [M:3/4]" "[F,,F,]2G,2G,,2" "[M:7/8] z[C,,C,]3zz2 [M:3/4]" " z2[E,A,]2z2" "[D,,D,]z E,z E,,z" "[E,G,C]4z2" "[M:5/8] [C,,C,]4!fermata!z [M:3/4]" "([C,,C,]4F,,)z" "[M:5/8] [C,,C,]4!fermata!z [M:3/4]" "[B,,B,]zz2z2" "[M:7/8] z[C,,C,]6 [M:3/4]" " z2[F,,F,]2[F,,F,]2" "[D,D]2z2z2" "[D,F,A,]2z2z2" "[D,,D,]6" "[F,,F,]z G,z G,,z" "[C,C]6" "[A,,A,]6" "[A,,G,]6" "F,2F,,2z2" "Ez Ez E,z" "[F,,F,]4 z[F,,F,]" "[C,C,,]6" "[C,C,,]6" "[C,C,,]6" "[E,C]z [E,C]z [E,C]z" "F,3 G, A,F," "[C,E,G,C]3 E,F,G," "[E,C]6" "[B,,B,][C,C] ([C,C]2F,) z" "A,D CB, A,D & F,6" "F,2 z2 [F,,F,]2" "z2 C B,G,G," "B,3 B,A,F," "[M:5/8] [A,,A,]4 !fermata!z [M:3/4]" "B,C [C,C]2F, z" "F,6" "[G,,G,]3 [F,,F,][F,,F,][F,,F,]" "[D,D]2z2z2" "[E,=B,]2 [F,A,] F,E,E," "[^C,C]2 Dz/B,/ =CC," "C2 [C,,C,][C,,C,] [C,,C,]2" "[M:5/8] [A,,A,]4 !fermata!z [M:3/4]" "[F,B,]2 z[F,,F,][F,,F,]z" "[F,A,][C,G,][A,,F,]z [A,,A,]z" "F,C,A,, [F,,F,][F,,F,]z" "[M:7/8] zF,,F, F,,F, F,,F, [M:3/4]" "[C,C]6" "[F,A,]2z2z2" "[C,C]6" "(F,2E,)z [A,,A,]z" "[C,,C,]z [E,,E,]4" " [B,,B,]2[A,,A,]z z2" "[F,,F,]6" "[F,,F,]6" "([C,,C,]4F,,) z" "[A,,F,]3 [F,,F,][A,,A,][F,,F,]" "[C,C]6" "[E,,C,]2 z[C,G,C][C,G,C]z" "[M:5/8] [C,,C,]4 !fermata!z [M:3/4]" "[C,,C,]3 z2z" "[M:5/8] [A,,A,]4 !fermata!z [M:3/4]" "=B,2 C G,E,C," "z2 [F,,F,]2z2" "([F,,E,]2[F,,F,]) [F,,F,][F,,F,] z" "[F,A,]2F,,2[F,A,]2" "[C,,C,]3 z[E,C]z" " [C,,C,]2z2z2" " [M:5/8] [C,,C,]4 !fermata!z [M:3/4]" "[F,,F,]3 [F,,F,][F,,F,]2" "[F,,F,]4 z2" "[E,C]6" "[M:7/8] z[G,,F,]2 [C,E,] zz2 [M:3/4]" " [A,,F,]2 z2z2" "[G,,G,]4F,2" "z[^C,E,A,]2 zz2" "[M:7/8] z [B,,B,]3 [A,,A,][G,,G,][C,C] [M:3/4]" " ([C,,C,]4F,,) !fermata!z z" "[M:7/8] z [C,,C,]3 z[C,C]z [M:3/4]" " [C,,C,]6" "[C,,C,]4 !fermata!z z" "[E,,E,]3 E,G,E," "[F,A,][C,G,] ([C,G,]2F,) z" "z2 F,2 z2" "A,2 F,2 z2 & D,6" "z2 [D,F,]2 z2" "[M:7/8] z [F,,F,]4 z2 [M:3/4]" " [C,C]4 z2" "[^C,E,A,]3 [A,,A,][A,,A,][A,,A,]" "[F,C]3 z[F,,F,]z" "[A,,F,]2 z[F,,F,][F,,F,]z" "[A,,F,]3 [F,,C,F,]2[F,,C,F,]" "[^C,C]3 [D,D][C,C][D,D]" "[F,,F,]6" "D,D D,D D,D" "[A,,A,]4 z2" "F,2 G,G,G, z" "[C,,C,]6" "[M:7/8] z D,D D,D D,D [M:3/4]" " z6" "[G,,G,]2[F,,F,]2 z2" "[C,C][B,,B,]2[A,,A,]2 [B,,B,]" "([C,,C,]4[F,,F,]) zz" "[F,,F,]3 [F,,F,][E,,E,][E,,E,]" "[A,,F,]4 z2" "[E,C]2[FC]z [C,C]z" "z2 [D,F,]2 z2" "[A,,F,]4 z2" " G,6" "[C,G,C]6" "[C,G,C]6" "[M:7/8] z [F,,F,]4z2 [M:3/4]" " z2 F,2 z2" " [F,,F,] z G,z  G,, z" "[M:7/8] z[F,,F,]4[E,,E,]2 [M:3/4]" " [^C,C]2 [D,D] [_D,D][C,C][B,,B,]" "[F,,F,]4 z2" "[F,,F,]6" "F,B,, F,,2 z2" "z _E,2 D,A,,B,," "[A,,F,]2 z2 z2" "B,3 B,A,^G," "([E,,E,]2[F,,F,])[F,,F,][F,,F,] z" "[E,,E,]2 z [E,,E,][E,,E,]z" "B,C ([C,C]2F,) z" "_B, B,2 C ^CC" "[F,,F,]z [F,,G,]z [A,,A,]z" "[F,,F,]4 z2" "[F,,F,]6" "[_D,D]3 [D,D][C,C][C,C]" "z6" "C,2 C,C,C, z" "[A,,F,]2 z2 z2" "[D,D] z [D,,D,]z [D,,D,]z" "[E,,E,]6" "F,6" "F,B,A,D[F,C] [F,F] & F,6" "z [A,,A,]2 A, B,B," "z2 [F,,F,]2 [F,,F,]2" "[F,B,] [F,A,]2 [F,D][F,C][F,B,]" "Dz Ez E,z" "B,z B,z Cz" "C D2 A,2 D" "[M:7/8] z [F,,F,]2[F,,F,]2[F,,F,]2 [M:3/4]" "[M:7/8] z [A,,A,]3 z B,C [M:3/4]" " [D,F,]2 z2 z2" "[F,A,]6" "[M:7/8] z [F,,F,]6 [M:3/4]" " [A,,F,]4z2" "[M:7/8] z [B,,B,]2 B,2 CC, [M:3/4]" " B,C C,2 F,2" "[M:5/8] [C,,C,]4 !fermata!z [M:3/4]" "B,,C, ([C,,C,]2F,,) z" "[F,,F,]2 [G,,G,]2 [F,,G,]2" "[B,,B,] z Cz C,z" "[F,,F,]z G,z G,,z" "[C,,C,]6" "[M:7/8] E,4 E,,2 z [M:3/4]" "[C,,C,]6" "[A,,A,][B,,B,]2 DA,B," "z6" "[A,,A,]2 z2 z2" "F,2 F,2 F,2" "z [B,,B,]2 A,A,A," " A,3 F,D,E," "[M:5/8] [C,,C,]4 !fermata!z [M:3/4]" "z6" "[G,,G,]6" "[C,F,]6" "[M:5/8] [A,,A,]4 !fermata!z [M:3/4]" "[M:7/8] z ^F,4 G,[=E,C] [M:3/4]" "z6" "[M:7/8] z [^C,A,]2[C,A,]2[C,A,]2 [M:3/4]" " ^G,2A,2 D,E," "[C,C]3 [C,C][C,C] z" "[B,,B,]3/[B,,B,]/ [B,,B,]4" "[F,,F,]4 z2" "[D,F,]6" "[B,,B,]2 [B,,B,]2 [B,,B,]2" "[F,,F,]4 [E,,E,]2" "F,3 D,G,F," "[C,E,G,C]3 E,F,G," "A,3 F,G,F," "[G,,G,]3 F,E,D," "F,,F, F,,F, F,,F," "[A,,A,]2 [B,,B,] [G,,G,]2 [F,,F,]" "[M:5/8] [C,,C,]4 !fermata!z [M:3/4]" "E,2 z2 z/ C,/D,/E,/" "[B,,B,][A,,A,]2 ^C,D,B,," "[G,,G,]2 [F,,F,]2 F,/D,/E,/F,/" "F,3 A,/G,/ F,D," " E,C, E,C, =B,,G,," "E,2 F,/F,,/A,,/C,/ F,F,," "C4 [CE][A,D]" "([E,,E,]2[F,,F,]2) z2" "[F,,F,]6" "[M:7/8] z [F,,F,]3 [F,,F,][F,,F,][F,,F,] [M:3/4]" " C,2 C,C,C, z" "F,2z F,/E,/ F,/C,/A,,/F,,/" "[M:7/8] z [F,,F,]6 [M:3/4]" )

#----------------------------------------------------------------------------------
# input notes for ritornellos
# declare arrays "notesRitSup", "notesRitInf", "notesRitHG" and "notesRitFH"
# notesRitup - array for possible measures for the ritornello's Superior Chant
# notesRitInf - array for possible measures for the ritornello's Inferior Chant
# notesRitHG - array for possible G-clef measures for the ritornello's harp/pianoforte acc.
# notesRitHF - array for possible F-clef measures for the ritornello's harp/pianoforte acc.
#----------------------------------------------------------------------------------
declare -a notesRitSup notesRitInf notesRitHG notesRitFH

#----------------------------------------------------------------------------------
# define notesRitSup, array of 44 possible measures
#----------------------------------------------------------------------------------
notesRitSup=( "z6" "z6" "z6" "[M:7/8] z z6 [M:3/4]" "[M:7/8] (3z/z/z/ z6 [M:3/4]" "[M:7/8] (3z/z/z/ z6 [M:3/4]" "z6" "z6" "z6" "z6" "z6" "[M:5/8] z2 z2 z [M:3/4]" "[M:7/8] z z6 [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "z6" "z6" "[M:5/8] z2 z2 z [M:3/4]" "[M:7/8] (3z/z/z/ z6" "z6" "z6" "[M:7/8] (3z/z/z/ z6" "z6" "[M:7/8] (3z/z/z/ z6 [M:3/4]" "z6" "z6" "[M:7/8] z z6 [M:3/4]" "[M:7/8] z z6 [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "z6" "z6" "z6" "z6" "z6" "[M:5/8] z2 z2 z [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "z6" "z6" "[M:5/8] z2 z2 z [M:3/4]" "z6" "[M:7/8] z z6 [M:3/4]" )

#----------------------------------------------------------------------------------
# define notesRitInf, array of 44 possible measures
#----------------------------------------------------------------------------------
notesRitInf=( "z6" "z6" "z6" "[M:7/8] z z6 [M:3/4]" "[M:7/8] (3z/z/z/ z6 [M:3/4]" "[M:7/8] (3z/z/z/ z6 [M:3/4]" "z6" "z6" "z6" "z6" "z6" "[M:5/8] z2 z2 z [M:3/4]" "[M:7/8] z z6 [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "z6" "z6" "[M:5/8] z2 z2 z [M:3/4]" "[M:7/8] (3z/z/z/ z6" "z6" "z6" "[M:7/8] (3z/z/z/ z6" "z6" "[M:7/8] (3z/z/z/ z6 [M:3/4]" "z6" "z6" "[M:7/8] z z6 [M:3/4]" "[M:7/8] z z6 [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "z6" "z6" "z6" "z6" "z6" "[M:5/8] z2 z2 z [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "[M:5/8] z2 z2 z [M:3/4]" "z6" "z6" "[M:5/8] z2 z2 z [M:3/4]" "z6" "[M:7/8] z z6 [M:3/4]" )

#----------------------------------------------------------------------------------
# define notesRitHG, array of 44 possible measures
#----------------------------------------------------------------------------------
notesRitHG=( "f/g/a/g/ f/e/d/c/ d/c/d/e/" "f/g/a/g/ f/e/d/c/ B/A/B/G/" "f fedcB" "[M:7/8] [Ff] [Bd][Bd]2 f[Ge][Bg] [M:3/4]" "[M:7/8] (3c/d/e/ [Af]2 f/a/c'/a/ f/c/A/c/ [M:3/4]" "[M:7/8] (3c/d/e/ f fedcB [M:3/4]" "f[Af]2 f {a/}g/f/g/a/" "[Af]f g/f/e/d/ c/B/A/G/" "[Af] z/ (c'/b/) a z/ (a/g/) f/f/" "f/c/d/e/ fac'a" "f/g/a/g/ f/e/d/c/ B/A/B/G/" "[M:5/8] f [Af]3/4[Af]/4 [Af][Af][Af] [M:3/4]" "[M:7/8] (3c/d/e/ [cf]f g/f/e/d/ c/B/A/G/ [M:3/4]" "[M:5/8] fz [ca]z [Af] [M:3/4]" "fcAcf (3c/d/e/" "[Bd][Bd]2 f[Ge][Bg]" "[M:5/8] [Af] c'/4(b/4a/4)g/4 f (c/4B/4A/4G/4) F [M:3/4]" "[M:7/8] (3c/d/e/ f/g/a/g/ f/e/d/c/ B/A/B/G/" "f/e/f/e/ f/e/f/e/ d/c/d/e/" "f [FA][GB][Ac][Bd][Ge]" "[M:7/8] (3c/d/e/ f/e/f/e/ f/e/f/e/ d/c/d/e/" "f(3c/d/e/ fac'a" "[M:7/8] (3c/d/e/ f [FA][GB][Ac][Bd][Ge] [M:3/4]" "A/F/G/A/ B/c/d/e/ f/g/a/g/" "f/e/f/e/ f/e/f/e/ d/c/d/e/" "[M:7/8] c [Af][Ac]2 [c_e][Bd][G=e] [M:3/4]" "[M:7/8] a/g/ f/g/a/g/ f/e/d/c/ d/c/d/e/ [M:3/4]" "[M:5/8] F3/(A/4c/4) f[Af] [Af] [M:3/4]" "[M:5/8] A [ca][Af][Af] [Af] [M:3/4]" "[M:5/8] [cf] [A,F]3/4[A,F]/4 [A,F][A,F][A,F] [M:3/4]" "[Af][cg][fa][gb][ac'] (3c/d/e/" "ff g/f/e/d/ c/B/A/G/" "f [Bd][Ac][GB][FA][EG]" "[Af]2 f/a/c/a/ f/c/A/c/" "f[Af]2 f {a/}g/f/g/a/" "[M:5/8] fz/a/4g/4 f[ca][Af] [M:3/4]" "[M:5/8] f2[ca]2[Af] [M:3/4]" "[M:5/8] f2[ca]2[Af] [M:3/4]" "[M:5/8] [Af][ca][Af][Gf] [Af] [M:3/4]" "[Af] f/4(g/4a/4b/4) .c' (c/4b/4a/4g/4) fc" "f/g/a/b/c [ca][Af][Ac]" "[M:5/8] F3/(A/4c/4) f3/(c/4A/4) F [M:3/4]" "[Af] [Ac]2 [c_e][Bd][G=e]" "[M:7/8] c f [Af]2 f {a/}g/f/g/a/ [M:3/4]" )

#----------------------------------------------------------------------------------
# define notesRitHF, array of 44 possible measures
#----------------------------------------------------------------------------------
notesRitHF=( "!/!A,4B,B, & !/!F,6" "!/!C6 & !/![F,A,]4[E,G,][E,G,]" "z DCB,A,G, & z F,4 C," "[M:7/8] z [F,,F,][F,,F,][F,,F,][F,,F,][F,,F,][F,,F,] [M:3/4]" "[M:7/8] (3z/z/z/ [F,,F,][F,,F,][F,,F,][F,,F,][F,,F,][F,,F,] [M:3/4]" "[M:7/8] (3z/z/z/ A, DCB,A,G, [M:3/4] & (3z/z/z/ F, F,4 C," "F,/C/A,/C/ F,/C/A,/C/ F,/C/B,/C/" "[F,,F,][F,A,] [B,,B,]4" "[F,,F,]z z2 z2" "[F,,F,]2 F,A,CA," "!/!C6 & [F,A,]4[E,G,][E,G,]" "[M:5/8] F, [F,,F,]3/4[F,,F,]/4 [F,,F,][F,,F,][F,,F,] [M:3/4]" "[M:7/8] (3z/z/z/ [F,,F,][F,A,] [B,,B,]4 [M:3/4]" "[M:5/8] [F,,F,]z [F,,F,]z [F,,F,] [M:3/4]" "F,C,A,,C,F, z" "[F,,F,][F,,F,][F,,F,][F,,F,][F,,F,][F,,F,]" "[M:5/8] [F,,F,] z z C,/4(B,,/4A,,/4G,,/4) F,, [M:3/4]" "[M:7/8] (3z/z/z/ !/!C6 & (3z/z/z/ [F,A,]4[E,G,][E,G,]" "!/!A,4B,B, & !/!F,6" "[F,,F,]z z2z2" "[M:7/8] (3z/z/z/ !/!A,4B,B, & [M:7/8] (3z/z/z/ !/!F,6" "[F,,F,]2 F,A,CA," "[M:7/8] (3z/z/z/ [F,,F,] zz2z2 [M:3/4]" "[F,,F,]2[G,,G,]2[A,,A,]2" "!/!A,4B,B, & !/!F,6" "[M:7/8] z [F,,F,][F,,F,]2 [F,,F,][F,,F,][F,,F,] [M:3/4]" "[M:7/8] z !/!A,4B,B, [M:3/4] & [M:7/8] z !/!F,6" "[M:5/8] [F,A,]2 z [F,,F,][F,,F,] [M:3/4]" "[M:5/8] F, [F,,F,][F,,F,][F,,F,] [F,,F,] [M:3/4]" "[M:5/8] [F,,F,]2 [F,,F,][F,,F,][F,,F,] [M:3/4]" "z6" "[F,,F,][F,A,] [B,,B,]4" "[F,,F,]2 zB,CC," "[F,,F,][F,,F,][F,,F,][F,,F,][F,,F,][F,,F,]" "F,/C/A,/C/ F,/C/A,/C/ E,/C/B,/C/" "[M:5/8] [F,A,]2 z [F,,F,][F,,F,] [M:3/4]" "[M:5/8] [F,A,]2 [F,,F,]2[F,,F,] [M:3/4]" "[M:5/8] [F,A,]2 [F,,F,]2[F,,F,] [M:3/4]" "[M:5/8] [F,,F,][F,,F,][F,,F,][F,,F,] [F,,F,] [M:3/4]" "[F,,F,]2[F,,F,]2[F,,F,][F,,F,]" "[F,A,]2 z [F,,F,][F,,F,][F,,F,]" "[M:5/8] [F,A,]2[F,A,]2[F,A,] [M:3/4]" "[F,,F,][F,,F,]2 [F,,F,][F,,F,][F,,F,]" "[M:7/8] z F,/C/A,/C/ F,/C/A,/C/ E,/C/B,/C/ [M:3/4]" )


#----------------------------------------------------------------------------------
# create empty ABC file
# set header info: generic index number, filename
# Total MDGs: 
# Unique MDGs:    
# all same for measures 
#----------------------------------------------------------------------------------
fileInd=$1-$2-$3-$4-$5-$6-$7-$8-$9-${10}-${11}-${12}-${13}-${14}-${15}-${16}
fileInd2=${17}-${18}-${19}-${20}-${21}-${22}-${23}-${24}-${25}-${26}-${27}-${28}-${29}-${30}-${31}-${32}
filen="acg5-$fileInd-$fileInd2.abc"

#Same measures??? 
#######
#TOTAL:		11**40 =	452,592,555,681,759,518,058,893,560,348,969,204,658,401 (452.593 duodecillion)
#UNIQUE:	
#######
# dbNum cannnot be computed in bash
##dbNum=(( ${diceS[0]}-1 + (${diceS[1]}-2)*11 + (${diceS[2]}-2)*11**2 + (${diceS[3]}-2)*11**3 + (${diceS[4]}-2)*11**4 + (${diceS[5]}-2)*11**5 + (${diceS[6]}-2)*11**6 + (${diceS[7]}-2)*11**7 + (${diceS[8]}-2)*11**8 + (${diceS[9]}-2)*11**9 + (${diceS[10]}-2)*11**10 + (${diceS[11]}-2)*11**11 + (${diceS[12]}-2)*11**12 + (${diceS[13]}-2)*11**13 + (${diceS[14]}-2)*11**14 + (${diceS[15]}-2)*11**15 + (${diceS[16]}-2)*11**16 + (${diceS[17]}-2)*11**17 + (${diceS[18]}-2)*11**18 + (${diceS[19]}-2)*11**19 + (${diceS[20]}-2)*11**20 + (${diceS[21]}-2)*11**21 + (${diceS[22]}-2)*11**22 + (${diceS[23]}-2)*11**23 + (${diceS[24]}-2)*11**24 + (${diceS[25]}-2)*11**25 + (${diceS[26]}-2)*11**26 + (${diceS[27]}-2)*11**27 + (${diceS[28]}-2)*11**28 + (${diceS[29]}-2)*11**29 + (${diceS[30]}-2)*11**30 + (${diceS[31]}-2)*11**31 + (${diceS[32]}-2)*11**32 + (${diceS[33]}-2)*11**33 + (${diceS[34]}-2)*11**34 + (${diceS[35]}-2)*11**35 + (${diceS[36]}-2)*11**36 + (${diceS[37]}-2)*11**37 + (${diceS[38]}-2)*11**38 + (${diceS[39]}-2)*11**39 )) 

#echo "${diceS[0]}-1 + (${diceS[1]}-2)*11 + (${diceS[2]}-2)*11**2 + (${diceS[3]}-2)*11**3 + (${diceS[4]}-2)*11**4 + (${diceS[5]}-2)*11**5 + (${diceS[6]}-2)*11**6 + (${diceS[7]}-2)*11**7 + (${diceS[8]}-2)*11**8 + (${diceS[9]}-2)*11**9 + (${diceS[10]}-2)*11**10 + (${diceS[11]}-2)*11**11 + (${diceS[12]}-2)*11**12 + (${diceS[13]}-2)*11**13 + (${diceS[14]}-2)*11**14 + (${diceS[15]}-2)*11**15 + (${diceS[16]}-2)*11**16 + (${diceS[17]}-2)*11**17 + (${diceS[18]}-2)*11**18 + (${diceS[19]}-2)*11**19 + (${diceS[20]}-2)*11**20 + (${diceS[21]}-2)*11**21 + (${diceS[22]}-2)*11**22 + (${diceS[23]}-2)*11**23 + (${diceS[24]}-2)*11**24 + (${diceS[25]}-2)*11**25 + (${diceS[26]}-2)*11**26 + (${diceS[27]}-2)*11**27 + (${diceS[28]}-2)*11**28 + (${diceS[29]}-2)*11**29 + (${diceS[30]}-2)*11**30 + (${diceS[31]}-2)*11**31 + (${diceS[32]}-2)*11**32 + (${diceS[33]}-2)*11**33 + (${diceS[34]}-2)*11**34 + (${diceS[35]}-2)*11**35 + (${diceS[36]}-2)*11**36 + (${diceS[37]}-2)*11**37 + (${diceS[38]}-2)*11**38 + (${diceS[39]}-2)*11**39"

# export to maxima to compute dbNum
cat > /tmp/001.mac << EOF
with_stdout("/tmp/001.txt",print(${diceS[0]}-1 + (${diceS[1]}-2)*11 + (${diceS[2]}-2)*11**2 + (${diceS[3]}-2)*11**3 + (${diceS[4]}-2)*11**4 + (${diceS[5]}-2)*11**5 + (${diceS[6]}-2)*11**6 + (${diceS[7]}-2)*11**7 + (${diceS[8]}-2)*11**8 + (${diceS[9]}-2)*11**9 + (${diceS[10]}-2)*11**10 + (${diceS[11]}-2)*11**11 + (${diceS[12]}-2)*11**12 + (${diceS[13]}-2)*11**13 + (${diceS[14]}-2)*11**14 + (${diceS[15]}-2)*11**15 + (${diceS[16]}-2)*11**16 + (${diceS[17]}-2)*11**17 + (${diceS[18]}-2)*11**18 + (${diceS[19]}-2)*11**19 + (${diceS[20]}-2)*11**20 + (${diceS[21]}-2)*11**21 + (${diceS[22]}-2)*11**22 + (${diceS[23]}-2)*11**23 + (${diceS[24]}-2)*11**24 + (${diceS[25]}-2)*11**25 + (${diceS[26]}-2)*11**26 + (${diceS[27]}-2)*11**27 + (${diceS[28]}-2)*11**28 + (${diceS[29]}-2)*11**29 + (${diceS[30]}-2)*11**30 + (${diceS[31]}-2)*11**31 + (${diceS[32]}-2)*11**32 + (${diceS[33]}-2)*11**33 + (${diceS[34]}-2)*11**34 + (${diceS[35]}-2)*11**35 + (${diceS[36]}-2)*11**36 + (${diceS[37]}-2)*11**37 + (${diceS[38]}-2)*11**38 + (${diceS[39]}-2)*11**39))$
printfile("/tmp/001.txt")$
quit();
EOF
/usr/local/bin/maxima < /tmp/001.mac > /dev/null
dbNum=`cat /tmp/001.txt`
echo "Permutation No.: "$dbNum

#----------------------------------------------------------------------------------
# calculate the measure numbers for the current dice toss (from (6**14)(16**6) possibilities)
#----------------------------------------------------------------------------------
currMeas=0
measPerm1=""
measPerm2=""
measPerm3=""
for measj in ${diceS[*]} ; do
	currMeas=`expr $currMeas + 1`
	#echo $currMeas
	if [ "$currMeas" -lt "9" ]; then
		ruletabA $measj
		measPerm1="$measPerm1${measNR[$currMeas-1]}:"
		continue
	elif [ "$currMeas" -lt "13" ]; then
		ruletabRit $measj
		measPerm1="$measPerm1${measNR[$currMeas-9]}:"
		continue
	elif [ "$currMeas" -lt "21" ]; then
		ruletabB $measj
		measPerm1="$measPerm1${measNR[$currMeas-13]}:"
		continue
	elif [ "$currMeas" -lt "29" ]; then
		ruletabA $measj
		measPerm1="$measPerm1${measNR[$currMeas-21]}:"
		continue
	elif [ "$currMeas" -lt "33" ]; then
		ruletabRit $measj
		measPerm1="$measPerm1${measNR[$currMeas-29]}:"
		continue	
	elif [ "$currMeas" -lt "41" ]; then
		ruletabC $measj
		measPerm2="$measPerm2${measNR[$currMeas-33]}:"
		continue
	elif [ "$currMeas" -lt "49" ]; then
		ruletabA $measj
		measPerm2="$measPerm2${measNR[$currMeas-41]}:"
		continue
	elif [ "$currMeas" -lt "53" ]; then
		ruletabRit $measj
		measPerm2="$measPerm2${measNR[$currMeas-49]}:"
		continue	
	elif [ "$currMeas" -lt "61" ]; then
		ruletabB $measj
		measPerm3="$measPerm3${measNR[$currMeas-53]}:"
		continue
	elif [ "$currMeas" -lt "65" ]; then
		ruletabA $measj
		measPerm3="$measPerm3${measNR[$currMeas-61+8]}:"
		continue
	elif [ "$currMeas" -lt "73" ]; then
		ruletabA $measj
		measPerm3="$measPerm3${measNR[$currMeas-65]}:"
		continue
	elif [ "$currMeas" -lt "77" ]; then
		ruletabRit $measj
		measPerm3="$measPerm3${measNR[$currMeas-73]}:"
		continue	
	fi
done
measPerm1="$measPerm1"
measPerm2="$measPerm2"
measPerm3="$measPerm3"


#----------------------------------------------------------------------------------
# if output abc file already exists, then make a back-up copy
#----------------------------------------------------------------------------------
if [ -f $filen ]; then 
	mv $filen $filen."bak"
fi

#----------------------------------------------------------------------------------
# create cat-to-output-file function for the ABC file
#----------------------------------------------------------------------------------
catToFile(){
	cat >> $filen << EOT
$1
EOT
}

#----------------------------------------------------------------------------------
# generate the header of the ABC file
#----------------------------------------------------------------------------------
catToFile "%%scale 0.60
%%pagewidth 21.082cm
%%bgcolor white
%%topspace 0.500cm
%%composerspace 1.00cm
%%leftmargin 0.254cm
%%rightmargin 0.254cm
%%musicspace 0.5cm
X:$dbNum
T:${fileInd}-${fileInd2}
%%setfont-1 Courier-Bold 12
T:\$1acg5::$measPerm1\$0
T:\$1:$measPerm2\$0
T:\$1:$measPerm3\$0
T:\$1Perm. No.: $dbNum\$0
M:3/4
L:1/8
Q:1/8=120
P:(AR)2.(BAR)2.(CAR)2.(BDAR)2
%%staves [1 2 3 4]
V:1 clef=alto1
V:2 clef=alto1
V:3 clef=treble
V:4 clef=bass
K:F
%
%%MIDI program 1 52       % 53-Choir Aahs
%%MIDI program 2 52       % 53-Choir Aahs
%%MIDI program 3 06       % 7-Harpsichord
%%MIDI program 4 06       % 7-Harpsichord"

#----------------------------------------------------------------------------------
# write the notes of the ABC file
#----------------------------------------------------------------------------------
# Determine the notes for the measures then write to ABC file:
# Part1 (measures 1-8, 9-12: ruletabA1 cols 1-8; ruletabRit cols 1-4
# Part2 (measures 13-20, 21-32: ruletabA2 cols 1-8; + Part 1
# Part3 (measures 33-40, 41-52: ruletabA3 cols 1-8; + Part 1
# Part4 (measures 53-64, 65-76: ruletabA2 cols 1-8; + Part 1 

# initialize the 4 voices for each part/ritornello
# then append the notes per measure 
pAV1="";pAV2="";pAV3="";pAV4=""
pRV1="";pRV2="";pRV3="";pRV4=""
pBV1="";pBV2="";pBV3="";pBV4=""
pCV1="";pCV2="";pCV3="";pCV4=""
for col in 1 2 3 4 5 6 7 8; do
	# for Part A
	ruletabA ${diceR[$col-1]}
	measN=${measNR[$col-1]}
	if [ "$measN" != "" ]; then
		pAV1=${pAV1}" "${notesAriaSup[$measN-1]}" |"
		pAV2=${pAV2}" "${notesAriaInf[$measN-1]}" |"
		pAV3=${pAV3}" "${notesAriaHG[$measN-1]}" |"
		pAV4=${pAV4}" "${notesAriaHF[$measN-1]}" |"
	fi
	# For Part R (ritornello)
	if [ "$col" -lt "5" ]; then
		ruletabRit ${diceR[$col+7]}
		measN=${measNR[$col-1]}
		if [ "$measN" != "" ]; then
			pRV1=${pRV1}" "${notesRitSup[$measN-1]}" |"
			pRV2=${pRV2}" "${notesRitInf[$measN-1]}" |"
			pRV3=${pRV3}" "${notesRitHG[$measN-1]}" |"
			pRV4=${pRV4}" "${notesRitHF[$measN-1]}" |"
		fi
	fi
	# for Part B
	ruletabB ${diceR[$col+11]}
	measN=${measNR[$col-1]}
	if [ "$measN" != "" ]; then
		pBV1=${pBV1}" "${notesAriaSup[$measN-1]}" |"
		pBV2=${pBV2}" "${notesAriaInf[$measN-1]}" |"
		pBV3=${pBV3}" "${notesAriaHG[$measN-1]}" |"
		pBV4=${pBV4}" "${notesAriaHF[$measN-1]}" |"
	fi
	# for Part C
	ruletabC ${diceR[$col+19]}
	measN=${measNR[$col-1]}
	if [ "$measN" != "" ]; then
		pCV1=${pCV1}" "${notesAriaSup[$measN-1]}" |"
		pCV2=${pCV2}" "${notesAriaInf[$measN-1]}" |"
		pCV3=${pCV3}" "${notesAriaHG[$measN-1]}" |"
		pCV4=${pCV4}" "${notesAriaHF[$measN-1]}" |"
	fi	
done

pDV1="";pDV2="";pDV3="";pDV4=""
for colD in 9 10 11 12; do
	# for Part D (Part B + last 4 cols of Table 1)
	ruletabA ${diceR[$colD+19]}
	measN=${measNR[$colD-1]}
	if [ "$measN" != "" ]; then
		pDV1=${pDV1}" "${notesAriaSup[$measN-1]}" |"
		pDV2=${pDV2}" "${notesAriaInf[$measN-1]}" |"
		pDV3=${pDV3}" "${notesAriaHG[$measN-1]}" |"
		pDV4=${pDV4}" "${notesAriaHF[$measN-1]}" |"
	fi	
done

#----------------------------------------------------------------------------------
# remove useless measure changes (only needed for Table of Measures)
#----------------------------------------------------------------------------------
# relevant measures
mtf="[M:3/4] |"
mse="[M:7/8]"
mfe="[M:5/8]"

# function for finding [M:3/4]
yesEND(){
	zEND="$1"
	tEND="$2"
	echo ${zEND:`expr ${#zEND} - ${#tEND}`:${#tEND}}
}

# function for finding [M:7/8] or [M:5/8]
yesSTART(){
	#echo $1
	aSTART="$1"
	tSTART="$2"
	echo ${aSTART:1:${#tSTART}}
}

# function for removing useless [M:3/4]
trimf(){
	phr=$1
	tcut=$2
	echo "${phr:0:`expr ${#phr} - ${#tcut}`} |"
}

# trim useless [M:3/4] to [M:7/8] changes
if [ "`yesEND "$pRV1" "$mtf"`" == "$mtf" ] && [ "`yesSTART "$pDV1" "$mse"`" == "$mse" ]; then pRV1=`trimf "$pRV1" "$mtf"`; fi
if [ "`yesEND "$pRV2" "$mtf"`" == "$mtf" ] && [ "`yesSTART "$pDV2" "$mse"`" == "$mse" ]; then pRV2=`trimf "$pRV2" "$mtf"`; fi
if [ "`yesEND "$pRV3" "$mtf"`" == "$mtf" ] && [ "`yesSTART "$pDV3" "$mse"`" == "$mse" ]; then pRV3=`trimf "$pRV3" "$mtf"`; fi
if [ "`yesEND "$pRV4" "$mtf"`" == "$mtf" ] && [ "`yesSTART "$pDV4" "$mse"`" == "$mse" ]; then pRV4=`trimf "$pRV4" "$mtf"`; fi

# trim useless [M:3/4] to [M:5/8] changes
if [ "`yesEND "$pRV1" "$mtf"`" == "$mtf" ] && [ "`yesSTART "$pDV1" "$mfe"`" == "$mfe" ]; then pRV1=`trimf "$pRV1" "$mtf"`; fi
if [ "`yesEND "$pRV2" "$mtf"`" == "$mtf" ] && [ "`yesSTART "$pDV2" "$mfe"`" == "$mfe" ]; then pRV2=`trimf "$pRV2" "$mtf"`; fi
if [ "`yesEND "$pRV3" "$mtf"`" == "$mtf" ] && [ "`yesSTART "$pDV3" "$mfe"`" == "$mfe" ]; then pRV3=`trimf "$pRV3" "$mtf"`; fi
if [ "`yesEND "$pRV4" "$mtf"`" == "$mtf" ] && [ "`yesSTART "$pDV4" "$mfe"`" == "$mfe" ]; then pRV4=`trimf "$pRV4" "$mtf"`; fi

# write the notes of the parts
echo -e "[P: A] \n[V:1]${pAV1}| \n[V:2]${pAV2}| \n[V:3]${pAV3}| \n[V:4]${pAV4}| " >> ./$filen
echo -e "[P: R] \n[V:1]${pRV1}|\ \n[V:2]${pRV2}|\ \n[V:3]${pRV3}|\ \n[V:4]${pRV4}|\ " >> ./$filen
echo -e "[P: D] \n[V:1]${pDV1}| \n[V:2]${pDV2}| \n[V:3]${pDV3}| \n[V:4]${pDV4}| " >> ./$filen
echo -e "[P: B] \n[V:1]${pBV1}| \n[V:2]${pBV2}| \n[V:3]${pBV3}| \n[V:4]${pBV4}| " >> ./$filen
echo -e "[P: C] \n[V:1]${pCV1}| \n[V:2]${pCV2}| \n[V:3]${pCV3}| \n[V:4]${pCV4}| " >> ./$filen

# delete additional useless meter changes
sed -i 's/\[M:3\/4\] | \[M:5\/8\]/ | \[M:5\/8\]/g' ./$filen
sed -i 's/\[M:3\/4\] | \[M:7\/8\]/ | \[M:7\/8\]/g' ./$filen

# create SVG
abcm2ps ./$filen -O ./"acg5-$fileInd-$fileInd2.svg" -g
# create PS
# abcm2ps ./$filen -O ./"acg5-$fileInd-$fileInd2.ps"

# create MIDI
/usr/bin/abc2midi ./$filen -quiet -silent -o ./"acg5-$fileInd-$fileInd2.mid"
echo ""
#
##
###
