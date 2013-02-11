" Vim color file
"
" Author: Douglas Morato <dfamorato@gmail.com>
"
" Note:
" Based on the monokai theme for vim and textmate.
" Based on the darkmate theme orm vim by  YearOfMoo Matias Niemelä <matias@yearofmoo.com>
"
" Based on the FRUITY theme by  Armin Ronacher <armin.ronacher@active-4.com>

"Clear all previous settings
hi clear

"set background as dark
set background=dark

" reset syntax coloring
if exists("syntax_on")
    syntax reset
endif

" Line and Columns
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline
set cursorline

" Try to set Font
set guifont=Monaco:h12

"set the name of our vim colorscheme
let g:colors_name="dfamorato"


" Main Colors and data types and syntax elements
hi Normal             guibg=#232323 ctermbg=235   guifg=#FFFFFF ctermfg=15  gui=none
hi Visual		      guifg=#FFFFFF ctermfg=15    guibg=#555753 ctermbg=240 gui=none
hi String             guifg=#96ff00 ctermfg=118                             gui=none
hi Delimiter          guifg=#96ff00 ctermfg=118                             gui=none
hi Boolean            guifg=#ff44cc ctermfg=206                             gui=none
hi Constant           guifg=#FFFFFF ctermfg=15                              gui=none
hi Number             guifg=#00c99b ctermfg=42                              gui=none
hi Statement          guifg=#FF9900 ctermfg=208                             gui=none
hi Character          guifg=#FF9900 ctermfg=208                             gui=none
hi Comment            guifg=#FF44CC ctermfg=135                             gui=none
hi Repeat             guifg=#FF9900 ctermfg=208                             gui=none
hi Type               guifg=#009cff ctermfg=39                              gui=none
hi Label              guifg=#FF9900 ctermfg=208                             gui=none
hi Conditional        guifg=#FF9900 ctermfg=208                             gui=none
hi Exception          guifg=#FF9900 ctermfg=208                             gui=none
hi Function           guifg=#FFFFFF ctermfg=15                              gui=none
hi Define             guifg=#FF9900 ctermfg=208                             gui=none
hi LineNr             guifg=#FFFFFF ctermfg=15                              gui=none
hi NonText            guifg=#444444 guibg=#000000
hi Function           guifg=#A6E22E
hi Float              guifg=#AE81FF
hi ColorColumn        guibg=#FF9900  ctermbg=42

" Cursor settings
hi CursorLine         guibg=#000000 ctermbg=0
hi CursorLineNr       ctermfg=250   guibg=#000000
hi Cursor             guifg=#000000 guibg=#F8F8F0
hi lCursor            guibg=#aaaaaa


" Vim Stuff
hi vimGroup           guifg=#FFFFFF ctermfg=15                    gui=none
hi vimHiGroup         guifg=#FFFFFF ctermfg=15                    gui=none
hi vimSetEqual        guifg=#FF44CC ctermfg=206                   gui=none
hi vimSet             guifg=#FF44CC ctermfg=206                   gui=none
hi vimOption          guifg=#FFFFFF ctermfg=15                    gui=none
hi vimHighLight       guifg=#FF9900 ctermfg=208                   gui=none
hi vimNotFunc         guifg=#FF9900 ctermfg=208                   gui=none
hi vimCommand         guifg=#FF9900 ctermfg=208                   gui=none

"Diff Elements
hi Debug           guifg=#BCA3A3               gui=bold
hi DiffAdd                       guibg=#13354A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4C4745 gui=italic,bold

hi Directory       guifg=#A6E22E               gui=bold
hi Error           guifg=#960050 guibg=#6E7B8B
hi ErrorMsg        guifg=#F92672 guibg=#232526 gui=bold
hi Current         guifg=#ffffff guibg=#ffffff
hi FoldColumn      guifg=#465457 guibg=#000000
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

hi Keyword         guifg=#F92672               gui=bold
hi Label           guifg=#E6DB74               gui=none
hi Macro           guifg=#C4BE89               gui=italic
hi SpecialKey      guifg=#66D9EF               gui=italic

hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#F92672

" complete menu
hi Pmenu           guifg=#66D9EF guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#66D9EF

"Conditional menu
hi PreCondit       guifg=#A6E22E               gui=bold
hi PreProc         guifg=#A6E22E
hi Question        guifg=#66D9EF
hi Repeat          guifg=#F92672               gui=bold
hi Search          guifg=#FFFFFF guibg=#455354

" marks column
hi SignColumn      guifg=#A6E22E guibg=#232526


" Special char
hi SpecialChar     guifg=#F92672               gui=bold
hi SpecialComment  guifg=#465457               gui=bold
hi Special         guifg=#66D9EF guibg=bg      gui=italic
hi SpecialKey      guifg=#888A85               gui=italic
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#F92672               gui=bold

" Window Elements
hi StatusLine      guifg=#455354               guibg=fg
hi StatusLineNC    guifg=#808080               guibg=#080808
hi VertSplit       guifg=#808080 guibg=#080808 gui=bold



hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#66D9EF
hi Tag             guifg=#F92672               gui=italic

" Todo and tite
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      gui=bold

hi Typedef         guifg=#66D9EF
hi Type            guifg=#66D9EF               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold
hi WildMenu        guifg=#66D9EF guibg=#000000

" XML Highlighting
hi xmlTag           guifg=#00bdec
hi xmlTagName       guifg=#00bdec
hi xmlEndTag        guifg=#00bdec
hi xmlNamespace     guifg=#00bdec                   gui=underline
hi xmlAttribPunct   guifg=#cccaa9                   gui=bold
hi xmlEqual         guifg=#cccaa9                   gui=bold
hi xmlCdata         guifg=#bf0945                   gui=bold
hi xmlCdataCdata    guifg=#ac1446   guibg=#232526010c   gui=none
hi xmlCdataStart    guifg=#bf0945                   gui=bold
hi xmlCdataEnd      guifg=#bf0945                   gui=bold

" Vim Stuff
hi vimGroup           guifg=#FFFFFF ctermfg=15                    gui=none
hi vimHiGroup         guifg=#FFFFFF ctermfg=15                    gui=none
hi vimSetEqual        guifg=#FF44CC ctermfg=206                   gui=none
hi vimSet             guifg=#FF44CC ctermfg=206                   gui=none
hi vimOption          guifg=#FFFFFF ctermfg=15                    gui=none
hi vimHighLight       guifg=#FF9900 ctermfg=208                   gui=none
hi vimNotFunc         guifg=#FF9900 ctermfg=208                   gui=none
hi vimCommand         guifg=#FF9900 ctermfg=208                   gui=none

" HTML Stuff
hi htmlTag              guifg=#00c900 ctermfg=2                   gui=none
hi htmlTagN             guifg=#00c900 ctermfg=2                   gui=none
hi htmlSpecialTagName   guifg=#00c900 ctermfg=2                   gui=none
hi htmlEndTag           guifg=#00c900 ctermfg=2                   gui=none
hi htmlArg              guifg=#009cff ctermfg=39                  gui=none
hi htmlString           guifg=#96ff00 ctermfg=118                 gui=none
hi htmlTagName          guifg=#00c900 ctermfg=2                   gui=none
hi htmlLink             guifg=#FFFFFF ctermfg=15                  gui=none
hi htmlComment          guifg=#FFFFFF ctermfg=15                  gui=none
hi htmlCommentPart      guifg=#BBBBBB ctermfg=250                 gui=none
hi htmlCSSStyleComment  guifg=#BBBBBB ctermfg=250                 gui=none
hi htmlEvent        guifg=#ffffff

" Python Highlighting for python.vim
hi pythonCoding guifg=#ff0086
hi pythonRun    guifg=#ff0086
hi pythonBuiltinObj     guifg=#2b6ba2           gui=bold
hi pythonBuiltinFunc    guifg=#2b6ba2           gui=bold
hi pythonException      guifg=#ee0000           gui=bold
hi pythonExClass        guifg=#66cd66           gui=bold
hi pythonSpaceError     guibg=#270000
hi pythonDocTest    guifg=#2f5f49
hi pythonDocTest2   guifg=#3b916a
hi pythonFunction   guifg=#ee0000               gui=bold
hi pythonClass      guifg=#ff0086               gui=bold

" Django Highlighting
hi djangoTagBlock   guifg=#ff0007   guibg=#200000   gui=bold
hi djangoVarBlock   guifg=#ff0007   guibg=#200000
hi djangoArgument   guifg=#0086d2   guibg=#200000
hi djangoStatement  guifg=#fb660a   guibg=#200000   gui=bold
hi djangoComment    guifg=#008800   guibg=#002300   gui=italic
hi djangoFilter     guifg=#ff0086   guibg=#200000   gui=italic

" Jinja Highlighting
hi jinjaTagBlock    guifg=#ff0007   guibg=#200000   gui=bold
hi jinjaVarBlock    guifg=#ff0007   guibg=#200000
hi jinjaString      guifg=#0086d2   guibg=#200000
hi jinjaNumber      guifg=#bf0945   guibg=#200000   gui=bold
hi jinjaStatement   guifg=#fb660a   guibg=#200000   gui=bold
hi jinjaComment     guifg=#008800   guibg=#002300   gui=italic
hi jinjaFilter      guifg=#ff0086   guibg=#200000
hi jinjaRaw         guifg=#aaaaaa   guibg=#200000
hi jinjaOperator    guifg=#ffffff   guibg=#200000
hi jinjaVariable    guifg=#92cd35   guibg=#200000
hi jinjaAttribute   guifg=#dd7700   guibg=#200000
hi jinjaSpecial     guifg=#008ffd   guibg=#200000

" Ruby Stuff
hi rubySymbol           guifg=#009cff ctermfg=39                  gui=none
hi rubyClassDeclaration guifg=#ff9900 ctermfg=208                 gui=none
hi rubyRailsUserClass   guifg=#fce94f ctermfg=221                 gui=none
hi rubyConstant         guifg=#fce94f ctermfg=221                 gui=none
hi erubyExpression      guifg=#ff9900 ctermfg=208                 gui=none
hi erubyDelimiter       guifg=#ff9900 ctermfg=208                 gui=none
hi rubyRegexp           guifg=#ff44cc ctermfg=206                 gui=none
hi rubyRegexpCharClass  guifg=#ff44cc ctermfg=206                 gui=none
hi rubyRegexpDelimiter  guifg=#ff44cc ctermfg=206                 gui=none
hi rubyRegexpQuantifier guifg=#ff44cc ctermfg=206                 gui=none
hi rubyInstanceVariable guifg=#00c900 ctermfg=2                   gui=none
hi rubyKeywordAsMethod  guifg=#ff44cc ctermfg=206                 gui=none
hi rubyPseudoVariable   guifg=#ff44cc ctermfg=206                 gui=none
hi rubyControl          guifg=#FF9900 ctermfg=208                 gui=none
hi rubyBlockParamater   guifg=#FFFFFF ctermfg=15                  gui=none
hi rubyBlockParamaterList   guifg=#FFFFFF ctermfg=15              gui=none
hi rubyFunction     guifg=#0066bb               gui=bold
hi rubyClass        guifg=#ff0086               gui=bold
hi rubyModule       guifg=#ff0086               gui=bold,underline
hi rubyKeyword      guifg=#008800               gui=bold
hi rubyIndentifier              guifg=#008aff
hi rubyGlobalVariable           guifg=#dd7700
hi rubyPredefinedIdentifier     guifg=#555555   gui=bold
hi rubyString           guifg=#0086d2
hi rubyStringDelimiter  guifg=#dd7700
hi rubySpaceError       guibg=#270000
hi rubyDocumentation    guifg=#aaaaaa
hi rubyData             guifg=#555555



" C Stuff
hi cCharacter           guifg=#FF9900 ctermfg=208                 gui=none
"
" Javascript Stuff
hi javaScript           guifg=#FFFFFF ctermfg=15                  gui=none
hi javaScriptGlobal     guifg=#FFFFFF ctermfg=15                  gui=none
hi javaScriptNumber     guifg=#00c99b ctermfg=42                  gui=none
hi javaScriptIdentifier guifg=#FF9900 ctermfg=208                 gui=none
hi javaScriptOperator   guifg=#FF9900 ctermfg=208                 gui=none
hi javaScriptFunction   guifg=#FF9900 ctermfg=208                 gui=none
hi javaScriptStatement  guifg=#FF9900 ctermfg=208                 gui=none
hi javaScriptNull       guifg=#ff44cc ctermfg=206                 gui=none
hi javaScriptMember     guifg=#00c900 ctermfg=2                   gui=none
hi javaScriptRegexpString       guifg=#aa6600
hi javaScriptDocComment         guifg=#aaaaaa
hi javaScriptCssStyles          guifg=#dd7700
hi javaScriptDomElemFuncs       guifg=#66cd66
hi javaScriptHtmlElemFuncs      guifg=#dd7700
hi javaScriptLabel              guifg=#00bdec   gui=italic
hi javaScriptPrototype          guifg=#00bdec
hi javaScriptConditional        guifg=#ff0007   gui=bold
hi javaScriptRepeat             guifg=#ff0007   gui=bold
hi javaScriptFunction           guifg=#ff0086   gui=bold



" CSS Stuff
hi cssTagName          guifg=#FFFFFF ctermfg=15                  gui=none
hi cssAttributeSelector     guifg=#DDDDDD ctermfg=15                  gui=none
hi cssSelectorOp       guifg=#DDDDDD ctermfg=15                  gui=none
hi cssSelectorOp2      guifg=#DDDDDD ctermfg=15                  gui=none
hi cssColorProp         guifg=#FF9900 ctermfg=208                 gui=none
hi cssBoxProp           guifg=#FF9900 ctermfg=208                 gui=none
hi cssTextAttr          guifg=#009cff ctermfg=208                 gui=none
hi cssDefinition        guifg=#009cff ctermfg=135                 gui=none
hi cssFunctionName      guifg=#009cff ctermfg=135                 gui=none
hi cssURL               guifg=#009cff ctermfg=135                 gui=none
hi cssBoxAttr           guifg=#bb66ff ctermfg=135                 gui=none
hi cssCommonAttr        guifg=#bb66ff ctermfg=135                 gui=none
hi cssStringQQ          guifg=#00c900 ctermfg=135                 gui=none
hi cssColor             guifg=#00c900 ctermfg=135                 gui=none
hi cssDefinition        guifg=#bb66ff ctermfg=135                 gui=none
hi cssRenderProp        guifg=#009cff ctermfg=39                  gui=none
hi cssTextProp          guifg=#FF9900 ctermfg=39                  gui=none
hi cssTableProp         guifg=#FF9900 ctermfg=39                  gui=none
hi cssFontProp          guifg=#FF9900 ctermfg=39                  gui=none
hi cssFontAttr          guifg=#009cff ctermfg=39                  gui=none
hi cssColorAttr         guifg=#009cff ctermfg=39                  gui=none
hi cssGeneratedContentProp        guifg=#FF9900 ctermfg=39                  gui=none
hi cssIdentifier            guifg=#66cd66       gui=bold
hi cssBraces                guifg=#00bdec       gui=bold


" PHP Stuff
hi phpParent            guifg=#FFFFFF ctermfg=15                  gui=none
hi phpInclude           guifg=#FF9900 ctermfg=208                 gui=none
hi phpIdentifier        guifg=#00c900 ctermfg=2                   gui=none

"
" Support for 256-color terminal
"
if &t_Co > 255
   hi Boolean         ctermfg=135
   hi Character       ctermfg=144
   hi Number          ctermfg=135
   hi String          ctermfg=144
   hi Conditional     ctermfg=161               cterm=bold
   hi Constant        ctermfg=135               cterm=bold
   hi Cursor          ctermfg=16  ctermbg=253
   hi Debug           ctermfg=225               cterm=bold
   hi Define          ctermfg=81
   hi Delimiter       ctermfg=241

   hi DiffAdd                     ctermbg=24
   hi DiffChange      ctermfg=181 ctermbg=239
   hi DiffDelete      ctermfg=162 ctermbg=53
   hi DiffText                    ctermbg=102 cterm=bold

   hi Directory       ctermfg=118               cterm=bold
   hi Error           ctermfg=219 ctermbg=89
   hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
   hi Exception       ctermfg=118               cterm=bold
   hi Float           ctermfg=135
   hi FoldColumn      ctermfg=67  ctermbg=16
   hi Folded          ctermfg=67  ctermbg=16
   hi Function        ctermfg=118
   hi Identifier      ctermfg=208
   hi Ignore          ctermfg=244 ctermbg=232
   hi IncSearch       ctermfg=193 ctermbg=16

   hi Keyword         ctermfg=161               cterm=bold
   hi Label           ctermfg=229               cterm=none
   hi Macro           ctermfg=193
   hi SpecialKey      ctermfg=81

   hi MatchParen      ctermfg=16  ctermbg=208 cterm=bold
   hi ModeMsg         ctermfg=229
   hi MoreMsg         ctermfg=229
   hi Operator        ctermfg=161

   " complete menu
   hi Pmenu           ctermfg=81  ctermbg=16
   hi PmenuSel                    ctermbg=244
   hi PmenuSbar                   ctermbg=232
   hi PmenuThumb      ctermfg=81

   hi PreCondit       ctermfg=118               cterm=bold
   hi PreProc         ctermfg=118
   hi Question        ctermfg=81
   hi Repeat          ctermfg=161               cterm=bold
   hi Search          ctermfg=253 ctermbg=66

   " marks column
   hi SignColumn      ctermfg=118 ctermbg=235
   hi SpecialChar     ctermfg=161               cterm=bold
   hi SpecialComment  ctermfg=245               cterm=bold
   hi Special         ctermfg=81  ctermbg=232
   hi SpecialKey      ctermfg=245

   hi Statement       ctermfg=161               cterm=bold
   hi StatusLine      ctermfg=238 ctermbg=253
   hi StatusLineNC    ctermfg=244 ctermbg=232
   hi StorageClass    ctermfg=208
   hi Structure       ctermfg=81
   hi Tag             ctermfg=161
   hi Title           ctermfg=166
   hi Todo            ctermfg=231 ctermbg=232   cterm=bold

   hi Typedef         ctermfg=81
   hi Type            ctermfg=81                cterm=none
   hi Underlined      ctermfg=244               cterm=underline

   hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
   hi VisualNOS                   ctermbg=238
   hi Visual                      ctermbg=235
   hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
   hi WildMenu        ctermfg=81  ctermbg=16

   hi Normal          ctermfg=252 ctermbg=233
   hi Comment         ctermfg=59
   hi CursorLine                  ctermbg=234   cterm=none
   hi CursorColumn                ctermbg=234
   hi LineNr          ctermfg=250 ctermbg=234
   hi NonText         ctermfg=250 ctermbg=234
end
