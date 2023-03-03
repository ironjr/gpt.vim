if !has("python3")
  echo "vim has to be compiled with +python3 to run this"
  finish
endif

if exists('g:sample_python_plugin_loaded')
    finish
endif


let s:plugin_root_dir = fnamemodify(resolve(expand('<sfile>:p')), ':h')

python3 << EOF
import sys
from os.path import normpath, join
import vim
plugin_root_dir = vim.eval('s:plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python'))
sys.path.insert(0, python_root_dir)
import plugin
EOF


function! CodeCompletion(max_tokens)
  python3 plugin.create_completion(engine='code-davinci-002')
endfunction

function! CodeCompletionLine()
  python3 plugin.create_completion(engine='code-davinci-002', stop='\n')
endfunction

function! TextCompletion(max_tokens)
  python3 plugin.create_completion(engine='text-davinci-003')
endfunction

function! TextCompletionLine()
  python3 plugin.create_completion(engine='text-davinci-003', stop='\n')
endfunction


command! -nargs=? CodeCompletion call CodeCompletion(<q-args>)
command! -nargs=0 CodeCompletionLine call CodeCompletionLine()
command! -nargs=? TextCompletion call TextCompletion(<q-args>)
command! -nargs=0 TextCompletionLine call TextCompletionLine()

map <Leader>co :CodeCompletion 2000<CR>
map <Leader>to :TextCompletion 2000<CR>
map <Leader>cl :CodeCompletionLine<CR>
map <Leader>tl :TextCompletionLine<CR>


let g:sample_python_plugin_loaded = 1
