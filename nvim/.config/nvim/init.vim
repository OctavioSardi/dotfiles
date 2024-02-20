let mapleader=" " " map leader to Space

set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
set softtabstop=4
set mouse=a
set termguicolors
set conceallevel=3
set foldmethod=marker
set clipboard=unnamedplus
syntax on

inoremap ;;; <Esc>/<++><Enter>"_c4l
inoremap ;;i **<Space><Esc>hi
inoremap ;;b ****<Space><Esc>2hi
inoremap ;;t ---<CR>title:<Space><++><CR>author:<Space><++><CR>date:<Space><++><CR>---<CR><Esc>ggI

call plug#begin()

Plug 'http://github.com/tpope/vim-surround' " Surrounding ysw
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
Plug 'https://github.com/vim-airline/vim-airline' " Status bar
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/rafi/awesome-vim-colorschemes' " Retro Scheme
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal 
Plug 'https://github.com/vimwiki/vimwiki' "vimwiki 
Plug 'https://github.com/jiangmiao/auto-pairs' "vim-autopairs
Plug 'https://github.com/alvan/vim-closetag' "vim-closetag 
Plug 'https://github.com/mhinz/vim-startify' "vim-startify
Plug 'junegunn/goyo.vim' "Goyo
Plug 'https://github.com/junegunn/limelight.vim' "Limelight
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'edluffy/hologram.nvim'

set encoding=UTF-8

call plug#end()

" example
nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle
nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

:colorscheme gruvbox

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" MD2PDF

nnoremap <silent> <leader>c :w! <CR> :!rm %:r.pdf <CR> :!pandoc --pdf-engine=xelatex -V geometry:"top=2cm, bottom=1.5cm, left=2cm, right=2cm" --toc %:p -o %:r.pdf <CR> :!sleep 1 <CR> :!okular %:r.pdf <CR>

"SaveClip

nnoremap <silent> <leader>p :call SaveFile()<cr>

function! SaveFile() abort
  let targets = filter(
        \ systemlist('xclip -selection clipboard -t TARGETS -o'),
        \ 'v:val =~# ''image''')
  if empty(targets) | return | endif

  let outdir = expand('%:p:h') . '/Imagenes'
  if !isdirectory(outdir)
    call mkdir(outdir)
  endif

  let mimetype = targets[0]
  let extension = split(mimetype, '/')[-1]
  let tmpfile = outdir . '/savefile_tmp.' . extension
  call system(printf('xclip -selection clipboard -t %s -o > %s',
        \ mimetype, tmpfile))

  let cnt = 0
  let filename = outdir . '/image' . cnt . '.' . extension
  while filereadable(filename)
    call system('diff ' . tmpfile . ' ' . filename)
    if !v:shell_error
      call delete(tmpfile)
      break
    endif

    let cnt += 1
    let filename = outdir . '/image' . cnt . '.' . extension
  endwhile

  if filereadable(tmpfile)
    call rename(tmpfile, filename)
  endif

  " let @* = '![](' . 'Imagenes/image' .cnt . '.' . extension . ')'
  let @* = '![](' . filename . ')'
  normal! "*p
endfunction

" Image Preview

nnoremap <leader>P :!feh "~/Obsidian/Attachments/<cfile>"&<CR><CR>
