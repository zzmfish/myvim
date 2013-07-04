"grep
command! -nargs=1 Grep :!grep --binary-files=without-match --color=always -n
    \ --exclude-dir='.svn' --exclude-dir='.git'
    \ --exclude='cscope.files' --exclude='cscope.out' --exclude='tags' --exclude='*.log'
    \ <args> * -r
command! -nargs=1 GrepWord :Grep "\b<args>\b"
command! -nargs=1 GrepClass :Grep "\bclass <args>\s*[:{\n]"
command! -nargs=1 GrepFunction :Grep "^[^\(]\+[: ]<args>\(.*\)\s\+[{\n]"


