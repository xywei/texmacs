
###############################################################################
##
## MODULE      : flush_verbatim.m
## DESCRIPTION : flush verbatim content to stdout
## COPYRIGHT   : (C) 2020  Darcy Shen
##
## This software falls under the GNU general public license version 3 or later.
## It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
## in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.

function flush_verbatim (content)
  flush_any (["verbatim:", content]);
endfunction

