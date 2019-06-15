<TeXmacs|1.99.9>

<style|source>

<\body>
  <active*|<\src-title>
    <src-package-dtd|ice-combo|1.0|ice-combo|1.0>

    <\src-purpose>
      Ice theme for presentations and posters.
    </src-purpose>

    <src-copyright|2013--2019|Joris van der Hoeven>

    <\src-license>
      This software falls under the <hlink|GNU general public license,
      version 3 or later|$TEXMACS_PATH/LICENSE>. It comes WITHOUT ANY
      WARRANTY WHATSOEVER. You should have received a copy of the license
      which the software. If not, see <hlink|http://www.gnu.org/licenses/gpl-3.0.html|http://www.gnu.org/licenses/gpl-3.0.html>.
    </src-license>
  </src-title>>

  <use-package|bluish-combo|natural-ice-deco>

  <copy-theme|ice|bluish>

  <select-theme|ice|natural-ice>

  <\active*>
    <\src-comment>
      Text colors
    </src-comment>
  </active*>

  <assign|ice-strong-color|#602060>

  <assign|ice-math-color|#503050>

  <\active*>
    <\src-comment>
      Titles
    </src-comment>
  </active*>

  <assign|ice-title-bar-color|<macro|<pattern|ice-dark-blue.png|*3/5|*3/5|dark
  blue>>>

  <assign|ice-title-color|<macro|<pattern|ice-light.png|*3/5|*3/5|#f0f0f0>>>

  <\active*>
    <\src-comment>
      Sessions
    </src-comment>
  </active*>

  <assign|ice-input-color|<pattern|ice-medium.png|*3/5|*3/5|pastel grey>>

  <assign|ice-fold-bar-color|<pattern|ice-dark-blue.png|*3/5|*3/5|dark blue>>

  <assign|ice-fold-title-color|<pattern|ice-medium-blue.png|*3/5|*3/5|pastel
  blue>>

  <\active*>
    <\src-comment>
      Posters
    </src-comment>
  </active*>

  <assign|ice-title-block|<value|natural-ice-block>>

  <assign|ice-framed-block|<value|natural-ice-block>>

  <assign|ice-framed-block*|<value|natural-ice-titled-block>>
</body>

<\initial>
  <\collection>
    <associate|sfactor|7>
  </collection>
</initial>