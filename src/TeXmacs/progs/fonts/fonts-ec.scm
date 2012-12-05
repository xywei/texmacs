
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : ec-fonts.scm
;; DESCRIPTION : setup european ec fonts for text mode
;; COPYRIGHT   : (C) 1999  Joris van der Hoeven
;;
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(texmacs-module (fonts fonts-ec))

(set-font-rules
  '(((roman rm medium right $s $d) (ec ecrm $s $d))
    ((roman rm medium slanted $s $d) (ec ecsl $s $d))
    ((roman rm medium italic $s $d) (ec ecti $s $d))
    ((roman rm medium left-slanted $s $d) (ec ecff $s $d))
    ((roman rm medium small-caps $s $d) (ec eccc $s $d))
    ((roman rm medium long $s $d) (ec ecdh $s $d))
    ((roman rm medium italic-right $s $d) (ec ecui $s $d))
    ((roman rm bold right $s $d) (ec ecbx $s $d))
    ((roman rm bold slanted $s $d) (ec ecbl $s $d))
    ((roman rm bold italic $s $d) (ec ecbi $s $d))
    ((roman rm bold condensed $s $d) (ec ecrb $s $d))
    ((roman rm bold small-caps $s $d) (ec ecxc $s $d))
    ((roman rm bold slanted-small-caps $s $d) (ec ecoc $s $d))
    ((roman tt medium right $s $d) (ec ectt $s $d))
    ((roman tt medium slanted $s $d) (ec ecst $s $d))
    ((roman tt medium italic $s $d) (ec ecst $s $d))
    ((roman tt medium small-caps $s $d) (ec ectc $s $d))
    ((roman tt medium flat $s $d) (ec ecltt $s $d))
    ((roman tt medium proportional $s $d) (ec ecvt $s $d))
    ((roman tt medium italic-proportional $s $d) (ec ecvi $s $d))
    ((roman tt bold right $s $d) (ec ectt $s $d))
    ((roman ss medium right $s $d) (ec ecss $s $d))
    ((roman ss medium slanted $s $d) (ec ecsi $s $d))
    ((roman ss medium italic $s $d) (ec ecsi $s $d))
    ((roman ss medium flat $s $d) (ec eclq $s $d 8))
    ((roman ss medium italic-flat $s $d) (ec ecli $s $d 8))
    ((roman ss bold right $s $d) (ec ecsx $s $d))
    ((roman ss bold slanted $s $d) (ec ecso $s $d))
    ((roman ss bold italic $s $d) (ec ecso $s $d))
    ((roman ss bold condensed $s $d) (ec ecssdc $s $d))
    ((roman ss bold flat $s $d) (ec eclb $s $d 8))
    ((roman ss bold italic-flat $s $d) (ec eclo $s $d 8))

    ((concrete rm medium right $s $d) (ec eorm $s $d))
    ((concrete rm medium slanted $s $d) (ec eosl $s $d))
    ((concrete rm medium italic $s $d) (ec eoti $s $d))
    ((concrete rm medium small-caps $s $d) (ec eocc $s $d))
    ((concrete rm bold right $s $d) (ec ecbx $s $d))
    ((concrete rm bold slanted $s $d) (ec ecbl $s $d))
    ((concrete rm bold italic $s $d) (ec ecbi $s $d))
    ((concrete rm bold condensed $s $d) (ec ecrb $s $d))
    ((concrete tt $a right $s $d) (ec ectt $s $d))
    ((concrete tt $a slanted $s $d) (ec ecst $s $d))
    ((concrete tt $a italic $s $d) (ec ecst $s $d))
    ((concrete tt medium small-caps $s $d) (ec ectc $s $d))
    ((concrete tt $a proportional $s $d) (ec ecvt $s $d))
    ((concrete ss medium right $s $d) (ec ecss $s $d))
    ((concrete ss medium slanted $s $d) (ec ecsi $s $d))
    ((concrete ss medium italic $s $d) (ec ecsi $s $d))
    ((concrete ss bold right $s $d) (ec ecsx $s $d))
    ((concrete ss bold condensed $s $d) (ec ecssdc $s $d))

    ((pandora rm medium right $s $d) (cm pnr $s $d))
    ((pandora rm medium slanted $s $d) (cm pnsl $s $d))
    ((pandora rm medium italic $s $d) (cm pnsl $s $d))
    ((pandora rm bold right $s $d) (cm pnb $s $d))
    ((pandora tt $a right $s $d) (cm pntt $s $d 9))
    ((pandora ss medium right $s $d) (cm pnss $s $d))
    ((pandora ss medium slanted $s $d) (cm pnssi $s $d))
    ((pandora ss medium italic $s $d) (cm pnssi $s $d))
    ((pandora ss bold right $s $d) (cm pnssb $s $d))

    ((duerer rm medium right $s $d) (tex cdr $s $d))
    ((duerer rm medium slanted $s $d) (tex cdsl $s $d))
    ((duerer rm medium italic $s $d) (tex cdi $s $d))
    ((duerer rm bold right $s $d) (tex cdb $s $d))
    ((duerer tt $a right $s $d) (tex cdtt $s $d))
    ((duerer ss medium right $s $d) (tex cdss $s $d))

    ((calligraphic $a medium $b $s $d) (tex callig $s $d 15))
    ((capbas $a medium $b $s $d) (tex capbas $s $d 0))
    ((hershey $a medium $b $s $d) (tex hscs $s $d))
    ((la $a medium $b $s $d) (tex la $s $d 14))
    ((messy $a medium $b $s $d) (tex ecfi $s $d))
    ((optical $a medium $b $s $d) (tex ocr $s $d))
    ((pacioli $a medium right $s $d) (tex cpcr $s $d))
    ((pacioli $a medium slanted $s $d) (tex cpcsl $s $d))
    ((punk $a medium right $s $d) (cm punk $s $d 20))
    ((punk $a medium slanted $s $d) (cm punksl $s $d 20))
    ((punk $a bold $b $s $d) (cm punkbx $s $d 20))
    ((twcal $a $b $c $s $d) (tex twcal $s $d 14))
    ((va $a medium $b $s $d) (tex va $s $d 14))

    ((Euler rm medium $b $s $d) (tex eufm $s $d))
    ((Euler rm bold $b $s $d) (tex eufb $s $d))
    ((ENR rm medium $b $s $d) (tex eurm $s $d))
    ((ENR rm bold $b $s $d) (tex eurb $s $d))
    ((gothic $a $b $c $s $d) (tex ygoth $s $d 0))
    ((schwell $a $b $c $s $d) (tex schwell $s $d 0))
    ((suet $a $b $c $s $d) (tex suet $s $d 14))
    ((swab $a $b $c $s $d) (tex yswab $s $d 0))
    ((blackletter $a $b $c $s $d) (tex blackletter $s $d 0))
    ((old-english $a $b $c $s $d) (tex hge $s $d 0))))

(set-font-rules
  '(((qt-helvetica $x $a $b $s $d) (qt Helvetica $s $d))))
