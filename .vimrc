""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 显示相关  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  
autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
autocmd InsertEnter * se cul    " 用浅色高亮当前行  
set ruler           " 显示标尺  
set showcmd         " 输入的命令显示出来，看的清楚些  
set cmdheight=1     " 命令行（在状态行下）的高度，设置为1  
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  
set novisualbell    " 不要闪烁(不明白)  
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
set laststatus=1    " 启动显示状态行(1),总是显示状态行(2)  
set foldmethod=manual   " 手动折叠  
" 显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

set nu!
syntax enable
syntax on
colorscheme desert

" Vundle manage
set nocompatible		" be iMprove,required
filetype off			" required

" set the runtimepath to include Vandle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle,required
Plugin 'VundleVim/Vundle.vim'
" All of your Plugins must be added before the following line

Plugin 'majutsushi/tagbar'   " Tag bar"
Plugin 'scrooloose/nerdtree'
Plugin 'w0rp/ale'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'Valloric/YouCompleteMe'

call vundle#end()			" required
filetype plugin indent on	" required

" -----------------------------------------------------
" cscope:建立数据库: cscope -Rbq;
" F5 查找C符号;
" F6 查找字符串;
" F7 查找函数谁调用了;
" -----------------------------------------------------
if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=1
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	endif
	set csverb
endif

:set cscopequickfix=s-,c-,d-,i-,t-,e-

" nmap <C-_>s:cs find s <C-_R>=expand("<cword>")<CR><CR>
" F5 查找C符号;F6 查找字符串;F7 查找函数谁调用了
nmap <silent> <F5> :cs find s <C-R>=expand("<cword>") <CR><CR>
nmap <silent> <F6> :cs find t <C-R>=expand("<cword>") <CR><CR>
nmap <silent> <F7> :cs find c <C-R>=expand("<cword>") <CR><CR>

" Tag bar
nmap <F9> :TagbarToggle<CR>
let g:tagbar_autopreview = 1
let g:tagbar_sort = 0
let g:tagbar_width=60
autocmd BufReadPost *.cpp,*.c,*.h,*.cc,*.cxx call tagbar#autoopen()

" NetRedTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeWinSize=30
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
let NERDTreeShowBookmarks=1

" ale
" let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
"打开文件时不进行检查
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_link_on_insert_level = 1
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

" youcompleteme
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
autocmd InsertLeave * if pumvisible() == 0|pclose|endif " 离开插入模式后自动关闭预览窗口
let g:ycm_collect_identifiers_from_tags_files=1         " 开启YCM基于标签引擎
let g:syntastic_ignore_files=[".*\.py$"]
let g:ycm_seed_identifiers_with_syntax = 1         " 语法关键字补全
let g:ycm_confirm_extra_conf = 0                   " 关闭加载.ycm_extra_conf.py提示
let g:ycm_key_list_select_completion = ['<c-n>','<Down>']" 没有这个会拦截掉tab
let g:ycm_key_list_previous_completion = ['<c-p>','<Up>']
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_server_python_interpreter='/usr/bin/python3'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 1       " 语法检查
let g:ycm_use_clangd = 0
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"        " 回车即选中当前项
nnoremap <c-j> :YcmCompleter GoToDefinitionElseDeclaration<CR>  " 跳转到定义处
let g:ycm_min_num_of_chars_for_completion = 2		      " 从第2歌键入字符就开始罗列匹配项

" vim-gutentags
" 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 配置ctags的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args = ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args = ['--c-kinds=+px']
