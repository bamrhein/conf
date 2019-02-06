## Path additions
# Added path to symlink for Python3 while P2 is still part of system.
export PATH=/usr/local/mysql/bin:/opt:/opt/local/bin:/usr/local/git/bin:/usr/local/opt/python/libexec/bin:$PATH

# Node dev
export NODE_PATH="./node_modules:/usr/local/lib/node_modules"


## Misc. aliases (mostly for colored output)
alias ls='ls -hFG'
alias ll='ls -lhFG'
alias lla='ls -lahFG'
alias grep='grep -G'
alias updatedb='launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist'


## Binds
bind 'set completion-ignore-case on'


## Set up directory marking commands.
## See: http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
## And: https://news.ycombinator.com/item?id=6229001
export MARKPATH=$HOME/.marks
function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
    rm -i "$MARKPATH/$1"
}
function marks {
    \ls -l "$MARKPATH" | tail -n +2 | sed 's/  / /g' | cut -d' ' -f9- | awk -F ' -> ' '{printf "%-10s -> %s\n", $1, $2}'
}
function _jump {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local marks=$(find $MARKPATH -type l | awk -F '/' '{print $NF}')
    COMPREPLY=($(compgen -W '${marks[@]}' -- "$cur"))
    return 0
}
complete -o default -o nospace -F _jump jump
