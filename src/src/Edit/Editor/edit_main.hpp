
/******************************************************************************
* MODULE     : edit_main.hpp
* DESCRIPTION: the main structure for the mathematical editor
* COPYRIGHT  : (C) 1999  Joris van der Hoeven
*******************************************************************************
* This software falls under the GNU general public license and comes WITHOUT
* ANY WARRANTY WHATSOEVER. See the file $TEXMACS_PATH/LICENSE for more details.
* If you don't have this file, write to the Free Software Foundation, Inc.,
* 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
******************************************************************************/

#ifndef EDIT_MAIN_H
#define EDIT_MAIN_H
#include "Interface/edit_interface.hpp"
#include "Interface/edit_cursor.hpp"
#include "Editor/edit_typeset.hpp"
#include "Modify/edit_modify.hpp"
#include "Modify/edit_text.hpp"
#include "Modify/edit_math.hpp"
#include "Modify/edit_table.hpp"
#include "Modify/edit_dynamic.hpp"
#include "Process/edit_process.hpp"
#include "Replace/edit_select.hpp"
#include "Replace/edit_replace.hpp"

class edit_main_rep:
  public edit_interface_rep,
  public edit_cursor_rep,
  public edit_typeset_rep,
  public edit_modify_rep,
  public edit_text_rep,
  public edit_math_rep,
  public edit_table_rep,
  public edit_dynamic_rep,
  public edit_process_rep,
  public edit_select_rep,
  public edit_replace_rep
{
private:
  hashmap<tree,tree> props; // properties associated to the editor

public:
  edit_main_rep (server_rep* sv, display dis, tm_buffer buf);
  ~edit_main_rep ();

  void set_property (scheme_tree what, scheme_tree val);
  void set_bool_property (string what, bool val);
  void set_int_property (string what, int val);
  void set_string_property (string what, string val);
  scheme_tree get_property (scheme_tree what);
  bool get_bool_property (string what);
  int get_int_property (string what);
  string get_string_property (string what);
  
  void clear_buffer ();
  void new_window ();
  void clone_window ();
  void tex_buffer ();
  url  get_name ();
  void focus_on_this_editor ();

  void set_page_parameters ();
  void set_page_medium (string medium);
  void set_page_type (string type);
  void set_page_orientation (string orientation);

  void print (url ps_name, bool to_file, int first, int last);
  void print_to_file (url ps_name, string first="1", string last="1000000");
  void print_buffer (string first="1", string last="1000000");
  void export_ps (url ps_name, string first="1", string last="1000000");

  void footer_eval (string s);
  tree the_line ();
  tree the_buffer ();
  path the_path ();
  void process_input ();

  void show_tree ();
  void show_env ();
  void show_path ();
  void show_cursor ();
  void show_selection ();
  void show_meminfo ();
  void edit_special ();
  void edit_test ();

  friend class editor;
};

#endif // defined EDIT_MAIN_H
