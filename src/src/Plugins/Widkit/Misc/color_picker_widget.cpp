
/******************************************************************************
* MODULE     : color_picker_widget.cpp
* DESCRIPTION: Widget for selecting colors or images
* COPYRIGHT  : (C) 2010  Joris van der Hoeven
*******************************************************************************
* This software falls under the GNU general public license version 3 or later.
* It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
* in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
******************************************************************************/

#include "Widkit/basic_widget.hpp"
#include "Widkit/attribute_widget.hpp"
#include "Widkit/layout.hpp"
#include "file.hpp"
#include "image_files.hpp"
#include "Scheme/object.hpp"

/******************************************************************************
* Color button widget
******************************************************************************/

class color_widget_rep: public basic_widget_rep {
  tree col;
public:
  color_widget_rep (tree col2): col (col2) {}
  operator tree () { return tuple ("color", col); }
  void handle_get_size (get_size_event ev);
  void handle_repaint (repaint_event ev);
};

void
color_widget_rep::handle_get_size (get_size_event ev) {
  ev->w= 32*PIXEL; ev->h= 24*PIXEL;
  /*
  if (ev->mode == -1)
    ev->w= ev->h= 8*PIXEL;
  if (ev->mode == 0) {
    ev->w= 48*PIXEL; ev->h= 24*PIXEL; }
  if (ev->mode == 1)
    gui_maximal_extents (ev->w, ev->h);
  */
}

void
color_widget_rep::handle_repaint (repaint_event ev) {
  renderer ren= win->get_renderer ();
  if (is_atomic (col)) {
    color c= named_color (col->label);
    ren->set_background (c);
    ren->set_color (c);
    ren->fill (ev->x1, ev->y1, ev->x2, ev->y2);
  }
  else {
    ren->set_shrinking_factor (5);
    tree old_bg= ren->get_background_pattern ();
    ren->set_background_pattern (col);
    ren->clear_pattern (5*ev->x1, 5*ev->y1, 5*ev->x2, 5*ev->y2);
    ren->set_background_pattern (old_bg);
    ren->set_shrinking_factor (1);
  }
}

wk_widget
color_widget (tree col) {
  return tm_new<color_widget_rep> (col);
}

class color_command_rep: public command_rep {
  command cmd;
  tree col;
public:
  color_command_rep (command cmd2, tree col2): cmd (cmd2), col (col2) {}
  void apply () { cmd (list_object (object (col))); }
  tm_ostream& print (tm_ostream& out) {
    return out << "Apply (" << cmd << ", " << col << ")"; }
};

command
color_command (command cmd, tree col) {
  return tm_new<color_command_rep> (cmd, col);
}

wk_widget
color_button_widget (tree col, command cmd) {
  return command_button (color_widget (col),
			 color_command (cmd, col),
			 WIDGET_STYLE_BUTTON);
}

/******************************************************************************
* Direct color picker
******************************************************************************/

wk_widget
tile_color_picker (array<tree> cols, command cmd, int columns) {
  int i, n= N(cols);
  array<wk_widget> ws (n);
  for (i=0; i<n; i++)
    ws[i]= color_button_widget (cols[i], cmd);
  return tile (ws, columns);
}

wk_widget
direct_color_picker (command cmd, array<tree> proposals) {
  (void) proposals;
  array<wk_widget> picker (5);

  array<tree> cols1;
  cols1 << tree ("dark red") << tree ("dark magenta")
	<< tree ("dark blue") << tree ("dark cyan")
	<< tree ("dark green") << tree ("dark yellow")
	<< tree ("dark orange") << tree ("dark brown")
	<< tree ("red") << tree ("magenta")
	<< tree ("blue") << tree ("cyan")
	<< tree ("green") << tree ("yellow")
	<< tree ("orange") << tree ("brown")
	<< tree ("pastel red") << tree ("pastel magenta")
	<< tree ("pastel blue") << tree ("pastel cyan")
	<< tree ("pastel green") << tree ("pastel yellow")
	<< tree ("pastel orange") << tree ("pastel brown");
  picker[0]= tile_color_picker (cols1, cmd, 8);

  picker[1]= glue_wk_widget (true, false, 0, 5*PIXEL);

  array<tree> cols2;
  cols2 << tree ("black") << tree ("dark grey")
	<< tree ("light grey") << tree ("pastel grey")
	<< tree ("white");
  picker[2]= tile_color_picker (cols2, cmd, 8);

  picker[3]= glue_wk_widget (true, false, 0, 5*PIXEL);

  bool dir_problem;
  url pattern_dir= "$TEXMACS_PATH/misc/patterns";
  array<string> all= read_directory (pattern_dir, dir_problem);
  array<tree> cols3;
  for (int i=0; i<N(all); i++)
    if (ends (all[i], ".png")) {
      url image= resolve (relative (pattern_dir, all[i]));
      int imw_pt, imh_pt;
      image_size (image, imw_pt, imh_pt);
      double pt= ((double) 600*PIXEL) / 72.0;
      SI imw= (SI) (((double) imw_pt) * pt);
      SI imh= (SI) (((double) imh_pt) * pt);
      cols3 << tree (PATTERN, as_string (pattern_dir * all[i]),
		     as_string (imw), as_string (imh));
    }
  picker[4]= tile_color_picker (cols3, cmd, 8);

  return vertical_list (picker);
}

/******************************************************************************
* exported routines
******************************************************************************/

wk_widget
color_picker_wk_widget (command cmd, array<tree> proposals) {
  return direct_color_picker (cmd, proposals);
  //return tm_new<color_picker_widget_rep> (cmd, proposals);
}
