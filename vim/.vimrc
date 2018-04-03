call pathogen#infect()
call pathogen#helptags()


"""""""""""""""""""""""""""
" UI
"""""""""""""""""""""""""""
syntax enable
set background=dark
set hlsearch
let g:solarized_termcolors=256
" colorscheme mustang
colorscheme solarized
"colorscheme wombat
set encoding=utf-8
set t_Co=256
set laststatus=2
set rnu
set cursorline
set cursorcolumn
"set regexpengine=1
set expandtab
set autoindent
set smartindent
set softtabstop=0
set shiftwidth=2
set tabstop=2
set mouse=a
set ruler
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
set colorcolumn=80


set nocompatible              " be iMproved, required
filetype off                  " required


"""""""""""""""""""""""""""
" Basic Mappings
"""""""""""""""""""""""""""
let mapleader=","

map <C-T> :tabnew<CR>
map <C-L> :tabn<CR>
map <C-H> :tabp<CR>
map <C-B> :tab all<CR>


"""""""""""""""""""""""""""
" Vundle
"""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'https://github.com/scrooloose/nerdcommenter.git'
Plugin 'kien/ctrlp.vim'
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'https://github.com/Shougo/unite.vim.git'

Plugin 'airblade/vim-gitgutter'

Plugin 'terryma/vim-multiple-cursors'

Plugin 'easymotion/vim-easymotion'
Plugin 'https://github.com/Valloric/YouCompleteMe.git'
Plugin 'scrooloose/syntastic'
Plugin 'altercation/vim-colors-solarized'
Plugin 'derekwyatt/vim-scala'

" Python related
Plugin 'nvie/vim-flake8'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'https://github.com/heavenshell/vim-pydocstring.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

"""""""""""""""""""""""""""
" Unite
"""""""""""""""""""""""""""
call unite#custom#source('file_rec/async', 'ignore_pattern', ['node_modules/', 'results/', 'build/'])
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file,file/new,buffer,file_rec/async,line', 'matchers', 'matcher_fuzzy')

" Use ag for search
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_rec_async_command= 'ag --nocolor --nogroup --hidden -g ""'
endif

nnoremap <C-F> :Unite grep:.<CR>


"""""""""""""""""""""""""""
" YouCompleteMe
"""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_python_binary_path = "/usr/bin/python"
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


"""""""""""""""""""""""""""
" NerdTree
"""""""""""""""""""""""""""
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" " buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
	if exists("t:NERDTreeBufName")
		if bufwinnr(t:NERDTreeBufName) != -1
			if winnr("$") == 1
				q
			endif
		endif
	endif
endfunction

map <C-A> :NERDTreeToggle<CR>


"""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_flake8_args='--ignore=E501,E225'


"""""""""""""""""""""""""""
" Powerline
"""""""""""""""""""""""""""
"let g:airline_powerline_fonts = 1


"""""""""""""""""""""""""""
" Javascript
"""""""""""""""""""""""""""
let jshint2_save = 1


"""""""""""""""""""""""""""
" Python
"""""""""""""""""""""""""""
let python_highlight_all = 1
nmap <silent> <C-m> <Plug>(pydocstring)

"""""""""""""""""""""""""""
" Prolog
"""""""""""""""""""""""""""
let g:filetype_pl="prolog"

"python with virtualenv support
python3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
