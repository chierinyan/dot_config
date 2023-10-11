nnoremap <Leader>p a<++><Esc>
inoremap <Leader>p <++>
nnoremap <Leader>e /<++><Return>c4l
inoremap <Leader>e <Esc>/<++><Return>c4l
nnoremap <Leader>r /<++><Return>v3lr R
inoremap <Leader>r <Esc>/<++><Return>v3lr R

autocmd Filetype markdown set textwidth=90
autocmd Filetype markdown nnoremap <buffer> <Leader>0 :s/#\+ \?//e<Return>$
autocmd Filetype markdown inoremap <buffer> <Leader>0 <Esc>:s/#\+ \?//e<Return>A
autocmd Filetype markdown nnoremap <buffer> <Leader>1 :s/#\+ \?//e<Return>I#<Space><Esc>$
autocmd Filetype markdown inoremap <buffer> <Leader>1 <Esc>:s/#\+ \?//e<Return>I#<Space><Esc>A
autocmd Filetype markdown nnoremap <buffer> <Leader>2 :s/#\+ \?//e<Return>I##<Space><Esc>$
autocmd Filetype markdown inoremap <buffer> <Leader>2 <Esc>:s/#\+ \?//e<Return>I##<Space><Esc>A
autocmd Filetype markdown nnoremap <buffer> <Leader>3 :s/#\+ \?//e<Return>I###<Space><Esc>$
autocmd Filetype markdown inoremap <buffer> <Leader>3 <Esc>:s/#\+ \?//e<Return>I###<Space><Esc>A
autocmd Filetype markdown nnoremap <buffer> <Leader>4 :s/#\+ \?//e<Return>I####<Space><Esc>$
autocmd Filetype markdown inoremap <buffer> <Leader>4 <Esc>:s/#\+ \?//e<Return>I####<Space><Esc>A
autocmd Filetype markdown nnoremap <buffer> <Leader>5 :s/#\+ \?//e<Return>I#####<Space><Esc>$
autocmd Filetype markdown inoremap <buffer> <Leader>5 <Esc>:s/#\+ \?//e<Return>I#####<Space><Esc>A
autocmd Filetype markdown nnoremap <buffer> <Leader>6 :s/#\+ \?//e<Return>I######<Space><Esc>$
autocmd Filetype markdown inoremap <buffer> <Leader>6 <Esc>:s/#\+ \?//e<Return>I######<Space><Esc>A
autocmd Filetype markdown nnoremap <buffer> <Leader><Return> o<div style="page-break-after: always; break-after: page;"></div><Return><Esc>
autocmd Filetype markdown inoremap <buffer> <Leader><Return> <Esc>o<div style="page-break-after: always; break-after: page;"></div><Return>
autocmd Filetype markdown inoremap <buffer> ,b ****<++><Esc>5hi
autocmd Filetype markdown inoremap <buffer> ,d ~~~~<++><Esc>5hi
autocmd Filetype markdown inoremap <buffer> ,h ====<++><Esc>5hi
autocmd Filetype markdown inoremap <buffer> ,c ```<Return>```<Return><++><Esc>2kA
autocmd Filetype tex,markdown inoremap <buffer> ,m $$<Return>$$<Return><++><Esc>kO

autocmd Filetype yaml set colorcolumn=
autocmd Filetype yaml highlight SepChars ctermbg=220
autocmd Filetype yaml match SepChars /[+,、／？！｜：＂＇＊＜＞＾～＆（）]\|よろず\|コミック\|comic\c/
