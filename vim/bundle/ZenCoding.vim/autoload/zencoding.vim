"=============================================================================
" zencoding.vim
" Author: Yasuhiro Matsumoto <mattn.jp@gmail.com>
" Last Change: 25-Jan-2011.

let s:save_cpo = &cpo
set cpo&vim

function! s:zen_getExpandos(type, key)
  let expandos = s:zen_getResource(a:type, 'expandos', {})
  if has_key(expandos, a:key)
    return expandos[a:key]
  endif
  return a:key
endfunction

function! s:zen_useFilter(filters, filter)
  for f in a:filters
    if f == a:filter
      return 1
    endif
  endfor
  return 0
endfunction

function! s:zen_isExtends(type, extend)
  if a:type == a:extend
    return 1
  endif
  if !has_key(s:zen_settings, a:type)
    return 0
  endif
  if !has_key(s:zen_settings[a:type], 'extends')
    return 0
  endif
  let extends = s:zen_settings[a:type].extends
  if type(extends) == 1
    let tmp = split(extends, '\s*,\s*')
    unlet! extends
    let extends = tmp
  endif
  for ext in extends
    if a:extend == ext
      return 1
    endif
  endfor
  return 0
endfunction

function! s:zen_parseIntoTree(abbr, type)
  let abbr = a:abbr
  let type = a:type
  if !has_key(s:zen_settings, type)
    let type = 'html'
  endif
  if len(type) == 0 | let type = 'html' | endif

  if has_key(s:zen_settings[type], 'indentation')
    let indent = s:zen_settings[type].indentation
  else
    let indent = s:zen_settings.indentation
  endif

  if s:zen_isExtends(type, "html")
    let abbr = substitute(abbr, '\([a-zA-Z][a-zA-Z0-9]*\)+\([()]\|$\)', '\="(".s:zen_getExpandos(type, submatch(1)).")".submatch(2)', 'i')
    let mx = '\([+>]\|<\+\)\{-}\s*\((*\)\{-}\s*\([@#.]\{-}[a-zA-Z\!][a-zA-Z0-9:\!\-]*\|{[^}]\+}\)\(\%(\%(#{[{}a-zA-Z0-9_\-\$]\+\|#[a-zA-Z0-9_\-\$]\+\)\|\%(\[[^\]]\+\]\)\|\%(\.{[{}a-zA-Z0-9_\-\$]\+\|\.[a-zA-Z0-9_\-\$]\+\)\)*\)\%(\({[^}]\+}\)\)\{0,1}\%(\s*\*\s*\([0-9]\+\)\s*\)\{0,1}\(\%(\s*)\%(\s*\*\s*[0-9]\+\s*\)\{0,1}\)*\)'
  else
    let mx = '\([+>]\|<\+\)\{-}\s*\((*\)\{-}\s*\([@#.]\{-}[a-zA-Z\!][a-zA-Z0-9:\!\+\-]*\|{[^}]\+}\)\(\%(\%(#{[{}a-zA-Z0-9_\-\$]\+\|#[a-zA-Z0-9_\-\$]\+\)\|\%(\[[^\]]\+\]\)\|\%(\.{[{}a-zA-Z0-9_\-\$]\+\|\.[a-zA-Z0-9_\-\$]\+\)\)*\)\%(\({[^}]\+}\)\)\{0,1}\%(\s*\*\s*\([0-9]\+\)\s*\)\{0,1}\(\%(\s*)\%(\s*\*\s*[0-9]\+\s*\)\{0,1}\)*\)'
  endif
  let root = { 'name': '', 'attr': {}, 'child': [], 'snippet': '', 'multiplier': 1, 'parent': {}, 'value': '', 'pos': 0 }
  let parent = root
  let last = root
  let pos = []

	" Added by Doug Avery
	let length  = len(abbr)
	let loopcount = 1


  while len(abbr)
    " parse line
    let match = matchstr(abbr, mx)
    let str = substitute(match, mx, '\0', 'ig')
    let operator = substitute(match, mx, '\1', 'ig')
    let block_start = substitute(match, mx, '\2', 'ig')
    let tag_name = substitute(match, mx, '\3', 'ig')
    let attributes = substitute(match, mx, '\4', 'ig')
    let value = substitute(match, mx, '\5', 'ig')
    let multiplier = 0 + substitute(match, mx, '\6', 'ig')
    let block_end = substitute(match, mx, '\7', 'ig')
    if len(str) == 0
      break
    endif
    if tag_name =~ '^#'
      let attributes = tag_name . attributes
      let tag_name = 'div'
    endif
    if tag_name =~ '^\.'
      let attributes = tag_name . attributes
      let tag_name = 'div'
    endif
    if multiplier <= 0 | let multiplier = 1 | endif

    " make default node
    let current = { 'name': '', 'attr': {}, 'child': [], 'snippet': '', 'multiplier': 1, 'parent': {}, 'value': '', 'pos': 0 }
    let current.name = tag_name

    " aliases
    let aliases = s:zen_getResource(type, 'aliases', {})
    if has_key(aliases, tag_name)
      let current.name = aliases[tag_name]
    endif

    " snippets
    let snippets = s:zen_getResource(type, 'snippets', {})
    if !empty(snippets) && has_key(snippets, tag_name)
      let snippet = snippets[tag_name]
      let snippet = substitute(snippet, '|', '${cursor}', 'g')
      let lines = split(snippet, "\n")
      call map(lines, 'substitute(v:val, "\\(    \\|\\t\\)", indent, "g")')
			let current.snippet = join(lines, "\n")
      let current.name = ''
    endif

		" Added by Doug Avery to simplify long CSS expands
		" let loopcount = loopcount - 1
		" echo loopcount
		" echo length
		" if type == 'css' && loopcount == length
			" execute "normal! dd\<CR>"
		" endif

    " default_attributes
    let default_attributes = s:zen_getResource(type, 'default_attributes', {})
    if !empty(default_attributes)
      for pat in [current.name, tag_name]
        if has_key(default_attributes, pat)
          if type(default_attributes[pat]) == 4
            let a = default_attributes[pat]
            for k in keys(a)
              let current.attr[k] = len(a[k]) ? substitute(a[k], '|', '${cursor}', 'g') : '${cursor}'
            endfor
          else
            for a in default_attributes[pat]
              for k in keys(a)
                let current.attr[k] = len(a[k]) ? substitute(a[k], '|', '${cursor}', 'g') : '${cursor}'
              endfor
            endfor
          endif
          if has_key(s:zen_settings.html.default_attributes, current.name)
            let current.name = substitute(current.name, ':.*$', '', '')
          endif
          break
        endif
      endfor
    endif

    " parse attributes
    if len(attributes)
      let attr = attributes
      while len(attr)
        let item = matchstr(attr, '\(\%(\%(#[{}a-zA-Z0-9_\-\$]\+\)\|\%(\[[^\]]\+\]\)\|\%(\.[{}a-zA-Z0-9_\-\$]\+\)*\)\)')
        if len(item) == 0
          break
        endif
        if item[0] == '#'
          let current.attr.id = item[1:]
        endif
        if item[0] == '.'
          let current.attr.class = substitute(item[1:], '\.', ' ', 'g')
        endif
        if item[0] == '['
          let atts = item[1:-2]
          while len(atts)
            let amat = matchstr(atts, '\(\w\+\%(="[^"]*"\|=''[^'']*''\|[^ ''"\]]*\)\{0,1}\)')
            if len(amat) == 0
              break
            endif
            let key = split(amat, '=')[0]
            let val = amat[len(key)+1:]
            if val =~ '^["'']'
              let val = val[1:-2]
            endif
            let current.attr[key] = val
            let atts = atts[stridx(atts, amat) + len(amat):]
          endwhile
        endif
        let attr = substitute(strpart(attr, len(item)), '^\s*', '', '')
      endwhile
    endif

    " parse text
    if tag_name =~ '^{.*}$'
      let current.name = ''
      let current.value = tag_name
    else
      let current.value = value
    endif
    let current.multiplier = multiplier

    " parse step inside/outside
    if !empty(last)
      if operator =~ '>'
        unlet! parent
        let parent = last
        let current.parent = last
        let current.pos = last.pos + 1
      else
        let current.parent = parent
        let current.pos = last.pos
      endif
    else
      let current.parent = parent
      let current.pos = 1
    endif
    if operator =~ '<'
      for c in range(len(operator))
        let tmp = parent.parent
        if empty(tmp)
          break
        endif
        let parent = tmp
      endfor
    endif

    call add(parent.child, current)
    let last = current

    " parse block
    if block_start =~ '('
      if operator =~ '>'
        let last.pos += 1
      endif
      for n in range(len(block_start))
        let pos += [last.pos]
      endfor
    endif
    if block_end =~ ')'
      for n in split(substitute(substitute(block_end, ' ', '', 'g'), ')', ',),', 'g'), ',')
        if n == ')'
          if len(pos) > 0 && last.pos >= pos[-1]
            for c in range(last.pos - pos[-1])
              let tmp = parent.parent
              if !has_key(tmp, 'parent')
                break
              endif
              let parent = tmp
            endfor
            if operator =~ '>'
              call remove(pos, -1)
            endif
            let last = parent
            let last.pos += 1
          endif
        elseif len(n)
          let cl = last.child
          let cls = []
          for c in range(n[1:])
            let cls += cl
          endfor
          let last.child = cls
        endif
      endfor
    endif
    let abbr = abbr[stridx(abbr, match) + len(match):]

    if g:zencoding_debug > 1
      echo "str=".str
      echo "block_start=".block_start
      echo "tag_name=".tag_name
      echo "operator=".operator
      echo "attributes=".attributes
      echo "value=".value
      echo "multiplier=".multiplier
      echo "block_end=".block_end
      echo "abbr=".abbr
      echo "pos=".string(pos)
      echo "\n"
    endif
  endwhile
  return root
endfunction

function! s:zen_parseTag(tag)
  let current = { 'name': '', 'attr': {}, 'child': [], 'snippet': '', 'multiplier': 1, 'parent': {}, 'value': '', 'pos': 0 }
  let mx = '<\([a-zA-Z][a-zA-Z0-9]*\)\(\%(\s[a-zA-Z][a-zA-Z0-9]\+=\%([^"'' \t]\+\|["''][^"'']*["'']\)\s*\)*\)\(/\{0,1}\)>'
  let match = matchstr(a:tag, mx)
  let current.name = substitute(match, mx, '\1', 'i')
  let attrs = substitute(match, mx, '\2', 'i')
  let mx = '\([a-zA-Z0-9]\+\)=["'']\{0,1}\([^"'' \t]*\|[^"'']\+\)["'']\{0,1}'
  while len(attrs) > 0
    let match = matchstr(attrs, mx)
    if len(match) == 0
      break
    endif
    let name = substitute(match, mx, '\1', 'i')
    let value = substitute(match, mx, '\2', 'i')
    let current.attr[name] = value
    let attrs = attrs[stridx(attrs, match) + len(match):]
  endwhile
  return current
endfunction

function! s:zen_mergeConfig(lhs, rhs)
  if type(a:lhs) == 3 && type(a:rhs) == 3
    let a:lhs += a:rhs
    if len(a:lhs)
      call remove(a:lhs, 0, len(a:lhs)-1)
    endif
    for rhi in a:rhs
      call add(a:lhs, a:rhs[rhi])
    endfor
  elseif type(a:lhs) == 4 && type(a:rhs) == 4
    for key in keys(a:rhs)
      if type(a:rhs[key]) == 3
        if !has_key(a:lhs, key)
          let a:lhs[key] = []
        endif
        let a:lhs[key] += a:rhs[key]
      elseif type(a:rhs[key]) == 4
        if has_key(a:lhs, key)
          call s:zen_mergeConfig(a:lhs[key], a:rhs[key])
        else
          let a:lhs[key] = a:rhs[key]
        endif
      else
        let a:lhs[key] = a:rhs[key]
      endif
    endfor
  endif
endfunction


function! s:zen_toString_haml(settings, current, type, inline, filters, itemno, indent)
  let settings = a:settings
  let current = a:current
  let type = a:type
  let inline = a:inline
  let filters = a:filters
  let itemno = a:itemno
  let indent = a:indent
  let str = ""

  let comment_indent = ''
  let comment = ''
  if len(current.name) > 0
    let str .= '%' . current.name
    let tmp = ''
    for attr in keys(current.attr)
      let val = current.attr[attr]
      if current.multiplier > 1
        while val =~ '\$\([^{]\|$\)'
          let val = substitute(val, '\(\$\+\)\([^{]\|$\)', '\=printf("%0".len(submatch(1))."d", itemno+1).submatch(2)', 'g')
        endwhile
      endif
      if attr == 'id'
        let str .= '#' . val
      elseif attr == 'class'
        let str .= '.' . substitute(val, ' ', '.', 'g')
      else
        if len(tmp) > 0 | let tmp .= ',' | endif
        let tmp .= ' :' . attr . ' => "' . val . '"'
      endif
    endfor
    if len(tmp)
      let str .= '{' . tmp . ' }'
    endif
    if stridx(','.settings.html.empty_elements.',', ','.current.name.',') != -1 && len(current.value) == 0
      let str .= "/"
    endif

    let inner = ''
    if len(current.value) > 0
      let lines = split(current.value[1:-2], "\n")
      let str .= " " . lines[0]
      for line in lines[1:]
        let str .= " |\n" . line
      endfor
    endif
    if len(current.child) == 1 && len(current.child[0].name) == 0
      let lines = split(current.child[0].value[1:-2], "\n")
      let str .= " " . lines[0]
      for line in lines[1:]
        let str .= " |\n" . line
      endfor
    elseif len(current.child) > 0
      for child in current.child
        let inner .= s:zen_toString(child, type, inline, filters)
      endfor
      let inner = substitute(inner, "\n", "\n  ", 'g')
      let inner = substitute(inner, "\n  $", "", 'g')
      let str .= "\n  " . inner
    endif
  endif
  let str .= "\n"
  return str
endfunction

function! s:zen_toString_html(settings, current, type, inline, filters, itemno, indent)
  let settings = a:settings
  let current = a:current
  let type = a:type
  let inline = a:inline
  let filters = a:filters
  let itemno = a:itemno
  let indent = a:indent
  let str = ""

  let comment_indent = ''
  let comment = ''
  if s:zen_useFilter(filters, 'c')
    let comment_indent = substitute(str, '^.*\(\s*\)$', '\1', '')
  endif
  let tmp = '<' . current.name
  for attr in keys(current.attr)
    if current.name =~ '^\(xsl:with-param\|xsl:variable\)$' && s:zen_useFilter(filters, 'xsl') && len(current.child) && attr == 'select'
      continue
    endif
    let val = current.attr[attr]
    if current.multiplier > 1
      while val =~ '\$\([^{]\|$\)'
        let val = substitute(val, '\(\$\+\)\([^{]\|$\)', '\=printf("%0".len(submatch(1))."d", itemno+1).submatch(2)', 'g')
      endwhile
    endif
    let tmp .= ' ' . attr . '="' . val . '"'
    if s:zen_useFilter(filters, 'c')
      if attr == 'id' | let comment .= '#' . val | endif
      if attr == 'class' | let comment .= '.' . val | endif
    endif
  endfor
  if len(comment) > 0
    let tmp = "<!-- " . comment . " -->" . (inline ? "" : "\n") . comment_indent . tmp
  endif
  let str .= tmp
  let inner = current.value[1:-2]
  if stridx(','.settings.html.inline_elements.',', ','.current.name.',') != -1
    let child_inline = 1
  else
    let child_inline = 0
  endif
  for child in current.child
    let html = s:zen_toString(child, type, child_inline, filters)
    if child.name == 'br'
      let inner = substitute(inner, '\n\s*$', '', '')
    endif
    let inner .= html
  endfor
  if len(current.child) == 1 && current.child[0].name == ''
    if stridx(','.settings.html.inline_elements.',', ','.current.name.',') == -1
      let str .= ">" . inner . "</" . current.name . ">\n"
    else
      let str .= ">" . inner . "</" . current.name . ">"
    endif
  elseif len(current.child)
    if inline == 0
      if stridx(','.settings.html.inline_elements.',', ','.current.name.',') == -1
        let inner = substitute(inner, "\n", "\n" . indent, 'g')
        let inner = substitute(inner, indent . "$", "", 'g')
        let str .= ">\n" . indent . inner . "</" . current.name . ">\n"
      else
        let str .= ">" . inner . "</" . current.name . ">\n"
      endif
    else
      let str .= ">" . inner . "</" . current.name . ">"
    endif
  else
    if inline == 0
      if stridx(','.settings.html.empty_elements.',', ','.current.name.',') != -1
        let str .= " />\n"
      else
        if stridx(','.settings.html.inline_elements.',', ','.current.name.',') == -1 && len(current.child)
          let str .= ">\n" . inner . '${cursor}</' . current.name . ">\n"
        else
          let str .= ">" . inner . '${cursor}</' . current.name . ">\n"
        endif
      endif
    else
      if stridx(','.settings.html.empty_elements.',', ','.current.name.',') != -1
        let str .= " />"
      else
        let str .= ">" . inner . '${cursor}</' . current.name . ">"
      endif
    endif
  endif
  if len(comment) > 0
    let str .= "<!-- /" . comment . " -->" . (inline ? "" : "\n") . comment_indent
  endif
  return str
endfunction

function! s:zen_toString(...)
  let current = a:1
  if a:0 > 1
    let type = a:2
  else
    let type = &ft
  endif
"  if !has_key(s:zen_settings, type)
"    let type = 'html'
"  endif
  if len(type) == 0 | let type = 'html' | endif
  if a:0 > 2
    let inline = a:3
  else
    let inline = 0
  endif
  if a:0 > 3
    if type(a:4) == 1
      let filters = split(a:4, '\s*,\s*')
    else
      let filters = a:4
    endif
  else
    let filters = ['html']
  endif

  if has_key(s:zen_settings, type) && has_key(s:zen_settings[type], 'indentation')
    let indent = s:zen_settings[type].indentation
  else
    let indent = s:zen_settings.indentation
  endif
  let itemno = 0
  let str = ''
  while itemno < current.multiplier
    if len(current.name)
      if exists('*g:zen_toString_'.type)
        let str .= function('g:zen_toString_'.type)(s:zen_settings, current, type, inline, filters, itemno, indent)
      elseif s:zen_useFilter(filters, 'haml')
        let str .= s:zen_toString_haml(s:zen_settings, current, type, inline, filters, itemno, indent)
      else
        let str .= s:zen_toString_html(s:zen_settings, current, type, inline, filters, itemno, indent)
      endif
    else
      let snippet = current.snippet
      if len(current.snippet) == 0
        let snippets = s:zen_getResource(type, 'snippets', {})
        if !empty(snippets) && has_key(snippets, 'zensnippet')
          let snippet = snippets['zensnippet']
        endif
      endif
      if len(snippet) > 0
        let tmp = substitute(snippet, '|', '${cursor}', 'g')
        let tmp = substitute(tmp, '\${zenname}', current.name, 'g')
        if type == 'css' && s:zen_useFilter(filters, 'fc')
          let tmp = substitute(tmp, '^\([^:]\+\):\(.*\)$', '\1: \2', '')
        endif
        for attr in keys(current.attr)
          let val = current.attr[attr]
          let tmp = substitute(tmp, '\${' . attr . '}', val, 'g')
        endfor
        let str .= tmp
      else
        if len(current.name)
          let str .= current.name
        endif
        if len(current.value)
          let str .= current.value[1:-2]
        endif
      endif
      let inner = ''
      if len(current.child)
        for n in current.child
          let inner .= s:zen_toString(n, type, inline, filters)
        endfor
        let inner = substitute(inner, "\n", "\n" . indent, 'g')
      endif
      let str = substitute(str, '\${child}', inner, '')
    endif
    let itemno = itemno + 1
  endwhile
  if s:zen_useFilter(filters, 'e')
    let str = substitute(str, '&', '\&amp;', 'g')
    let str = substitute(str, '<', '\&lt;', 'g')
    let str = substitute(str, '>', '\&gt;', 'g')
  endif
  return str
endfunction

function! s:zen_getResource(type, name, default)
  if !has_key(s:zen_settings, a:type)
    return a:default
  endif
  let ret = a:default

  if has_key(s:zen_settings[a:type], a:name)
    call s:zen_mergeConfig(ret, s:zen_settings[a:type][a:name])
  endif

  if has_key(s:zen_settings[a:type], 'extends')
    let extends = s:zen_settings[a:type].extends
    if type(extends) == 1
      let tmp = split(extends, '\s*,\s*')
      unlet! extends
      let extends = tmp
    endif
    for ext in extends
      if has_key(s:zen_settings, ext) && has_key(s:zen_settings[ext], a:name)
        call s:zen_mergeConfig(ret, s:zen_settings[ext][a:name])
      endif
    endfor
  endif
  return ret
endfunction

function! s:zen_getFileType()
  let type = &ft
  if type == 'xslt' | let type = 'xsl' | endif
  if synIDattr(synID(line("."), col("."), 1), "name") =~ '^css'
    let type = 'css'
  endif
  if synIDattr(synID(line("."), col("."), 1), "name") =~ '^html'
    let type = 'html'
  endif
  if synIDattr(synID(line("."), col("."), 1), "name") =~ '^xml'
    let type = 'xml'
  endif
  if synIDattr(synID(line("."), col("."), 1), "name") =~ '^javaScript'
    let type = 'javascript'
  endif
  if len(type) == 0 | let type = 'html' | endif
  return type
endfunction

function! zencoding#expandAbbr(mode) range
  let type = s:zen_getFileType()
  let expand = ''
  let filters = ['html']
  let line = ''
  let part = ''
  let rest = ''

  if has_key(s:zen_settings, type) && has_key(s:zen_settings[type], 'filters')
    let filters = split(s:zen_settings[type].filters, '\s*,\s*')
  endif

  if a:mode == 2
    let leader = substitute(input('Tag: ', ''), '^\s*\(.*\)\s*$', '\1', 'g')
    if len(leader) == 0
      return
    endif
    let mx = '|\(\%(html\|haml\|e\|c\|fc\|xsl\)\s*,\{0,1}\s*\)*$'
    if leader =~ mx
      let filters = split(matchstr(leader, mx)[1:], '\s*,\s*')
      let leader = substitute(leader, mx, '', '')
    endif
    if leader =~ '\*'
      let query = substitute(leader, '*', '*' . (a:lastline - a:firstline + 1), '') . '>{$line$}'
      let items = s:zen_parseIntoTree(query, type).child
      for item in items
        let expand .= s:zen_toString(item, type, 0, filters)
      endfor
      let line = getline(a:firstline)
      let part = substitute(line, '^\s*', '', '')
      for n in range(a:firstline, a:lastline)
        let lline = getline(n)
        let lpart = substitute(lline, '^\s*', '', '')
        let pos = stridx(expand, "$line$")
        if pos != -1
          let expand = expand[:pos-1] . lpart . expand[pos+6:]
        endif
      endfor
    else
      let str = ''
      if a:firstline != a:lastline
        let line = getline(a:firstline)
        let part = substitute(line, '^\s*', '', '')
        for n in range(a:firstline, a:lastline)
          if len(leader) > 0
            let str .= getline(n) . "\n"
          else
            let lpart = substitute(getline(n), '^\s*', '', '')
            let str .= lpart . "\n"
          endif
        endfor
        if len(leader)
          let items = s:zen_parseIntoTree(leader, type).child
          let items[0].value = "{\n".str."}"
        else
          let items = s:zen_parseIntoTree(leader, type).child
          let items[0].value = "{".str."}"
        endif
      else
        let str .= getline(a:firstline)
        let items = s:zen_parseIntoTree(leader, type).child
        let items[0].value = "{".str."}"
      endif
      for item in items
        let expand .= s:zen_toString(item, type, 0, filters)
      endfor
    endif
    silent! exe "normal! gvc"
  else
    let line = getline('.')
    if col('.') < len(line)
      let line = matchstr(line, '^\(.*\%'.col('.').'c.\)')
    endif
    if a:mode == 1
      let part = matchstr(line, '\([a-zA-Z0-9_\@:|]\+\)$')
    else
      let part = matchstr(line, '\(\S.*\)$')
    endif
    let rest = getline('.')[len(line):]
    let str = part
    let mx = '|\(\%(html\|haml\|e\|c\|fc\|xsl\)\s*,\{0,1}\s*\)*$'
    if str =~ mx
      let filters = split(matchstr(str, mx)[1:], '\s*,\s*')
      let str = substitute(str, mx, '', '')
    endif
    let items = s:zen_parseIntoTree(str, type).child
    for item in items
      let expand .= s:zen_toString(item, type, 0, filters)
    endfor
  endif
  if len(expand)
    if expand !~ '\${cursor}'
      if a:mode == 2 |
        let expand = '${cursor}' . expand
      else
        let expand .= '${cursor}'
      endif
    endif
    let expand = substitute(expand, '${lang}', s:zen_settings.lang, 'g')
    let expand = substitute(expand, '${charset}', s:zen_settings.charset, 'g')
    let expand = substitute(expand, '\${cursor}', '$cursor$', '')
    let expand = substitute(expand, '\${cursor}', '', 'g')
    if has_key(s:zen_settings, 'timezone') && len(s:zen_settings.timezone)
      let expand = substitute(expand, '${datetime}', strftime("%Y-%m-%dT%H:%M:%S") . s:zen_settings.timezone, 'g')
    else
      " TODO: on windows, %z/%Z is 'Tokyo(Standard)'
      let expand = substitute(expand, '${datetime}', strftime("%Y-%m-%dT%H:%M:%S %z"), 'g')
    endif
    if line[:-len(part)-1] =~ '^\s\+$'
      let indent = line[:-len(part)-1]
    else
      let indent = ''
    endif
    let expand = substitute(expand, '\n\s*$', '', 'g')
    let expand = line[:-len(part)-1] . substitute(expand, "\n", "\n" . indent, 'g') . rest
    let lines = split(expand, '\n')
    call setline(line('.'), lines[0])
    if len(lines) > 1
      call append(line('.'), lines[1:])
    endif
  endif
  silent! exe "normal! ".len(part)."h"
  if search('\$cursor\$', 'e')
    let oldselection = &selection
    let &selection = 'inclusive'
    silent! exe "normal! v7h\"_s"
    let &selection = oldselection
  endif
  if g:zencoding_debug > 1
    call getchar()
  endif
endfunction

function! zencoding#moveNextPrev(flag)
  if search('><\/\|\(""\)\|^\s*$', a:flag ? 'Wpb' : 'Wp') == 3
    startinsert!
  else
    silent! normal! l
    startinsert
  endif
endfunction

function! zencoding#imageSize()
  let img_region = s:search_region('<img\s', '>')
  if !s:region_is_valid(img_region) || !s:cursor_in_region(img_region)
    return
  endif
  let content = s:get_content(img_region)
  if content !~ '^<img[^><]\+>$'
    return
  endif
  let current = s:zen_parseTag(content)
  let fn = current.attr.src
  if fn !~ '^\(/\|http\)'
    let fn = simplify(expand('%:h') . '/' . fn)
  endif
  let [type, width, height] = ['', -1, -1]

  if filereadable(fn)
    let hex = substitute(system('xxd -p "'.fn.'"'), '\n', '', 'g')
  else
    let hex = substitute(system('curl -s "'.fn.'" | xxd -p'), '\n', '', 'g')
  endif

  if hex =~ '^89504e470d0a1a0a'
    let type = 'png'
    let width = eval('0x'.hex[32:39])
    let height = eval('0x'.hex[40:47])
  endif
  if hex =~ '^ffd8'
    let pos = match(hex, 'ffc[02]')
    let type = 'jpg'
    let height = eval('0x'.hex[pos+10:pos+11])*256 + eval('0x'.hex[pos+12:pos+13])
    let width = eval('0x'.hex[pos+14:pos+15])*256 + eval('0x'.hex[pos+16:pos+17])
  endif
  if hex =~ '^47494638'
    let type = 'gif'
    let width = eval('0x'.hex[14:15].hex[12:13])
    let height = eval('0x'.hex[18:19].hex[16:17])
  endif

  if width == -1 && height == -1
    return
  endif
  let current.attr.width = width
  let current.attr.height = height
  let html = s:zen_toString(current, 'html', 1)
  call s:change_content(img_region, html)
endfunction

function! zencoding#toggleComment()
  if s:zen_getFileType() == 'css'
    let line = getline('.')
    let mx = '^\(\s*\)/\*\s*\(.*\)\s*\*/\s*$'
    if line =~ mx
      let space = substitute(matchstr(line, mx), mx, '\1', '')
      let line = substitute(matchstr(line, mx), mx, '\2', '')
      let line = space . substitute(line, '^\s*\|\s*$', '\1', 'g')
    else
      let mx = '^\(\s*\)\(.*\)\s*$'
      let line = substitute(line, mx, '\1/* \2 */', '')
    endif
    call setline('.', line)
    return
  endif

  let curpos = getpos('.')
  while 1
    let mx = '<\(/\{0,1}[a-zA-Z][a-zA-Z0-9]*\)[^>]*>'
    let pos1 = searchpos(mx, 'bcnW')
    let content = matchstr(getline(pos1[0])[pos1[1]-1:], mx)
    let tag_name = substitute(content, '^<\(/\{0,1}[a-zA-Z0-9]*\).*$', '\1', '')
    let block = [pos1, [pos1[0], pos1[1] + len(content) - 1]]
    if content[-2:] == '/>' && s:point_in_region(curpos[1:2], block)
      let comment_region = s:search_region('<!--', '-->')
      if !s:region_is_valid(comment_region) || !s:point_in_region(curpos[1:2], comment_region) || !(s:point_in_region(comment_region[0], block) && s:point_in_region(comment_region[1], block))
        let content = '<!-- ' . s:get_content(block) . ' -->'
        call s:change_content(block, content)
      else
        let content = s:get_content(comment_region)
        let content = substitute(content, '^<!--\s\(.*\)\s-->$', '\1', '')
        call s:change_content(comment_region, content)
      endif
      return
    else
      if tag_name[0] == '/'
        let pos1 = searchpos('<' . tag_name[1:] . '[^a-zA-Z0-9]', 'bcnW')
        call setpos('.', [0, pos1[0], pos1[1], 0])
        let pos2 = searchpos('</' . tag_name[1:] . '>', 'cneW')
      else
        let pos2 = searchpos('</' . tag_name . '>', 'cneW')
      endif
      let block = [pos1, pos2]
      if !s:region_is_valid(block)
        call setpos('.', curpos)
        let block = s:search_region('<!', '-->')
        if !s:region_is_valid(block)
          return
        endif
      endif
      if s:point_in_region(curpos[1:2], block)
        let comment_region = s:search_region('<!--', '-->')
        if !s:region_is_valid(comment_region) || !s:point_in_region(curpos[1:2], comment_region) || !(s:point_in_region(comment_region[0], block) && s:point_in_region(comment_region[1], block))
          let content = '<!-- ' . s:get_content(block) . ' -->'
          call s:change_content(block, content)
        else
          let content = s:get_content(comment_region)
          let content = substitute(content, '^<!--\s\(.*\)\s-->$', '\1', '')
          call s:change_content(comment_region, content)
        endif
        return
      else
        if block[0][0] > 0
          call setpos('.', [0, block[0][0]-1, block[0][1], 0])
        else
          call setpos('.', curpos)
          return
        endif
      endif
    endif
  endwhile
endfunction

function! zencoding#splitJoinTag()
  let curpos = getpos('.')
  while 1
    let mx = '<\(/\{0,1}[a-zA-Z][a-zA-Z0-9]*\)[^>]*>'
    let pos1 = searchpos(mx, 'bcnW')
    let content = matchstr(getline(pos1[0])[pos1[1]-1:], mx)
    let tag_name = substitute(content, '^<\(/\{0,1}[a-zA-Z0-9]*\).*$', '\1', '')
    let block = [pos1, [pos1[0], pos1[1] + len(content) - 1]]
    if content[-2:] == '/>' && s:cursor_in_region(block)
      let content = content[:-3] . "></" . tag_name . '>'
      call s:change_content(block, content)
      call setpos('.', [0, block[0][0], block[0][1], 0])
      return
    else
      if tag_name[0] == '/'
        let pos1 = searchpos('<' . tag_name[1:] . '[^a-zA-Z0-9]', 'bcnW')
        call setpos('.', [0, pos1[0], pos1[1], 0])
        let pos2 = searchpos('</' . tag_name[1:] . '>', 'cneW')
      else
        let pos2 = searchpos('</' . tag_name . '>', 'cneW')
      endif
      let block = [pos1, pos2]
      let content = s:get_content(block)
      if s:point_in_region(curpos[1:2], block) && content[1:] !~ '<' . tag_name . '[^a-zA-Z0-9]*[^>]*>'
        let content = matchstr(content, mx)[:-2] . '/>'
        call s:change_content(block, content)
        call setpos('.', [0, block[0][0], block[0][1], 0])
        return
      else
        if block[0][0] > 0
          call setpos('.', [0, block[0][0]-1, block[0][1], 0])
        else
          call setpos('.', curpos)
          return
        endif
      endif
    endif
  endwhile
endfunction

function! zencoding#removeTag()
  let curpos = getpos('.')
  while 1
    let mx = '<\(/\{0,1}[a-zA-Z][a-zA-Z0-9]*\)[^>]*>'
    let pos1 = searchpos(mx, 'bcnW')
    let content = matchstr(getline(pos1[0])[pos1[1]-1:], mx)
    let tag_name = substitute(content, '^<\(/\{0,1}[a-zA-Z0-9]*\).*$', '\1', '')
    let block = [pos1, [pos1[0], pos1[1] + len(content) - 1]]
    if content[-2:] == '/>' && s:cursor_in_region(block)
      call s:change_content(block, '')
      call setpos('.', [0, block[0][0], block[0][1], 0])
      return
    else
      if tag_name[0] == '/'
        let pos1 = searchpos('<' . tag_name[1:] . '[^a-zA-Z0-9]', 'bcnW')
        call setpos('.', [0, pos1[0], pos1[1], 0])
        let pos2 = searchpos('</' . tag_name[1:] . '>', 'cneW')
      else
        let pos2 = searchpos('</' . tag_name . '>', 'cneW')
      endif
      let block = [pos1, pos2]
      let content = s:get_content(block)
      if s:point_in_region(curpos[1:2], block) && content[1:] !~ '<' . tag_name . '[^a-zA-Z0-9]*[^>]*>'
        call s:change_content(block, '')
        call setpos('.', [0, block[0][0], block[0][1], 0])
        return
      else
        if block[0][0] > 0
          call setpos('.', [0, block[0][0]-1, block[0][1], 0])
        else
          call setpos('.', curpos)
          return
        endif
      endif
    endif
  endwhile
endfunction

function! zencoding#balanceTag(flag) range
  let vblock = s:get_visualblock()
  if a:flag == -2 || a:flag == 2
    let curpos = [0, line("'<"), col("'<"), 0]
  else
    let curpos = getpos('.')
  endif
  while 1
    let mx = '<\(/\{0,1}[a-zA-Z][a-zA-Z0-9]*\)[^>]*>'
    let pos1 = searchpos(mx, (a:flag == -2 ? 'nW' : 'bcnW'))
    let content = matchstr(getline(pos1[0])[pos1[1]-1:], mx)
    let tag_name = substitute(content, '^<\(/\{0,1}[a-zA-Z0-9]*\).*$', '\1', '')
    let block = [pos1, [pos1[0], pos1[1] + len(content) - 1]]
    if !s:region_is_valid(block)
      break
    endif
    if content[-2:] == '/>' && s:point_in_region(curpos[1:2], block)
      call s:select_region(block)
      return
    else
      if tag_name[0] == '/'
        let pos1 = searchpos('<' . tag_name[1:] . '[^a-zA-Z0-9]', a:flag == -2 ? 'nW' : 'bcnW')
        if pos1[0] == 0
          break
        endif
        call setpos('.', [0, pos1[0], pos1[1], 0])
        let pos2 = searchpos('</' . tag_name[1:] . '>', 'cneW')
      else
        let pos2 = searchpos('</' . tag_name . '>', 'cneW')
      endif
      let block = [pos1, pos2]
      if !s:region_is_valid(block)
        break
      endif
      let content = s:get_content(block)
      if a:flag == -2
        let check = s:region_in_region(vblock, block) && content[1:] !~ '<' . tag_name . '[^a-zA-Z0-9]*[^>]*>'
      else
        let check = s:point_in_region(curpos[1:2], block) && content[1:] !~ '<' . tag_name . '[^a-zA-Z0-9]*[^>]*>'
      endif
      if check
        if a:flag < 0
          let l = getline(pos1[0])
          let content = matchstr(l[pos1[1]-1:], mx)
          if pos1[1] + len(content) > len(l)
            let pos1[0] += 1
          else
            let pos1[1] += len(content)
          endif
          let pos2 = searchpos('\(\n\|.\)</' . tag_name . '>', 'cnW')
        else
          let pos2 = searchpos('</' . tag_name . '>', 'cneW')
        endif
        let block = [pos1, pos2]
        call s:select_region(block)
        return
      else
        if s:region_is_valid(block)
          if a:flag == -2
            if setpos('.', [0, block[0][0]+1, block[0][1], 0]) == -1
              break
            endif
          else
            if setpos('.', [0, block[0][0]-1, block[0][1], 0]) == -1
              break
            endif
          endif
        else
          break
        endif
      endif
    endif
  endwhile
  if a:flag == -2 || a:flag == 2
    silent! exe "normal! gv"
  else
    call setpos('.', curpos)
  endif
endfunction

function! zencoding#anchorizeURL(flag)
  let mx = 'https\=:\/\/[-!#$%&*+,./:;=?@0-9a-zA-Z_~]\+'
  let pos1 = searchpos(mx, 'bcnW')
  let url = matchstr(getline(pos1[0])[pos1[1]-1:], mx)
  let block = [pos1, [pos1[0], pos1[1] + len(url) - 1]]
  if !s:cursor_in_region(block)
    return
  endif

  let content = s:get_content_from_url(url)
  let content = substitute(content, '\n', '', 'g')
  let content = substitute(content, '\n\s*\n', '\n', 'g')
  let head = strpart(content, 0, stridx(content, '</head>'))
  let title = substitute(head, '.*<title[^>]*>\([^<]\+\)<\/title[^>]*>.*', '\1', 'g')

  if a:flag == 0
    let a = s:zen_parseTag('<a>')
    let a.attr.href = url
    let a.value = '{' . title . '}'
    let expand = s:zen_toString(a, 'html', 0, [])
    let expand = substitute(expand, '\${cursor}', '', 'g')
  else
    let body = s:get_text_from_html(content)
    let body = '{' . substitute(body, '^\(.\{0,100}\).*', '\1', '') . '...}'

    let blockquote = s:zen_parseTag('<blockquote class="quote">')
    let a = s:zen_parseTag('<a>')
    let a.attr.href = url
    let a.value = '{' . title . '}'
    call add(blockquote.child, a)
    call add(blockquote.child, s:zen_parseTag('<br/>'))
    let p = s:zen_parseTag('<p>')
    let p.value = body
    call add(blockquote.child, p)
    let cite = s:zen_parseTag('<cite>')
    let cite.value = '{' . url . '}'
    call add(blockquote.child, cite)
    let expand = s:zen_toString(blockquote, 'html', 0, [])
    let expand = substitute(expand, '\${cursor}', '', 'g')
    let indent = substitute(getline('.'), '^\(\s*\).*', '\1', '')
    let expand = substitute(expand, "\n", "\n" . indent, 'g')
  endif
  call s:change_content(block, expand)
endfunction

"==============================================================================
" html utils
"==============================================================================
function! s:get_content_from_url(url)
  silent! new
  silent! exec '0r!curl -s -L "'.substitute(a:url, '#.*', '', '').'"'
  let ret = join(getline(1, '$'), "\n")
  silent! bw!
  return ret
endfunction

function! s:get_text_from_html(buf)
  let threshold_len = 100
  let threshold_per = 0.1
  let buf = a:buf

  let buf = substitute(buf, '<!--.\{-}-->', '', 'g')
  let buf = strpart(buf, stridx(buf, '</head>'))
  let buf = substitute(buf, '<style[^>]*>.\{-}</style>', '', 'g')
  let buf = substitute(buf, '<script[^>]*>.\{-}</script>', '', 'g')
  let res = ''
  let max = 0
  let mx = '\(<td[^>]\{-}>\)\|\(<\/td>\)\|\(<div[^>]\{-}>\)\|\(<\/div>\)'
  let m = split(buf, mx)
  for str in m
    let c = split(str, '<[^>]*?>')
    let str = substitute(str, '<[^>]\{-}>', '', 'g')
    let str = substitute(str, '&gt;', '>', 'g')
    let str = substitute(str, '&lt;', '<', 'g')
    let str = substitute(str, '&quot;', '"', 'g')
    let str = substitute(str, '&apos;', "'", 'g')
    let str = substitute(str, '&nbsp;', ' ', 'g')
    let str = substitute(str, '&yen;', '\&#65509;', 'g')
    let str = substitute(str, '&amp;', '\&', 'g')
    let str = substitute(str, '^\s*\(.*\)\s*$', '\1', '')
    let str = substitute(str, '\s\+', ' ', 'g')
    let l = len(str)
    if l > threshold_len
      let per = len(c) / l
      if max < l && per < threshold_per
          let max = l
          let res = str
      endif
    endif
  endfor
  let res = substitute(res, '^\s*\(.*\)\s*$', '\1', 'g')
  return res
endfunction
"==============================================================================

"==============================================================================
" region utils
"==============================================================================
" delete_content : delete content in region
"   if region make from between '<foo>' and '</foo>'
"   --------------------
"   begin:<foo>
"   </foo>:end
"   --------------------
"   this function make the content as following
"   --------------------
"   begin::end
"   --------------------
function! s:delete_content(region)
  let lines = getline(a:region[0][0], a:region[1][0])
  call setpos('.', [0, a:region[0][0], a:region[0][1], 0])
  silent! exe "delete ".(a:region[1][0] - a:region[0][0])
  call setline(line('.'), lines[0][:a:region[0][1]-2] . lines[-1][a:region[1][1]])
endfunction

" change_content : change content in region
"   if region make from between '<foo>' and '</foo>'
"   --------------------
"   begin:<foo>
"   </foo>:end
"   --------------------
"   and content is
"   --------------------
"   foo
"   bar
"   baz
"   --------------------
"   this function make the content as following
"   --------------------
"   begin:foo
"   bar
"   baz:end
"   --------------------
function! s:change_content(region, content)
  let newlines = split(a:content, '\n')
  let oldlines = getline(a:region[0][0], a:region[1][0])
  call setpos('.', [0, a:region[0][0], a:region[0][1], 0])
  silent! exe "delete ".(a:region[1][0] - a:region[0][0])
  if len(newlines) == 0
    let tmp = ''
    if a:region[0][1] > 1
      let tmp = oldlines[0][:a:region[0][1]-2]
    endif
    if a:region[1][1] > 1
      let tmp .= oldlines[-1][a:region[1][1]:]
    endif
    call setline(line('.'), tmp)
  elseif len(newlines) == 1
    if a:region[0][1] > 1
      let newlines[0] = oldlines[0][:a:region[0][1]-2] . newlines[0]
    endif
    if a:region[1][1] > 1
      let newlines[0] .= oldlines[-1][a:region[1][1]:]
    endif
    call setline(line('.'), newlines[0])
  else
    if a:region[0][1] > 1
      let newlines[0] = oldlines[0][:a:region[0][1]-2] . newlines[0]
    endif
    if a:region[1][1] > 1
      let newlines[-1] .= oldlines[-1][a:region[1][1]:]
    endif
    call setline(line('.'), newlines[0])
    call append(line('.'), newlines[1:])
  endif
endfunction

" select_region : select region
"   this function make a selection of region
function! s:select_region(region)
  call setpos('.', [0, a:region[1][0], a:region[1][1], 0])
  normal! v
  call setpos('.', [0, a:region[0][0], a:region[0][1], 0])
endfunction

" point_in_region : check point is in the region
"   this function return 0 or 1
function! s:point_in_region(point, region)
  if !s:region_is_valid(a:region) | return 0 | endif
  if a:region[0][0] > a:point[0] | return 0 | endif
  if a:region[1][0] < a:point[0] | return 0 | endif
  if a:region[0][0] == a:point[0] && a:region[0][1] > a:point[1] | return 0 | endif
  if a:region[1][0] == a:point[0] && a:region[1][1] < a:point[1] | return 0 | endif
  return 1
endfunction

" cursor_in_region : check cursor is in the region
"   this function return 0 or 1
function! s:cursor_in_region(region)
  if !s:region_is_valid(a:region) | return 0 | endif
  let cur = getpos('.')[1:2]
  return s:point_in_region(cur, a:region)
endfunction

" region_is_valid : check region is valid
"   this function return 0 or 1
function! s:region_is_valid(region)
  if a:region[0][0] == 0 || a:region[1][0] == 0 | return 0 | endif
  return 1
endfunction

" search_region : make region from pattern which is composing start/end
"   this function return array of position
function! s:search_region(start, end)
  return [searchpos(a:start, 'bcnW'), searchpos(a:end, 'cneW')]
endfunction

" get_content : get content in region
"   this function return string in region
function! s:get_content(region)
  if !s:region_is_valid(a:region)
    return ''
  endif
  let lines = getline(a:region[0][0], a:region[1][0])
  if a:region[0][0] == a:region[1][0]
    let lines[0] = lines[0][a:region[0][1]-1:a:region[1][1]-1]
  else
    let lines[0] = lines[0][a:region[0][1]-1:]
    let lines[-1] = lines[-1][:a:region[1][1]-1]
  endif
  return join(lines, "\n")
endfunction

" region_in_region : check region is in the region
"   this function return 0 or 1
function! s:region_in_region(outer, inner)
  if !s:region_is_valid(a:inner) || !s:region_is_valid(a:outer)
    return 0
  endif
  return s:point_in_region(a:inner[0], a:outer) && s:point_in_region(a:inner[1], a:outer)
endfunction

" get_visualblock : get region of visual block
"   this function return region of visual block
function! s:get_visualblock()
  return [[line("'<"), col("'<")], [line("'>"), col("'>")]]
endfunction
"==============================================================================

function! zencoding#ExpandWord(abbr, type, orig)
  let mx = '|\(\%(html\|haml\|e\|c\|fc\|xsl\)\s*,\{0,1}\s*\)*$'
  let str = a:abbr
  let type = a:type

  if len(type) == 0 | let type = 'html' | endif
  if str =~ mx
    let filters = split(matchstr(str, mx)[1:], '\s*,\s*')
    let str = substitute(str, mx, '', '')
  elseif has_key(s:zen_settings[a:type], 'filters')
    let filters = split(s:zen_settings[a:type].filters, '\s*,\s*')
  else
    let filters = ['html']
  endif
  let items = s:zen_parseIntoTree(str, a:type).child
  let expand = ''
  for item in items
    let expand .= s:zen_toString(item, a:type, 0, filters)
  endfor
  if a:orig == 0
    let expand = substitute(expand, '\${lang}', s:zen_settings.lang, 'g')
    let expand = substitute(expand, '\${charset}', s:zen_settings.charset, 'g')
    let expand = substitute(expand, '\${cursor}', '', 'g')
  endif
  return expand
endfunction

function! zencoding#CompleteTag(findstart, base)
  if a:findstart
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '[a-zA-Z0-9:\@]'
      let start -= 1
    endwhile
    return start
  else
    let type = s:zen_getFileType()
    let res = []

    let snippets = s:zen_getResource(type, 'snippets', {})
    for item in keys(snippets)
      if stridx(item, a:base) != -1
        call add(res, substitute(item, '\${cursor}\||', '', 'g'))
      endif
    endfor
    let aliases = s:zen_getResource(type, 'aliases', {})
    for item in values(aliases)
      if stridx(item, a:base) != -1
        call add(res, substitute(item, '\${cursor}\||', '', 'g'))
      endif
    endfor
    return res
  endif
endfunction

unlet! s:zen_settings
let s:zen_settings = {
\    'indentation': "\t",
\    'lang': "en",
\    'charset': "UTF-8",
\    'css': {
\        'snippets': {
\            "g": "/* @group name */\n\n\n\n/* @end */\n\n",
\            "@i": "@import url();",
\            "@m": "@media print {\n\t\n}\n\n",
\            "@f": "@font-face {\n\tfont-family:;\n\tsrc:url();\n}\n\n",
\            "!": "!important\n\n",
\            "pos": "position: px;\n\n",
\            "pos:s": "position: static;\n\n",
\            "pos:a": "position: absolute;\n\n",
\            "pos:r": "position: relative;\n\n",
\            "pos:f": "position: fixed;\n\n",
\            "t": "top: ;\n\n",
\            "t:0": "top: 0;\n\n",
\            "t:a": "top: auto;\n\n",
\            "r": "right: px;\n\n",
\            "r:a": "right: auto;\n\n",
\            "b": "bottom: px;\n\n",
\            "b:a": "bottom: auto;\n\n",
\            "l": "left: px;\n\n",
\            "l:0": "left: 0;\n\n",
\            "l:a": "left: auto;\n\n",
\            "z": "z-index: 0;\n\n",
\            "z:a": "z-index: auto;\n\n",
\            "fl": "float: left;\n\n",
\            "fl:n": "float: none;\n\n",
\            "fl:l": "float: left;\n\n",
\            "fl:r": "float: right;\n\n",
\            "cl": "clear: both;\n\n",
\            "cl:n": "clear: none;\n\n",
\            "cl:l": "clear: left;\n\n",
\            "cl:r": "clear: right;\n\n",
\            "cl:b": "clear: both;\n\n",
\            "d": "display: block;\n\n",
\            "d:n": "display: none;\n\n",
\            "d:b": "display: block;\n\n",
\            "d:i": "display: inline;\n\n",
\            "d:ib": "display: inline-block;\n\n",
\            "d:li": "display: list-item;\n\n",
\            "d:ri": "display: run-in;\n\n",
\            "d:cp": "display: compact;\n\n",
\            "d:tb": "display: table;\n\n",
\            "d:itb": "display: inline-table;\n\n",
\            "d:tbcp": "display: table-caption;\n\n",
\            "d:tbcl": "display: table-column;\n\n",
\            "d:tbclg": "display: table-column-group;\n\n",
\            "d:tbhg": "display: table-header-group;\n\n",
\            "d:tbfg": "display: table-footer-group;\n\n",
\            "d:tbr": "display: table-row;\n\n",
\            "d:tbrg": "display: table-row-group;\n\n",
\            "d:tbc": "display: table-cell;\n\n",
\            "d:rb": "display: ruby;\n\n",
\            "d:rbb": "display: ruby-base;\n\n",
\            "d:rbbg": "display: ruby-base-group;\n\n",
\            "d:rbt": "display: ruby-text;\n\n",
\            "d:rbtg": "display: ruby-text-group;\n\n",
\            "v": "visibility: hidden;\n\n",
\            "v:v": "visibility: visible;\n\n",
\            "v:h": "visibility: hidden;\n\n",
\            "v:c": "visibility: collapse;\n\n",
\            "ov": "overflow: hidden;\n\n",
\            "ov:v": "overflow: visible;\n\n",
\            "ov:h": "overflow: hidden;\n\n",
\            "ov:s": "overflow: scroll;\n\n",
\            "ov:a": "overflow: auto;\n\n",
\            "ovx": "overflow-x: hidden;\n\n",
\            "ovx:v": "overflow-x: visible;\n\n",
\            "ovx:h": "overflow-x: hidden;\n\n",
\            "ovx:s": "overflow-x: scroll;\n\n",
\            "ovx:a": "overflow-x: auto;\n\n",
\            "ovy": "overflow-y: hidden;\n\n",
\            "ovy:v": "overflow-y: visible;\n\n",
\            "ovy:h": "overflow-y: hidden;\n\n",
\            "ovy:s": "overflow-y: scroll;\n\n",
\            "ovy:a": "overflow-y: auto;\n\n",
\            "ovs": "overflow-style: auto;\n\n",
\            "ovs:a": "overflow-style: auto;\n\n",
\            "ovs:s": "overflow-style: scrollbar;\n\n",
\            "ovs:p": "overflow-style: panner;\n\n",
\            "ovs:m": "overflow-style: move;\n\n",
\            "ovs:mq": "overflow-style: marquee;\n\n",
\            "zoo": "zoom: 1;\n\n",
\            "cp": "clip: auto;\n\n",
\            "cp:a": "clip: auto;\n\n",
\            "cp:r": "clip: rect();\n\n",
\            "m": "margin: 0px;\n\n",
\            "m:a": "margin: auto;\n\n",
\            "m:0": "margin: 0;\n\n",
\            "m:2": "margin: 0 0;\n\n",
\            "m:3": "margin: 0 0 0;\n\n",
\            "m:4": "margin: 0 0 0 0;\n\n",
\            "mt": "margin-top: 0;\n\n",
\            "mt:a": "margin-top: auto;\n\n",
\            "mr": "margin-right: 0;\n\n",
\            "mr:a": "margin-right: auto;\n\n",
\            "mb": "margin-bottom: 0;\n\n",
\            "mb:a": "margin-bottom: auto;\n\n",
\            "ml": "margin-left: 0;\n\n",
\            "ml:a": "margin-left: auto;\n\n",
\            "p": "padding: 0px;\n\n",
\            "p:0": "padding: 0;\n\n",
\            "p:2": "padding: 0 0;\n\n",
\            "p:3": "padding: 0 0 0;\n\n",
\            "p:4": "padding: 0 0 0 0;\n\n",
\            "pt": "padding-top: 0px;\n\n",
\            "pr": "padding-right: 0px;\n\n",
\            "pb": "padding-bottom: 0px;\n\n",
\            "pl": "padding-left: 0px;\n\n",
\            "w": "width: 0px;\n\n",
\            "w:0": "width: 0;\n\n",
\            "w:a": "width: auto;\n\n",
\            "h": "height: 0px;\n\n",
\            "h:0": "height: 0;\n\n",
\            "h:a": "height: auto;\n\n",
\            "maw": "max-width: 0px;\n\n",
\            "maw:n": "max-width: none;\n\n",
\            "mah": "max-height: 0px;\n\n",
\            "mah:n": "max-height: none;\n\n",
\            "miw": "min-width: 0px;\n\n",
\            "mih": "min-height: 0px;\n\n",
\            "o": "outline: none;\n\n",
\            "o:n": "outline: none;\n\n",
\            "oo": "outline-offset: 0px;\n\n",
\            "ow": "outline-width: 1px;\n\n",
\            "os": "outline-style: solid;\n\n",
\            "oc": "outline-color: #000;\n\n",
\            "oc:i": "outline-color: invert;\n\n",
\            "bd": "border: 1px solid #000;\n\n",
\            "bd+": "border: 1px solid #000;\n\n",
\            "bd:n": "border: none;\n\n",
\            "bdc": "border-color: #000;\n\n",
\            "bdl": "border-left: 0px;\n\n",
\            "bdl:a": "border-length: auto;\n\n",
\            "bdsp": "border-spacing: 0px;\n\n",
\            "bds": "border-style: solid;\n\n",
\            "bds:n": "border-style: none;\n\n",
\            "bds:h": "border-style: hidden;\n\n",
\            "bds:dt": "border-style: dotted;\n\n",
\            "bds:ds": "border-style: dashed;\n\n",
\            "bds:s": "border-style: solid;\n\n",
\            "bds:db": "border-style: double;\n\n",
\            "bds:dtds": "border-style: dot-dash;\n\n",
\            "bds:dtdtds": "border-style: dot-dot-dash;\n\n",
\            "bds:w": "border-style: wave;\n\n",
\            "bds:g": "border-style: groove;\n\n",
\            "bds:r": "border-style: ridge;\n\n",
\            "bds:i": "border-style: inset;\n\n",
\            "bds:o": "border-style: outset;\n\n",
\            "bdw": "border-width: 0px;\n\n",
\            "bdt": "border-top: 0px;\n\n",
\            "bdt+": "border-top: 1px solid #000;\n\n",
\            "bdt:n": "border-top: none;\n\n",
\            "bdtw": "border-top-width: 0px;\n\n",
\            "bdts": "border-top-style: 0px;\n\n",
\            "bdts:n": "border-top-style: none;\n\n",
\            "bdtc": "border-top-color: #000;\n\n",
\            "bdr": "border-right: 0px;\n\n",
\            "bdr+": "border-right: 1px solid #000;\n\n",
\            "bdr:n": "border-right: none;\n\n",
\            "bdrw": "border-right-width: 0px;\n\n",
\            "bdrs": "border-right-style: solid;\n\n",
\            "bdrs:n": "border-right-style: none;\n\n",
\            "bdrc": "border-right-color: #000;\n\n",
\            "bdb": "border-bottom: 0px;\n\n",
\            "bdb+": "border-bottom: 1px solid #000;\n\n",
\            "bdb:n": "border-bottom: none;\n\n",
\            "bdbw": "border-bottom-width: 0px;\n\n",
\            "bdbs": "border-bottom-style: solid;\n\n",
\            "bdbs:n": "border-bottom-style: none;\n\n",
\            "bdbc": "border-bottom-color: #000;\n\n",
\            "bdl+": "border-left: 1px solid #000;\n\n",
\            "bdl:n": "border-left: none;\n\n",
\            "bdlw": "border-left-width: 0px;\n\n",
\            "bdls": "border-left-style: solid;\n\n",
\            "bdls:n": "border-left-style: none;\n\n",
\            "bdlc": "border-left-color: #000;\n\n",
\            "bg": "background: none;\n\n",
\            "bg+": "background: #FFF url() 0 0 no-repeat;\n\n",
\            "bg:n": "background: none;\n\n",
\            "bgc": "background-color: #FFF;\n\n",
\            "bgi": "background-image: url();\n\n",
\            "bgi:n": "background-image: none;\n\n",
\            "bgr": "background-repeat: no-repeat;\n\n",
\            "bgr:n": "background-repeat: no-repeat;\n\n",
\            "bgr:x": "background-repeat: repeat-x;\n\n",
\            "bgr:y": "background-repeat: repeat-y;\n\n",
\            "bga": "background-attachment: fixed;\n\n",
\            "bga:f": "background-attachment: fixed;\n\n",
\            "bga:s": "background-attachment: scroll;\n\n",
\            "bgp": "background-position: 0 0;\n\n",
\            "bgpx": "background-position-x: 0px;\n\n",
\            "bgpy": "background-position-y: 0px;\n\n",
\            "bgcp": "background-clip: padding-box;\n\n",
\            "bgcp:bb": "background-clip: border-box;\n\n",
\            "bgcp:pb": "background-clip: padding-box;\n\n",
\            "bgcp:cb": "background-clip: content-box;\n\n",
\            "bgcp:nc": "background-clip: no-clip;\n\n",
\            "bgo": "background-origin: padding-box;\n\n",
\            "bgo:pb": "background-origin: padding-box;\n\n",
\            "bgo:bb": "background-origin: border-box;\n\n",
\            "bgo:cb": "background-origin: content-box;\n\n",
\            "bgz": "background-size: contain;n\n",
\            "bgz:a": "background-size: auto;\n\n",
\            "bgz:ct": "background-size: contain;\n\n",
\            "bgz:cv": "background-size: cover;\n\n",
\            "c": "color: #000;\n\n",
\            "tbl": "table-layout: auto;\n\n",
\            "tbl:a": "table-layout: auto;\n\n",
\            "tbl:f": "table-layout: fixed;\n\n",
\            "cps": "caption-side: top;\n\n",
\            "cps:t": "caption-side: top;\n\n",
\            "cps:b": "caption-side: bottom;\n\n",
\            "ec": "empty-cells: |;\n\n",
\            "ec:s": "empty-cells: show;\n\n",
\            "ec:h": "empty-cells: hide;\n\n",
\            "ls": "list-style: none;\n\n",
\            "ls:n": "list-style: none;\n\n",
\            "lsp": "list-style-position: outside;\n\n",
\            "lsp:i": "list-style-position: inside;\n\n",
\            "lsp:o": "list-style-position: outside;\n\n",
\            "lst": "list-style-type: none;\n\n",
\            "lst:n": "list-style-type: none;\n\n",
\            "lst:d": "list-style-type: disc;\n\n",
\            "lst:c": "list-style-type: circle;\n\n",
\            "lst:s": "list-style-type: square;\n\n",
\            "lst:dc": "list-style-type: decimal;\n\n",
\            "lst:dclz": "list-style-type: decimal-leading-zero;\n\n",
\            "lst:lr": "list-style-type: lower-roman;\n\n",
\            "lst:ur": "list-style-type: upper-roman;\n\n",
\            "lsi": "list-style-image: none;\n\n",
\            "lsi:n": "list-style-image: none;\n\n",
\            "q": "quotes: |;\n\n",
\            "q:n": "quotes: none;\n\n",
\            "ct": "content: \"\";\n\n",
\            "ct:n": "content: normal;\n\n",
\            "ct:oq": "content: open-quote;\n\n",
\            "ct:noq": "content: no-open-quote;\n\n",
\            "ct:cq": "content: close-quote;\n\n",
\            "ct:ncq": "content: no-close-quote;\n\n",
\            "ct:a": "content: attr();\n\n",
\            "ct:c": "content: counter();\n\n",
\            "ct:cs": "content: counters();\n\n",
\            "coi": "counter-increment: 1;\n\n",
\            "cor": "counter-reset: ;\n\n",
\            "va": "vertical-align: top;\n\n",
\            "va:sup": "vertical-align: super;\n\n",
\            "va:t": "vertical-align: top;\n\n",
\            "va:tt": "vertical-align: text-top;\n\n",
\            "va:m": "vertical-align: middle;\n\n",
\            "va:bl": "vertical-align: baseline;\n\n",
\            "va:b": "vertical-align: bottom;\n\n",
\            "va:tb": "vertical-align: text-bottom;\n\n",
\            "va:sub": "vertical-align: sub;\n\n",
\            "ta": "text-align: center;\n\n",
\            "ta:l": "text-align: left;\n\n",
\            "ta:c": "text-align: center;\n\n",
\            "ta:r": "text-align: right;\n\n",
\            "tal": "text-align-last: ;\n\n",
\            "tal:a": "text-align-last: auto;\n\n",
\            "tal:l": "text-align-last: left;\n\n",
\            "tal:c": "text-align-last: center;\n\n",
\            "tal:r": "text-align-last: right;\n\n",
\            "td": "text-decoration: none;\n\n",
\            "td:n": "text-decoration: none;\n\n",
\            "td:u": "text-decoration: underline;\n\n",
\            "td:o": "text-decoration: overline;\n\n",
\            "td:l": "text-decoration: line-through;\n\n",
\            "te": "text-emphasis: ;\n\n",
\            "te:n": "text-emphasis: none;\n\n",
\            "te:ac": "text-emphasis: accent;\n\n",
\            "te:dt": "text-emphasis: dot;\n\n",
\            "te:c": "text-emphasis: circle;\n\n",
\            "te:ds": "text-emphasis: disc;\n\n",
\            "te:b": "text-emphasis: before;\n\n",
\            "te:a": "text-emphasis: after;\n\n",
\            "th": "text-height: ;\n\n",
\            "th:a": "text-height: auto;\n\n",
\            "th:f": "text-height: font-size;\n\n",
\            "th:t": "text-height: text-size;\n\n",
\            "th:m": "text-height: max-size;\n\n",
\            "ti": "text-indent: -9999px;\n\n",
\            "ti:-": "text-indent: -9999px;\n\n",
\            "tj": "text-justify: ;\n\n",
\            "tj:a": "text-justify: auto;\n\n",
\            "tj:iw": "text-justify: inter-word;\n\n",
\            "tj:ii": "text-justify: inter-ideograph;\n\n",
\            "tj:ic": "text-justify: inter-cluster;\n\n",
\            "tj:d": "text-justify: distribute;\n\n",
\            "tj:k": "text-justify: kashida;\n\n",
\            "tj:t": "text-justify: tibetan;\n\n",
\            "to": "text-outline: ;\n\n",
\            "to+": "text-outline: 0 0 #000;\n\n",
\            "to:n": "text-outline: none;\n\n",
\            "tr": "text-replace: ;\n\n",
\            "tr:n": "text-replace: none;\n\n",
\            "tt": "text-transform: uppercase;\n\n",
\            "tt:n": "text-transform: none;\n\n",
\            "tt:c": "text-transform: capitalize;\n\n",
\            "tt:u": "text-transform: uppercase;\n\n",
\            "tt:l": "text-transform: lowercase;\n\n",
\            "tw": "text-wrap: normal;\n\n",
\            "tw:n": "text-wrap: normal;\n\n",
\            "tw:no": "text-wrap: none;\n\n",
\            "tw:u": "text-wrap: unrestricted;\n\n",
\            "tw:s": "text-wrap: suppress;\n\n",
\            "ts": "text-shadow: 0 0 0 #000;\n\n",
\            "ts+": "text-shadow: 0 0 0 #000;\n\n",
\            "ts:n": "text-shadow: none;\n\n",
\            "lh": "line-height: 1.45;\n\n",
\            "ws": "white-space: normal;\n\n",
\            "ws:n": "white-space: normal;\n\n",
\            "ws:p": "white-space: pre;\n\n",
\            "whs:nw": "white-space: nowrap;\n\n",
\            "ws:pw": "white-space: pre-wrap;\n\n",
\            "ws:pl": "white-space: pre-line;\n\n",
\            "wsc": "white-space-collapse: |;\n\n",
\            "wsc:n": "white-space-collapse: normal;\n\n",
\            "wsc:k": "white-space-collapse: keep-all;\n\n",
\            "wsc:l": "white-space-collapse: loose;\n\n",
\            "wsc:bs": "white-space-collapse: break-strict;\n\n",
\            "wsc:ba": "white-space-collapse: break-all;\n\n",
\            "wob": "word-break: |;\n\n",
\            "wob:n": "word-break: normal;\n\n",
\            "wob:k": "word-break: keep-all;\n\n",
\            "wob:l": "word-break: loose;\n\n",
\            "wob:bs": "word-break: break-strict;\n\n",
\            "wob:ba": "word-break: break-all;\n\n",
\            "wos": "word-spacing: |;\n\n",
\            "wow": "word-wrap: |;\n\n",
\            "wow:nm": "word-wrap: normal;\n\n",
\            "wow:n": "word-wrap: none;\n\n",
\            "wow:u": "word-wrap: unrestricted;\n\n",
\            "wow:s": "word-wrap: suppress;\n\n",
\            "lts": "letter-spacing: 1px;\n\n",
\            "f": "font: ;\n\n",
\            "fw": "font-weight: bold;\n\n",
\            "fw:n": "font-weight: normal;\n\n",
\            "fw:b": "font-weight: bold;\n\n",
\            "fw:br": "font-weight: bolder;\n\n",
\            "fw:lr": "font-weight: lighter;\n\n",
\            "fs": "font-style: italic;\n\n",
\            "fs:n": "font-style: normal;\n\n",
\            "fs:i": "font-style: italic;\n\n",
\            "fs:o": "font-style: oblique;\n\n",
\            "fv": "font-variant: small-caps;\n\n",
\            "fv:n": "font-variant: normal;\n\n",
\            "fv:sc": "font-variant: small-caps;\n\n",
\            "fz": "font-size: 12px;\n\n",
\            "fza": "font-size-adjust: 0px;\n\n",
\            "fza:n": "font-size-adjust: none;\n\n",
\            "ff": "font-family: sans-serif;\n\n",
\            "ff:s": "font-family: serif;\n\n",
\            "ff:ss": "font-family: sans-serif;\n\n",
\            "ff:c": "font-family: cursive;\n\n",
\            "ff:f": "font-family: fantasy;\n\n",
\            "ff:m": "font-family: monospace;\n\n",
\            "fef": "font-effect: none;\n\n",
\            "fef:n": "font-effect: none;\n\n",
\            "fef:eg": "font-effect: engrave;\n\n",
\            "fef:eb": "font-effect: emboss;\n\n",
\            "fef:o": "font-effect: outline;\n\n",
\            "fem": "font-emphasize: |;\n\n",
\            "femp": "font-emphasize-position: |;\n\n",
\            "femp:b": "font-emphasize-position: before;\n\n",
\            "femp:a": "font-emphasize-position: after;\n\n",
\            "fems": "font-emphasize-style: |;\n\n",
\            "fems:n": "font-emphasize-style: none;\n\n",
\            "fems:ac": "font-emphasize-style: accent;\n\n",
\            "fems:dt": "font-emphasize-style: dot;\n\n",
\            "fems:c": "font-emphasize-style: circle;\n\n",
\            "fems:ds": "font-emphasize-style: disc;\n\n",
\            "fsm": "font-smooth: |;\n\n",
\            "fsm:a": "font-smooth: auto;\n\n",
\            "fsm:n": "font-smooth: never;\n\n",
\            "fsm:aw": "font-smooth: always;\n\n",
\            "fst": "font-stretch: |;\n\n",
\            "fst:n": "font-stretch: normal;\n\n",
\            "fst:uc": "font-stretch: ultra-condensed;\n\n",
\            "fst:ec": "font-stretch: extra-condensed;\n\n",
\            "fst:c": "font-stretch: condensed;\n\n",
\            "fst:sc": "font-stretch: semi-condensed;\n\n",
\            "fst:se": "font-stretch: semi-expanded;\n\n",
\            "fst:e": "font-stretch: expanded;\n\n",
\            "fst:ee": "font-stretch: extra-expanded;\n\n",
\            "fst:ue": "font-stretch: ultra-expanded;\n\n",
\            "op": "opacity: 0;\n\n",
\            "rz": "resize: |;\n\n",
\            "rz:n": "resize: none;\n\n",
\            "rz:b": "resize: both;\n\n",
\            "rz:h": "resize: horizontal;\n\n",
\            "rz:v": "resize: vertical;\n\n",
\            "cur": "cursor: pointer;\n\n",
\            "cur:a": "cursor: auto;\n\n",
\            "cur:d": "cursor: default;\n\n",
\            "cur:c": "cursor: crosshair;\n\n",
\            "cur:ha": "cursor: hand;\n\n",
\            "cur:he": "cursor: help;\n\n",
\            "cur:m": "cursor: move;\n\n",
\            "cur:p": "cursor: pointer;\n\n",
\            "cur:t": "cursor: text;\n\n",
\            "pgbb": "page-break-before: |;\n\n",
\            "pgbb:au": "page-break-before: auto;\n\n",
\            "pgbb:al": "page-break-before: always;\n\n",
\            "pgbb:l": "page-break-before: left;\n\n",
\            "pgbb:r": "page-break-before: right;\n\n",
\            "pgbi": "page-break-inside: |;\n\n",
\            "pgbi:au": "page-break-inside: auto;\n\n",
\            "pgbi:av": "page-break-inside: avoid;\n\n",
\            "pgba": "page-break-after: |;\n\n",
\            "pgba:au": "page-break-after: auto;\n\n",
\            "pgba:al": "page-break-after: always;\n\n",
\            "pgba:l": "page-break-after: left;\n\n",
\            "pgba:r": "page-break-after: right;\n\n",
\            "orp": "orphans: |;\n\n",
\            "wid": "widows: |\n\n;"
\        }
\    },
\    'html': {
\        'snippets': {
\            'cc:ie6': "<!--[if lte IE 6]>\n\t${child}|\n<![endif]-->",
\            'cc:ie': "<!--[if IE]>\n\t${child}|\n<![endif]-->",
\            'cc:noie': "<!--[if !IE]><!-->\n\t${child}|\n<!--<![endif]-->",
\            'html:4t': "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\n"
\                    ."<html lang=\"${lang}\">\n"
\                    ."<head>\n"
\                    ."    <meta http-equiv=\"Content-Type\" content=\"text/html;charset=${charset}\">\n"
\                    ."    <title></title>\n"
\                    ."</head>\n"
\                    ."<body>\n\t${child}|\n</body>\n"
\                    ."</html>",
\            'html:4s': "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n"
\                    ."<html lang=\"${lang}\">\n"
\                    ."<head>\n"
\                    ."    <meta http-equiv=\"Content-Type\" content=\"text/html;charset=${charset}\">\n"
\                    ."    <title></title>\n"
\                    ."</head>\n"
\                    ."<body>\n\t${child}|\n</body>\n"
\                    ."</html>",
\            'html:xt': "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n"
\                    ."<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"${lang}\">\n"
\                    ."<head>\n"
\                    ."    <meta http-equiv=\"Content-Type\" content=\"text/html;charset=${charset}\" />\n"
\                    ."    <title></title>\n"
\                    ."</head>\n"
\                    ."<body>\n\t${child}|\n</body>\n"
\                    ."</html>",
\            'html:xs': "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n"
\                    ."<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"${lang}\">\n"
\                    ."<head>\n"
\                    ."    <meta http-equiv=\"Content-Type\" content=\"text/html;charset=${charset}\" />\n"
\                    ."    <title></title>\n"
\                    ."</head>\n"
\                    ."<body>\n\t${child}|\n</body>\n"
\                    ."</html>",
\            'html:xxs': "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">\n"
\                    ."<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"${lang}\">\n"
\                    ."<head>\n"
\                    ."    <meta http-equiv=\"Content-Type\" content=\"text/html;charset=${charset}\" />\n"
\                    ."    <title></title>\n"
\                    ."</head>\n"
\                    ."<body>\n\t${child}|\n</body>\n"
\                    ."</html>",
\            'html:5': "<!DOCTYPE HTML>\n"
\                    ."<html lang=\"${lang}\">\n"
\                    ."<head>\n"
\                    ."    <meta charset=\"${charset}\">\n"
\                    ."    <title></title>\n"
\                    ."</head>\n"
\                    ."<body>\n\t${child}|\n</body>\n"
\                    ."</html>"
\        },
\        'default_attributes': {
\            'a': {'href': ''},
\            'a:link': {'href': 'http://|'},
\            'a:mail': {'href': 'mailto:|'},
\            'abbr': {'title': ''},
\            'acronym': {'title': ''},
\            'base': {'href': ''},
\            'bdo': {'dir': ''},
\            'bdo:r': {'dir': 'rtl'},
\            'bdo:l': {'dir': 'ltr'},
\            'del': {'datetime': '${datetime}'},
\            'ins': {'datetime': '${datetime}'},
\            'link:css': [{'rel': 'stylesheet'}, {'type': 'text/css'}, {'href': '|style.css'}, {'media': 'all'}],
\            'link:print': [{'rel': 'stylesheet'}, {'type': 'text/css'}, {'href': '|print.css'}, {'media': 'print'}],
\            'link:favicon': [{'rel': 'shortcut icon'}, {'type': 'image/x-icon'}, {'href': '|favicon.ico'}],
\            'link:touch': [{'rel': 'apple-touch-icon'}, {'href': '|favicon.png'}],
\            'link:rss': [{'rel': 'alternate'}, {'type': 'application/rss+xml'}, {'title': 'RSS'}, {'href': '|rss.xml'}],
\            'link:atom': [{'rel': 'alternate'}, {'type': 'application/atom+xml'}, {'title': 'Atom'}, {'href': 'atom.xml'}],
\            'meta:utf': [{'http-equiv': 'Content-Type'}, {'content': 'text/html;charset=UTF-8'}],
\            'meta:win': [{'http-equiv': 'Content-Type'}, {'content': 'text/html;charset=Win-1251'}],
\            'meta:compat': [{'http-equiv': 'X-UA-Compatible'}, {'content': 'IE=7'}],
\            'style': {'type': 'text/css'},
\            'script': {'type': 'text/javascript'},
\            'script:src': [{'type': 'text/javascript'}, {'src': ''}],
\            'img': [{'src': ''}, {'alt': ''}],
\            'iframe': [{'src': ''}, {'frameborder': '0'}],
\            'embed': [{'src': ''}, {'type': ''}],
\            'object': [{'data': ''}, {'type': ''}],
\            'param': [{'name': ''}, {'value': ''}],
\            'map': {'name': ''},
\            'area': [{'shape': ''}, {'coords': ''}, {'href': ''}, {'alt': ''}],
\            'area:d': [{'shape': 'default'}, {'href': ''}, {'alt': ''}],
\            'area:c': [{'shape': 'circle'}, {'coords': ''}, {'href': ''}, {'alt': ''}],
\            'area:r': [{'shape': 'rect'}, {'coords': ''}, {'href': ''}, {'alt': ''}],
\            'area:p': [{'shape': 'poly'}, {'coords': ''}, {'href': ''}, {'alt': ''}],
\            'link': [{'rel': 'stylesheet'}, {'href': ''}],
\            'form': {'action': ''},
\            'form:get': {'action': '', 'method': 'get'},
\            'form:post': {'action': '', 'method': 'post'},
\            'form:upload': {'action': '', 'method': 'post', 'enctype': 'multipart/form-data'},
\            'label': {'for': ''},
\            'input': {'type': ''},
\            'input:hidden': [{'type': 'hidden'}, {'name': ''}],
\            'input:h': [{'type': 'hidden'}, {'name': ''}],
\            'input:text': [{'type': 'text'}, {'name': ''}, {'id': ''}],
\            'input:t': [{'type': 'text'}, {'name': ''}, {'id': ''}],
\            'input:search': [{'type': 'search'}, {'name': ''}, {'id': ''}],
\            'input:email': [{'type': 'email'}, {'name': ''}, {'id': ''}],
\            'input:url': [{'type': 'url'}, {'name': ''}, {'id': ''}],
\            'input:password': [{'type': 'password'}, {'name': ''}, {'id': ''}],
\            'input:p': [{'type': 'password'}, {'name': ''}, {'id': ''}],
\            'input:datetime': [{'type': 'datetime'}, {'name': ''}, {'id': ''}],
\            'input:date': [{'type': 'date'}, {'name': ''}, {'id': ''}],
\            'input:datetime-local': [{'type': 'datetime-local'}, {'name': ''}, {'id': ''}],
\            'input:month': [{'type': 'month'}, {'name': ''}, {'id': ''}],
\            'input:week': [{'type': 'week'}, {'name': ''}, {'id': ''}],
\            'input:time': [{'type': 'time'}, {'name': ''}, {'id': ''}],
\            'input:number': [{'type': 'number'}, {'name': ''}, {'id': ''}],
\            'input:color': [{'type': 'color'}, {'name': ''}, {'id': ''}],
\            'input:checkbox': [{'type': 'checkbox'}, {'name': ''}, {'id': ''}],
\            'input:c': [{'type': 'checkbox'}, {'name': ''}, {'id': ''}],
\            'input:radio': [{'type': 'radio'}, {'name': ''}, {'id': ''}],
\            'input:r': [{'type': 'radio'}, {'name': ''}, {'id': ''}],
\            'input:range': [{'type': 'range'}, {'name': ''}, {'id': ''}],
\            'input:file': [{'type': 'file'}, {'name': ''}, {'id': ''}],
\            'input:f': [{'type': 'file'}, {'name': ''}, {'id': ''}],
\            'input:submit': [{'type': 'submit'}, {'value': ''}],
\            'input:s': [{'type': 'submit'}, {'value': ''}],
\            'input:image': [{'type': 'image'}, {'src': ''}, {'alt': ''}],
\            'input:i': [{'type': 'image'}, {'src': ''}, {'alt': ''}],
\            'input:reset': [{'type': 'reset'}, {'value': ''}],
\            'input:button': [{'type': 'button'}, {'value': ''}],
\            'input:b': [{'type': 'button'}, {'value': ''}],
\            'select': [{'name': ''}, {'id': ''}],
\            'option': {'value': ''},
\            'textarea': [{'name': ''}, {'id': ''}, {'cols': '30'}, {'rows': '10'}],
\            'menu:context': {'type': 'context'},
\            'menu:c': {'type': 'context'},
\            'menu:toolbar': {'type': 'toolbar'},
\            'menu:t': {'type': 'toolbar'},
\            'video': {'src': ''},
\            'audio': {'src': ''},
\            'html:xml': [{'xmlns': 'http://www.w3.org/1999/xhtml'}, {'xml:lang': '${lang}'}]
\        },
\        'aliases': {
\            'link:*': 'link',
\            'meta:*': 'meta',
\            'area:*': 'area',
\            'bdo:*': 'bdo',
\            'form:*': 'form',
\            'input:*': 'input',
\            'script:*': 'script',
\            'html:*': 'html',
\            'a:*': 'a',
\            'menu:*': 'menu',
\            'bq': 'blockquote',
\            'acr': 'acronym',
\            'fig': 'figure',
\            'ifr': 'iframe',
\            'emb': 'embed',
\            'obj': 'object',
\            'src': 'source',
\            'cap': 'caption',
\            'colg': 'colgroup',
\            'fst': 'fieldset',
\            'btn': 'button',
\            'optg': 'optgroup',
\            'opt': 'option',
\            'tarea': 'textarea',
\            'leg': 'legend',
\            'sect': 'section',
\            'art': 'article',
\            'hdr': 'header',
\            'ftr': 'footer',
\            'adr': 'address',
\            'dlg': 'dialog',
\            'str': 'strong',
\            'sty': 'style',
\            'prog': 'progress',
\            'fset': 'fieldset',
\            'datag': 'datagrid',
\            'datal': 'datalist',
\            'kg': 'keygen',
\            'out': 'output',
\            'det': 'details',
\            'cmd': 'command'
\        },
\        'expandos': {
\            'ol': 'ol>li',
\            'ul': 'ul>li',
\            'dl': 'dl>dt+dd',
\            'map': 'map>area',
\            'table': 'table>tr>td',
\            'colgroup': 'colgroup>col',
\            'colg': 'colgroup>col',
\            'tr': 'tr>td',
\            'select': 'select>option',
\            'optgroup': 'optgroup>option',
\            'optg': 'optgroup>option'
\        },
\        'empty_elements': 'area,base,basefont,br,col,frame,hr,img,input,isindex,link,meta,param,embed,keygen,command',
\        'block_elements': 'address,applet,blockquote,button,center,dd,del,dir,div,dl,dt,fieldset,form,frameset,hr,iframe,ins,isindex,link,map,menu,noframes,noscript,object,ol,p,pre,script,table,tbody,td,tfoot,th,thead,tr,ul,h1,h2,h3,h4,h5,h6,style',
\        'inline_elements': 'a,abbr,acronym,applet,b,basefont,bdo,big,br,button,cite,code,del,dfn,em,font,i,iframe,img,input,ins,kbd,label,map,object,q,s,samp,script,small,span,strike,strong,sub,sup,textarea,tt,u,var',
\    },
\    'xsl': {
\        'extends': 'html',
\        'default_attributes': {
\            'tmatch': [{'match': ''}, {'mode': ''}],
\            'tname': [{'name': ''}],
\            'xsl:when': {'test': ''},
\            'var': [{'name': ''}, {'select': ''}],
\            'vari': {'name': ''},
\            'if': {'test': ''},
\            'call': {'name': ''},
\            'attr': {'name': ''},
\            'wp': [{'name': ''}, {'select': ''}],
\            'par': [{'name': ''}, {'select': ''}],
\            'val': {'select': ''},
\            'co': {'select': ''},
\            'each': {'select': ''},
\            'ap': [{'select': ''}, {'mode': ''}]
\        },
\        'aliases': {
\            'tmatch': 'xsl:template',
\            'tname': 'xsl:template',
\            'var': 'xsl:variable',
\            'vari': 'xsl:variable',
\            'if': 'xsl:if',
\            'call': 'xsl:call-template',
\            'wp': 'xsl:with-param',
\            'par': 'xsl:param',
\            'val': 'xsl:value-of',
\            'attr': 'xsl:attribute',
\            'co' : 'xsl:copy-of',
\            'each' : 'xsl:for-each',
\            'ap' : 'xsl:apply-templates'
\        },
\        'expandos': {
\            'choose': 'xsl:choose>xsl:when+xsl:otherwise'
\        }
\    },
\    'haml': {
\        'extends': 'html'
\    },
\    'xhtml': {
\        'extends': 'html'
\    },
\    'mustache': {
\        'extends': 'html'
\    }
\}

if exists('g:user_zen_settings')
  call s:zen_mergeConfig(s:zen_settings, g:user_zen_settings)
endif

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
