set term=xterm
syntax enable
set wildmenu
set incsearch
set hlsearch
set showbreak=^

highlight ExtraWhitespace ctermbg=red guibg=red
highlight SpacesBeforeTab ctermbg=red guibg=red

match ExtraWhitespace /\s\+\%#\@<!$\| \+\ze\t/

if (&columns > 92)
	set winwidth=80
	set winminwidth=12
endif

if (&lines > 30)
	set winheight=24
	set winminheight=6
endif

command Develop edit scp://stjepan@real-eniac//home/stjepan/Develop/
