if exists(':Tabularize')
  function! TabularizeDeclAssign(lines)
    " A list containing each of the lines with leading spaces removed
    let text = map(copy(a:lines), 'substitute(v:val, "^ *", "", "")')
    " A list containing just the leading spaces for each line
    let spaces = map(copy(a:lines), 'substitute(v:val, "^ *\\zs.*", "", "")')
    " Tabularize only the text, not the leading spaces.
    call tabular#TabularizeStrings(text, '\S\+ \+= ', 'l2')
    let assignment = '[|&+*/%<>=!~-]\@<!\([<>!=]=\|=\~\)\@![|&+*/%<>=!~-]*='
    call tabular#TabularizeStrings(text, assignment, 'l2r2')
    " Tack the spaces back on to the beginning of each line, and store the
    " resulting lines back in the a:lines list
    call map(a:lines, 'remove(spaces, 0) . remove(text, 0)')
  endfunction

  AddTabularPipeline! decl_assign /=/ TabularizeDeclAssign(a:lines)
  AddTabularPattern 1=    /^[^=]*\zs=/l2r2
endif
