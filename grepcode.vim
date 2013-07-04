"grep
function! Grep(word)
    let cmd = "grep --binary-files=without-match --color=never -n"
    \ . " --exclude-dir='.svn' --exclude-dir='.git'"
    \ . " --exclude='cscope.files' --exclude='cscope.out' --exclude='tags' --exclude='*.log'"
    \ . " \"" . escape(a:word, '\') . "\" * -r"
    let result = system(cmd)
    let matchList = split(result, '\n')
    let idx = 0
    if len(matchList) > 20
        return
    elseif len(matchList) > 1
        let idx = inputlist(matchList)
    endif
    let line = matchList[idx]
    let splitLine = split(line, ':')
    let filePath = splitLine[0]
    let lineNum = splitLine[1]
    execute "tabedit " . filePath
    execute lineNum
endfunction

function! GrepMenu()
    let word = expand("<cword>")
    echo "Search: " . word
    let type = inputlist(['Type:', '1.Any', '2.Word', '3.Class', '4.Function'])
    if type == 1
        call Grep(word)
    elseif type == 2
        call Grep('\b' . word . '\b')
    elseif type == 3
        call Grep('\bclass ' . word . '\s*[:{\n]')
    elseif type == 4
        call Grep('^[^\(]\+[: ]' . word . '\(.*\)\s\+[{\n]')
    else
    endif
endfunction
