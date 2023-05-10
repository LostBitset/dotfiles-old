" [LINKTO] ~/.config/nvim/init.vim

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

syntax on

filetype plugin indent on

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
set guifont=Fira\ Code:h15

call plug#begin()

Plug 'luochen1990/rainbow'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'neovim/nvim-lspconfig'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mhartington/oceanic-next'
Plug 'tikhomirov/vim-glsl'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'lambdalisue/fern.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'junegunn/fzf'
Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'liquidz/vim-iced', {'for': 'clojure'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/lsp-colors.nvim'
Plug 'zah/nim.vim'

call plug#end()

let g:iced_enable_default_key_mappings = v:true

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> \     pumvisible() ? "\<C-p>" : "\\"
inoremap <expr> ;     pumvisible() ? asyncomplete#close_popup() : ";"

inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"

colorscheme OceanicNext

let g:cursorhold_updatetime = 100

nnoremap <M-[> <C-w>v<C-w><C-w>:terminal<CR>65<C-w><bar><C-w><C-w>
nnoremap <M-]> <C-w>v<C-w><C-w>:terminal<CR>65<C-w><bar>

nnoremap <C-l> i<C-l><C-\><C-n>

nnoremap <M-W> <C-w><C-w>:q<CR>

nnoremap <M-s> :Fern . -drawer<CR><C-w><C-w>

nnoremap <M-k> <C-w><C-w>:w<CR><C-w><C-w>

let g:lsp_document_code_action_signs_enabled = 0

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight EndOfBuffer ctermbg=none

highlight Normal guibg=none
highlight NonText guibg=none
highlight EndOfBuffer guibg=none

" Begin snippet for zah/nim.vim

fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

" Jump to tag
nn <M-g> :call JumpToDef()<cr>
ino <M-g> <esc>:call JumpToDef()<cr>i

" End snippet for zah/nim.vim

