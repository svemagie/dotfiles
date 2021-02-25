set nocompatible
filetype plugin on
syntax on

set shell=sh

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
"below function is needed for ycm:
function! BuildYCM(info)
  if a:info.status == 'installed' || a:info.force
	!./install.py
   endif
endfunction
Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }

" For UltiSnip
Plug 'SirVer/ultisnips'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } |
	\Plug 'Xuyuanp/nerdtree-git-plugin' |
	\Plug 'ryanoasis/vim-devicons' |
	\Plug 'scrooloose/nerdtree-project-plugin'
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'michal-h21/vim-zettel'
"Plug 'michal-h21/vimwiki-sync'		" auto git
Plug 'alok/notational-fzf-vim'
Plug 'matt-snider/vim-tagquery'
Plug 'mattn/calendar-vim'

"Plug 'tpope/vim-fugitive'		" git plugin
Plug 'itchyny/landscape.vim'
"Plug 'parkr/vim-jekyll'
Plug 'robertbasic/vim-hugo-helper'

Plug 'konfekt/vim-detectspelllang'
Plug 'ActivityWatch/aw-watcher-vim'	"ActivityWatch

Plug 'blindFS/vim-taskwarrior'
Plug 'vim-airline/vim-airline'
Plug 'Shougo/unite.vim'

Plug 'tools-life/taskwiki'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'majutsushi/tagbar'
Plug 'farseer90718/vim-taskwarrior'
call plug#end()

" Vimwiki 
let mapleader=","		" use mapleader+ww to go to wiki-index
let maplocalleadder=","
let g:vimwiki_global_ext = 0	" vimwiki only explicit, not on all *.md files 

let g:vimwiki_list = [{'path':'~/Projekte/notes/', 'ext':'.md', 'syntax':'markdown', 'name':'Notes', 
			\ 'path_html': '~/public_html/notes', 
			\ 'auto_diary_index': 1,
			\ 'auto_tags': 1,
			\ 'auto_generate_tags': 1,
			\ 'auto_generate_links': 1,
      		        \ 'template_path': '~/public_html/notes/templates/',
          		\ 'template_default': 'def_template',
          		\ 'template_ext': '.html'}]

" search
let g:nv_search_paths = ['~/Projekte/notes', '~/Projekte/notes/diary', './notes.md']

" TagQuery
noremap <C-t> :FzfTagQuery
let g:tagquery_ctags_file = '~/Projekte/notes/.vimwiki_tags'

" Diary
au BufNewFile ~/Projekte/notes/diary/*.md :silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'

au BufRead,BufNewFile *.md set filetype=vimwiki
:autocmd FileType vimwiki map D :VimwikiMakeDiaryNote

let g:zettel_format = "%Y%m%d%H%M %title"
let g:vimwiki_markdown_link_ext = 1
let g:zettel_default_title = "%Y%m%d%H%M %title"
let g:zettel_link_format="[%title](%link)"
let g:zettel_backlinks_title="[%title](%link)"

"doesnt work let g:zettel_title_format="%Y%m%d%H%M %title" 

function! s:insert_id()
    if exists("g:zettel_current_id")
      return g:zettel_current_id
    else
      return "unnamed"
    endif
endfunction

let g:zettel_options = [{"front_matter" : [ [ "id" , function("s:insert_id")]], "template" :  "~/.vim/templates/default.tpl" }]

" Calendar in diary function
function! ToggleCalendar()
  execute ":Calendar"
  if exists("g:calendar_open")
    if g:calendar_open == 1
      execute "q"
      unlet g:calendar_open
    else
      g:calendar_open = 1
    end
  else
    let g:calendar_open = 1
  end
endfunction
:autocmd FileType vimwiki map c :call ToggleCalendar()


let g:nv_search_paths = ['~/Projekte/notes', '~/Projekte/notes/diary', './notes.md']

" others
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

let g:detectspelllang_langs = {
      \ 'aspell'   : [ 'en_US', 'de_DE', 'es', 'it' ],
      \ 'hunspell' : [ 'en_US', 'de_DE', 'es_ES', 'it_IT' ],
      \ }

" UltiSnip and YCM Trigger configuration. Do not use <tab> if you use YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-t>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

