
/******************************************************************************
* MODULE     : bitmap_font.cpp
* DESCRIPTION: bitmap fonts
* COPYRIGHT  : (C) 1999  Joris van der Hoeven
*******************************************************************************
* This software falls under the GNU general public license and comes WITHOUT
* ANY WARRANTY WHATSOEVER. See the file $TEXMACS_PATH/LICENSE for more details.
* If you don't have this file, write to the Free Software Foundation, Inc.,
* 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
******************************************************************************/

#include "bitmap_font.hpp"

RESOURCE_CODE(font_metric);
RESOURCE_CODE(font_glyphs);

/******************************************************************************
* font_metrics
******************************************************************************/

font_metric_rep::font_metric_rep (string name):
  rep<font_metric> (name), bad_font_metric (false) {}

font_metric_rep::~font_metric_rep () {
  fatal_error ("not yet implemented",
	       "font_metric_rep::~font_metric_rep",
	       "font_metric.cpp");
}

/******************************************************************************
* Standard bitmap metrics
******************************************************************************/

static metric error_metric;

struct std_font_metric_rep: public font_metric_rep {
  int bc, ec;
  metric* fnm;

  std_font_metric_rep (string name, metric* fnm, int bc, int ec);
  metric& get (int char_code);
};

std_font_metric_rep::std_font_metric_rep (
  string name, metric* fnm2, int bc2, int ec2):
    font_metric_rep (name), bc (bc2), ec (ec2), fnm (fnm2)
{
  error_metric->x1= error_metric->y1= 0;
  error_metric->x2= error_metric->y2= 0;
  error_metric->x3= error_metric->y3= 0;
  error_metric->x4= error_metric->y4= 0;
}

metric&
std_font_metric_rep::get (int c) {
  if ((c<bc) || (c>ec)) return error_metric;
  return fnm [c-bc];
}

font_metric
std_font_metric (string name, metric* fnm, int bc, int ec) {
  return make (font_metric, name,
	       new std_font_metric_rep (name, fnm, bc, ec));
}

/******************************************************************************
* font_glyphs
******************************************************************************/

font_glyphs_rep::font_glyphs_rep (string name):
  rep<font_glyphs> (name), bad_font_glyphs (false) {}

font_glyphs_rep::~font_glyphs_rep () {
  fatal_error ("not yet implemented",
	       "font_glyphs_rep::~font_glyphs_rep",
	       "font_glyphs.cpp");
}

/******************************************************************************
* Standard bitmap fonts
******************************************************************************/

static glyph error_glyph;

struct std_font_glyphs_rep: public font_glyphs_rep {
  int bc, ec;
  glyph* fng; // definitions of the characters

  std_font_glyphs_rep (string name, glyph* fng, int bc, int ec);
  glyph& get (int char_code);
};

std_font_glyphs_rep::std_font_glyphs_rep (
  string name, glyph* fng2, int bc2, int ec2):
    font_glyphs_rep (name), bc (bc2), ec (ec2), fng (fng2) {}

glyph&
std_font_glyphs_rep::get (int c) {
  if ((c<bc) || (c>ec)) return error_glyph;
  return fng [c-bc];
}

font_glyphs
std_font_glyphs (string name, glyph* fng, int bc, int ec) {
  return make (font_glyphs, name, new std_font_glyphs_rep (name, fng, bc, ec));
}
