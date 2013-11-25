
/******************************************************************************
* MODULE     : file.hpp
* DESCRIPTION: file handling
* COPYRIGHT  : (C) 1999  Joris van der Hoeven
*******************************************************************************
* This software falls under the GNU general public license version 3 or later.
* It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
* in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
******************************************************************************/

#ifndef FILE_H
#define FILE_H
#include "url.hpp"
#include "sys_utils.hpp"
#include "analyze.hpp"

bool load_string (url file_name, string& s, bool fatal);
bool save_string (url file_name, string s, bool fatal=false);

bool is_of_type (url name, string filter);
bool is_regular (url name);
bool is_directory (url name);
bool is_symbolic_link (url name);
bool is_newer (url which, url than);
int  last_modified (url u, bool cache_flag= true);
url  url_temp (string suffix= "");
url  url_numbered (url dir, string prefix, string postfix, int i=1);
url  url_scratch (string prefix="no_name_", string postfix=".tm", int i=1);
bool is_scratch (url u);
string file_format (url u);

array<string> read_directory (url name, bool& error_flag);

inline string sys_concretize (url u1) {
  return escape_sh (concretize (u1)); }

inline void system (string which, url u1) {
  system (which * " " * sys_concretize (u1)); }
inline void system (string which, url u1, url u2) {
  system (which * " " * sys_concretize (u1) * " " * sys_concretize (u2)); }
inline void system (string which, url u1, const char* post) {
  system (which * " " * sys_concretize (u1) * " " * post); }
inline void system (string which, url u1, const char* sep, url u2) {
  system (which * " " * sys_concretize (u1) * " " * sep *
	          " " * sys_concretize (u2)); }
inline string eval_system (string which, url u1) {
  return eval_system (which * " " * escape_sh (concretize (u1))); }
inline string eval_system (string which, url u1, url u2) {
  return eval_system (which * " " * escape_sh (concretize (u1)) * " " * escape_sh (concretize (u2))); }

void move (url from, url to);
void copy (url from, url to);
void remove (url what);
void mkdir (url dir);
void rmdir (url what);
void change_mode (url u, int mode);
void ps2pdf (url u1, url u2);

int search_score (url u, array<string> a);

array<string> file_completions (url search, url dir);

url grep (string what, url u);

#endif // defined FILE_H
