" My VIMRC File :
" ---------------
" @AUTHOR       : Guillaume Seren
" @WEBSITE      : http://guillaumeseren.com
" @LICENSE      : www.opensource.org/licenses/bsd-license.php
" @Link         : https://github.com/GuillaumeSeren/vimrc
" @CONTRIBUTOR  : Juanes Espinel (juanes0890@gmail.com)  Forked version 16/10/2015
" ---------------

" Summary {{{1
" ===========
" Let's try to split this file into several clear part
" - Startup config
" - Auto load / install plugin manager
" - Plugins List
" - Tweaking Plugins
" - Vim core
" - Vim Display
" - AutoCmd
" - Functions
" - Input

" Startup config {{{1
" ===========
" We can export some config in modular files like :
" Change the default mode of vim.
if has('vim_starting')
    " Be iMproved
    set nocompatible
    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Auto load / install plugin manager {{{1
if !1 | finish | endif

" Auto Install NeoBundle
let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')

" Check if bundle dir is available for new install
if !filereadable(neobundle_readme)
    echo "Installing NeoBundle..."
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
endif

" Plugins List {{{1
" Load Python for  {{{2
if has('nvim')
    runtime! plugin/python_setup.vim
endif

" Default plugins {{{2
" NeoBundle base {{{3
" 20131206: Add NeoBundle
" 13-10-2014: NeoBundle change call to begin
call neobundle#begin(expand('~/.vim/bundle/'))
" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" Some more customisation:
" from: https://github.com/rkaneko/dotfiles/blob/master/.vimrc.init
" let g:neobundle#install_max_processes = 4
let g:neobundle#install_process_timeout = 1500
" My Bundles here:
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" === Plugins non installés par Guillaume {{{3
"}}} 
" DelimitMate {{{3
" https://github.com/Raimondi/delimitMate
" Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc. 
if has('nvim')
    NeoBundle ('Raimondi/delimitMate')
endif

" Plugin disable in txt {{{3

if has('lua')
    autocmd FileType * call PluginDisableInTxt()

    function PluginDisableInTxt()
    if (&ft!='text')
        NeoBundleSource auto-pairs
    endif
    endfunction

        " Auto-pairs {{{4
        " https://github.com/jiangmiao/auto-pairs
        " Vim plugin, insert or delete brackets, parens, quotes in pair
        " WARNING : MY VERSION OF AUTO-PAIRS IS CUSTOMIZED
        NeoBundleLazy 'jiangmiao/auto-pairs'
endif

" IndentLine {{{3
" A vim plugin to display the indention levels with thin vertical lines A vim plugin to display the indention levels with thin vertical lines u
" https://github.com/Yggdroot/indentLine
NeoBundle 'Yggdroot/indentLine'
 
" Numbers {{{3 
" numbers.vim is a vim plugin for better line numbers
" https://github.com/myusuf3/numbers.vim
NeoBundle 'myusuf3/numbers.vim'

" Rainbow_parentheses.vim {{{3
" https://github.com/kien/rainbow_parentheses.vim
" Better Rainbow Parentheses
NeoBundle 'kien/rainbow_parentheses.vim'
 
" Vim Visual Increment {{{3
" visual-increment.vim - use CTRL+A/X to create increasing sequence of numbers or letters via visual mode 
" https://github.com/triglav/vim-visual-increment
 NeoBundle 'triglav/vim-visual-increment'
" On peut aussi utiliser « '<,'>!seq -s ", " » 1 5 pour générer sur une seule ligne avec des « , ». À vois aussi avec awk.

" html5-vim {{{3
" http://vimawesome.com/plugin/html5-vim
" HTML5 omnicomplete and syntax
NeoBundleLazy 'othree/html5.vim', {
      \ 'autoload': {
      \ 'filetypes':['html']
      \ }}

" Deoplete {{{3
" https://github.com/Shougo/deoplete.nvim
" Dark powered asynchronous completion framework for neovim 
if has('nvim')
    NeoBundle 'Shougo/deoplete.nvim'
    let g:deoplete#enable_at_startup = 1
endif

"  Indent object {{{3
" https://github.com/michaeljsmith/vim-indent-object
" Vim plugin that defines a new text object representing lines of code at the same indent level. Useful for python/vim scripts, etc. (better method for Python, it's for txt) !
 
autocmd FileType * call PluginEnableInTxt()

function PluginEnableInTxt()
  if(&ft=='text')
    NeoBundleSource vim-indent-object
  endif
endfunction

NeoBundleLazy 'michaeljsmith/vim-indent-object'


" Restore_view {{{3
" vim-scripts/restore_view.vim
" A plugin for automatically restoring file's cursor position and foldingu
" https://github.com/vim-scripts/restore_view.vim
NeoBundle 'vim-scripts/restore_view.vim'
" === Fin plugins non installés par Guillaume {{{3

"" VIMPROC {{{3
"" Recommended to install
"" original repos on github
"" After install, turn shell ~/.vim/bundle/vimproc,
"" (n,g)make -f your_machines_makefile
"NeoBundle 'Shougo/vimproc', {
"\ 'build' : {
"\     'windows' : 'tools\\update-dll-mingw',
"\     'cygwin'  : 'make -f make_cygwin.mak',
"\     'mac'     : 'make -f make_mac.mak',
"\     'linux'   : 'make',
"\     'unix'    : 'gmake',
"\    },
"\ }
"
"" UNITE {{{3
"" Unite and create user interfaces
"" http://www.vim.org/scripts/script.php?script_id=3396
"" https://github.com/Shougo/unite.vim
"NeoBundle 'Shougo/unite.vim.git'
"
    " NeoComplete {{{3
if has('lua')
    " https://github.com/Shougo/neocomplete.vim
    " Next generation completion framework after neocomplcache
    NeoBundle 'Shougo/neocomplete'
endif


" NeoSnippet {{{3
" https://github.com/Shougo/neosnippet.vim
" neo-snippet plugin contains neocomplcache snippets source
NeoBundle 'Shougo/neosnippet'

" NeoSnippet-snippets {{{3
" https://github.com/Shougo/neosnippet-snippets
" The standard snippets repository for neosnippet
NeoBundle 'Shougo/neosnippet-snippets'

"" unite-outline {{{3
"" outline source for unite.vim
"" https://github.com/h1mesuke/unite-outline
"" http://d.hatena.ne.jp/h1mesuke/20101107/p1
"" Call it with :unite outline
"NeoBundle 'h1mesuke/unite-outline'
"
"" unite-colorscheme {{{3
"" https://github.com/ujihisa/unite-colorscheme
"" A unite.vim plugin
"NeoBundle 'ujihisa/unite-colorscheme'
"


" SYNTASTIC {{{3
" Syntax checking hacks for vim
" https://github.com/scrooloose/syntastic
NeoBundle 'scrooloose/syntastic.git'

" Sensible {{{3
" sensible.vim: Defaults everyone can agree on
" http://www.vim.org/scripts/script.php?script_id=4391
NeoBundle 'tpope/vim-sensible'

"" Fugitive {{{3
"" fugitive.vim: a Git wrapper so awesome, it should be illegal
"" https://github.com/tpope/vim-fugitive
"NeoBundle 'tpope/vim-fugitive'
"
"" Committia {{{3
"" A Vim plugin for more pleasant editing on commit messages
"NeoBundle 'rhysd/committia.vim'
"
"" VimSession {{{3
"" Extended session management for Vim (:mksession on steroids)
"" https://github.com/xolox/vim-session
"NeoBundle 'xolox/vim-session.git', {
"\ 'depends' : 'xolox/vim-misc.git'
"\ }
"
" Repeat {{{3
" repeat.vim: enable repeating supported plugin maps with "."
" http://www.vim.org/scripts/script.php?script_id=2136
" https://github.com/tpope/vim-repeat
NeoBundle 'tpope/vim-repeat'

" SpeedDating {{{3
" speeddating.vim: use CTRL-A/CTRL-X to increment dates, times, and more
" https://github.com/tpope/vim-speeddating
NeoBundle 'tpope/vim-speeddating.git'

"" EditorConfig {{{3
"" EditorConfig plugin for Vim http://editorconfig.org
"NeoBundle 'editorconfig/editorconfig-vim'
"
"" Vinegar {{{3
"" vinegar.vim: combine with netrw to create a delicious salad dressing
"" https://github.com/tpope/vim-vinegar
"NeoBundle 'tpope/vim-vinegar.git'

"" vim-eunuch {{{3
"" tpope/vim-eunuch
"" eunuch.vim: helpers for UNIX
"" http://www.vim.org/scripts/script.php?script_id=4300
"" https://github.com/tpope/vim-eunuch
"NeoBundle 'tpope/vim-eunuch'

" Recover.vim {{{3
" chrisbra/Recover.vim
" A Plugin to show a diff, whenever recovering a buffer
" http://www.vim.org/scripts/script.php?script_id=3068
NeoBundle 'chrisbra/Recover.vim'

"" SearchParty {{{3
"" Extended search commands and maps for Vim
"NeoBundle 'dahu/SearchParty'
"
" Surround {{{3
" surround.vim: quoting/parenthesizing made simple
" https://github.com/tpope/vim-surround
NeoBundle 'tpope/vim-surround'

" Vim-commentary {{{3
" http://www.vim.org/scripts/script.php?script_id=3695
" tpope/vim-commentary
" commentary.vim: comment stuff out
NeoBundle 'tpope/vim-commentary'

" VimAirline {{{3
" lean & mean status/tabline for vim that's light as air
" https://github.com/bling/vim-airline
NeoBundle 'bling/vim-airline'

"" vimwiki {{{3
"" Personal Wiki for Vim
"" https://github.com/vimwiki/vimwiki
"" Key bindings
"" see :h vimwiki-mappings
"" normal mode:
"" <Leader>ww -- Open default wiki index file.
"" <Leader>wt -- Open default wiki index file in a new tab.
"" <Leader>ws -- Select and open wiki index file.
"" <Leader>wd -- Delete wiki file you are in.
"" <Leader>wr -- Rename wiki file you are in.
"" <Enter> -- Folow/Create wiki link
"" <Shift-Enter> -- Split and folow/create wiki link
"" <Ctrl-Enter> -- Vertical split and folow/create wiki link
"" <Backspace> -- Go back to parent(previous) wiki link
"" <Tab> -- Find next wiki link
"" <Shift-Tab> -- Find previous wiki link
"NeoBundle 'vimwiki/vimwiki'
"
"" EasyMotion {{{3
"" Vim motions on speed!
"" https://github.com/Lokaltog/vim-easymotion
"NeoBundle 'Lokaltog/vim-easymotion'
"
" Stupid-EasyMotion {{{3
" A dumbed down version of EasyMotion
" that aids navigation on the current line
" We use the global leader
" <Leader><Leader>w  - make every word a target
" <Leader><Leader>W  - make every space separated word a target
" <Leader><Leader>fx - make every character x in the line a target
NeoBundle 'joequery/Stupid-EasyMotion'

"" quickfixsigns {{{3
"" Mark quickfix & location list items with signs
"" http://www.vim.org/scripts/script.php?script_id=2584
"" NeoBundle 'vim-scripts/quickfixsigns'
"NeoBundle 'tomtom/quickfixsigns_vim'
"
"" VCSCOMMAND {{{3
"" http://www.vim.org/scripts/script.php?script_id=90
"" https://code.google.com/p/vcscommand/
"NeoBundle 'vcscommand.vim'
"
"" vDebug {{{3
"" On remplace Xdebug par Vdebug apparement plus performant
"" http://www.vim.org/scripts/script.php?script_id=4170
"" https://github.com/joonty/vdebug
"" Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.)
"NeoBundle 'joonty/vdebug.git'
"
"" AG.VIM {{{3
"" https://github.com/rking/ag.vim
"" Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module /
"" CLI script 'ack'
"NeoBundle 'rking/ag.vim'
"
"" undotree.vim
"" The ultimate undo history visualizer for VIM
"" https://github.com/mbbill/undotree
"NeoBundle 'mbbill/undotree'
"
"" SUCKLESS {{{3
"" https://github.com/fabi1cazenave/suckless.vim
"" This plugin emulates the excellent wmii <http://wmii.suckless.org/> window
"" manager in Vim.
"NeoBundle 'fabi1cazenave/suckless.vim'
"
" Tabularize ! {{{3
" https://github.com/godlygeek/tabular
" Vim script for text filtering and alignment
" one  : 1
" two  : 2
" tree : 3
" select text in visual mode, then hit : Tabularize /:
" change the : with the needed char to align
NeoBundle 'godlygeek/tabular'

"" Characterize {{{3
"" tpope/vim-characterize
"" characterize.vim:
"" Unicode character metadata
"" http://www.vim.org/scripts/script.php?script_id=4410
"NeoBundle 'tpope/vim-characterize'
"
"" Vim-DevIcons {{{3
"" https://github.com/ryanoasis/vim-devicons#installation
"" adds font icons (glyphs ★♨☢) to programming languages, libraries, and web
"" developer filetypes for: NERDTree, powerline, vim-airline, ctrlp, unite,
"" lightline.vim, vimfiler, and flagship
"NeoBundle 'ryanoasis/vim-devicons'
"
"" goyo {{{3
"" Distraction-free writing in Vim
"" https://github.com/junegunn/goyo.vim
"NeoBundle 'junegunn/goyo.vim'
"
"" vim-colors-solarized {{{3
"" precision colorscheme for the vim text editor
"" http://ethanschoonover.com/solarized
"" https://github.com/altercation/vim-colors-solarized
"NeoBundle 'altercation/vim-colors-solarized.git'
"
"" Vividchalk {{{3
"" a colorscheme strangely reminiscent of Vibrant Ink for a
"" certain OS X editor
"" https://github.com/tpope/vim-vividchalk
"" http://www.vim.org/scripts/script.php?script_id=1891
"NeoBundle 'tpope/vim-vividchalk.git'
"
"" jellybeans.vim {{{3
"" A colorful, dark color scheme for Vim.
"" http://www.vim.org/scripts/script.php?script_id=2555
"" https://github.com/nanotech/jellybeans.vim
"NeoBundle 'nanotech/jellybeans.vim'
"
"" TagBar {{{3
"" Vim plugin that displays tags in a window, ordered by class etc.
"" https://github.com/majutsushi/tagbar
"NeoBundle 'majutsushi/tagbar'
"
"" guyzmo/notmuch
"NeoBundle "guyzmo/notmuch-abook"
"
" Lazy specific plugins {{{2
" a.vim {{{3
" A few of quick commands to swtich between source files and header files
" quickly.
NeoBundleLazy 'a.vim', {
\ 'autoload': {
\     'filetype': ['c', 'h']
\ }}

" Vim-OrgMode {{{3
" Text outlining and task management for Vim based on Emacs' Org-Mode
" https://github.com/jceb/vim-orgmode
NeoBundleLazy 'jceb/vim-orgmode', {
\ 'autoload': {
\     'filetype': ['org']
\ },
\     'depends' : ['vim-scripts/utl.vim']
\ }

" Rails {{{3
" rails.vim: Ruby on Rails power tools
" https://github.com/tpope/vim-rails
NeoBundleLazy 'tpope/vim-rails.git', {
\ 'autoload': {
\     'filetypes': ['ruby']
\ }}

" lua-ftplugin {{{3
" Lua file type plug-in for the Vim text editor
" http://peterodding.com/code/vim/lua-ftplugin
" https://github.com/xolox/vim-lua-ftplugin
NeoBundleLazy 'xolox/vim-lua-ftplugin' , {
\ 'autoload': {
\     'filetypes': ['lua']
\ },
\     'depends' : 'xolox/vim-misc',
\ }

" moonscript-vim {{{3
" leafo/moonscript-vim
" MoonScript support for vim http://moonscript.org
NeoBundleLazy 'leafo/moonscript-vim' , {
\ 'autoload': {
\     'filetypes': ['moon']
\     },
\ }

" elzr: json {{{3
" A better JSON for Vim: distinct highlighting of keywords vs values,
" JSON-specific (non-JS) warnings, quote concealing. Pathogen-friendly.
" https://github.com/elzr/vim-json
NeoBundleLazy 'elzr/vim-json', {
\ 'autoload' : {
\     'filetypes' : ['javascript']
\ }}

" yaml {{{3
NeoBundleLazy 'avakhov/vim-yaml', {
\ 'autoload' : {
\     'filetypes' : ['python', 'yaml']
\ }}

" vim-systemd-syntax {{{3
NeoBundleLazy 'Matt-Deacalion/vim-systemd-syntax', {
\ 'autoload' : {
\     'filetypes' : ['systemd']
\ }}

" Vim-Markdown {{{3
NeoBundleLazy 'tpope/vim-markdown', {
\ 'autoload':{
\     'filetypes':['markdown']
\ }}

" php.vim {{{3
" old::
" NeoBundle 'php.vim'
" 20141028: Change to new StanAngeloff
" https://github.com/StanAngeloff/php.vim
NeoBundleLazy 'StanAngeloff/php.vim', {
\ 'autoload': {
\     'filetypes':['php']
\ }}

" Better PHP indent {{{3
" The official VIm indent script for PHP
" http://www.2072productions.com/to/phpindent.txt
" https://github.com/2072/PHP-Indenting-for-VIm
NeoBundleLazy '2072/PHP-Indenting-for-VIm', {
\ 'autoload': {
\     'filetypes':['php']
\ }}

" PHP Getter / Setter {{{3
" php_getset.vim
" Automatically add getter/setters for PHP4 properties.
" Commands:
"  :InsertGetterSetter
"      Inserts a getter/setter for the property on the current line, or
"      the range of properties specified via a visual block or x,y range
"      notation.  The user is prompted to determine what type of method
"      to insert.
"
"  :InsertGetterOnly
"      Inserts a getter for the property on the current line, or the
"      range of properties specified via a visual block or x,y range
"      notation.  The user is not prompted.
"
"  :InsertSetterOnly
"      Inserts a setter for the property on the current line, or the
"      range of properties specified via a visual block or x,y range
"      notation.  The user is not prompted.
"
"  :InsertBothGetterSetter
"      Inserts a getter and setter for the property on the current line,
"      or the range of properties specified via a visual block or x,y
"      range notation.  The user is not prompted.
NeoBundleLazy 'vim-scripts/php_getset.vim', {
\ 'autoload': {
\     'filetypes':['php']
\ }}

" CSS color {{{3
" Highlight colors in css files
" NeoBundle 'skammer/vim-css-color'
" http://ap.github.io/vim-css-color/
NeoBundleLazy 'ap/vim-css-color', {
\ 'autoload': {
\     'filetypes':['css']
\ }}

" css.vim {{{3
" css.vim
" Cutting-edge vim css syntax file
" http://www.vim.org
NeoBundleLazy "JulesWang/css.vim", {
\ 'autoload': {
\     'filetypes':['css']
\ }}

" vim-css3-syntax {{{3
" Add CSS3 syntax support to vim's built-in `syntax/css.vim`.
" https://github.com/hail2u/vim-css3-syntax
NeoBundleLazy 'hail2u/vim-css3-syntax', {
\ 'autoload': {
\     'filetypes':['css']
\ }}

" html5.vim
" TML5 omnicomplete and syntax
" https://github.com/othree/html5.vim
NeoBundleLazy 'othree/html5.vim', {
\ 'autoload': {
\     'filetypes':['html', 'xhtml']
\ }}

" YAJS.vim
" Yet Another JavaScript Syntax for Vim
" https://github.com/othree/yajs.vim
NeoBundleLazy 'othree/yajs.vim', {
\ 'autoload': {
\     'filetypes':['javascript']
\ }}

" sparkup {{{3
" A parser for a condensed HTML format
" https://github.com/rstacruz/sparkup
NeoBundleLazy 'rstacruz/sparkup', {
\ 'autoload': {
\     'filetypes':['html', 'xhtml']
\ }}

" ragtag {{{3
" ragtag.vim: ghetto HTML/XML mappings (formerly allml.vim)
NeoBundleLazy 'tpope/vim-ragtag', {
\ 'autoload': {
\     'filetypes':['html', 'xhtml']
\ }}

" vim-latex {{{3
" lervag/vim-latex
" https://github.com/lervag/vim-latex
" A simple and lightweight vim-plugin for editing LaTeX files.
NeoBundleLazy 'lervag/vim-latex', {
\ 'autoload': {
\     'filetypes':['tex']
\ }}

" BashSupport {{{3
" BASH IDE -- Write and run BASH-scripts using menus and hotkeys.
" https://github.com/vim-scripts/bash-support.vim
NeoBundleLazy 'vim-scripts/bash-support.vim', {
\ 'autoload': {
\     'filetypes':['sh']
\ }}

"" Bundle samples {{{2
"" non github repos{{{3
"" CommandT :     ================
""Bundle 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (ie. when working on your own plugin)
""Bundle 'file:///Users/gmarik/path/to/plugin'
"" Just for ex of multi repo {{{3
""NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"
" NeoBundle end() {{{2
call neobundle#end()
" Required
filetype plugin indent on
" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Tweaking Plugins {{{1
" === Plugin non installés par Guillaume {{{2
"=== }}}

" Restore_view {{{2
" vim-scripts/restore_view.vim
" A plugin for automatically restoring file's cursor position and foldingu
" https://github.com/vim-scripts/restore_view.vim
set viewoptions=cursor

" IndentLine {{{3
" A vim plugin to display the indention levels with thin vertical lines A vim plugin to display the indention levels with thin vertical lines u
" https://github.com/Yggdroot/indentLine
" vertical line indentation (see config http://www.lucianofiandesio.com/vim-configuration-for-happy-java-coding)
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'

" DelimitMate {{{2
" https://github.com/Raimondi/delimitMate
" Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc. 
if has('nvim')
  let delimitMate_expand_cr = 1
endif
" Auto-pairs {{{2

if has('lua')
    " https://github.com/jiangmiao/auto-pairs
    " Vim plugin, insert or delete brackets, parens, quotes in pair
    " WARNING : MY VERSION OF AUTO-PAIRS IS CUSTOMIZED
    au Filetype vim let b:AutoPairs = {"(": ")"}
endif
" 
" IndentLine {{{2
" A vim plugin to display the indention levels with thin vertical lines A vim plugin to display the indention levels with thin vertical lines u
" https://github.com/Yggdroot/indentLine
" vertical line indentation (see config http://www.lucianofiandesio.com/vim-configuration-for-happy-java-coding)
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'
" Rainbow_parentheses.vim {{{2
" https://github.com/kien/rainbow_parentheses.vim
" Better Rainbow Parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16

let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" === Fin  Plugin non installés par Guillaume {{{2
" }}}
"" AG {{{2
"" if available use ag
"" From: http://robots.thoughtbot.com/faster-grepping-in-vim
"" The Silver Searcher
"if executable('ag')
"  " Use ag over grep
"  set grepprg=ag\ --nogroup\ --nocolor
"endif
"
"" Unite {{{2
"" Unite and create user interfaces
"" http://www.vim.org/scripts/script.php?script_id=3396
"" https://github.com/Shougo/unite.vim
"" interresting :
"" http://www.reddit.com/r/vim/comments/1fpti5/unitevim_the_plugin_you_didnt_know_you_need/
"" http://bling.github.io/blog/2013/06/02/unite-dot-vim-the-plugin-you-didnt-know-you-need/
"" nnoremap <C-p> :Unite file_rec/async<cr>
"" Unite functions {{{3
"" Function unite_settings()
"" add distinct action to be used in a unite buffer
"function! s:unite_settings()
"    " To keep ?
"    " seem's to overide supertab to not be used in unite,
"    " not sure to want it.
"    let b:SuperTabDisabled=1
"    " original up j / down k
"    " ctrl+t : Move down in the list
"    imap <buffer> <C-t>   <Plug>(unite_select_next_line)
"    " ctrl+s : Move up in the list
"    imap <buffer> <C-s>   <Plug>(unite_select_previous_line)
"    " ctrl+x : Open file in a new split
"    imap <silent><buffer><expr> <C-x> unite#do_action('split')
"    " ctrl+v : Open file in a new vertical split
"    imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
"    " ctrl+t : Open file in a new tab
"    imap <silent><buffer><expr> <C-g> unite#do_action('tabopen')
"    " Quit on escape
"    nmap <buffer> <ESC> <Plug>(unite_exit)
"endfunction
"
"" Unite Config {{{3
"" Use ag for search
"if executable('ag')
"  let g:unite_source_grep_command = 'ag'
"  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
"  let g:unite_source_grep_recursive_opt = ''
"endif
"
""let g:unite_data_directory=s:get_cache_dir('unite')
"let g:unite_source_history_yank_enable=1
"let g:unite_source_rec_max_cache_files=5000
"let g:unite_force_overwrite_statusline = 0
"let g:unite_winheight = 10
"
"" Default filters :
"" https://github.com/bling/dotvim/blob/master/vimrc
"call unite#filters#matcher_default#use(['matcher_fuzzy'])
"call unite#filters#sorter_default#use(['sorter_rank'])
"" Custom source :
"call unite#custom#source('line,outline','matchers','matcher_fuzzy')
"" 20150121: old conf:
"" http://eblundell.com/thoughts/2013/08/15/Vim-CtrlP-behaviour-with-Unite.html
""call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
""    \ 'ignore_pattern', join([
""    \ '\.git/',
""    \ ], '\|'))
""function! s:get_cache_dir(suffix)
""    return resolve(expand(s:cache_dir . '/' . a:suffix))
""endfunction
"" Format the unite output to better
"call unite#custom#profile('default', 'context', {
"    \ 'start_insert': 1,
"    \ 'direction': 'botright',
"    \ })
"
"" Keep actions shortcut in distinct function: s:unite_settings()
"autocmd FileType unite call s:unite_settings()
"
"" Unite mappings {{{3
"" Unite grep
"nnoremap <space>/ :Unite grep:.<cr>
"let g:unite_source_history_yank_enable = 1
"" Unite history / Yank
"nnoremap <space>y :Unite history/yank<cr>
"" Unite in buffer
"nnoremap <space>s :Unite -quick-match buffer<cr>
"" Show mapping
"nnoremap <space>m :Unite mapping<cr>
"" Show Syntastic error
"nnoremap <space>x :Error<cr>
"
"" Emulate ctrl-p behavior quite general unite (all type)
"nnoremap <C-P> :<C-u>Unite  -buffer-name=files   -start-insert buffer file_rec/async:!<cr>
"

" NeoComplete {{{2
if has('lua')
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    "@todo: find new dictionary
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default'  : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme'   : $HOME.'/.gosh_completions'
        \ }
    let g:neocomplcache_disabled_sources_list = {'_' : ['dictionary_complete']}
    " Define keyword.
    " je fais esprét de me trompait

    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return neocomplete#close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()

    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
    "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
    "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplete#enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplete#enable_insert_char_pre = 1

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif

" NeoSnippet {{{2
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" SYNTASTIC {{{2
" Syntax checking hacks for vim
" https://github.com/scrooloose/syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open            = 1
let g:syntastic_enable_signs             = 1
let g:syntastic_aggregate_errors         = 1
let g:syntastic_php_checkers             = ['php', 'phpcs', 'phpmd']
" from : https://github.com/scrooloose/syntastic/wiki/PHP%3A---phpcs
let g:syntastic_php_phpcs_args="--encoding=utf-8 --tab-width=4 --standard=PSR2"

" Vim-Airline {{{2
if &term=~'linux'
  let g:airline#extensions#tabline#enabled = 1
elseif &term=~'screen'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
endif

" DBEXT {{{2
" vim-scripts/dbext.vim
" Provides database access to many dbms (Oracle, Sybase, Microsoft, MySQL,
" DBI,..)
" http://www.vim.org/scripts/script.php?script_id=356
" https://github.com/vim-scripts/dbext.vim
" help : ':h dbext-tutorial'
" Default database (local)
" MySQL
let g:dbext_default_profile_mysql_local = 'type=MYSQL:user=root:passwd='':dbname=mysql'

" CRA.vim {{{2
" define cra filetype for lazy loading
au BufRead,BufNewFile *.cra set filetype=cra

"" VimSession {{{2
"" Extended session management for Vim (:mksession on steroids)
"" https://github.com/xolox/vim-session
"let g:session_autoload = 'yes'
"let g:session_autosave = 'yes'
""let g:session_autosave_periodic = 1

" PHP.vim {{{2
" HighLight sql
let php_sql_query = 1
" HighLight HTML
let php_htmlInStrings = 1
" to highlight superglobals like $_GET, $_SERVER, etc.
let php_special_vars = 1
" to highlight functions with special behaviour
let php_special_functions = 1
" to highlight comparison operators in an alternate colour
let php_alt_comparisons = 1
" to highlight '=&' in '$foo =& $bar' in an alternate colour
let php_alt_assignByReference = 1
" syntax works out whether -> indicates a property or method
let php_smart_members = 1
" ... use a different color for '->' based on whether it is used
" " for property access, method access, or dynamic access (using
" " '->{...}')
" " * requires php_smart_members
let php_alt_properties = 1
" ... 1: for folding classes and functions
" 2: for folding all { } regions
" 3: for folding only functions
" TODO: documentation for php_folding_manual
let php_folding = 3

"" Committia {{{2
"let g:committia_hooks = {}
"function! g:committia_hooks.edit_open(info)
"    " Additional settings
"    " If no commit message, start with insert mode
"    if a:info.vcs ==# 'git' && getline(1) ==# ''
"        startinsert
"    end
"
"    " Scroll the diff window from insert mode
"    " Map <C-n> and <C-p>
"    imap <buffer><C-n> <Plug>(committia-scroll-diff-down-half)
"    imap <buffer><C-p> <Plug>(committia-scroll-diff-up-half)
"
"endfunction
"
"function! g:committia_hooks.diff_open(info)
"    " No fold on the committia diff screen
"    set nofoldenable
"endfunction
"
" Vim core {{{1
" Syntax {{{2
" Automatically indent when adding a curly bracket, etc.
set smartindent
" Indispensable pour ne pas tout casser avec ce qui va suivre
set preserveindent
" Largeur de l'autoindentation
set shiftwidth=2
" Arrondit la valeur de l'indentation
set shiftround
" Largeur du caractère tab
set tabstop=2
" Largeur de l'indentation de la touche tab
set softtabstop=2
" Remplace les tab par des expaces
set expandtab ts=2 sw=2 ai
" Do not tab expand on Makefile
autocmd FileType make set noexpandtab shiftwidth=2 softtabstop=0
" 20140901: Add for test.
" redraw only when we need to.
set lazyredraw
" Detection de l'indentation
set cindent
set smartindent
" https://georgebrock.github.io/talks/vim-completion/
" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Modeline {{{2
set modeline modelines=5

"let g:git_modelines_allowed_items = [
"    \ "textwidth",   "tw",
"    \ "softtabstop", "sts",
"    \ "tabstop",     "ts",
"    \ "shiftwidth",  "sw",
"    \ "expandtab",   "et",   "noexpandtab", "noet",
"    \ "filetype",    "ft",
"    \ "foldmethod",  "fdm",
"    \ "readonly",    "ro",   "noreadonly", "noro",
"    \ "rightleft",   "rl",   "norightleft", "norl",
"    \ "cindent",     "cin",  "nocindent", "nocin",
"    \ "smartindent", "si",   "nosmartindent", "nosi",
"    \ "autoindent",  "ai",   "noautoindent", "noai",
"    \ "spell",
"    \ "spelllang"
"    \ ]

" TERM TYPE {{{2
" Let's use screen-256
" From: http://reyhan.org/2013/12/colours-on-vim-and-tmux.html
"set term=screen-256color
"set term=rxvt-unicode-256color
" Just for vimShell
"let g:vimshell_environment_term='rxvt-unicode-256color'

"" Clipboard {{{2
"" Set the clipboard if running inside X11
"if has("X11")
"    set clipboard=unnamedplus
"else
"    set clipboard=unnamed
"endif
"
" SEARCH {{{2
" Recherche en minuscule -> indépendante de la casse,
" une majuscule -> stricte
set smartcase
" Ne jamais respecter la casse
" (attention totalement indépendant du précédent mais de priorité plus faible)
set ignorecase
" Met en évidence TOUS les résultats d'une recherche,
" A consommer avec modération
set hlsearch
" Déplacer le curseur quand on écrit un (){}[]
" (attention il ne s'agit pas du highlight
set showmatch

" PASTE / NOPASTE {{{2
"@TODO: Not certain if really needed
" A utiliser en live, paste désactive l'indentation automatique
" (entre autre) et nopaste le contraire
set nopaste

" COMPLETION MENU {{{2
" Afficher une liste lors de complétion de commandes/fichiers :
set wildmode=list:full
" Allow completion on filenames right after a '='.
" Uber-useful when editing bash scripts
set isfname-==

" BACKUP {{{2
" Modif tmp
set swapfile
" Modif tmp
let g:dotvim_backup=expand('$HOME') . '/.vim/backup'
if ! isdirectory(g:dotvim_backup)
    call mkdir(g:dotvim_backup, "p")
endif
set directory=~/.vim/backup

"" Backups with persistent undos {{{2
"set backup
"let g:dotvim_backups=expand('$HOME') . '/.vim/backups'
"if ! isdirectory(g:dotvim_backups)
"    call mkdir(g:dotvim_backups, "p")
"endif
"exec "set backupdir=" . g:dotvim_backups
"if has('persistent_undo')
"    set undofile
"    set undolevels=1000
"    set undoreload=10000
"    exec "set undodir=" . g:dotvim_backups
"endif
"
"" LINE WRAPPING {{{2
"" Laisse les lignes déborder de l'écran si besoin
""set nowrap
"" Ne laisse pas les ligne deborder de l'écran
"set si "Smart indent
"set wrap "Wrap lines
"set linebreak
"" Size of the linewrapping
"set textwidth=80
"
" SPELL CHECKER {{{2
" @TODO: Remap the mapping of the spell checker
" @TOOD: Support auto detection of the sentence language,
"        so it can support multi language fr / us / en / etc (jpn)
" En live pour quand vous écrivez anglais (le fr est à trouver dans les méandres du net)
" Chiant pour programmer, mais améliorable avec des dico
    " perso et par languages
" set spell
" [s / ]s : saute au prochain / précédant mot avec faute.
    " z= : affiche la liste de suggestion pour corriger.
" set spelllang=fr,en
"http://www.vim-fr.org/index.php/Correction_orthographique
" MOVE CURSOR {{{2
" Envoyer le curseur sur la ligne suivante/précédente après usage des flèches droite/gauche en bout de ligne :
set whichwrap=<,>,[,]

" Stay on the same column if possible {{{2
" Tenter de rester toujours sur la même colonne lors de changements de lignes :
set nostartofline

" COMMAND HISTORY {{{2
" Nombre de commandes maximale dans l'historique :
set history=10000

" Vim display {{{1
" Folding {{{2
" @TODO: Do not change status on :w keep state fold saved.
" I like some folding ideas from :
" http://dougblack.io/words/a-good-vimrc.html#colors
set foldmethod=marker
" Then we want it to close every fold by default so that we have this high level
" view when we open our vimrc.
set foldlevel=0

" Show command (usefull for leader) {{{2
set showcmd

"" COLORSHEME {{{2
"" set the background light or dark
"set background=dark
""let g:solarized_termtrans = 1
""colorscheme solarized
""" Change le colorsheme en mode diff
""if &diff
""    colorscheme solarized
""endif
"
" STATUS {{{2
" Show editing mode
set showmode

" VISUAL BELL {{{2
" Error bells are displayed visually.
set visualbell

" DIFF {{{2
" Affiche toujours les diffs en vertical
set diffopt=vertical

" Split {{{2
" Set the split below the active region.
set splitbelow

" Display cmd mod {{{2
" Indiquer le nombre de modification lorsqu'il y en a plus de 0
" suite à une commande
set report=0

" Title {{{2
" This is nice if you have something
" that reset the title of you term at
" each command, othersize it's annoying ...
set title

" Show Special Char {{{2
" show tabs / nbsp ' ' / trailing spaces
set listchars=nbsp:¬,tab:··,trail:¤,extends:▷,precedes:◁
set list

" Cursor {{{2
" SHOW CURRENT LINE :
set cursorline
"SHOW CURRENT COLUMN :
set cursorcolumn
" SHOW CURSOR
highlight Cursor  guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" LINE NUMBER {{{2
" Show line number
set number
" Show number relative from the cursor
set relativenumber

" HighLighting {{{2
augroup highlight
    " From «More Instantly Better Vim» - OSCON 2013
    " http://youtu.be/aHm36-na4-4
    " Highlight long lines
    autocmd ColorScheme * highlight OverLength ctermbg=darkblue ctermfg=white guibg=darkblue guibg=white
    autocmd ColorScheme * call matchadd('OverLength', '\%81v', 100)
    " Highlight TODO:
    autocmd ColorScheme * highlight todo ctermbg=darkcyan ctermfg=white guibg=darkcyan guibg=white
    autocmd ColorScheme * call matchadd('todo', 'TODO\|@TODO', 100)
    " Highlight MAIL:
    autocmd ColorScheme * call matchadd('todo', 'MAIL\|mail', 100)
    " Highlight misspelled word: errreur
    autocmd ColorScheme * highlight SpellBad ctermfg=red guifg=red
    " Highlight BUGFIX / FIXME
    autocmd ColorScheme * highlight fix ctermbg=darkred ctermfg=white guibg=darkred guibg=white
    autocmd ColorScheme * call matchadd('fix', 'BUGFIX\|@BUGFIX\|bugfix\|FIXME\|@FIXME\|fixme', 100)
    " Highlight author
    autocmd ColorScheme * highlight author ctermfg=brown guibg=brown
    autocmd ColorScheme * call matchadd('author', 'author\|@author', 100)
augroup END

" AutoCmd {{{1
" Fix filetype detection {{{2
if has("autocmd")
    au BufRead            /var/log/kern.log set  ft=messages
    au BufRead            /var/log/syslog   setl ft=messages
    au BufNewFile,BufRead /etc/apache/*     setl ft=apache
    au BufNewFile,BufRead /etc/apache2/*    setl ft=apache
    au BufNewFile,BufRead /etc/nginx/*      setl ft=nginx
    au BufNewFile,BufRead /etc/exim4/*      setl ft=exim
    au BufNewFile,BufRead *.txt             setl ft=text
    " .tac files are used in twisted
    au BufNewFile,BufRead *.tac             setl ft=python
    " pygobject overrides
    au BufNewFile,BufRead *.override        setl ft=c
    " pygobject definitions
    au BufNewFile,BufRead *.defs            setl syntax=scheme et
    au BufNewFile,BufRead *.vala            setl ft=vala
    au BufNewFile,BufRead *.vapi            setl ft=vala
    au BufNewFile,BufRead *.json            setl ft=javascript
    au BufNewFile,BufRead *.qml             setl ft=javascript
    au BufNewFile,BufRead *.otl             setl ft=votl
    au BufNewFile,BufRead *.jeco            setl ft=eco
    au BufNewFile,BufRead *.glsl            setl ft=c
endif

" AutoReLoad vimrc {{{2
" Auto apply modification to vimrc
if has("autocmd")
    autocmd bufwritepost ~/.vimrc     source ~/.vimrc
    autocmd bufwritepost ~/.vim/vimrc source ~/.vimrc
endif

" SESSION {{{2
" Récupération de la position du curseur entre 2 ouvertures de fichiers
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal g'\"" | endif
endif

" Functions {{{1
" AppendModeline() {{{2
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ft=%s ts=%d sw=%d tw=%d %set :",
        \ &filetype, &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" CLOSING {{{2
" ZZ now saves all files, creates a session and exits
function! AutocloseSession()
    wqall
endfunction
noremap <silent> ZZ :call AutocloseSession()<CR>


" OpenTab and lcd to the file {{{2
" Change local working dir upon tab creation
function! TabNewWithCwD(newpath)
    :execute "tabnew " . a:newpath
    if isdirectory(a:newpath)
        :execute "lcd " . a:newpath
    else
        let dirname = fnamemodify(a:newpath, ":h")
        :execute "lcd " . dirname
    endif
endfunction
command! -nargs=1 -complete=file TabNew :call TabNewWithCwD("<args>")

" Remove trailing whitespace {{{2
function! CleanWhiteSpace()
    let l = line(".")
    let c = col(".")
    :%s/\s\+$//e
    let last_search_removed_from_history = histdel('s', -1)
    call cursor(l, c)
endfunction()
command! -nargs=0 CleanWhiteSpace :call CleanWhiteSpace()

" Convert DOS line endings to UNIX line endings {{{2
function! FromDos()
    %s/\r//e
endfunction
command! FromDos call FromDos()

" Auto Chmod {{{2
" Automatically give executable permissions if file begins with #! and
" contains '/bin/' in the path
function! MakeScriptExecuteable()
    if getline(1) =~ "^#!.*/bin/"
        silent !chmod +x <afile>
    endif
endfunction

" Mkdir Create missing directory {{{2
" Used to create missing directories before writing a
" buffer
function! MkdirP()
    :!mkdir -p %:h
endfunction
command! MkdirP call MkdirP()

" SHEBANG {{{2
" shebang automatique lors de l'ouverture nouveau
" d'un fichier *.py, *.sh (bash), modifier l'entête selon les besoins :
" shell
:autocmd BufNewFile *.sh,*.bash 0put =\"#!/bin/bash\<nl># -*- coding: UTF8 -*-\<nl>\<nl>\"|$
" python
:autocmd BufNewFile *.py 0put=\"#!/usr/bin/env python\"|1put=\"# -*- coding: UTF8 -*-\<nl>\<nl>\"|$
" php
:autocmd BufNewFile *.php 0put=\"<?php\<nl>// -*- coding: UTF8 -*-\<nl>\<nl>\"|$

nnoremap <space-a> :echom 'This is a Test !'<CR>

" Input bindings {{{1
" Searching {{{2
" From http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" Reselect visual block after indentation
vnoremap > >gv
vnoremap < <gv

" VimSurround {{{2
let g:surround_no_mappings= 1
nmap ds  <Plug>Dsurround
nmap hs  <Plug>Csurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround

" vim-commentary {{{2
" remap for bépo
xmap gc  <Plug>Commentary
nmap gc  <Plug>Commentary
omap gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap hgc <Plug>ChangeCommentary
nmap gcu <Plug>Commentary<Plug>Commentary

"" SearchParty {{{2
"" Extended search commands and maps for Vim
"" Remap * to #
"" This is done to prevent error when remaping for bépo
"nmap ^* <Plug>SearchPartyVisualFindNext
"nmap ^l <Plug>SearchPartyHighlightClear

" SpeedDating {{{2
" Reselect after increment decrement
map <C-A> <Plug>SpeedDatingUpgv
map <C-X> <Plug>SpeedDatingDowngv

"" Vdebug tweak {{{2
"let g:vdebug_keymap = {
"\ "run"               : "<F5>",
"\ "run_to_cursor"     : "<F1>",
"\ "step_over"         : "<F2>",
"\ "step_into"         : "<F3>",
"\ "step_out"          : "<F4>",
"\ "close"             : "<F6>",
"\ "detach"            : "<F7>",
"\ "set_breakpoint"    : "<F10>",
"\ "get_context"       : "<F11>",
"\ "eval_under_cursor" : "<F12>",
"\ "eval_visual"       : "<Leader>e",
"\ }
"
" Vim Easy Motion {{{2
let g:EasyMotion_leader_key = '\'

"" Disable Arrow in insert mode {{{2
"ino <down>  <Nop>
"ino <left>  <Nop>
"ino <right> <Nop>
"ino <up>    <Nop>
"
"" Disable Arrow in visual mode {{{2
"vno <down>  <Nop>
"vno <left>  <Nop>
"vno <right> <Nop>
"vno <up>    <Nop>
"
"" Remap Arrow Up/Down to move line {{{2
"" Real Vimmer forget the cross
"no <down>   ddp
"no <up>     ddkP
"
"" Remap Arrow Right / Left to switch tab {{{2
"no <left>   :tabprevious<CR>
"no <right>  :tabnext<CR>
"
" Remap netrw arrow {{{2
" From:
" http://unix.stackexchange.com/questions/31575/remapping-keys-in-vims-directory-view
augroup netrw_dvorak_fix
    autocmd!
    autocmd filetype netrw call Fix_netrw_maps_for_dvorak()
augroup END

function! Fix_netrw_maps_for_dvorak()
    " {cr} = « gauche / droite »
    " @TODO: Remap to more vinegar related feature, like:
    " - c : Go back
    " - t : Preview (ranger inspired)
    noremap <buffer> c h
    noremap <buffer> r l
    " {ts} = « haut / bas »
    noremap <buffer> t j
    noremap <buffer> s k
    " noremap <buffer> d h
    " noremap <buffer> h gj
    " noremap <buffer> t gk
    " noremap <buffer> n l
    " noremap <buffer> e d
    " noremap <buffer> l n
    " and any others...
endfunction

" Change default leader key {{{2
let mapleader = ","

" Permet de sauvegarder par ctrl + s {{{2
:nmap <c-s> :w<CR>
" Fonctionne aussi en mode edition
:imap <c-s> <Esc>:w<CR>a
:imap <c-s> <Esc><c-s>

" Completion avec ctrl + space {{{2
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
    \ "\<lt>C-n>" :
    \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
    \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
    \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

augroup linterConfiguration
    autocmd FileType xml   setlocal  makeprg=xmllint\ -
    autocmd FileType xml   setlocal  equalprg=xmllint\ --format\ -
    autocmd FileType html  setlocal  equalprg=tidy\ -q\ -i\ -w\ 80\ -utf8\ --quote-nbsp\ no\ --output-xhtml\ yes\ --show-warnings\ no\ --show-body-only\ auto\ --tidy-mark\ no\ -
    autocmd FileType xhtml setlocal  equalprg=tidy\ -q\ -i\ -w\ 80\ -utf8\ --quote-nbsp\ no\ --output-xhtml\ yes\ --show-warnings\ no\ --show-body-only\ auto\ --tidy-mark\ no\ -
    autocmd FileType json  setlocal  equalprg=python\ -mjson.tool
augroup END

" MOUSE {{{2
" =======
" Utilise la souris pour les terminaux qui le peuvent (tous ?)
" pratique si on est habitué à coller sous la souris et pas sous le curseur,
" attention fonctionnement inhabituel
set mouse=a

" REMAP KEYBOARD for bépo {{{1
" @FIXME: Detect keyboard layout (qwerty / bépo)
" @TODO: Move it at the end, the config must not be layout dependant.
" I use kind dvorak-fr the «bépo» layout on my keyboard.
source ~/.vim/vimrc.bepo
" remap number for direct access
"source ~/.vim/vimrc.num
"
"
" REMAP KEYBOARD for bépo {{{1
" @FIXME: Detect keyboard layout (qwerty / bépo)
" @TODO: Move it at the end, the config must not be layout dependant.
" I use kind dvorak-fr the «bépo» layout on my keyboard.
source ~/.vim/vimrc.bepo
" remap number for direct access
" source ~/.vim/vimrc.num

" Remapage perso {{{2 

noremap ' `
noremap ` '
"See http://vim.wikia.com/wiki/Using_marks

"j -> ; et réciproquement
noremap j ;
noremap ; j

"Ici, je défini la valeur de mapleader à , car la valeur par défaut, \ est loin d’être pratique.
" let mapleader = ',' 
noremap \ ,

noremap <Leader>W :w !sudo tee % > /dev/null
noremap <Leader>o o<Esc>k
noremap <Leader>O O<Esc>j

augroup filetype_c
	autocmd!
	autocmd filetype c nnoremap <buffer> <Leader>à i#include <stdlib.h><CR>#include <stdio.h><CR><CR><ESC>
	autocmd filetype c nnoremap <buffer> <Leader>mai iint main (int argc, char *argv[]) {<CR><CR><CR>printf ("\n\n*********************************\n\n");<CR><CR><CR>printf ("\n\n*********************************\n\n");<CR>return 0;<CR>}<ESC>kkkkkki    <ESC>
	autocmd filetype p* nnoremap <buffer> <Leader>à i#!/usr/sbin/python3.4<CR># -*-coding:Utf-8 -*<CR><CR><ESC>
augroup end

nnoremap <leader>t :tabnew 

"http://asktherelic.com/2011/04/02/on-easily-replacing-text-in-vim/
vmap <Leader>r "sy:%s/<C-R>=substitute(@s,"\n",'\\n','g')<CR>/
" Ajouts persos {{{1
autocmd VimLeave * call system("echo -n $'" . escape(getreg(), "'") . "' | xsel -ib")
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
"http://vim.wikia.com/wiki/Disable_automatic_comment_insertion This sets up an auto command that fires after any filetype-specific plugin; the command removes the three flags from the 'formatoptions' option that control the automatic insertion of comments. With this in your vimrc, a comment character will not be automatically inserted in the next line under any situation. 
doautoall highlight ColorScheme
set background=light "or put dark
hi SpellBad ctermbg=001
" Pour les couleurs voir https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
highlight NbSp ctermbg=015
match NbSp /\%xa0/
highlight Pmenu ctermbg=005 gui=bold
highlight Search ctermbg=178
highlight IncSearch ctermbg=118
highlight visual ctermbg=249
hi CursorColumn ctermbg=239
map <silent> <F7> "<Esc>:silent setlocal spell! spelllang=fr,en<CR>"
autocmd BufNew,BufRead,BufEnter *.txt setlocal spell spelllang=fr,en
let g:neosnippet#snippets_directory='~/.vim/neosnippet-snippets_custom/'
" Step the highlighting. 
" ATTENTION, IL FAUT BIEN METTRE NNOREMAP, SINON, QUAND ON ENTRE EN VISUAL BLOCK, ÇA PLANTE QUAND ON VEUT REPASSER directement EN MODE INSERTION ^^
nnoremap i :noh<CR>i
nnoremap I :noh<CR>I
nnoremap a :noh<CR>a
nnoremap A :noh<CR>A
