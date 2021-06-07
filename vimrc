syntax on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set hlsearch
set incsearch
set mouse=n

map <C-H> :tabprevious<CR>
map <C-L> :tabnext<CR>
colorscheme industry

" ~~~~ GUI ~~~~
"
set guifont="DejaVu Sans Mono 11"


" ~~~~ NERDTree ~~~~
"
nnoremap <C-n> :NERDTreeToggle<CR>

" Start NERDTree when Vim is started without file arguments.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Open the existing NERDTree on each new tab.
"autocmd BufWinEnter * silent NERDTreeMirror

let NERDTreeWinSize=50

"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif



" ~~~~ LeaderF ~~~~
"
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_ShowDevIcons = 0
let g:Lf_WindowPosition = 'popup'
"let g:Lf_PreviewInPopup = 1
"let g:Lf_PopupColorscheme = 'gruvbox_default'


" ~~~~ Tarbar ~~~~
"
nmap <F8> :TagbarToggle<CR>

" ~~~~ Flake8 ~~~~
"
" run check every time you write a Python file
autocmd BufWritePost *.py call flake8#Flake8()
