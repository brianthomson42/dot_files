" Sy's .vimrc file for customizing the Vim editor
" Last edited: 11/02/14
"

" Use Vim settings, rather then Vi settings.
" Must be first, as it changes other options as a side effect.
set nocompatible

" Plugin manager
filetype off
execute pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

syntax on            " syntax coloring enabled
set background=dark
set backup           " keep a backup file~
set history=1000     " keep 1000 lines of command line history
set undolevels=1000  " allow 1000 undos
set ruler            " show the cursor position all the time
set title            " change the terminal's title
set incsearch        " do incremental searching
set hlsearch         " highlight search strings
set autoindent       " copy indent from current line when starting new line
set showmode         " show Insert, Replace or Visual as appropriate
set showmatch        " jump briefly to the matching bracket
set showcmd          " display incomplete commands
set shiftwidth=4     " number of spaces to use for (auto)indent
set tabstop=4        " uses 4 spaces when Tab is used
set expandtab        " uses spaces instead of ^I when Tab is used
set ignorecase       " ignore case when doing string searches
set smartcase        "   except when include UPPERCASE chars
set wildignore=*.swp,*.bak,*.pyc  " ignore some file extensions
                                  "   when using TAB completion 

set laststatus=2     " tell VIM to always put a status line in, even
                     "    if there is only one window

set wildmode=list:full " show a list when pressing tab and complete
                       "   first full match

" toggle highlighted search str on/off
map <silent> <C-h> <Esc>:set hls!<bar>set hls?<CR>

" set filetype stuff to on
filetype on
filetype plugin on
filetype indent on

" autocorrect common typos
iab teh the
iab taht that
iab chnage change


" Force the use of the hjkl keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Remap j and k to act as expected when used on long, wrapped, lines
nnoremap j gj
nnoremap k gk

" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" Highlight text beyond 79 chars
:au BufWinEnter * let w:m1=matchadd('Search', '\%<81v.\%>79v', -1)
:au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"
" Convenient command to see the difference between the current buffer
" and the file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" When vimrc is edited, reload it automatically
autocmd! bufwritepost vimrc source ~/.vimrc

" Python specific
let python_highlight_all=1
"python remove trailing whitespace
"autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``

" Ruby specific
let ruby_minlines=100
let ruby_operators=1
let ruby_space_errors=1
let ruby_fold=1
let ruby_no_comment_fold=1

" Indent Python in the Google way.

setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"

" OCaml specific
execute ":source " . "/home/sy/.opam/system/share/vim/syntax/ocp-indent.vim"
au BufRead,BufNewFile *.ml,*.mli compiler ocaml
" add merlin to vim's runtime-path
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

" to index the documentation
":execute "helptags " . g:opamshare . "/merlin/vim/doc"

