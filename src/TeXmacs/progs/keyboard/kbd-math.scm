
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : kbd-math.scm
;; DESCRIPTION : keyboard shortcuts for mathematics
;; COPYRIGHT   : (C) 1999  Joris van der Hoeven
;;
;; This software falls under the GNU general public license and comes WITHOUT
;; ANY WARRANTY WHATSOEVER. See the file $TEXMACS_PATH/LICENSE for details.
;; If you don't have this file, write to the Free Software Foundation, Inc.,
;; 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(texmacs-module (keyboard kbd-math)
  (:use (texmacs edit edit-table) (texmacs tools tm-bracket)))

(kbd-map in-math?
  ("math" "" "Insert mathematical markup")
  ("math:greek" "" "Insert a Greek character")
  ("math:bold" "" "Insert a bold character")
  ("math:bold:greek" "" "Insert a bold Greek character")
  ("math:cal" "" "Insert a calligraphic character")
  ("math:bold:cal" "" "Insert a bold calligraphic character")
  ("math:frak" "" "Insert a fraktur character")
  ("math:bbb" "" "Insert a blackboard bold character")
  ("math:over" "" "Insert a wide symbol above")
  ("math:under" "" "Insert a wide symbol below")
  ("math:left" "" "Insert a large left delimiter or left subscript")
  ("math:middle" "" "Insert a large separator")
  ("math:right" "" "Insert a large right delimiter")
  ("math:symbol" "" "Insert a mathematical symbol")
  ("math:symbol:circled" "" "Insert a big circled operator")
  ("math:symbol:limits" "" "Insert a mathematical symbol with limits")

  ;; must come first in order not to screw the menus up
  ("accent:deadhat" (make-script #t #t))
  ("math:left accent:deadhat" (make-script #t #f))
  ("math accent:tilde" (make-wide "~"))          ; yields M-M-~
  ("math accent:deadhat" (make-wide "^"))        ; yields M-M-^
  ("math accent:acute" (make-wide "<acute>"))    ; yields M-M-'
  ("math accent:grave" (make-wide "<grave>"))    ; yields M-M-`
  ("accent:abovedot" (make-wide "<dot>"))        ; yields M-.
  ("accent:umlaut" (make-wide "<ddot>"))         ; yields M-\"
  ("accent:breve" (make-wide "<breve>"))         ; yields M-U
  ("accent:check" (make-wide "<check>"))         ; yields M-V
  ("math:under accent:tilde" (make-wide-under "~"))
  ("math:under accent:deadhat" (make-wide-under "^"))
  ("math:under accent:acute" (make-wide-under "<acute>"))
  ("math:under accent:grave" (make-wide-under "<grave>"))
  ("math:under accent:abovedot" (make-wide-under "<dot>"))
  ("math:under accent:umlaut" (make-wide-under "<ddot>"))
  ("math:under accent:breve" (make-wide-under "<breve>"))
  ("math:under accent:check" (make-wide-under "<check>"))
  ;; end

  ("$" (go-end-with "mode" "math"))
  ("math $" (make-with "mode" "text"))
  ("math *" (table-toggle-number-equation))
  ("`" (make-lprime "`"))
  ("'" (make-rprime "'"))
  ("math:greek '" (make-rprime "<dag>"))
  ("math:greek \"" (make-rprime "<ddag>"))
  ("math:greek +" (make-rprime "<kreuz>"))
  ("\"" (make-rprime "'") (make-rprime "'"))
  ("_" (make-script #f #t))
  ("^" (make-script #t #t))
  ("math:left _" (make-script #f #f))
  ("math:left ^" (make-script #t #f))
  ("math f" (make-fraction))
  ("math s" (make-sqrt))
  ("math S" (make-var-sqrt))
  ("math n" (make-neg))
  ("math O" (make 'op))
  ("math +" (make-rprime "<dag>"))
  ("math a" (make-above))
  ("math b" (make-below))

  ("math B" (make-wide "<bar>"))
  ("math C" (make-wide "<check>"))
  ("math U" (make-wide "<breve>"))
  ("math T" (make-wide "<bind>"))
  ("math V" (make-wide "<vect>"))
  ("math ~" (make-wide "~"))
  ("math ^" (make-wide "^"))
  ("math '" (make-wide "<acute>"))
  ("math `" (make-wide "<grave>"))
  ("math -" (make-wide "<wide-bar>"))
  ("math ." (make-wide "<dot>"))
  ("math \"" (make-wide "<ddot>"))
  ("math @" (make-wide "<abovering>"))
  ("math _" (make-wide-under "<wide-bar>"))
  ("math:over {" (make-wide "<wide-overbrace>"))
  ("math:over }" (make-wide "<wide-underbrace*>"))
  ("math:over <" (make-wide "<wide-varleftarrow>"))
  ("math:over >" (make-wide "<wide-varrightarrow>"))
  ("math:over -" (make-wide "<wide-bar>"))
  ("math:under B" (make-wide-under "<bar>"))
  ("math:under C" (make-wide-under "<check>"))
  ("math:under U" (make-wide-under "<breve>"))
  ("math:under U" (make-wide-under "<bind>"))
  ("math:under V" (make-wide-under "<vect>"))
  ("math:under ~" (make-wide-under "~"))
  ("math:under ^" (make-wide-under "^"))
  ("math:under '" (make-wide-under "<acute>"))
  ("math:under `" (make-wide-under "<grave>"))
  ("math:under -" (make-wide-under "<wide-bar>"))
  ("math:under ." (make-wide-under "<dot>"))
  ("math:under \"" (make-wide-under "<ddot>"))
  ("math:under @" (make-wide-under "<abovering>"))
  ("math:under {" (make-wide-under "<wide-overbrace*>"))
  ("math:under }" (make-wide-under "<wide-underbrace>"))
  ("math:under <" (make-wide-under "<wide-varleftarrow>"))
  ("math:under >" (make-wide-under "<wide-varrightarrow>"))

  ("table N c" (make 'choice))
  ("table N m" (make 'matrix))
  ("table N d" (make 'det))
  ("table N s" (make 'stack))

  ("font R" (make-with "math-font" "roman"))
  ("font K" (make-with "math-font" "concrete"))
  ("font F" (make-with "math-font" "Euler"))
  ("font E" (make-with "math-font" "ENR"))
  ("font C" (make-with "math-font" "cal"))
  ("font B" (make-with "math-font" "Bbb*"))
  ("font o" (make-with "math-font-family" "mr"))
  ("font s" (make-with "math-font-family" "ms"))
  ("font t" (make-with "math-font-family" "mt"))
  ("font m" (make-with "math-font-series" "medium"))
  ("font b" (make-with "math-font-series" "bold"))
  ("font n" (make-with "math-font-shape" "normal"))
  ("font r" (make-with "math-font-shape" "right"))
  ("font l" (make-with "math-font-shape" "slanted"))
  ("font i" (make-with "math-font-shape" "italic"))
  ("font u" (make-with "math-font-shape" "semi-right"))

  ("notsign" "<neg>")
  ("plusminus" "<pm>")
  ("twosuperior" (insert '(rsup "2")))
  ("threesuperior" (insert '(rsup "3")))
  ("mu" "<mu>")
  ("onequarter" (insert '(frac "1" "4")))
  ("onehalf" (insert '(frac "1" "2")))
  ("threequarters" (insert '(frac "3" "4")))

  ("(" (make-bracket-open "(" ")"))
  (")" (make-bracket-close ")" "("))
  ("[" (make-bracket-open "[" "]"))
  ("]" (make-bracket-close "]" "["))
  ("{" (make-bracket-open "{" "}"))
  ("}" (make-bracket-close "}" "{"))
  ("| ," (make-bracket-open "<lfloor>" "<rfloor>"))
  (", |" (make-bracket-close "<rfloor>" "<lfloor>"))
  ("| '" (make-bracket-open "<lceil>" "<rceil>"))
  ("' |" (make-bracket-close "<rceil>" "<lceil>"))
  ("| accent:acute" (make-bracket-open "<lceil>" "<rceil>"))
  ("accent:acute |" (make-bracket-close "<rceil>" "<lceil>"))

  ("space" " ")
  ("S-space" " ")
  ("space var" "<nonesep>")

  ("math:symbol a" "<amalg>")
  ("math:symbol d" "<partial>")
  ("math:symbol p" "<wp>")
  ("math:symbol n" "<cap>")
  ("math:symbol n var" "<sqcap>")
  ("math:symbol u" "<cup>")
  ("math:symbol u var" "<sqcup>")
  ("math:symbol w" "<wedge>")
  ("math:symbol w var" "<curlywedge>")
  ("math:symbol w var var" "<curlywedgeuparrow>")
  ("math:symbol w var var var" "<curlywedgedownarrow>")
  ("math:symbol w var var var var" "<wedges>")
  ("math:symbol v" "<vee>")
  ("math:symbol v var" "<curlyvee>")
  ("math:symbol v var var" "<curlyveeuparrow>")
  ("math:symbol v var var var" "<curlyveedownarrow>")
  ("math:symbol x" "<times>")

  ("math:symbol S" (make-big-operator "sum"))
  ("math:symbol P" (make-big-operator "prod"))
  ("math:symbol I" (make-big-operator "int"))
  ("math:symbol:limits I" (make-big-operator "intlim"))
  ("math:symbol O" (make-big-operator "oint"))
  ("math:symbol:limits O" (make-big-operator "ointlim"))
  ("math:symbol A" (make-big-operator "amalg"))
  ("math:symbol N" (make-big-operator "cap"))
  ("math:symbol W" (make-big-operator "wedge"))
  ("math:symbol U" (make-big-operator "cup"))
  ("math:symbol V" (make-big-operator "vee"))
  ("math:symbol:circled ." (make-big-operator "odot"))
  ("math:symbol:circled +" (make-big-operator "oplus"))
  ("math:symbol:circled x" (make-big-operator "otimes"))
  ("math:symbol ." (make-big-operator "."))

  ("math:large (" (make-bracket-open "(" ")" #t))
  ("math:large )" (make-bracket-close ")" "(" #t))
  ("math:large [" (make-bracket-open "[" "]" #t))
  ("math:large ]" (make-bracket-close "]" "[" #t))
  ("math:large {" (make-bracket-open "{" "}" #t))
  ("math:large }" (make-bracket-close "}" "{" #t))
  ("math:large <" (make-bracket-open "langle" "rangle" #t))
  ("math:large >" (make-bracket-close "rangle" "langle" #t))
  ("math:large /" (make-separator "/" #t))
  ("math:large \\" (make-separator "\\" #t))
  ("math:large |" (make-separator "|" #t))

  ("math:left (" (make-bracket-open "(" ")" #t))
  ("math:left )" (make-bracket-open ")" "(" #t))
  ("math:left [" (make-bracket-open "[" "]" #t))
  ("math:left ]" (make-bracket-open "]" "[" #t))
  ("math:left {" (make-bracket-open "{" "}" #t))
  ("math:left }" (make-bracket-open "}" "{" #t))
  ("math:left <" (make-bracket-open "langle" "rangle" #t))
  ("math:left >" (make-bracket-open "rangle" "langle" #t))
  ("math:left /" (make-bracket-open "/" "\\" #t))
  ("math:left \\" (make-bracket-open "\\" "/" #t))
  ("math:left |" (make-bracket-open "|" "|" #t))
  ("math:left ." (make-bracket-open "." "." #t))

  ("math:middle (" (make-separator "(" #t))
  ("math:middle )" (make-separator ")" #t))
  ("math:middle [" (make-separator "[" #t))
  ("math:middle ]" (make-separator "]" #t))
  ("math:middle {" (make-separator "{" #t))
  ("math:middle }" (make-separator "}" #t))
  ("math:middle <" (make-separator "langle" #t))
  ("math:middle >" (make-separator "rangle" #t))
  ("math:middle /" (make-separator "/" #t))
  ("math:middle \\" (make-separator "\\" #t))
  ("math:middle |" (make-separator "|" #t))
  ("math:middle ." (make-separator "." #t))

  ("math:right (" (make-bracket-close "(" ")" #t))
  ("math:right )" (make-bracket-close ")" "(" #t))
  ("math:right [" (make-bracket-close "[" "]" #t))
  ("math:right ]" (make-bracket-close "]" "[" #t))
  ("math:right {" (make-bracket-close "{" "}" #t))
  ("math:right }" (make-bracket-close "}" "{" #t))
  ("math:right <" (make-bracket-close "langle" "rangle" #t))
  ("math:right >" (make-bracket-close "rangle" "langle" #t))
  ("math:right /" (make-bracket-close "/" "\\" #t))
  ("math:right \\" (make-bracket-close "\\" "/" #t))
  ("math:right |" (make-bracket-close "|" "|" #t))
  ("math:right ." (make-bracket-close "." "." #t))

  ("<" "<less>")
  (">" "<gtr>")
  ("< /" "<nless>")
  ("> /" "<ngtr>")
  ("< =" "<leqslant>")
  ("> =" "<geqslant>")
  ("< = /" "<nleqslant>")
  ("> = /" "<ngeqslant>")
  ("< = var" "<leq>")
  ("> = var" "<geq>")
  ("< = var /" "<nleq>")
  ("> = var /" "<ngeq>")
  ("< <" "<ll>")
  ("< < <" "<lll>")
  ("> >" "<gg>")
  ("> > >" "<ggg>")
  ("< < =" "<lleq>")
  ("< < < =" "<llleq>")
  ("> > =" "<ggeq>")
  ("> > > =" "<gggeq>")
  ("< < /" "<nll>")
  ("< < < /" "<nlll>")
  ("> > /" "<ngg>")
  ("> > > /" "<nggg>")
  ("< < = /" "<nlleq>")
  ("< < < = /" "<nllleq>")
  ("> > = /" "<nggeq>")
  ("> > > = /" "<ngggeq>")
  ("< ." "<lessdot>")
  (". >" "<gtrdot>")
  ("< = ." "<lesseqdot>")
  (". > =" "<gtreqdot>")

  ("< var" "<prec>")
  ("> var" "<succ>")
  ("< var /" "<nprec>")
  ("> var /" "<nsucc>")
  ("< var =" "<preccurlyeq>")
  ("> var =" "<succcurlyeq>")
  ("< var = /" "<npreccurlyeq>")
  ("> var = /" "<nsucccurlyeq>")
  ("< var = var" "<preceq>")
  ("> var = var" "<succeq>")
  ("< var = var /" "<npreceq>")
  ("> var = var /" "<nsucceq>")
  ("< var = var / var" "<precneqq>")
  ("> var = var / var" "<succneqq>")
  ("< < var" "<precprec>")
  ("< < < var" "<precprecprec>")
  ("> > var" "<succsucc>")
  ("> > > var" "<succsuccsucc>")
  ("< < var =" "<precpreceq>")
  ("< < < var =" "<precprecpreceq>")
  ("> > var =" "<succsucceq>")
  ("> > > var =" "<succsuccsucceq>")
  ("< < var /" "<nprecprec>")
  ("< < < var /" "<nprecprecprec>")
  ("> > var /" "<nsuccsucc>")
  ("> > > var /" "<nsuccsuccsucc>")
  ("< < var = /" "<nprecpreceq>")
  ("< < < var = /" "<nprecprecpreceq>")
  ("> > var = /" "<nsuccsucceq>")
  ("> > > var = /" "<nsuccsuccsucceq>")
  ("< var ." "<precdot>")
  (". > var" "<dotsucc>")
  ("< var = ." "<preceqdot>")
  (". > var =" "<dotsucceq>")
  ("< < var var" "<llangle>")
  ("> > var var" "<rrangle>")

  ("< >" "<lessgtr>")
  ("> <" "<gtrless>")
  ("< ~" "<lesssim>")
  ("< ~ ~" "<lessapprox>")
  ("< var ~" "<precsim>")
  ("< var ~ ~" "<precapprox>")
  ("> ~" "<gtrsim>")
  ("> ~ ~" "<gtrapprox>")
  ("> var ~" "<gtrsim>")
  ("> var ~ ~" "<gtrapprox>")
  ("< = var var" "<leqq>")
  ("> = var var" "<geqq>")
  ("< = var >" "<lesseqgtr>")
  ("> = var <" "<gtreqless>")
  ("< = var var >" "<lesseqqgtr>")
  ("> = var var <" "<gtreqqless>")
  ("< > /" "<nlessgtr>")
  ("> < /" "<ngtrless>")
  ("< ~ /" "<nlesssim>")
  ("< ~ / var" "<lnsim>")
  ("< ~ ~ /" "<nlessapprox>")
  ("< ~ ~ / var" "<lnapprox>")
  ("< var ~ /" "<nprecsim>")
  ("< var ~ / var" "<precnsim>")
  ("< var ~ ~ /" "<nprecapprox>")
  ("< var ~ ~ / var" "<precnapprox>")
  ("> ~ /" "<ngtrsim>")
  ("> ~ / var" "<gnsim>")
  ("> ~ ~ /" "<ngtrapprox>")
  ("> ~ ~ / var" "<gnapprox>")
  ("> var ~ /" "<nsuccsim>")
  ("> var ~ / var" "<succnsim>")
  ("> var ~ ~ /" "<nsuccapprox>")
  ("> var ~ ~ / var" "<succnapprox>")
  ("< = var var /" "<nleqq>")
  ("> = var var /" "<ngeqq>")
  ("< = var > /" "<nlesseqgtr>")
  ("> = var < /" "<ngtreqless>")
  ("< = var var > /" "<nlesseqqgtr>")
  ("> = var var < /" "<ngtreqqless>")
  ("< = var / var" "<lneq>")
  ("< = var var / var" "<lneqq>")
  ("< = var var / var var" "<lvertneqq>")
  ("> = var / var" "<gneq>")
  ("> = var var / var" "<gneqq>")
  ("> = var var / var var" "<gvertneqq>")

  ("- >" "<rightarrow>")
  ("- > var" "<downarrow>")
  ("- > var var" "<uparrow>")
  ("- > var var var" "<searrow>")
  ("- > var var var var" "<nearrow>")
  ("< -" "<leftarrow>")
  ("< - var" "<uparrow>")
  ("< - var var" "<downarrow>")
  ("< - var var var" "<nwarrow>")
  ("< - var var var var" "<swarrow>")
  ("< - >" "<leftrightarrow>")
  ("< - > var" "<updownarrow>")
  ("- -" "<longminus>")
  ("- - >" "<longrightarrow>")
  ("- - > var" "<longdownarrow>")
  ("- - > var var" "<longuparrow>")
  ("< - -" "<longleftarrow>")
  ("< - - var" "<longuparrow>")
  ("< - - var var" "<longdownarrow>")
  ("< - - >" "<longleftrightarrow>")
  ("< - - > var" "<longupdownarrow>")
  ("= >" "<Rightarrow>")
  ("= > var" "<Downarrow>")
  ("= > var var" "<Uparrow>")
  ("< = var var var" "<Leftarrow>")
  ("< = >" "<Leftrightarrow>")
  ("< = > var" "<Updownarrow>")
  ("= =" "<longequal>")
  ("= = >" "<Longrightarrow>")
  ("= = > var" "<Longdownarrow>")
  ("= = > var var" "<Longuparrow>")
  ("< = =" "<Longleftarrow>")
  ("< = = var" "<Longuparrow>")
  ("< = = var var" "<Longdownarrow>")
  ("< = = >" "<Longleftrightarrow>")
  ("< = = > var" "<Longupdownarrow>")
  ("| - >" "<mapsto>")
  ("| - > var" "<hookrightarrow>")
  ("| - > var var" "<mapsdown>")
  ("| - > var var var" "<hookdownarrow>")
  ("| - > var var var var" "<mapsup>")
  ("| - > var var var var var" "<hookuparrow>")
  ("| - - >" "<longmapsto>")
  ("| - - > var" "<longhookrightarrow>")
  ("| - - > var var" "<longmapsdown>")
  ("| - - > var var var" "<longhookdownarrow>")
  ("| - - > var var var var" "<longmapsup>")
  ("| - - > var var var var var" "<longhookuparrow>")
  ("< - |" "<mapsfrom>")
  ("< - | var" "<hookleftarrow>")
  ("< - | var var" "<mapsup>")
  ("< - | var var var" "<hookuparrow>")
  ("< - | var var var var" "<mapsdown>")
  ("< - | var var var var var" "<hookdownarrow>")
  ("< - - |" "<longmapsfrom>")
  ("< - - | var" "<longhookleftarrow>")
  ("< - - | var var" "<longmapsup>")
  ("< - - | var var var" "<longhookuparrow>")
  ("< - - | var var var var" "<longmapsdown>")
  ("< - - | var var var var var" "<longhookdownarrow>")
  ("~ >" "<rightsquigarrow>")
  ("~ > var" "<downsquigarrow>")
  ("~ > var var" "<upsquigarrow>")
  ("< ~ var" "<leftsquigarrow>")
  ("< ~ var var" "<upsquigarrow>")
  ("< ~ var var var" "<downsquigarrow>")
  ("< ~ >" "<leftrightsquigarrow>")
  ("< - <" "<leftarrowtail>")
  ("> - >" "<rightarrowtail>")
  ("- > - >" "<rightrightarrows>")
  ("< - < -" "<leftleftarrows>")
  ("- > < -" "<rightleftarrows>")
  ("- > < - var" "<rightleftharpoons>")
  ("< - - > var" "<leftrightarrows>")
  ("< - - > var var" "<leftrightharpoons>")
  ("- > >" "<twoheadrightarrow>")
  ("< < -" "<twoheadleftarrow>")
  ("- - > >" "<longtwoheadrightarrow>")
  ("< < - -" "<longtwoheadleftarrow>")
  ("- > /" "<nrightarrow>")
  ("< - /" "<nleftarrow>")
  ("< - > /" "<nleftrightarrow>")
  ("= > /" "<nRightarrow>")
  ("< = var var var /" "<nLeftarrow>")
  ("< = > /" "<nLeftrightarrow>")
  ("< - > -" "<leftrightarroweq>")
  ("- | >" "<rightarrowtriangle>")
  ("< | -" "<leftarrowtriangle>")
  ("< | - | >" "<leftrightarrowtriangle>")
  ("| - | >" "<longmapstotriangle>")
  ("- - | >" "<longrightarrowtriangle>")
  ("< | - -" "<longleftarrowtriangle>")
  ("< | - - | >" "<longleftrightarrowtriangle>")
  ("| - - | >" "<longmapstotriangle>")
  ("< - < var" "<leftprec>")
  ("> var - >" "<succright>")
  ("< - < var =" "<leftpreceq>")
  ("> var = - >" "<succeqright>")

  ("- > !" "<rightarrowlim>")
  ("< - !" "<leftarrowlim>")
  ("< - > !" "<leftrightarrowlim>")
  ("| - > !" "<mapstolim>")
  ("- - > !" "<longrightarrowlim>")
  ("< - - !" "<longleftarrowlim>")
  ("< - - > !" "<longleftrightarrowlim>")
  ("| - - > !" "<longmapstolim>")
  ("= !" "<equallim>")
  ("= = !" "<longequallim>")
  ("= > !" "<Rightarrowlim>")
  ("< = !" "<Leftarrowlim>")
  ("< = > !" "<Leftrightarrowlim>")
  ("= = > !" "<Longrightarrowlim>")
  ("< = = !" "<Longleftarrowlim>")
  ("< = = > !" "<Longleftrightarrowlim>")

  ("@" "<circ>")
  ("@ /" "<varnothing>")
  ("@ +" "<oplus>")
  ("@ -" "<ominus>")
  ("@ x" "<otimes>")
  ("@ :" "<oover>")
  ("@ ." "<odot>")
  ("@ R" "<circledR>")
  ("@ S" "<circledS>")
  ("@ / var" "<oslash>")
  ("@ \\" "<obslash>")
  ("@ <" "<olessthan>")
  ("@ >" "<ogreaterthan>")
  ("@ &" "<owedge>")
  ("@ |" "<obar>")
  ("@ | var" "<ovee>")
  ("@ v" "<ovee>")
  ("@ @" "<infty>")
  ("@ @ var" "<varocircle>")
  ("- @ @" "-<infty>")
  ("@ var" "<box>")
  ("@ var +" "<boxplus>")
  ("@ var -" "<boxminus>")
  ("@ var x" "<boxtimes>")
  ("@ var ." "<boxdot>")
  ("@ var /" "<boxslash>")
  ("@ var \\" "<boxbslash>")
  ("@ var @" "<boxcircle>")
  ("@ var @ var" "<boxbox>")
  ("@ var |" "<boxbar>")
  ("@ var var" "<bullet>")
  ("@ var var var" "<blacksquare>")

  ("= var" "<asymp>")
  ("= var var" "<equiv>")
  ("= var var var" "<asympasymp>")
  ("= var var var var" "<simsim>")
  ("~" "<sim>")
  ("~ ~" "<approx>")
  ("~ ~ -" "<approxeq>")
  ("~ -" "<simeq>")
  ("~ =" "<cong>")
  ("= /" "<neq>")
  ("= var /" "<nasymp>")
  ("= var var /" "<nequiv>")
  ("= var var var /" "<nasympasymp>")
  ("= var var var var /" "<nsimsim>")
  ("~ /" "<nsim>")
  ("~ ~ /" "<napprox>")
  ("~ - /" "<nsimeq>")
  ("~ = /" "<ncong>")
    
  ("|" "|")
  ("| |" "<||>")
  ("| | |" "<interleave>")
  ("| | var" "<shortparallel>")
  ("| -" "<vdash>")
  ("| - -" "<longvdash>")
  ("| | -" "<Vdash>")
  ("| | - -" "<longVdash>")
  ("| | | -" "<Vvdash>")
  ("| | | - -" "<longVvdash>")
  ("- |" "<dashv>")
  ("- - |" "<longdashv>")
  ("| =" "<vDash>")
  ("| = =" "<longvDash>")
  ;; ("| | =" "<VDash>")
  ;; ("| | = =" "<longVDash>")
  ("| /" "<nmid>")
  ("| | /" "<nparallel>")
  ("| | var /" "<nshortparallel>")
  ("| - /" "<nvdash>")
  ("| | - /" "<nVdash>")
  ;; ("- | /" "<ndashv>")
  ;; ("- | | /" "<ndashV>")
  ("| = /" "<nvDash>")
  ;; ("| | = /" "<nVDash>")
  ;; ("= | /" "<nDashv>")
  ;; ("= | | /" "<nDashV>")
    
  ("< |" "<vartriangleleft>")
  ("< | var" "<blacktriangleleft>")
  ("< | /" "<ntriangleleft>")
  ("< | =" "<trianglelefteqslant>")
  ("< | = /" "<ntrianglelefteqslant>")
  ("< | = var" "<trianglelefteq>")
  ("< | = var /" "<ntriangleqleft>")
  ("| >" "<vartriangleright>")
  ("| > var" "<blacktriangleright>")
  ("| > /" "<ntriangleright>")
  ("| > =" "<trianglerighteq>")
  ("| > = /" "<ntriangleqright>")
  ("| > = var" "<trianglerighteqslant>")
  ("| > = var /" "<ntrianglerighteqslant>")
    
  ("+ var" "<upl>")
  ("+ var var" "<kreuz>")
  ("+ var var var" "<dag>")
  ("+ var var var var" "<ddag>")
  ("- var" "<um>")
  ("+ -" "<pm>")
  ("+ - var" "<upm>")
  ("- +" "<mp>")
  ("- + var" "<ump>")
  ("@ =" "<circeq>")
  ("= @" "<eqcirc>")
  ("- @" "<multimap>")
  (". =" "<doteq>")
  (". ." "<ldots>")
  (". . var" "<cdots>")
  (". . var !" "<cdotslim>")
  (". . var var" "<hdots>")
  (". . var var var" "<vdots>")
  (". . var var var var" "<ddots>")
  (". . var var var var var" "<udots>")
  (": =" "<assign>")
  ("+ =" "<plusassign>")
  ("- =" "<minusassign>")
  ("/ var" "<div>")
  ("* var" "<ast>")
  ("* var var" "<times>")
  ("* var var var" "<cdot>")
  ("| * var" "<ltimes>")
  ("| * var |" "<join>")
  ("* | var" "<rtimes>")
  ("* var var |" "<rtimes>")

  ("< var var" "<subset>")
  ("> var var" "<supset>")
  ("< var var /" "<nsubset>")
  ("> var var /" "<nsupset>")
  ("< var var =" "<subseteq>")
  ("> var var =" "<supseteq>")
  ("< var var = /" "<nsubseteq>")
  ("> var var = /" "<nsupseteq>")
  ("< var var = var" "<subseteqq>")
  ("> var var = var" "<supseteqq>")
  ("< var var = /" "<nsubseteq>")
  ("> var var = /" "<nsupseteq>")
  ("< var var = var /" "<nsubseteqq>")
  ("> var var = var /" "<nsupseteqq>")
  ("< var var = / var" "<subsetneq>")
  ("> var var = / var" "<supsetneq>")
  ("< var var = / var var" "<varsubsetneq>")
  ("> var var = / var var" "<varsupsetneq>")
  ("< var var = var / var" "<subsetneqq>")
  ("> var var = var / var" "<supsetneqq>")
  ("< var var = var / var var" "<varsubsetneqq>")
  ("> var var = var / var var" "<varsupsetneqq>")
  ("< var var +" "<subsetplus>")
  ("> var var +" "<supsetplus>")
  ("< var var + =" "<subsetpluseq>")
  ("> var var + =" "<supsetpluseq>")
  ("< var var = +" "<subsetpluseq>")
  ("> var var = +" "<supsetpluseq>")
  ("< var var ~" "<subsetsim>")
  ("> var var ~" "<supsetsim>")
  ("< var var var" "<in>")
  ("> var var var" "<ni>")
  ("< var var var /" "<nin>")
  ("> var var var /" "<nni>")

  ("< var var var var" "<sqsubset>")
  ("> var var var var" "<sqsupset>")
  ("< var var var var /" "<nsqsubset>")
  ("> var var var var /" "<nsqsupset>")
  ("< var var var var =" "<sqsubseteq>")
  ("> var var var var =" "<sqsupseteq>")
  ("< var var var var = /" "<nsqsubseteq>")
  ("> var var var var = /" "<nsqsupseteq>")

  ("< var var var var var" "<langle>")
  ("> var var var var var" "<rangle>")
  ("< var var var var var var" "<leftslice>")
  ("> var var var var var var" "<rightslice>")

  ("symbol \\ var" "<setminus>")
  ("symbol \\ var var" "<smallsetminus>")
  ("# var" "<sharp>")
  ("# var var" "<natural>")
  ("# var var var" "<flat>")
  ("& var" "<wedge>")
  ("& var var" "<cap>")
  ("& var var var" "<sqcap>")
  ("| var" "<vee>")
  ("| var var" "<cup>")
  ("| var var +" "<uplus>")
  ("| var var var" "<sqcup>")
  ("| var var var var" "<shortmid>")
  ("| var var var var /" "<nshortmid>")

  ("math:greek a" "<alpha>")
  ("math:greek b" "<beta>")
  ("math:greek g" "<gamma>")
  ("math:greek d" "<delta>")
  ("math:greek e" "<varepsilon>")
  ("math:greek e var" "<epsilon>")
  ("math:greek e var var" "<backepsilon>")
  ("math:greek z" "<zeta>")
  ("math:greek h" "<eta>")
  ("math:greek j" "<theta>")
  ("math:greek j var" "<vartheta>")
  ("math:greek i" "<iota>")
  ("math:greek k" "<kappa>")
  ("math:greek k var" "<varkappa>")
  ("math:greek l" "<lambda>")
  ("math:greek m" "<mu>")
  ("math:greek n" "<nu>")
  ("math:greek x" "<xi>")
  ("math:greek o" "<omicron>")
  ("math:greek p" "<pi>")
  ("math:greek p var" "<mathpi>")
  ("math:greek p var var" "<varpi>")
  ("math:greek r" "<rho>")
  ("math:greek r var" "<varrho>")
  ("math:greek s" "<sigma>")
  ("math:greek s var" "<varsigma>")
  ("math:greek c" "<varsigma>")
  ("math:greek c var" "<sigma>")
  ("math:greek t" "<tau>")
  ("math:greek u" "<upsilon>")
  ("math:greek f" "<varphi>")
  ("math:greek f var" "<phi>")
  ("math:greek y" "<psi>")
  ("math:greek q" "<chi>")
  ("math:greek w" "<omega>")
  ("math:greek w var" "<mho>")
  ("math:greek v" "<phi>")
  ("math:greek v var" "<varphi>")
  ("math:greek A" "<Alpha>")
  ("math:greek B" "<Beta>")
  ("math:greek G" "<Gamma>")
  ("math:greek D" "<Delta>")
  ("math:greek E" "<Epsilon>")
  ("math:greek E var" "<Backepsilon>")
  ("math:greek Z" "<Zeta>")
  ("math:greek H" "<Eta>")
  ("math:greek J" "<Theta>")
  ("math:greek I" "<Iota>")
  ("math:greek K" "<Kappa>")
  ("math:greek L" "<Lambda>")
  ("math:greek M" "<Mu>")
  ("math:greek N" "<Nu>")
  ("math:greek X" "<Xi>")
  ("math:greek O" "<Omicron>")
  ("math:greek P" "<Pi>")
  ("math:greek R" "<Rho>")
  ("math:greek S" "<Sigma>")
  ("math:greek C" "<Sigma>")
  ("math:greek T" "<Tau>")
  ("math:greek U" "<Upsilon>")
  ("math:greek F" "<Phi>")
  ("math:greek Y" "<Psi>")
  ("math:greek Q" "<Chi>")
  ("math:greek W" "<Omega>")
  ("math:greek W var" "<Mho>")
  ("math:greek V" "<Phi>")

  ("math:bold 0" "<b-0>")
  ("math:bold 1" "<b-1>")
  ("math:bold 2" "<b-2>")
  ("math:bold 3" "<b-3>")
  ("math:bold 4" "<b-4>")
  ("math:bold 5" "<b-5>")
  ("math:bold 6" "<b-6>")
  ("math:bold 7" "<b-7>")
  ("math:bold 8" "<b-8>")
  ("math:bold 9" "<b-9>")
  ("math:bold a" "<b-a>")
  ("math:bold b" "<b-b>")
  ("math:bold c" "<b-c>")
  ("math:bold d" "<b-d>")
  ("math:bold e" "<b-e>")
  ("math:bold f" "<b-f>")
  ("math:bold g" "<b-g>")
  ("math:bold h" "<b-h>")
  ("math:bold i" "<b-i>")
  ("math:bold j" "<b-j>")
  ("math:bold k" "<b-k>")
  ("math:bold l" "<b-l>")
  ("math:bold m" "<b-m>")
  ("math:bold n" "<b-n>")
  ("math:bold o" "<b-o>")
  ("math:bold p" "<b-p>")
  ("math:bold q" "<b-q>")
  ("math:bold r" "<b-r>")
  ("math:bold s" "<b-s>")
  ("math:bold t" "<b-t>")
  ("math:bold u" "<b-u>")
  ("math:bold v" "<b-v>")
  ("math:bold w" "<b-w>")
  ("math:bold x" "<b-x>")
  ("math:bold y" "<b-y>")
  ("math:bold z" "<b-z>")
  ("math:bold A" "<b-A>")
  ("math:bold B" "<b-B>")
  ("math:bold C" "<b-C>")
  ("math:bold D" "<b-D>")
  ("math:bold E" "<b-E>")
  ("math:bold F" "<b-F>")
  ("math:bold G" "<b-G>")
  ("math:bold H" "<b-H>")
  ("math:bold I" "<b-I>")
  ("math:bold J" "<b-J>")
  ("math:bold K" "<b-K>")
  ("math:bold L" "<b-L>")
  ("math:bold M" "<b-M>")
  ("math:bold N" "<b-N>")
  ("math:bold O" "<b-O>")
  ("math:bold P" "<b-P>")
  ("math:bold Q" "<b-Q>")
  ("math:bold R" "<b-R>")
  ("math:bold S" "<b-S>")
  ("math:bold T" "<b-T>")
  ("math:bold U" "<b-U>")
  ("math:bold V" "<b-V>")
  ("math:bold W" "<b-W>")
  ("math:bold X" "<b-X>")
  ("math:bold Y" "<b-Y>")
  ("math:bold Z" "<b-Z>")
  ("math:bold i var" "<b-imath>")
  ("math:bold j var" "<b-jmath>")
  ("math:bold l var" "<b-ell>")

  ("math:bold:greek a" "<b-alpha>")
  ("math:bold:greek b" "<b-beta>")
  ("math:bold:greek g" "<b-gamma>")
  ("math:bold:greek d" "<b-delta>")
  ("math:bold:greek e" "<b-varepsilon>")
  ("math:bold:greek e var" "<b-epsilon>")
  ("math:bold:greek e var var" "<b-backepsilon>")
  ("math:bold:greek z" "<b-zeta>")
  ("math:bold:greek h" "<b-eta>")
  ("math:bold:greek j" "<b-theta>")
  ("math:bold:greek j var" "<b-vartheta>")
  ("math:bold:greek i" "<b-iota>")
  ("math:bold:greek k" "<b-kappa>")
  ("math:bold:greek k var" "<b-varkappa>")
  ("math:bold:greek l" "<b-lambda>")
  ("math:bold:greek m" "<b-mu>")
  ("math:bold:greek n" "<b-nu>")
  ("math:bold:greek x" "<b-xi>")
  ("math:bold:greek o" "<b-omicron>")
  ("math:bold:greek p" "<b-pi>")
  ("math:bold:greek p var" "<b-varpi>")
  ("math:bold:greek r" "<b-rho>")
  ("math:bold:greek r var" "<b-varrho>")
  ("math:bold:greek s" "<b-sigma>")
  ("math:bold:greek s var" "<b-varsigma>")
  ("math:bold:greek c" "<b-varsigma>")
  ("math:bold:greek c var" "<b-sigma>")
  ("math:bold:greek t" "<b-tau>")
  ("math:bold:greek u" "<b-upsilon>")
  ("math:bold:greek f" "<b-varphi>")
  ("math:bold:greek f var" "<b-phi>")
  ("math:bold:greek y" "<b-psi>")
  ("math:bold:greek q" "<b-chi>")
  ("math:bold:greek w" "<b-omega>")
  ("math:bold:greek w var" "<b-mho>")
  ("math:bold:greek v" "<b-phi>")
  ("math:bold:greek v var" "<b-varphi>")
  ("math:bold:greek A" "<b-Alpha>")
  ("math:bold:greek B" "<b-Beta>")
  ("math:bold:greek G" "<b-Gamma>")
  ("math:bold:greek D" "<b-Delta>")
  ("math:bold:greek E" "<b-Epsilon>")
  ("math:bold:greek E var" "<b-Backepsilon>")
  ("math:bold:greek Z" "<b-Zeta>")
  ("math:bold:greek H" "<b-Eta>")
  ("math:bold:greek J" "<b-Theta>")
  ("math:bold:greek I" "<b-Iota>")
  ("math:bold:greek K" "<b-Kappa>")
  ("math:bold:greek L" "<b-Lambda>")
  ("math:bold:greek M" "<b-Mu>")
  ("math:bold:greek N" "<b-Nu>")
  ("math:bold:greek X" "<b-Xi>")
  ("math:bold:greek O" "<b-Omicron>")
  ("math:bold:greek P" "<b-Pi>")
  ("math:bold:greek R" "<b-Rho>")
  ("math:bold:greek S" "<b-Sigma>")
  ("math:bold:greek C" "<b-Sigma>")
  ("math:bold:greek T" "<b-Tau>")
  ("math:bold:greek U" "<b-Upsilon>")
  ("math:bold:greek F" "<b-Phi>")
  ("math:bold:greek Y" "<b-Psi>")
  ("math:bold:greek Q" "<b-Chi>")
  ("math:bold:greek W" "<b-Omega>")
  ("math:bold:greek W var" "<b-Mho>")
  ("math:bold:greek V" "<b-Phi>")

  ("math:cal A" "<cal-A>")
  ("math:cal B" "<cal-B>")
  ("math:cal C" "<cal-C>")
  ("math:cal D" "<cal-D>")
  ("math:cal E" "<cal-E>")
  ("math:cal F" "<cal-F>")
  ("math:cal G" "<cal-G>")
  ("math:cal H" "<cal-H>")
  ("math:cal I" "<cal-I>")
  ("math:cal J" "<cal-J>")
  ("math:cal K" "<cal-K>")
  ("math:cal L" "<cal-L>")
  ("math:cal M" "<cal-M>")
  ("math:cal N" "<cal-N>")
  ("math:cal O" "<cal-O>")
  ("math:cal P" "<cal-P>")
  ("math:cal Q" "<cal-Q>")
  ("math:cal R" "<cal-R>")
  ("math:cal S" "<cal-S>")
  ("math:cal T" "<cal-T>")
  ("math:cal U" "<cal-U>")
  ("math:cal V" "<cal-V>")
  ("math:cal W" "<cal-W>")
  ("math:cal X" "<cal-X>")
  ("math:cal Y" "<cal-Y>")
  ("math:cal Z" "<cal-Z>")

  ("math:bold:cal A" "<b-cal-A>")
  ("math:bold:cal B" "<b-cal-B>")
  ("math:bold:cal C" "<b-cal-C>")
  ("math:bold:cal D" "<b-cal-D>")
  ("math:bold:cal E" "<b-cal-E>")
  ("math:bold:cal F" "<b-cal-F>")
  ("math:bold:cal G" "<b-cal-G>")
  ("math:bold:cal H" "<b-cal-H>")
  ("math:bold:cal I" "<b-cal-I>")
  ("math:bold:cal J" "<b-cal-J>")
  ("math:bold:cal K" "<b-cal-K>")
  ("math:bold:cal L" "<b-cal-L>")
  ("math:bold:cal M" "<b-cal-M>")
  ("math:bold:cal N" "<b-cal-N>")
  ("math:bold:cal O" "<b-cal-O>")
  ("math:bold:cal P" "<b-cal-P>")
  ("math:bold:cal Q" "<b-cal-Q>")
  ("math:bold:cal R" "<b-cal-R>")
  ("math:bold:cal S" "<b-cal-S>")
  ("math:bold:cal T" "<b-cal-T>")
  ("math:bold:cal U" "<b-cal-U>")
  ("math:bold:cal V" "<b-cal-V>")
  ("math:bold:cal W" "<b-cal-W>")
  ("math:bold:cal X" "<b-cal-X>")
  ("math:bold:cal Y" "<b-cal-Y>")
  ("math:bold:cal Z" "<b-cal-Z>")

  ("math:frak a" "<frak-a>")
  ("math:frak b" "<frak-b>")
  ("math:frak c" "<frak-c>")
  ("math:frak d" "<frak-d>")
  ("math:frak e" "<frak-e>")
  ("math:frak f" "<frak-f>")
  ("math:frak g" "<frak-g>")
  ("math:frak h" "<frak-h>")
  ("math:frak i" "<frak-i>")
  ("math:frak i var" "<frak-imath>")
  ("math:frak j" "<frak-j>")
  ("math:frak j var" "<frak-jmath>")
  ("math:frak k" "<frak-k>")
  ("math:frak l" "<frak-l>")
  ("math:frak m" "<frak-m>")
  ("math:frak n" "<frak-n>")
  ("math:frak o" "<frak-o>")
  ("math:frak p" "<frak-p>")
  ("math:frak q" "<frak-q>")
  ("math:frak r" "<frak-r>")
  ("math:frak s" "<frak-s>")
  ("math:frak t" "<frak-t>")
  ("math:frak u" "<frak-u>")
  ("math:frak v" "<frak-v>")
  ("math:frak w" "<frak-w>")
  ("math:frak x" "<frak-x>")
  ("math:frak y" "<frak-y>")
  ("math:frak z" "<frak-z>")
  ("math:frak A" "<frak-A>")
  ("math:frak B" "<frak-B>")
  ("math:frak C" "<frak-C>")
  ("math:frak D" "<frak-D>")
  ("math:frak E" "<frak-E>")
  ("math:frak F" "<frak-F>")
  ("math:frak G" "<frak-G>")
  ("math:frak H" "<frak-H>")
  ("math:frak I" "<frak-I>")
  ("math:frak J" "<frak-J>")
  ("math:frak K" "<frak-K>")
  ("math:frak L" "<frak-L>")
  ("math:frak M" "<frak-M>")
  ("math:frak N" "<frak-N>")
  ("math:frak O" "<frak-O>")
  ("math:frak P" "<frak-P>")
  ("math:frak Q" "<frak-Q>")
  ("math:frak R" "<frak-R>")
  ("math:frak S" "<frak-S>")
  ("math:frak T" "<frak-T>")
  ("math:frak U" "<frak-U>")
  ("math:frak V" "<frak-V>")
  ("math:frak W" "<frak-W>")
  ("math:frak X" "<frak-X>")
  ("math:frak Y" "<frak-Y>")
  ("math:frak Z" "<frak-Z>")

  ("math:bbb a" "<bbb-a>")
  ("math:bbb b" "<bbb-b>")
  ("math:bbb c" "<bbb-c>")
  ("math:bbb d" "<bbb-d>")
  ("math:bbb e" "<bbb-e>")
  ("math:bbb f" "<bbb-f>")
  ("math:bbb g" "<bbb-g>")
  ("math:bbb h" "<bbb-h>")
  ("math:bbb i" "<bbb-i>")
  ("math:bbb j" "<bbb-j>")
  ("math:bbb k" "<bbb-k>")
  ("math:bbb l" "<bbb-l>")
  ("math:bbb m" "<bbb-m>")
  ("math:bbb n" "<bbb-n>")
  ("math:bbb o" "<bbb-o>")
  ("math:bbb p" "<bbb-p>")
  ("math:bbb q" "<bbb-q>")
  ("math:bbb r" "<bbb-r>")
  ("math:bbb s" "<bbb-s>")
  ("math:bbb t" "<bbb-t>")
  ("math:bbb u" "<bbb-u>")
  ("math:bbb v" "<bbb-v>")
  ("math:bbb w" "<bbb-w>")
  ("math:bbb x" "<bbb-x>")
  ("math:bbb y" "<bbb-y>")
  ("math:bbb z" "<bbb-z>")
  ("math:bbb A" "<bbb-A>")
  ("math:bbb B" "<bbb-B>")
  ("math:bbb C" "<bbb-C>")
  ("math:bbb D" "<bbb-D>")
  ("math:bbb E" "<bbb-E>")
  ("math:bbb F" "<bbb-F>")
  ("math:bbb G" "<bbb-G>")
  ("math:bbb H" "<bbb-H>")
  ("math:bbb I" "<bbb-I>")
  ("math:bbb J" "<bbb-J>")
  ("math:bbb K" "<bbb-K>")
  ("math:bbb L" "<bbb-L>")
  ("math:bbb M" "<bbb-M>")
  ("math:bbb N" "<bbb-N>")
  ("math:bbb O" "<bbb-O>")
  ("math:bbb P" "<bbb-P>")
  ("math:bbb Q" "<bbb-Q>")
  ("math:bbb R" "<bbb-R>")
  ("math:bbb S" "<bbb-S>")
  ("math:bbb T" "<bbb-T>")
  ("math:bbb U" "<bbb-U>")
  ("math:bbb V" "<bbb-V>")
  ("math:bbb W" "<bbb-W>")
  ("math:bbb X" "<bbb-X>")
  ("math:bbb Y" "<bbb-Y>")
  ("math:bbb Z" "<bbb-Z>"))

(kbd-map in-math-not-hybrid?
  ("a var" "<alpha>")
  ("b var" "<beta>")
  ("b var var" "<flat>")
  ("s var var" "<varsigma>")
  ("c var" "<varsigma>")
  ("d var" "<delta>")
  ("d var var" "<mathd>")
  ("d var var var" "<partial>")
  ("e var" "<varepsilon>")
  ("e var var" "<mathe>")
  ("e var var var" "<epsilon>")
  ("e var var var var" "<backepsilon>")
  ("v var var" "<varphi>")
  ("f var" "<varphi>")
  ("g var" "<gamma>")
  ("h var" "<eta>")
  ("h var var" "<hbar>")
  ("i var" "<iota>")
  ("i var var" "<mathi>")
  ("i var var var" "<imath>")
  ("j var" "<theta>")
  ("j var var" "<jmath>")
  ("j var var var" "<vartheta>")
  ("k var" "<kappa>")
  ("k var var" "<varkappa>")
  ("l var" "<lambda>")
  ("l var var" "<ell>")
  ("m var" "<mu>")
  ("n var" "<nu>")
  ("o var" "<omicron>")
  ("p var" "<pi>")
  ("p var var" "<mathpi>")
  ("p var var var" "<varpi>")
  ("q var" "<chi>")
  ("r var" "<rho>")
  ("r var var" "<varrho>")
  ("c var var" "<sigma>")
  ("s var" "<sigma>")
  ("t var" "<tau>")
  ("u var" "<upsilon>")
  ("f var var" "<phi>")
  ("v var" "<phi>")
  ("w var" "<omega>")
  ("w var var" "<mho>")
  ("x var" "<xi>")
  ("y var" "<psi>")
  ("z var" "<zeta>")

  ("A var" "<Alpha>")
  ("A var var" "<forall>")
  ("A var var avr" "<aleph>")
  ("B var" "<Beta>")
  ("B var var" "<bot>")
  ("B var var var" "<beth>")
  ("C var" "<Sigma>")
  ("D var" "<Delta>")
  ("D var var" "<mathD>")
  ("D var var var" "<daleth>")
  ("E var" "<Epsilon>")
  ("E var var" "<exists>")
  ("E var var var" "<Backepsilon>")
  ("F var" "<Phi>")
  ("G var" "<Gamma>")
  ("G var var" "<gimel>")
  ("H var" "<Eta>")
  ("I var" "<Iota>")
  ("J var" "<Theta>")
  ("K var" "<Kappa>")
  ("L var" "<Lambda>")
  ("M var" "<Mu>")
  ("N var" "<Nu>")
  ("O var" "<Omicron>")
  ("P var" "<Pi>")
  ("P var var" "<wp>")
  ("Q var" "<Chi>")
  ("R var" "<Rho>")
  ("S var" "<Sigma>")
  ("T var" "<Tau>")
  ("T var var" "<top>")
  ("U var" "<Upsilon>")
  ("V var" "<Phi>")
  ("W var" "<Omega>")
  ("W var var" "<Mho>")
  ("X var" "<Xi>")
  ("Y var" "<Psi>")
  ("Z var" "<Zeta>"))

(kbd-map like-old-math?
  ("math L" "" "Insert a left script")

  ("math B" (make-wide "<bar>"))
  ("math a B" (make-wide "<wide-bar>"))
  ("math b B" (make-wide-under "<wide-bar>"))
  ("math V" (make-wide "<vect>"))
  ("math C" (make-wide "<check>"))
  ("math U" (make-wide "<breve>"))
  ("math L _" (make-script #f #f))
  ("math L ^" (make-script #t #f))
  ("math F" (make-fraction))
  ("math S" (make-sqrt))
  ("math R" (make-var-sqrt))
  ("math N" (make-neg))
  ("math A" (make-tree))
  ("math s o" (make 'op)))
