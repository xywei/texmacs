<TeXmacs|1.99.9>

<style|source>

<\body>
  <active*|<\src-title>
    <src-package-dtd|stone-granite-ornament|1.0|stone-granite-ornament|1.0>

    <\src-purpose>
      Granite ornament for presentations and posters.
    </src-purpose>

    <src-copyright|2013--2019|Joris van der Hoeven>

    <\src-license>
      This software falls under the <hlink|GNU general public license,
      version 3 or later|$TEXMACS_PATH/LICENSE>. It comes WITHOUT ANY
      WARRANTY WHATSOEVER. You should have received a copy of the license
      which the software. If not, see <hlink|http://www.gnu.org/licenses/gpl-3.0.html|http://www.gnu.org/licenses/gpl-3.0.html>.
    </src-license>
  </src-title>>

  <use-package|dark-combo>

  <copy-theme|stone-granite|dark-ornament>

  <assign|granite|<macro|x|<with-stone-granite|<ornament|<arg|x>>>>>

  <\active*>
    <\src-comment>
      The ornament
    </src-comment>
  </active*>

  <assign|stone-granite-ornament-color|<pattern|granite-dark.png|*3/5|*3/5|#101010>>

  <assign|stone-granite-ornament-extra-color|<pattern|granite-medium.png|*3/5|*3/5|#202020>>

  <assign|stone-granite-ornament-title-color|gold>

  <assign|stone-granite-ornament-sunny-color|light grey>

  <assign|stone-granite-ornament-shadow-color|dark grey>

  <\active*>
    <\src-comment>
      Text colors
    </src-comment>
  </active*>

  <assign|stone-granite-strong-color|#f0ffb0>

  <assign|stone-granite-math-color|#ffd4c0>
</body>

<\initial>
  <\collection>
    <associate|sfactor|7>
  </collection>
</initial>