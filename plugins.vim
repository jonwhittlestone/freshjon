filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Plugin 'takac/vim-hardtime'        " ban cursor keys completely
Plugin 'VundleVim/Vundle.vim'       " Plugin manager
Plugin 'scrooloose/nerdtree'        " File drawer / sidebar thing
Plugin 'ctrlpvim/ctrlp.vim'         " Open new files with ctrl-P
Plugin 'jnurmine/Zenburn'           " Low-contast colour scheme
Plugin 'tpope/vim-obsession'        " Vim session stuff
Plugin 'ramele/agrep'               " Asynchronous grep plugin
Plugin 'airblade/vim-gitgutter'     " gitgutter
Plugin 'Xuyuanp/nerdtree-git-plugin' " show git status in nerdtree
Plugin 'terryma/vim-multiple-cursors'   " err multiple cursors
Plugin 'tpope/vim-vinegar'
Plugin 'vim-scripts/indentpython.vim'
"Bundle 'Valloric/YouCompleteMe'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'rizzatti/dash.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'Yggdroot/indentLine'
Plugin 'tobyS/pdv'
Plugin 'tobyS/vmustache'
"Plugin 'SirVer/ultisnips'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-fugitive'
Plugin 'benmills/vimux'
Plugin 'tpope/vim-surround'
Plugin 'leafgarland/typescript-vim'
Plugin 'tmhedberg/SimpylFold'               "Python Folding with zc and zo
Plugin 'markgandolfo/nerdtree-fetch.vim'    "Pull into Nerdtree with wget
Plugin 'vim-scripts/matchit.zip'            "Syntax Highlighting, specifically Volt
Plugin 'jyyan/vim-volt-syntax'              "Volt Syntax Highlighting
Plugin 'nvie/vim-flake8'                    " Runs the open file through Flake 8 static syntax checking
Plugin 'vim-syntastic/syntastic'     
Plugin 'KabbAmine/zeavim'                 " zeal documentation helper
Plugin 'ludovicchabant/vim-gutentags'     " tag management
Plugin 'posva/vim-vue'     " tag management

 " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
