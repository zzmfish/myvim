"grep
command! -nargs=1 Grep :!grep --binary-files=without-match --color=always -n
    \ --exclude-dir='.svn' --exclude-dir='.git'
    \ --exclude='cscope.files' --exclude='cscope.out' --exclude='tags' --exclude='*.log'
    \ <args> * -r
command! -nargs=1 GrepWord :Grep "\b<args>\b"
command! -nargs=1 GrepClass :Grep "\bclass <args>\s*[:{\n]"
command! -nargs=1 GrepFunction :Grep "^[^\(]\+[: ]<args>\(.*\)\s\+[{\n]"

function! GrepMenu()
    let word = expand("<cword>")
    echo "Search: " . word
    let type = inputlist(['Type:', '1.Any', '2.Word', '3.Class', '4.Function'])
    if type == 1
        execute "Grep " . word
    elseif type == 2
        execute "GrepWord " . word
    elseif type == 3
        execute "GrepClass " . word
    elseif type == 4
        execute "GrepFunction " . word
    else
    endif
endfunction
