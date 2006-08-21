
/******************************************************************************
* MODULE     : edit_graphics.cpp
* DESCRIPTION: graphics between the editor and the window manager
* COPYRIGHT  : (C) 2003  Joris van der Hoeven and Henri Lesourd
*******************************************************************************
* This software falls under the GNU general public license and comes WITHOUT
* ANY WARRANTY WHATSOEVER. See the file $TEXMACS_PATH/LICENSE for more details.
* If you don't have this file, write to the Free Software Foundation, Inc.,
* 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
******************************************************************************/

#include "Interface/edit_graphics.hpp"
#include "server.hpp"
#include "scheme.hpp"
#include "Graphics/curve.hpp"
#include "Boxes/graphics.hpp"
#include "Bridge/impl_typesetter.hpp"

/******************************************************************************
* Constructors and destructors
******************************************************************************/

edit_graphics_rep::edit_graphics_rep () { graphical_object= tree(); }
edit_graphics_rep::~edit_graphics_rep () {}

/******************************************************************************
* Main edit_graphics routines
******************************************************************************/

bool
edit_graphics_rep::inside_graphics (bool b) {
  path p   = path_up (tp);
  bool flag= false;
  tree st  = et;
  while (!nil (p)) {
    if (is_func (st, GRAPHICS)) flag= true;
    if (b && is_func (st, TEXT_AT )) flag= false;
    st= st[p->item];
    p = p->next;
  }
  return flag || (L(st) == GRAPHICS);
}

bool
edit_graphics_rep::inside_active_graphics (bool b) {
  return inside_graphics (b) && get_env_string (PREAMBLE) == "false";
}

bool
edit_graphics_rep::over_graphics (SI x, SI y) {
  frame f= find_frame ();
  if (!nil (f)) {
    point lim1, lim2;
    find_limits (lim1, lim2);
    point p = adjust (f [point (x, y)]);
    // cout << type << " at " << p << " [" << lim1 << ", " << lim2 << "]\n";
    if (N(lim1) == 2)
      if ((p[0]<lim1[0]) || (p[0]>lim2[0]) || (p[1]<lim1[1]) || (p[1]>lim2[1]))
	return false;
    return true;
  }
  return false;
}

tree
edit_graphics_rep::get_graphics () {
  path p   = path_up (tp);
  tree st  = et;
  tree res = tree ();
  while (!nil (p)) {
    if (is_func (st, GRAPHICS)) res= st;
    st= st[p->item];
    p = p->next;
  }
  return res;
}

frame
edit_graphics_rep::find_frame (bool last) {
  bool bp_found;
  path bp= eb->find_box_path (tp, bp_found);
  if (bp_found) return eb->find_frame (path_up (bp), last);
  else return frame ();
}

grid
edit_graphics_rep::find_grid () {
  bool bp_found;
  path bp= eb->find_box_path (tp, bp_found);
  if (bp_found) return eb->find_grid (path_up (bp));
  else return grid ();
}

void
edit_graphics_rep::find_limits (point& lim1, point& lim2) {
  lim1= point (); lim2= point ();
  bool bp_found;
  path bp= eb->find_box_path (tp, bp_found);
  if (bp_found) eb->find_limits (path_up (bp), lim1, lim2);
}

bool
edit_graphics_rep::find_graphical_region (SI& x1, SI& y1, SI& x2, SI& y2) {
  point lim1, lim2;
  find_limits (lim1, lim2);
  if (lim1 == point ()) return false;
  frame f= find_frame ();
  if (nil (f)) return false;
  point p1= f (point (lim1[0], lim1[1]));
  point p2= f (point (lim2[0], lim2[1]));
  x1= (SI) p1[0]; y1= (SI) p1[1];
  x2= (SI) p2[0]; y2= (SI) p2[1];
  return true;
}

point
edit_graphics_rep::adjust (point p) {
  frame f= find_frame ();
  point pmin= p, pmax= p;
  if (!nil (f)) {
    static const int NB= 10;
    point p2= f (p);
    pmin= f [point (p2[0]-NB*get_pixel_size (), p2[1]-NB*get_pixel_size ())];
    pmax= f [point (p2[0]+NB*get_pixel_size (), p2[1]+NB*get_pixel_size ())];
  }
  grid g= find_grid ();
  if (!nil (g) && !nil (gr0) && g!=gr0) {
    graphical_select (p[0], p[1]);
    g= gr0;
  }
  if (nil (g))
    return p;
  else {
    point res= g->find_closest_point (p, pmin, pmax);
    gr_selections sels= gs;
    frame f2= find_frame (true);
    if (!nil (f2)) {
      point fp= f2 (p);
      res= f2 (res);
      int i;
      for (i=0; i<N(ci); i++) {
	point sp= ci[i];
	if (N(sp)>0 && norm (fp - sp) < norm (fp - res))
	  res= ci[i];
      }
      for (i=0; i<N(cgi); i++) {
	point sp= cgi[i];
	if (N(sp)>0 && norm (fp - sp) < norm (fp - res))
	  res= cgi[i];
      }
    /*NOTE: Uncomment this to adjust by means of projecting on the curve
      int n= N(sels);
      if (N(ci)==0 && N(cgi)==0) for (i=0; i<n; i++) {
	point sp= sels[i]->p;
	if (N(sp)>0 && norm (fp - sp) < norm (fp - res))
	  res= sels[i]->p;
      }*/
    //TODO: Adjusting by means on freely moving on surface of closed curves
      ;
      res= f2[res];
    }
    return res;
  }
}

tree
edit_graphics_rep::find_point (point p) {
  return tree (_POINT, as_string (p[0]), as_string (p[1]));
}

tree
edit_graphics_rep::graphical_select (double x, double y) { 
  frame f= find_frame ();
  if (nil (f)) return tuple ();
  gr_selections sels;
  point p = f (point (x, y));
  sels= eb->graphical_select ((SI)p[0], (SI)p[1], 10 * get_pixel_size ());
  gs= sels;
  ci= array<point> (0);
  cgi= array<point> (0);
  gr0= empty_grid ();
  grid g= find_grid ();
  frame f2= find_frame (true);
  if (!nil (g) && !nil (f2)) {
    gr0= g;
    point pmin, pmax;
    static const int NB= 10;
    pmin= f[point (p[0]-NB*get_pixel_size (), p[1]-NB*get_pixel_size ())];
    pmax= f[point (p[0]+NB*get_pixel_size (), p[1]+NB*get_pixel_size ())];
    p = f2 (point (x, y));
    int i, j, n= N(sels);
    double eps= get_pixel_size () / 10.0;
    for (i=0; i<n; i++) {
      for (j=0; j<n; j++)
        if (i<j)
          ci= ci << sels[i]->b->curve_intersection (sels[j]->b, p, eps);
    }
    array<grid_curve> gc= g->get_curves (pmin, pmax, 1e-6, true);
    //FIXME: Too slow
    for (i=0; i<N(gc); i++) {
      curve c= f2 (gc[i]->c);
      for (j=0; j<n; j++)
        cgi= cgi << intersection (c, sels[j]->b->get_curve (), p, eps);
    }
  }
  return as_tree (sels);
}

tree
edit_graphics_rep::graphical_select (
  double x1, double y1, double x2, double y2)
{ 
  frame f= find_frame ();
  if (nil (f)) return tuple ();
  gr_selections sels;
  point p1 = f (point (x1, y1)), p2= f (point (x2, y2));
  sels= eb->graphical_select ((SI)p1[0], (SI)p1[1], (SI)p2[0], (SI)p2[1]);
  return as_tree (sels);
}

tree
edit_graphics_rep::get_graphical_object () {
  return graphical_object;
}

void
edit_graphics_rep::set_graphical_object (tree t) {
  go_box= box ();
  graphical_object= t;
  if (N (graphical_object) == 0) return;
  edit_env env= get_typesetter ()->env;
  //tree old_fr= env->local_begin (GR_FRAME, (tree) find_frame ());  
  frame f_env= env->fr;
  env->fr= find_frame ();
  if (!nil (env->fr)) {
    int i,n=0;
    go_box= typeset_as_concat (env, t, path (0));
    for (i=0; i<N(go_box); i++)
      if (go_box[i]!="") n++;
    if (n) {
      array<box> bx(n);
      n=0;
      for (i=0; i<N(go_box); i++) if (go_box[i]!="") {
	array<box> bx2(1);
	array<SI> spc2(1);
	bx2[0]= go_box[i];
	spc2[0]=0;
	bx[n]= concat_box (path (0), bx2, spc2);
	n++;
      }
      go_box= composite_box (path (0), bx);
    }
  }
  env->fr= f_env;
  //env->local_end (GR_FRAME, old_fr);
}

void
edit_graphics_rep::invalidate_graphical_object () {
  SI gx1, gy1, gx2, gy2;
  if (find_graphical_region (gx1, gy1, gx2, gy2) && !nil (go_box)) {
    int i;
    rectangles rs;
    rectangle gr (gx1, gy1, gx2, gy2);
    for (i=0; i<go_box->subnr(); i++) {
      box b= go_box->subbox (i);
      rs= rectangles (rectangle (b->x3, b->y3, b->x4, b->y4), rs);
    }
    rs= rs & rectangles (gr);
    invalidate (rs);
  }
}

void
edit_graphics_rep::draw_graphical_object (ps_device dev) {
  if (nil (go_box)) set_graphical_object (graphical_object);
  if (nil (go_box)) return;
  SI ox1, oy1, ox2, oy2;
  dev->get_clipping (ox1, oy1, ox2, oy2);
  SI gx1, gy1, gx2, gy2;
  if (find_graphical_region (gx1, gy1, gx2, gy2))
    dev->extra_clipping (gx1, gy1, gx2, gy2);
  int i;
  for (i=0; i<go_box->subnr(); i++) {
    box b= go_box->subbox (i);
    if ((tree)b=="point" || (tree)b=="curve")
      b->display (dev);
    else {
      rectangles rs;
      b->redraw (dev, path (), rs);
    }
  }
  dev->set_clipping (ox1, oy1, ox2, oy2);
}

bool
edit_graphics_rep::mouse_graphics (string type, SI x, SI y, time_t t) {
  (void) t;
  // apply_changes (); // FIXME: remove after review of synchronization
  frame f= find_frame ();
  if (!nil (f)) {
    if (!over_graphics (x, y)) return false;
    if (type == "move" || type == "dragging")
      if (dis->check_event (MOTION_EVENT))
	return true;
    point p = f [point (x, y)];
    graphical_select (p[0], p[1]); // init the caching for adjust().
    p = adjust (p);
    string sx= as_string (p[0]);
    string sy= as_string (p[1]);
    invalidate_graphical_object ();
    if (type == "move"            ) call ("graphics-move-point"      , sx, sy);
    if (type == "release-left"    ) call ("graphics-insert-point"    , sx, sy);
    if (type == "release-middle"  ) call ("graphics-remove-point"    , sx, sy);
    if (type == "release-right"   ) call ("graphics-last-point"      , sx, sy);
    if (type == "start-drag"      ) call ("graphics-start-drag"      , sx, sy);
    if (type == "dragging"        ) call ("graphics-dragging"        , sx, sy);
    if (type == "end-drag"        ) call ("graphics-end-drag"        , sx, sy);
    if (type == "start-right-drag") call ("graphics-start-right-drag", sx, sy);
    if (type == "right-dragging"  ) call ("graphics-right-dragging"  , sx, sy);
    if (type == "end-right-drag"  ) call ("graphics-end-right-drag"  , sx, sy);
    invalidate_graphical_object ();
    notify_change (THE_CURSOR);
    return true;
  }
  return false;
}
