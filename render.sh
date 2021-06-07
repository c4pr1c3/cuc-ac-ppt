#!/usr/bin/env bash
# ref: https://github.com/jgm/pandoc/wiki/Using-pandoc-to-produce-reveal.js-slides

output_dir=(
"."
)

secret=(
"''"  
"'${PRETOKEN}'"
"null"
)

for input in ./*.md;do
    if [[ "$input" == "./README.md" ]];then
      continue
    fi
    i=0
    for dir in "${output_dir[@]}";do
      if [[ "$input" =~ index.md ]];then
        # 生成默认首页
        pandoc index.md -s -o "${dir}/index.html"
        continue
      fi
      if [[ $dir == "." ]];then
        multiplex=''
      else
        multiplex='true'
      fi
      # reveal.js v4 based
      output_ppt="${input}.html"
      pandoc -t revealjs --template=lib/revealjs.template.v4.html -s "${input}" -V theme=my-white -V transition=fade -V incremental=true -V slideNumber=true -o "${output_ppt}" -V revealjs-url="lib/reveal.js.v4" -V history=true --no-highlight -V hlss=monokai -V mathjax=true -V multiplex=${multiplex} -V multiplex-secret="${secret[$i]}" -V multiplex-id="${PREID}" -V multiplex-server="${PRESERVER}" -L revealjs-codeblock.lua
      i=$((i+1))
    done
done
