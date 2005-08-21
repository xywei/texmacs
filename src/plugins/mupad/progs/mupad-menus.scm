
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : mupad-menus.scm
;; DESCRIPTION : Mupad menus
;; COPYRIGHT   : (C) 1999  Andrey Grozin and Joris van der Hoeven,
;;                   2003  MuPAD group & SciFace Software GmbH
;;
;; This software falls under the GNU general public license and comes WITHOUT
;; ANY WARRANTY WHATSOEVER. See the file $TEXMACS_PATH/LICENSE for details.
;; If you don't have this file, write to the Free Software Foundation, Inc.,
;; 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(texmacs-module (mupad-menus))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Several subroutines for the evaluation of Mupad expressions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(tm-define (plugin-output-simplify name t)
  (:require (== name "mupad"))
  (cond ((match? t '(concat (with "mode" "math" "math-display" "true" :1) :*))
	 `(math ,(plugin-output-simplify name (tm-ref t 0 4))))
	(else (plugin-output-std-simplify name t))))

(define mupad-apply script-apply)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The Mupad menu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(menu-bind mupad-menu
  (if (not-in-session?)
      (link scripts-eval-menu)
      ---)
  (-> "Elementary functions"
      ("exp" (mupad-apply "exp"))
      ("log" (mupad-apply "log"))
      ("sqrt" (mupad-apply "sqrt"))
      ---
      ("cos" (mupad-apply "cos"))
      ("sin" (mupad-apply "sin"))
      ("tan" (mupad-apply "tan"))
      ("arccos" (mupad-apply "arccos"))
      ("arcsin" (mupad-apply "arcsin"))
      ("arctan" (mupad-apply "arctan"))
      ---
      ("ch" (mupad-apply "cosh"))
      ("sh" (mupad-apply "sinh"))
      ("th" (mupad-apply "tanh")))
  (-> "Transcendental functions"
      ("Gamma" (mupad-apply "Gamma"))
      ("Zeta" (mupad-apply "zeta")))
  (-> "Number theoretical functions"
      ("Factor" (mupad-apply "factor"))
      ("Gcd" (mupad-apply "gcd"))
      ("Lcm" (mupad-apply "lcm")))
  (-> "Calculus"
      ("Differentiate" (mupad-apply "diff" 2))
      ("Integrate" (mupad-apply "int" 2)))
  (if (not-in-session?)
      ---
      (link scripts-eval-toggle-menu)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Help menus
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (mupad-show-help arg)
  (with root (var-eval-system "mupad -r")
    (system (string-append "mxdvi " root "/share/doc/dvi/" arg " &"))))

(menu-bind mupad-help-menu
  ("Tutorial" (mupad-show-help "tutorium"))
  ("Quick reference" (mupad-show-help "quickref"))
  ("Standard library" (mupad-show-help "stdlib"))
  ("What's new" (mupad-show-help "changes"))
  ("SciLab interface" (mupad-show-help "scilab"))
  ---
  ("Solving equations" (mupad-show-help "solvelib"))
  ("Numerical calculations" (mupad-show-help "numeric"))
  ("Plots" (mupad-show-help "plot"))
  ---
  (-> "Algebra" (link mupad-help-algebra))
  (-> "Polynomials" (link mupad-help-polynomials))
  (-> "Calculus" (link mupad-help-calculus))
  (-> "Programming" (link mupad-help-programming))
  (-> "Domains" (link mupad-help-domains))
  (-> "Input-output" (link mupad-help-io)))

(menu-bind mupad-help-algebra
  ("Linear algebra" (mupad-show-help "linalg"))
  ("Linear optimization" (mupad-show-help "linopt"))
  ("Number theory" (mupad-show-help "numlib"))
  ("Combinatorics" (mupad-show-help "combinat"))
  ("Graph theory" (mupad-show-help "Network"))
  ("Statistics" (mupad-show-help "stats"))
  ("Miscellania" (mupad-show-help "misc")))

(menu-bind mupad-help-polynomials
  ("Polynomials" (mupad-show-help "polylib"))
  ("Orthogonal polynomials" (mupad-show-help "orthpoly"))
  ("Groebner bases" (mupad-show-help "groebner")))

(menu-bind mupad-help-calculus
  ("Integration" (mupad-show-help "intlib"))
  ("Educational tools" (mupad-show-help "student"))
  ("Integral transforms" (mupad-show-help "transform"))
  ("Differential equations" (mupad-show-help "detools")))

(menu-bind mupad-help-programming
  ("Data types" (mupad-show-help "datatypes"))
  ("Strings" (mupad-show-help "stringlib"))
  ("Lists" (mupad-show-help "listlib"))
  ("Programmer's toolbox" (mupad-show-help "prog"))
  ("Abstract data types" (mupad-show-help "adt"))
  ("Functional programming" (mupad-show-help "fp"))
  ("Type checking" (mupad-show-help "Type"))
  ("Properties" (mupad-show-help "property"))
  ("Pattern matching" (mupad-show-help "matchlib"))
  ("User preferences" (mupad-show-help "Pref"))
  ("Dynamic modules" (mupad-show-help "module")))

(menu-bind mupad-help-domains
  ("Axioms, categories and domains" (mupad-show-help "domainref"))
  ("Domains" (mupad-show-help "Dom"))
  ("Categories" (mupad-show-help "Cat"))
  ("Axioms" (mupad-show-help "Ax")))

(menu-bind mupad-help-io
  ("Formatted output" (mupad-show-help "output"))
  ("Importing data" (mupad-show-help "import"))
  ("Generating input for other programs"
   (mupad-show-help "generate")))
