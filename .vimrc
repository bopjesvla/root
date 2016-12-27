autocmd bufwritepost .vimrc source $MYVIMRC

call plug#begin()
Plug 'exu/pgsql.vim'
Plug 'ivalkeen/vim-simpledb'
Plug 'vim-scripts/summerfruit256.vim'
Plug 'reedes/vim-colors-pencil'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-multiple-cursors'
Plug 'SirVer/ultisnips'
Plug 'posva/vim-vue'
Plug 'honza/vim-snippets'
"Plug 'cohama/lexima.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-unimpaired'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-sensible'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'https://github.com/pangloss/vim-javascript'
Plug 'vim-airline/vim-airline'
Plug 'jonathanfilip/vim-lucius'
Plug 'tpope/vim-fugitive'
Plug 'rking/ag.vim'
Plug 'maksimr/vim-jsbeautify'
call plug#end()

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
			\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
			\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

noremap <Leader>v :e ~/.vimrc<CR>
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_map = '<c-s-e>'
noremap <c-p> :CtrlPMixed<CR>
noremap <Leader>c :CtrlPMixed<CR>
noremap <Leader>s :w<CR>
noremap <Leader>a :Ag 

let g:sql_type_default = 'pgsql'

let g:sneak#use_ic_scs = 1
"set tabstop=4
"set shiftwidth=4
set number

set whichwrap+=<,>,h,l,[,]
set incsearch

noremap <expr> f '/\V'.escape(nr2char(getchar()), '/\\').'<cr>'
noremap <expr> F '?\V'.escape(nr2char(getchar()), '/\\').'<cr>'
noremap <expr> t '/\V\.'.escape(nr2char(getchar()), '/\\').'<cr>'
noremap <expr> T '?\V\.'.escape(nr2char(getchar()), '/\\').'<cr>'
onoremap <expr> f '/\V'.escape(nr2char(getchar()), '/\\').'/e<cr>'
onoremap <expr> F '?\V'.escape(nr2char(getchar()), '/\\').'<cr>'
onoremap <expr> t '/\V'.escape(nr2char(getchar()), '/\\').'<cr>'
onoremap <expr> T '?\V'.escape(nr2char(getchar()), '/\\').'<cr>'

nnoremap <Leader>p "+P=']
set t_ut=
colo lucius
" set t_Co=256
LuciusWhite

set autoread
noremap 0 :buffer<Space>
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1

let g:multi_cursor_exit_from_insert_mode = 0

set ignorecase

set mouse=a

if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif

au FileType * set formatoptions-=r fo-=o
set hidden

function! WriteCreatingDirs()
	execute ':silent !mkdir -p %:h'
	write
endfunction
command! W call WriteCreatingDirs()

nnoremap Zz :w<CR>:bd<CR>
:set backupcopy=yes
set backupdir=~/.vim/backup_files//
set directory=~/.vim/swap_files//
set undodir=~/.vim/undo_files//

autocmd BufNewFile,BufRead *.json set ft=javascript
autocmd BufNewFile,BufRead *.jison set ft=javascript
autocmd BufNewFile,BufRead *.vue set ft=html

autocmd BufNewFile,BufRead *.pl set ft=prolog
autocmd BufNewFile,BufRead *.plt set ft=prolog

autocmd FileType javascript vnoremap <buffer>  <c-f> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-f> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-f> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-f> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-f> :call RangeCSSBeautify()<cr>

function! g:UltiSnips_Complete()
	call UltiSnips#ExpandSnippet()
	if g:ulti_expand_res == 0
		if pumvisible()
			return "\<C-n>"
		else
			if emmet#isExpandable()
				call emmet#expandAbbr(0, '')
				return "\<right>"
			else
				call UltiSnips#JumpForwards()
				if g:ulti_jump_forwards_res == 0
					return "\<tab>"
				endif
			endif
		endif
	endif
	return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <tab> :call UltiSnips#JumpForwards()<CR>
inoremap <s-tab> <c-o>:call UltiSnips#JumpBackwards()<CR>
vmap <M-w> <c-y>,
nmap <M-w> V<c-y>,
let g:ycm_autoclose_preview_window_after_completion=1

nnoremap zp p=']
nnoremap zP P=']

nnoremap <leader>x mtkdd't
