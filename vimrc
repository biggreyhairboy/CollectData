call plug#begin()
Plug 'scrooloose/nerdtree', 
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'Valloric/YouCompleteMe',
Plug 'nvie/vim-flake8',
Plug 'w0rp/ale',
Plug 'Xuyuanp/nerdtree-git-plugin',
Plug 'airblade/vim-gitgutter',
Plug 'ctrlpvim/ctrlp.vim',
Plug 'vim-airline/vim-airline',
Plug 'vim-airline/vim-airline-themes',
Plug 'SirVer/ultisnips',
Plug 'skywind3000/asyncrun.vim',
Plug 'OmniSharp/omnisharp-vim',
Plug 'tpope/vim-fugitive',
Plug 'jiangmiao/auto-pairs',
Plug 'scrooloose/nerdcommenter',
Plug 'tpope/vim-surround'
call plug#end()
"ESC key mapping
nmap <c-[> <esc>
imap <c-[> <esc>
vmap <c-[> <esc>
omap <c-[> <esc>
"basic setting
set ic
set hls is
set nocompatible
"use , as leader key
let mapleader=","

"set backspace working for most" of the case
set backspace=indent,eol,start

"disable python-mode auto completion in case conflicts with ycm
let g:pymode_rope_complete_on_dot = 0
"python-mode syntax checking python3 by setting
let g:pymode_python = 'python3'
let g:pymode_rope_goto_definition_bind = '<leader>pg'

"flake8 setting
let g:flake8_pyflake_marker=''
let g:flake8_naming_marker=''
"F9 execute current python script
nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>

"syntastic checking
"syntastic not chekcing python
"let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_python_checkers = ['python3']
"let g:syntastic_python_checkers = ['flake8']
"ycm setting
""disable ycm
"let g:loaded_youcompleteme = 1
"go to declaration
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
"disable ycm syntax checker
let g:ycm_show_diagnostics_ui = 0
"open ycm syntax completion by printing two characters
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
"ctrl + z open syntax completion
let g:ycm_key_invoke_completion = '<c-z>'
"disalbe function autocomplete preview window
set completeopt=menu,menuone
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_server_log_level = 'info'
"nerdtree setting
"open nerdtree automatically
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"open a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"close window when only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"short key for nerdtree
"nmap <leader>nt :NERDTreeToggle<cr>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"vimairline config and  theme
let g:airline_theme='light'
set laststatus=2
set ttimeoutlen=50
set t_Co=256

""" OmniSharp won't work without this setting
filetype plugin on

" Set the type lookup function to use the preview window instead of echoing it
"let g:OmniSharp_typeLookupInPreview = 1

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview' if you
" don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview

" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono).
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
"let g:omnicomplete_fetch_full_documentation = 1

" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
set previewheight=5

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
let g:ale_linters = { 'cs': ['OmniSharp']  }

" Fetch semantic type/interface/identifier names on BufEnter and highlight them
let g:OmniSharp_highlight_types = 1

augroup omnisharp_commands
    autocmd!

    " When Syntastic is available but not ALE, automatic syntax check on events
    " (TextChanged requires Vim 7.4)
    " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " Update the highlighting whenever leaving insert mode
    autocmd InsertLeave *.cs call OmniSharp#HighlightBuffer()

    " Alternatively, use a mapping to refresh highlighting for the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>th :OmniSharpHighlightTypes<CR>

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

