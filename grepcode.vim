"grep
function! ParseGrepLine(line)
    let splitItem = split(a:line, ":")
    let colon1 = stridx(a:line, ":")
    let colon2 = stridx(a:line, ":", colon1 + 1)
    let fileName = strpart(a:line, 0, colon1)
    let fileLine = strpart(a:line, colon1 + 1, colon2 - colon1 - 1)
    let matchLine = strpart(a:line, colon2 + 1)
    return [fileName, fileLine, matchLine]
endfunction

function! Grep(pattern, word)
    let cmd = "grep --binary-files=without-match --color=never -n"
    \ . " --exclude-dir='.svn' --exclude-dir='.git'"
    \ . " --exclude='cscope.files' --exclude='cscope.out' --exclude='tags' --exclude='*.log'"
    \ . " \"" . escape(a:pattern, '\') . "\" * -r"
    let result = system(cmd)
    let matchList = split(result, '\n')
    let idx = 0
    if len(matchList) == 0
        echo "Nothing is matched!"
        return
    elseif len(matchList) > 100
        echo "Too Many result!"
        return
    else
        let i = 1
        for i in range(len(matchList))
            let matchItem = matchList[i]
            let parsedItem = ParseGrepLine(matchItem)
            let matchList[i] = parsedItem
            echon (i + 1). "# "
            echon parsedItem[0]
            echon ":"
            echon parsedItem[1]
            echon ":"
            "显示匹配行并高亮关键词
            let matchLine = parsedItem[2]
            let linePos = 0
            while 1
                let wordPos = stridx(matchLine, a:word, linePos)
                if wordPos == -1
                    echon strpart(matchLine, linePos)
                    break
                else
                    echon strpart(matchLine, linePos, wordPos - linePos)
                    echohl Keyword
                    echon strpart(matchLine, wordPos, strlen(a:word))
                    echohl None
                    let linePos = wordPos + strlen(a:word)
                    if linePos >= strlen(matchLine)
                        break
                    endif
                endif
            endwhile
            echon "\n"
            let i = i + 1
        endfor
        let idx = input("Select: ")
        if idx <= 0 || idx > len(matchList)
            echo "Invalid Selection!"
            sleep 1
            return
        endif
        let idx = idx - 1
    endif
    let selectItem = matchList[idx]
    execute "edit " . selectItem[0]
    execute selectItem[1]
endfunction

function! GrepMenu()
    let word = expand("<cword>")
    echon "Search Word: "
    echohl Keyword
    echon word
    echohl None
    let type = inputlist(['Type:', '1.Any', '2.Word', '3.Class', '4.Function'])
    echo "\n"
    if type == 1
        call Grep(word, grep)
    elseif type == 2
        call Grep('\b' . word . '\b', word)
    elseif type == 3
        call Grep('\bclass ' . word . '\s*[:{\n]', word)
    elseif type == 4
        call Grep('^[^\(]\+[: ]' . word . '\(.*\)\s\+[{\n]', word)
    else
    endif
endfunction
