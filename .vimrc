set nocompatible              						                                                        "We want the latest Vim settings/options.
set encoding=utf-8
filetype plugin indent on
so ~/.vim/plugins.vim
set noswapfile
"syntax enable
"colorscheme atom-dark-256
set term=screen-256color
let python_highlight_all=1
syntax on
set clipboard=unnamed

set tags=tags

set autoindent
"set foldmethod=indent

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab                                                    " 2 space indenting for YAML"
"-------------Visuals--------------"
set number
set relativenumber
set linespace=20
set t_CO=256
set guioptions-=e


set background=dark
colorscheme hybrid_material
let g:airline_theme = "hybrid"
" show existing tab with 4 spaces width
set tabstop=4
" " when indenting with '>', use 4 spaces width
set shiftwidth=4
" " On pressing tab, insert 4 spaces
set expandtab

"-------------General Settings--------------"
set backspace=indent,eol,start                                          "Make backspace behave like every other editor.
let mapleader = ',' 						    	"The default leader is \, but a comma is much better.


"-------------Search--------------"
set hlsearch
set incsearch


"----------Show Quotes in JSON-----------"
set conceallevel=0


"-------Split Managemnent------"

"set simpler mappings to switch between splits.
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

"Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
"
" " Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>



"-------------Mappings--------------"
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
"
" run command with vimux pane
nmap <Leader>c :VimuxPromptCommand<cr>

" fold a C-style function
nmap <Leader>f /{<cr>v%zf,<space>

" python debug. Add ipdb to next line and and save
nmap <Leader>db $a<cr>import ipdb; ipdb.set_trace()<C-c>:w<cr>

" open new tab with NERDTree
nmap <Leader>n :tabe<cr>:NERDTreeToggle<cr>

" open new tab, and open recent files
nmap <Leader>e :tabe<cr><C-E>

" open a new tab and close all the others
nmap <Leader>no :tabe<cr>:Bonly<cr>gt<cr>

" open a new tab and close all the others
nmap <Leader>o :Bonly<cr>gt<cr>

" todo review / tasks with Agrep
nmap <Leader>t :Agrep --exclude-dir={./vendor,./node_modules,./.idea,./public,./storage} --exclude=*.sql -i -r -F "todo" .<cr><C-J>

"Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

"Make NERDTree easier to toggle
nmap <Leader>1 :NERDTreeToggle<cr>

"Hack for Python syntax highlighting ::cry::
nmap <Leader>s :syntax on <cr>

"Search in a new tab"
nmap <Leader>g :tabe<cr>:Agrep -irF '

"Ctrl P look for symbols/tags
nmap <c-R> :CtrlPBufTag

"-------------Auto-Commands--------------"

"Automatically source the Vimrc file on save.
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

"-------------Plugins--------------"
" Ultisnips
" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'


" " better key bindings for UltiSnipsExpandTrigger
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" PDV / PHP Documentor
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <leader>d :call pdv#DocumentWithSnip()<CR>

"/
""/ CtrlP
"/
let g:ctrlp_custom_ignore = 'node_modules\DS_Store\|git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'
"
nmap <C-r> :CtrlPBufTag<cr>
nmap <C-e> :CtrlPMRUFiles<cr>
nmap <C-t> <Plug>PeepOpen

" Hardtime
"let g:hardtime_default_on = 1

"airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

" NERDTre
let g:ctrlp_open_func = { 'files': 'CustomOpenFunc' }
function! CustomOpenFunc(action, line)
	    call call('ctrlp#acceptfile', [':t', a:line])
endfunction

" Powerline
if has("gui_running")
	   let s:uname = system("uname")
	      	if s:uname == "Darwin\n"
		 	set guifont=Inconsolata\ for\ Powerline:h15
		endif
endif

" Vimwiki
let g:vimwiki_list = [{'path': '~/knowledge/', 'syntax': 'markdown', 'ext': '.md'}]
 
"indentline
let g:indentLine_color_term = 239

if has("gui_running")
	   let s:uname = system("uname")
	      if s:uname == "Darwin\n"
		            set guifont=Inconsolata\ for\ Powerline:h15
			       endif
		       endif

    highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

" Python Linting with Synastic
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_yaml_checkers = ['yamllint']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Git add, commit and push with vim-fugitive
nnoremap <leader>gv :Gwrite<CR>:Gcommit -m WIP<CR>:Gpush<cr><cr>:e!<cr>
