
/******************************************************************************
* MODULE     : image_files.cpp
* DESCRIPTION: image file handling
* COPYRIGHT  : (C) 1999-2016  Joris van der Hoeven & the TeXmacs team
*******************************************************************************
* This software falls under the GNU general public license version 3 or later.
* It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
* in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
*******************************************************************************
* 
* This module centralizes functions that pick the best way to perfom
* common operations on external images depending on their type and the
* availability of various other modules (Qt, gs, pdf renderer ...) : 
* 
* -determining original image size (and caching it)
* -various conversions using (preferentially) internal methods or
*    calling external tools (including converters defined in the
*    scheme code, and in last resort ImageMagick )
* 
* Other modules (let say gs or pdf-renderer) should use only functions
* implemented here (implement new ones if needed) and refrain from
* calling directly other tools or converters (for instance qt,
* scheme converters or imagemagick) because this leads to fragmentary
* special cases and code duplication that are hard to maintain and debug
* 
******************************************************************************/

#include "file.hpp"
#include "image_files.hpp"
#include "web_files.hpp"
#include "sys_utils.hpp"
#include "analyze.hpp"
#include "hashmap.hpp"
#include "scheme.hpp"
#include "Imlib2/imlib2.hpp"

#ifdef MACOSX_EXTENSIONS
#include "MacOS/mac_images.h"
#endif

#ifdef QTTEXMACS
#include "Qt/qt_utilities.hpp"
#endif

#ifdef OS_WIN32
#include <x11/xlib.h>
#endif

#ifdef USE_GS
#include "Ghostscript/gs_utilities.hpp"
#endif

#ifdef PDF_RENDERER
#include "Pdf/pdf_hummus_renderer.hpp"
#endif
typedef struct { int xmin; int ymin; int xmax; int ymax; } bbox ;
hashmap<tree,bbox> ps_bbox;
typedef struct { int wid; int hei;} imsize ;
hashmap<tree,imsize> imagesize; //TODO : provide a way to reset this when "document update all"

/******************************************************************************
* Loading xpm pixmaps
******************************************************************************/

tree
xpm_load (url u) {
  string s;
  load_string ("$TEXMACS_PIXMAP_PATH" * u, s, false);
  if (s == "") load_string ("$TEXMACS_PATH/misc/pixmaps/TeXmacs.xpm", s, true);

  int i, j;
  tree t (TUPLE);
  for (i=0; i<N(s); i++)
    if (s[i]=='\x22') {
      i++;
      j=i;
      while ((i<N(s)) && (s[i]!='\x22')) i++;
      t << s (j, i);
    }
  if (N(t)==0) return xpm_load ("$TEXMACS_PATH/misc/pixmaps/TeXmacs.xpm");
  return t;
}

void
xpm_size (url u, int& w, int& h) {
  static hashmap<string,string> xpm_size_table ("");
  string file_name= as_string (u);
  if (!xpm_size_table->contains (file_name)) {
    tree t= xpm_load (u);
    xpm_size_table (file_name)= t[0]->label;
  }

  int i= 0;
  bool ok;
  string s= xpm_size_table[file_name];
  skip_spaces (s, i);
  ok= read_int (s, i, w);
  skip_spaces (s, i);
  ok= read_int (s, i, h) && ok;
  if (!ok) {
    failed_error << "File name= " << file_name << "\n";
    FAILED ("invalid xpm");
  }
}

array<string>
xpm_colors (tree t) {
  array<string> res(0);
  string s= t[0]->label;
  int ok, i=0, j, k, w, h, c, b;
  skip_spaces (s, i);
  ok= read_int (s, i, w);
  skip_spaces (s, i);
  ok= read_int (s, i, h) && ok;
  skip_spaces (s, i);
  ok= read_int (s, i, c) && ok;
  skip_spaces (s, i);
  ok= read_int (s, i, b) && ok;
  ASSERT (ok && N(t)>c && c>0, "invalid xpm tree");

  for (k=0; k<c; k++) {
    string s   = as_string (t[k+1]);
    string def = "none";
    if (N(s)<b) i=N(s); else i=b;

    skip_spaces (s, i);
    if ((i<N(s)) && (s[i]=='s')) {
      i++;
      skip_spaces (s, i);
      while ((i<N(s)) && (s[i]!=' ') && (s[i]!='\t')) i++;
      skip_spaces (s, i);
    }
    if ((i<N(s)) && (s[i]=='c')) {
      i++;
      skip_spaces (s, i);
      j=i;
      while ((i<N(s)) && (s[i]!=' ') && (s[i]!='\t')) i++;
      def= locase_all (s (j, i));
    }
    res<<def;
  }
  return res;
}

array<SI>
xpm_hotspot (tree t) {
  array<SI> res(0);
  string s= t[0]->label;
  int ok, i=0, w, h, c, b, x, y;
  skip_spaces (s, i);
  ok= read_int (s, i, w);
  skip_spaces (s, i);
  ok= read_int (s, i, h) && ok;
  skip_spaces (s, i);
  ok= read_int (s, i, c) && ok;
  skip_spaces (s, i);
  ok= read_int (s, i, b) && ok;
  ASSERT (ok && N(t)>c && c>0, "invalid xpm tree");

  skip_spaces (s, i);
  ok= read_int (s, i, x) && ok;
  skip_spaces (s, i);
  ok= read_int (s, i, y) && ok;
  if (ok) {
    res<<x;
    res<<y;
  }
  return res;
}

/******************************************************************************
* Loading postscript files (possibly triggering conversion to postscript)
******************************************************************************/

string
ps_load (url image) {
  if (DEBUG_CONVERT) debug_convert << "ps_load " << image << LF;

  url name= resolve (image);
  if (is_none (name))
    name= "$TEXMACS_PATH/misc/pixmaps/unknown.ps";

#ifdef OS_WIN32
  if (is_ramdisc (name)) name= get_from_ramdisc (name);
#endif

  string s, suf= suffix (image);
  if (suf == "ps" || suf == "eps") 
    load_string (image, s, false);
  else 
    s= image_to_psdoc (image); // call converters, then load resulting ps

  if (s == "") load_string ("$TEXMACS_PATH/misc/pixmaps/unknown.ps", s, true);
  return s;
}

void
ps_bounding_box (url image, int& x1, int& y1, int& x2, int& y2) {
  tree lookup= image->t;
  if (ps_bbox->contains (lookup)) {
    bbox box= ps_bbox [lookup];
    x1= box.xmin; y1= box.ymin;
    x2= box.xmax; y2= box.ymax;
  }
  else {
    string s= ps_load (image);// this would actually convert to eps if
    // this function were called with a non-ps file suffix (which should not happen)
    if (!ps_read_bbox (s,x1, y1, x2,y2 )) {
      x1= y1= 0; x2= 596; y2= 842;
      }
    else {
      ps_bbox (lookup)= (bbox) {x1,y1,x2,y2};
      imagesize (lookup)= (imsize) {x2-x1,y2-y1};
    }  
  }
}

bool
ps_read_bbox (string buf, int& x1, int& y1, int& x2, int& y2 ) {
  int pos= search_forwards ("\n%%BoundingBox:", buf);
  if (pos < 0) pos = search_forwards ("%%BoundingBox:", buf);
  if (pos < 0) return false;
  if (buf[pos] == '\n') pos++;
  bool ok= read (buf, pos, "%%BoundingBox:");
  double X1, Y1, X2, Y2;
  skip_spaces (buf, pos);
  ok= read_double (buf, pos, X1) && ok;
  x1= (int) floor (X1);
  skip_spaces (buf, pos);
  ok= read_double (buf, pos, Y1) && ok;
  y1= (int) floor (Y1);
  skip_spaces (buf, pos);
  ok= read_double (buf, pos, X2) && ok;
  x2= (int) ceil (X2);
  skip_spaces (buf, pos);
  ok= read_double (buf, pos, Y2) && ok;
  y2= (int) ceil (Y2);
  if (DEBUG_CONVERT) debug_convert<< "bbox found : " <<ok << " : "<< x1<<" , "<<y1<<" , "<<x2<<" , "<<y2<<LF;
  if (!ok) return false;
  return true;
}


/******************************************************************************
* Getting the original size of an image, using internal plug-ins if possible
******************************************************************************/
void  image_size_sub (url image, int& w, int& h);

void
image_size (url image, int& w, int& h) {
/* Get original image size (in pt units) using cached result if possible,
* otherwise actually fetch image size and cache it.
* Caching is super important because the typesetter calls image_size */ 
  tree lookup= image->t;
  if (imagesize->contains (lookup)) {
    imsize s= imagesize [lookup];
    w=s.wid;
    h=s.hei;
    if (DEBUG_CONVERT) debug_convert<< "image_size in cache for " << image <<LF
        << w<<" x "<<h<<LF;;
  }
  else {
  w=h=0;
  image_size_sub (image, w, h);
  imagesize (lookup)= (imsize){w,h};
  }
}

void
image_size_sub (url image, int& w, int& h) { // returns w,h in units of pt (1/72 inch)
if (DEBUG_CONVERT) debug_convert<< "image_size not cached for :" << image <<LF;
  string suf = suffix (image);	
  if (suf=="pdf") {
    pdf_image_size (image, w, h);
    return;
    }
  if (suf=="eps") {
    int x1, y1, x2, y2;
    ps_bounding_box (image, x1, y1, x2, y2);
    w= x2 - x1;
    h= y2 - y1;
    if (DEBUG_CONVERT) debug_convert << "size from ps_bounding_box : " << w << " x " << h << "\n";
    return;
  }
#ifdef QTTEXMACS
  if (qt_supports (image)) { // native support by Qt : most bitmaps & svg  
    qt_image_size (image, w, h); 
    return;
  }
#endif
#ifdef MACOSX_EXTENSIONS 
  if (mac_image_size (image, w, h) ) {
    if (DEBUG_CONVERT) debug_convert << "image_size  mac  : " << w << " x " << h << "\n";
    return;
  }
#endif
#ifdef USE_IMLIB2
  if (imlib2_supports (image)) {
    imlib2_image_size (image, w, h);
    if (DEBUG_CONVERT) debug_convert << "image_size imlib2 : " << w << " x " << h << "\n";
    return;
  }
#endif
#ifdef USE_GS
  if (gs_supports (image)) {// this is for handling ps ; eps and pdf already treated above
    gs_image_size (image, w, h);
    return;
  }
#endif
  if(imagemagick_image_size(image, w, h)) {
	  if (DEBUG_CONVERT) debug_convert<< "image_size imagemagick : " << w << " x " << h << "\n";
	  return;
  }

  convert_error << "could not determine size of '"<< concretize(image) <<"'\n"
  << "you may consider :\n"
  << " - checking the file is valid,\n"
  << " - converting to a more standard format,\n"
  << " - defining an appropriate converter (see documentation).\n";
}

void
pdf_image_size (url image, int& w, int& h) {
// we have two ways of finding pdf sizes
// centralize here to ensure consistent determination;
// prefer internal method (avoid calling gs)
#ifdef PDF_RENDERER
  hummus_pdf_image_size (image, w, h);
  return;
#endif
#ifdef USE_GS
  gs_PDFimage_size (image, w, h);
  return;
#endif
// if above methods are absent :-(, fallback to 
  imagemagick_image_size(image, w, h, true);
}
 
/******************************************************************************
* Converting any image format to the only three we need for
* displaying and printing : png, eps, pdf
******************************************************************************/

void
image_to_eps (url image, url eps, int w_pt, int h_pt, int dpi) {
  if (DEBUG_CONVERT) debug_convert << "image_to_eps ...";
  /* if ((suffix (eps) != "eps") && (suffix (eps) != "ps")) {
     std_warning << concretize (eps) << " has no .eps or .ps suffix\n";
     }
  */
  string s= suffix (image);
  // First try to preserve "vectorialness"

  // Note: since inkscape would most likely be the prog called to
  // translate svg we could at no additional cost allow other
  // vector formats supported by inkscape : ai, svgz, cdr, wmf ...
  if ((s == "svg") && (call_scm_converter (image, eps))) return;
  
#ifdef USE_GS
  if (gs_supports (image)) {
    if (DEBUG_CONVERT) debug_convert << " using gs" << LF;
    gs_to_eps (image, eps);
    return;
  }
#endif
  //converters below will yield only raster images.
#ifdef QTTEXMACS 
  if (qt_supports (image)) {
    if (DEBUG_CONVERT) debug_convert << " using qt" << LF;
    qt_image_to_eps (image, eps, w_pt, h_pt, dpi);
    return;
  }
#endif
  if (DEBUG_CONVERT) debug_convert << " using plug-ins" << LF;
  if ((s != "svg") && call_scm_converter (image, eps)) return;
  call_imagemagick_convert (image, eps, w_pt, h_pt, dpi);
}

string
image_to_psdoc (url image) {
  if (DEBUG_CONVERT) debug_convert << "image_to_psdoc " << image << LF;
  
  url psfile= url_temp (".eps");
  image_to_eps (image, psfile);
  string psdoc;
  load_string (psfile, psdoc, false);
  remove (psfile);
  return psdoc;
}

//essentially the same code as image_to_eps 
void 
image_to_pdf (url image, url pdf, int w_pt, int h_pt, int dpi) {
  if (DEBUG_CONVERT) debug_convert << "image_to_pdf ... ";
  string s= suffix (image);
  // First try to preserve "vectorialness"
  if ((s == "svg") && call_scm_converter(image, pdf)) return;
#ifdef USE_GS
  if (gs_supports (image)) {
    if (DEBUG_CONVERT) debug_convert << " using gs "<<LF;
    gs_to_pdf (image, pdf, w_pt, h_pt);
    return;
  }
#endif
  //converters below will yield only raster images.
#ifdef QTTEXMACS
  if (qt_supports (image)) {
    if (DEBUG_CONVERT) debug_convert << " using qt "<<LF;
    qt_image_to_pdf (image, pdf, w_pt, h_pt, dpi);
    return;
  }
#endif
  if ((s != "svg") && call_scm_converter (image, pdf)) return;
  call_imagemagick_convert(image, pdf, w_pt, h_pt, dpi);
}

void
image_to_png (url image, url png, int w, int h) {// IN PIXEL UNITS!
  if (DEBUG_CONVERT) debug_convert << "image_to_png ... ";
  /* if (suffix (png) != "png") {
     std_warning << concretize (png) << " has no .png suffix\n";
     }
  */
#ifdef MACOSX_EXTENSIONS
  //cout << "mac convert " << image << ", " << png << "\n";
  if (mac_supports (image)) {
    if (DEBUG_CONVERT) debug_convert << " using mac_os "<<LF;
    mac_image_to_png (image, png, w, h);
    return;
  }
#endif
#ifdef QTTEXMACS
  if (qt_supports (image)) {
    if (DEBUG_CONVERT) debug_convert << " using qt "<<LF;
    qt_convert_image (image, png, w, h);
    return;
  }
#endif
#ifdef USE_GS
  if (gs_supports (image)) {
    if (DEBUG_CONVERT) debug_convert << " using gs "<<LF;
    gs_to_png (image, png, w, h);
    return;
  }
#endif
  if (call_scm_converter(image, png)) return;
  call_imagemagick_convert (image, png, w, h);
}

bool
call_scm_converter(url image, url dest) {
  if (as_bool (call ("file-converter-exists?",
                     "x." * suffix (image),
                     "x." * suffix (dest)))) {
    call ("file-convert", object (image), object (dest));
    bool success= exists (dest);
    if (success && DEBUG_CONVERT)
      debug_convert << "scm file-convert " << concretize (image)
                    << " -> " << concretize (dest) << LF;
    return success;
  }
  return false;
}

/******************************************************************************
* Imagemagick stuff 
* last resort solution -- should rarely be useful.
******************************************************************************/

bool
has_image_magick (){
#if defined(__MINGW__) || defined(__MINGW32__)
  static bool has_imagemagick = exists_in_path ("conjure"); 
  // testing for "convert" would be ambiguous because it is also a WINDOWS filesystem utility
  // better test for "conjure" for the presence of imagemagick
#else
  static bool has_imagemagick= exists_in_path ("convert");
#endif
  return has_imagemagick;
}

string
imagemagick_cmd () {
  if (has_image_magick()) {
#if defined(__MINGW__) || defined(__MINGW32__)
    static string image_magick_cmd=
      sys_concretize (resolve_in_path ("convert"));
#else
    static string image_magick_cmd= "convert";
#endif
    return copy (image_magick_cmd);
  } 
  else return "";
}

void
call_imagemagick_convert (url image, url dest, int w_pt, int h_pt, int dpi) {
  if (has_image_magick ()) { 
    string cmd= imagemagick_cmd ();
    string s= suffix (image);
    if (s != "pdf" && s != "ps" && s != "eps" &&
        dpi > 0 && w_pt > 0 && h_pt > 0) {
      int ww= w_pt * dpi / 72; //number of pixels @dpi to make w_pt
      int hh= h_pt * dpi / 72;
      int w_px,h_px;
      bool ok= imagemagick_image_size(image, w_px, h_px, false);
      if (ok && (ww < w_px || hh < h_px)) {
        // down-sample image if unecessarily large
        cmd << " -resize " * as_string (ww) * "x" * as_string (hh) * "!";
      }
    }
    system (cmd, image, dest);
  }
}

bool
imagemagick_image_size(url image, int& w, int& h, bool pt_units) {
  if (!has_image_magick()) return false;
  else {		
    string cmd= "identify"; //ImageMagick utility
#if defined(__MINGW__) || defined(__MINGW32__)
    cmd = sys_concretize(resolve_in_path(cmd));
#endif
    cmd << " -ping -format \"%w %h %x\\n%y\""; 
    string sz= eval_system (cmd, image);
    int w_px, h_px, ok= true, pos= 0;
    string unit;
    ok= read_int (sz, pos, w_px);
    skip_spaces (sz, pos);  
    ok= ok && read_int (sz, pos, h_px);
    if (!ok) return false;
    else
      if (!pt_units) { //return numbers of pixels
        w = w_px;
        h = h_px;	
        return true;
      }
      else { 
        double densityx=72, densityy=72, ptperpix=1;
        skip_spaces (sz, pos);
        ok= ok && read_double (sz, pos, densityx);
        if (densityx == 0) return false;
        else {
          ok= ok && read_line (sz, pos, unit);    
          // according to the IM doc, units should be in [PixelsPerCentimeter,PixelsPerInch,Undefined]
          // When "Undefined" IM gives the nonsensical default value of 72 "dots per Undefined"
          // svg is SCALABLE and hence logically gives "Undefined"; in that case we assume 90 dpi
          // so that the physical image size matches that of svg created with inkscape
          if (unit == "PixelsPerCentimeter") ptperpix = 72/(2.54*densityx);
          else if (unit == "PixelsPerInch") ptperpix = 72/densityx;
          else if (unit == "Undefined") ptperpix = 90/densityx; 
          w= (int) w_px * ptperpix;
          h= (int) h_px * ptperpix;
          ok= ok && read_double (sz, pos, densityy);
          if ((densityy != 0) && (densityy != densityx))
            h= (int) (h*densityx/densityy);
          return ok;
        }
      }
  }
}
