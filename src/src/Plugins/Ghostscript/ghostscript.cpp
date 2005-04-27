
/******************************************************************************
* MODULE     : ghostscript.cpp
* DESCRIPTION: interface with ghostscript
* COPYRIGHT  : (C) 1999  Joris van der Hoeven
*******************************************************************************
* This software falls under the GNU general public license and comes WITHOUT
* ANY WARRANTY WHATSOEVER. See the file $TEXMACS_PATH/LICENSE for more details.
* If you don't have this file, write to the Free Software Foundation, Inc.,
* 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
******************************************************************************/

#include "Ghostscript/ghostscript.hpp"
#include "file.hpp"
#include "image_files.hpp"

/******************************************************************************
* Special hack for a bug in Ghostscript 6.50, 6.51 and 6.52
******************************************************************************/

static int gs_type= -1;
  // -1: uninitialized
  //  0: OK
  //  1: with pixmap bug

bool
ghostscript_bugged () {
  if (gs_type == -1) {
    string gs_version= var_eval_system ("gs --version");
    gs_type= 0;
    if ((gs_version == "6.50") ||
	(gs_version == "6.51") ||
	(gs_version == "6.52"))
      gs_type= 1;
  }
  return (gs_type == 1);
}

/******************************************************************************
* Drawing a postscript image file in a pixmap
******************************************************************************/

static string
encapsulate_postscript (string s) {
  int i, n=N(s);
  string r;
  for (i=0; i<n; ) {
    if ((i<(n-8)) && (s(i,i+8)=="showpage")) {i+=8; continue;}
    r << s[i++];
  }
  return r;
}

void
ghostscript_run (Display* dpy, Window gs_win, Pixmap pm,
		 url image, SI w, SI h, int x1, int y1, int x2, int y2)
{
  int win_id= (int) gs_win;
  int pix_id= (int) pm;
  if (ghostscript_bugged ()) set_env ("GHOSTVIEW", as_string (win_id));
  else set_env ("GHOSTVIEW", as_string (win_id) * " " * as_string (pix_id));
  Atom gh= XInternAtom (dpy, "GHOSTVIEW", false);
  Atom st= XA_STRING;
  double dpi_x= ((double) (w*72))/((double) (x2-x1));
  double dpi_y= ((double) (h*72))/((double) (y2-y1));
  string data=
    (ghostscript_bugged ()? as_string (pix_id): string ("0")) * " 0 " *
    as_string (x1) * " " * as_string (y1) * " " *
    as_string (x2) * " " * as_string (y2) * " " *
    as_string (dpi_x) * " " * as_string (dpi_y) * " " *
    "0 0 0 0";
  unsigned char* _data= (unsigned char*) as_charp (data);
  int _n= N(data);
  XChangeProperty (dpy, gs_win, gh, st, 8, PropModeReplace, _data, _n);
  delete[] _data;
  XSync(dpy, false);
  string raw_ps, nice_ps;
  raw_ps= ps_load (image);
  nice_ps= encapsulate_postscript (raw_ps);
  url temp_name= url_temp ();
  save_string (temp_name, nice_ps, true);
  system ("tm_gs", temp_name);
  remove (temp_name);
}
