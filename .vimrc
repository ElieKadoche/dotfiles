" Use vi for very large files
" Configuration for very large CSV files (combined with the following command)
" alias csvv='vi -c "set nowrap" -c "set scrolloff=5" -c "set number" -c "1split | wincmd w"'

" Load Vim defaults (syntax, filetype detection, sane backspace, etc.)
" They are skipped when a vimrc exists
source $VIMRUNTIME/defaults.vim

" Enable termguicolors if supported
if has("termguicolors")
  set termguicolors
endif

" General parameters
set background=dark
set encoding=utf8

" Leader
let mapleader=","
nnoremap <leader>v :vsplit<cr>

" Clipboard
set clipboard+=unnamed

" Enable mouse
set mouse=a

" Set search highlight and change color
hi Search cterm=NONE ctermfg=black ctermbg=green
hi Search guibg=green guifg=black
set hlsearch

" Set filetype for CSV
augroup csv_highlight
  autocmd!
  autocmd BufRead,BufNewFile *.csv set filetype=csv
  " Enable CSV highlighting only for CSV files
  autocmd FileType csv call SetupCSVHighlight()
augroup END

" Special CSV function
function! SetupCSVHighlight()
  " Enable syntax highlighting
  syntax clear
  syntax enable

  " List of colors
  let colors = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 202, 208, 214, 220, 226, 190, 154, 118]

  " Loop over columns
  for i in range(1, 100)
    " Build the match regex for the i-th column
    let pattern = '\v^([^,]*,){' . (i - 1) . '}\zs[^,]*'

    " Create a unique name for each match group
    let colname = "col" . i

    " Syntax match command
    execute "syntax match " . colname . " /" . pattern . "/"

    " Assign a color
    let color = colors[(i - 1) % len(colors)]
    execute "highlight " . colname . " ctermfg=" . color
  endfor
endfunction
