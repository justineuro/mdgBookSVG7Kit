## mdgBookSVG7Kit

**Here's an opportunity for one to "compose" Rondos and to author a Collection Book of such!!!**  

![](./acg5-rondo-450.png)

[Audio: &nbsp; [ogg](https://justineuro.github.io/mdgBookSVG7Kit/audio-samples/acg5-2-8-10-8-5-8-11-8-2-7-7-6-7-12-11-6-2-2-7-7-10-7-4-3-3-12-10-8-6-6-2-12.ogg) &nbsp;&nbsp; [midi](./audio-samples/acg5-2-8-10-8-5-8-11-8-2-7-7-6-7-12-11-6-2-2-7-7-10-7-4-3-3-12-10-8-6-6-2-12.mid)]  
(Additional sample `midi` and `ogg` audio may be found in the [`audio-samples`](./audio-samples) folder of this repository.)

This folder contains materials that allow the user to author a book containing a collection of [Musical Dice Games (MDG)](https://en.wikipedia.org/wiki/Musikalisches_W%C3%BCrfelspiel) rondos, generated based on the rules given in Antonio Callegari's [*L'art de composer de la musique sans en connaître les éléments  2nd Ed. (1802)*](https://imslp.org/wiki/L'art_de_composer_de_la_musique_sans_en_conna%C3%AEtre_les_%C3%A9l%C3%A9ments_(Calegari%2C_Antonio)).  

To creat a book, simply [download](https://github.com/justineuro/mdgBookSVG7Kit/archive/main.zip) (or clone: `git clone https://github.com/justineuro/mdgBookSVG7Kit.git`) this project to one's computer, unzip the downloaded archive, and at the command line inside the main folder (`mdgBookSVG7Kit` or `mdgBookSVG7Kit-main` directory) issue the following command (pre-requisites: `bash`, `abcmidi`, `abcm2ps`, `Ghostscript`, `Inkscape`, and `LaTeX`):

```shell
bash HOWTO
```

Wait for a **few** minutes, i.e., until one gets the bash prompt again.  The compiled book in PDF format (`mdgBookSVG7v1.pdf`), among other things, should be located in the `res` folder (subdirectory).  


## For the Impatient
To examine an example of a book (`mdgBookSVG7v1.pdf`) that was generated in a similar manner, simply left-click on the image below; to download a copy right-click (then "Save Link As ...") on the image:

[![Front Cover](./mdgBookSVG7v1-tit.png)](https://raw.githubusercontent.com/justineuro/mdgBookSVG7Kit/main/mdgBookSVG7v1.pdf)

(**Note**: To enable the MIDI audio links in the book, one should download [mdgBookSVG7v1_1-midi.zip](https://github.com/justineuro/mdgBookSVG7Kit/raw/main/mdgBookSVG7v1_1-midi.zip) and unzip in the same directory in one's computer that contains the book, i.e., the book and midi files have to be in the same directory.  These same midis in ogg format: [mdgBookSVG7v1-ogg.zip](https://github.com/justineuro/mdgBookSVG7Kit/raw/main/mdgBookSVG7v1-ogg.zip))


## Important Parameters
To personalize one's generated book (in addition to the randomly generated rondos), one may want to change some of the default parameters/values in the following (all three files are initially found in the main directory but are eventually moved into the `res` folder): 

- `mdgBookSVG7v1.tex` - (main latex file) see lines 37-47; also, one may have to occasionally change the \\topmargin and \\textheight values on lines 413 and 414 of this file to ensure that each audio MIDI file will be on the same page as the corresponding musical score; these values affect the pages containing the 20 rondos and are different from the global values that appear on lines 31 and 32 near the top part of the file
- `mdgBookSVG7v1-cover.tex`- makes the cover of the book; see lines 37-47 of `mdgBookSVG7v1.tex` for default values
- `hyperref.cfg` - contains the `\hypersetup` keyvalues; one may wish to change the default value of `pdfauthor`, among other keyvalues; see the documentation for the TeX package `hyperref` for more information on these keyvalues

Once the desired changes have been made to the files above, one can then re-compile the book by issuing, in the `res` subdirectory, the last set of commands in the HOWTO file:
```shell
pdflatex -synctex=1 -interaction=nonstopmode -shell-escape mdgBookSVG7v1.tex
bibtex mdgBookSVG7v1.aux
pdflatex -synctex=1 -interaction=nonstopmode -shell-escape mdgBookSVG7v1.tex
pdflatex -synctex=1 -interaction=nonstopmode -shell-escape mdgBookSVG7v1.tex
```

Also, line 32 of the `HOWTO` is set by default so that each new book created contains 20 rondos.  One may wish to change this number, as desired, to some other counting number.  This has to be done **before** issuing the `bash HOWTO` command within the `mdgBookSVG7Kit` (or `mdgBookSVG7Kit-main`) directory.


## Similar Kits (by the same author) on GitHub
MDG Book kits similar to this may be found on related GitHub sites such as:

- [mdgBookSVGKit](https://github.com/justineuro/mdgBookSVGKit) - MDG based on [*Musikalisches W&uuml;rferspiel, K. 516f*](http://imslp.org/wiki/Musikalisches_W%C3%BCrfelspiel,_K.516f_%28Mozart,_Wolfgang_Amadeus%29), attributed to Wolfgang Amadeus Mozart
- [mdgBookSVG1ecdKit](https://justineuro.github.io/mdgBookSVG1ecdKit) - One-Command Kit for Creating MDG English Country Dances (ECD) Collection Book, the ECDs are generated based on the rules given in  [*Musikalisches Würfelspiel, K.Anh.C 30.01 - Englische Contret&auml;nze* (Mozart, Wolfgang Amadeus)](https://imslp.org/wiki/Musikalische_W%C3%BCrfelspiele%2C_K.Anh.C.30.01_(Mozart%2C_Wolfgang_Amadeus))
- [mdgBookSVG2Kit](https://justineuro.github.io/mdgBookSVG2Kit) - One-Command Kit for Creating MDG Double Counterpoints (Six Measures) Collection Book, the counterpoints are generated based on the rules given in C.P.E. Bach's [*Einfall, einen doppelten Contrapunct in der Octave von sechs Tacten zu machen, ohne die Regeln davon zu wissen*](https://www.jstor.org/stable/843301)
- [mdgBookSVG3Kit](https://justineuro.github.io/mdgBookSVG3Kit) - One-Command Kit for Creating MDG (Kirnberger) Minuet-Trios Collection Book, the minuet-trios are generated based on the rules given in [*Der allezeit fertige Polonoisen- und Menuettencomponist* (*1757*)](https://imslp.org/wiki/Der_allezeit_fertige_Polonoisen-_und_Menuettencomponist_(Kirnberger%2C_Johann_Philipp)) 
- [mdgBookSVG4Kit](https://justineuro.github.io/mdgBookSVG4Kit) - One-Command Kit for Creating MDG Minuet-Trios Collection Book, the minuet-trios are generated based on the rules given in [*Table pour composer des Minuets et des Trios &agrave; la infinie*](http://imslp.org/wiki/Table_pour_composer_des_Minuets_et_des_Trios_%C3%A0_la_infinie_(Stadler,_Maximilian)) (also known as or *Tabelle welcher aus man unzählige Menuetten und Trio für das Klavier herauswürfeln kann* or *Gioco Filarmonico o sia maniera facile per comporre un infinito numero di menuetti e trio, anche senza sapere il contrapunto*) 
- [mdgBookSVG4itKit](https://github.com/justineuro/mdgBookSVG4itKit) - MDG based on [*Gioco Filarmonico o sia maniera facile per comporre un infinito numero di menuetti e trio, anche senza sapere il contrapunto*](http://imslp.org/wiki/Table_pour_composer_des_Minuets_et_des_Trios_%C3%A0_la_infinie_(Stadler,_Maximilian)); similar to  [mdgBookSVG4Kit](https://github.com/justineuro/mdgBookSVG4Kit) but arranged for three (3) instruments
- [mdgBookSVG6Kit](https://justineuro.github.io/mdgBookSVG6Kit) - One-Command Kit for Creating MDG Scottish Dances (Dance-Trios) Collection Book, each dance-trio is generated based on the rules given in [*Kunst, Schottische Taenze zu componiren, ohne musicalisch zu sein*](https://imslp.org/wiki/Kunst%2C_Schottische_Taenze_zu_componiren%2C_ohne_musicalisch_zu_sein_(Gerlach%2C_Gustav))
- [mdgBookSVG8Kit](https://justineuro.github.io/mdgBookSVG8Kit) - One-Command Kit for Creating MDG Minuets Collection Book, each minuet is generated based on the rules given in [*Ludus Melothedicus 2nd ed. (1759)*](https://imslp.org/wiki/Ludus_Melothedicus_(Anonymous))


## Related Sites
- [Opus Infinity](https://opus-infinity.org/) - Collaborative work of Robbert Harms, Hein Moors, and Suus van Petegem whose goal is to unravel the mystery behind the tables used for generating MDGs.  Site visitors can generate MDGs based on works of Kirnberger, Mozart, Stadler/Haydn, Bach, Gerlach, and Callegari (_1st Cahier_).  Corresponding audio files (<tt>mid</tt>, <tt>ogg</tt>, and/or <tt>mp3</tt>) and image files (<tt>pdf</tt> or <tt>png</tt>) are also made available for listening, viewing, or downloading.
- [Mozart](https://marian-aldenhoevel.de/mozart/) - A site maintained by Marian Aldenh&ouml;vel allows the visitor to generate a MDG (user-specified or randomly-generated) and the corresponding audio (<tt>midi</tt>, <tt>wav</tt>) and image files (<tt>pdf</tt>, <tt>png</tt>) based on *Musikalisches W&uuml;rferspiel, K. 516f*.
- [Mozart](http://sunsite.univie.ac.at/Mozart/dice/) - A site maintained by John Chuang that allows the site visitor to generate MDGs based on the work of Stadler/Haydn.
- [`mozart.zip`](https://www.amaranthpublishing.com/mozart.zip) -  This is a Windows software (&copy; 1995 VisionSoft) by John Chuang and Stephen Goodwin that generates MDG based on input from user and is available for <em> free</em> from  [Amaranth Publishing](http://www.amaranthpublishing.com/MozartDiceGame.htm). 
-  [Mozart - Musical Game in C K. 516f*](http://www.asahi-net.or.jp/~rb5h-ngc/e/k516f.htm), Mozart Studies Online - The site of Hideo Noguchi that offers an explanation linking <tt>Musikalisches W&uuml;rferspiel, K. 516f</tt> and <tt>K. 294d (K. Anh. C 30.01)</tt>.


## Acknowledgments
Special thanks to  [International Music Score Library Project (IMSLP)](http://imslp.org/) for [_L'art de composer de la musique sans en connaître les éléments  2nd Ed. (1802)_](https://s9.imslp.org/files/imglnks/usimg/6/63/IMSLP653334-PMLP1047762-L'Art_de_composer_de_la_-...-Calegari_Antonio_bpt6k9617931c.pdf), [Opus Infinity](https://opus-infinity.org) for additional related information, and [Amaranth Publishing](http://www.amaranthpublishing.com/MozartDiceGame.htm) for a copy of <tt>mozart.zip</tt>. My sincerest gratitude to  Chris Walshaw et al. for the [ABC music notation](http://www.abcnotation.com);  Jean-Francois Moine for [abcm2ps](http://moinejf.free.fr/) and the accompanying examples, templates, and pointers for the appropriate use of these resources;  Guido Gonzato for the [ABC Plus Project](http://abcplus.sourceforge.net/) and the [abcmidi resources](http://abcplus.sourceforge.net/#abcMIDI) available there, more especially for the ABC resource book *Making Music with ABC 2*; James R. Allwright and Seymour Shlien for [abcmidi](http://abc.sourceforge.net/abcMIDI) source and binaries; Nils Liberg, Jan Wybren de Jong, Seymour Shlien et al. for [EasyABC](https://easyabc.sourceforge.net); [Artifex, Inc.](https://artifex.com) for `Ghostscript v.10.00.0` (includes the `ps2pdf` converter); [`Inkscape v.1.2.2`](https://www.inkscape.org) for the tool for converting SVGs to PDFs for inclusion into LaTeX documents; Peter Hanappe et al. for FluidSynth v.2.3.1 that was used for converting `midi` to `ogg`; [Google Lens](https://lens.google) and [Google Translate](https://translate.google.com) for aiding in producing the English versions of the text of _L'Art - 5th Cahier_; Colomban Wendling et. al for [Geany 2.0 IDE](https://www.geany.org); and [<tt>User:Martin H</tt>](https://tex.stackexchange.com/users/632/martin-h) for his [reply](https://tex.stackexchange.com/questions/2099/how-to-include-svg-diagrams-in-latex) to a TeX/LaTeX Stack Exchange question on including SVGs into LaTeX documents.  Ditto to Machtelt Garrels for the book [Bash Guide for Beginners](http://tldp.org/LDP/Bash-Beginners-Guide/html/Bash-Beginners-Guide.html), Vivek Gite for the book [Linux Script Shell Tutorial](http://www.freeos.com/guides/lsst/), Steve Parker for the [Unix/Linux Shell Cheatsheet](http://steve-parker.org/sh/cheatsheet.pdf).  John Fogarty's GitHub Site: [Latex CreateSpace BookCover](https://github.com/jfogarty/latex-createspace-bookcover) and Peter Wilson's reply in TeX/LaTeX Stack Exchange on [designing a book cover](https://tex.stackexchange.com/questions/17579/how-can-i-design-a-book-cover) were sources of ideas, information, and materials for creating the book cover and title page, thanks to both of them. Many thanks to the [Debian Project](https://www.debian.org) for the Debian 12 (Bookworm) GNU/Linux OS, [TeXLive 2024](http://www.tug.org/texlive/) for the TeX distribution, to Brian Fox for [Bash](https://www.gnu.org/software/bash/), and [GitHub](https://github.com) for its generosity in providing space for [this project](https://github.com/justineuro/mdgBookSVG7Kit).


## License
<p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/">
	<a property="dct:title" rel="cc:attributionURL" href="https://github.com/justineuro/mdgBookSVG7Kit">mdgBookSVG7Kit</a> by 
	<a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://justineuro.github.io/">Justine Leon A. Uro</a> is marked with 
        	<a href="https://creativecommons.org/publicdomain/zero/1.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC0 1.0 Universal
        <img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1" alt="">
    		<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/zero.svg?ref=chooser-v1" alt="">
	</a>
</p>