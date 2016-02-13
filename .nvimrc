filetype off

set rtp+=~/.nvim/bundle/neobundle.vim/
"set rtp+=~/code/deltos.vim
call neobundle#begin(expand('~/.nvim/bundle/'))

"leader key
let mapleader = " "
"Bundles
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'igungor/schellar'
NeoBundle 'polm/deltos.vim'
NeoBundle 'MattesGroeger/vim-bookmarks'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'gkz/vim-ls'
NeoBundle 'kshenoy/vim-signature'
NeoBundle 'Mark'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'chrisbra/csv.vim'
NeoBundle 'tpope/vim-fugitive'
call neobundle#end()

NeoBundleCheck

filetype plugin indent on

set autoindent
"case insensitive search
set ic
set hlsearch
"case sensitive with caps
set smartcase
set expandtab
set tabstop=2
set shiftwidth=2
set guioptions-=T
color inkpot
"Allow hiding buffers without writing
set hidden
"Smarter term completion
set wildmenu
set wildmode=list:longest
"set window title
set title
"scroll before you hit the border
set scrolloff=3
"tmp dir
set backupdir=~/.nvim-tmp//,~/.tmp//,~/tmp//,/var/tmp//,/tmp//
set directory=~/.nvim-tmp//,~/.tmp//,~/tmp//,/var/tmp//,/tmp//
set undodir=~/.nvim-undo//
set undofile

"Better ctags bindings
map <C-j> <C-]>
map <C-k> <C-T>

" read the current line, execute it in the shell, and put the results beneath
noremap <silent> <leader>rr yyp!!sh<CR><Esc>

" This will save the first hundred lines of all registers between sessions.
set viminfo=%,'50,\"100,n~/.nviminfo
set backspace=indent,eol,start

set backup        " keep a backup file
set history=100	  " keep command line history
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set mouse=""      " don't use mouse

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif

" Use arrow keys to move between windows
nmap <silent> <Up> :wincmd k<CR>
nmap <silent> <Down> :wincmd j<CR>
nmap <silent> <Left> :wincmd h<CR>
nmap <silent> <Right> :wincmd l<CR>

"strip trailing whitespace
noremap <silent> <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"Disable scratch window
set completeopt=menu,menuone,longest

syntax on

" Open a note for the day
function! EditDailyNote()
    let l:fname = '~/daily/daily.' . strftime('%Y-%m-%d')
    execute ':e' l:fname
endfunction
nnoremap <leader>dd :<C-u>call EditDailyNote()<cr>

"Unite settings
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>b :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" Snippets
let g:neosnippet#snippets_directory = "~/.nvim/snippets"
imap <expr><C-l>
        \ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"

function! RunThat()
    "remove old lines
    let cmd = getline('.')
    let l:winview = winsaveview()
    execute ":.+1,/^$/d" 
    call winrestview(l:winview)
    let output = split(system(cmd), "\n")
    " prefix it so there are no blank lines
    call map(output, '"    " . v:val')
    call add(output, '')
    call append(line('.'), output)
endfunction

function! RunClear()
    " just remove old lines
    let l:winview = winsaveview()
    execute ":.+1,/^$/d" 
    call winrestview(l:winview)
endfunction
nmap <silent> <leader>rr :call RunThat()<cr>
nmap <silent> <leader>rc :call RunClear()<cr>

" for marking todos etc.
iab xnow <c-r>=system("date -Is")<cr>
iab xsat <c-r>=system("date -Is -d'next saturday 10am'")<cr>
iab xsun <c-r>=system("date -Is -d'next sunday 10am'")<cr>
iab xmon <c-r>=system("date -Is -d'next monday 10am'")<cr>
iab xwed <c-r>=system("date -Is -d'next wednesday 10am'")<cr>
iab xnw <c-r>=system('date -Is -d"next week 10am"')<cr>
iab xtomorrow <c-r>=system('date -Is -d"tomorrow 10am"')<cr>

" Execute current file
nnoremap <leader>; :w<cr>:!./%<cr>

set conceallevel=2 concealcursor=i " Uses conceal settings

" escape key issue
set ttimeoutlen=-1

" easytags async
let g:easytags_async = 1
