# Maybe a bit antiquated
export PATH=/usr/local/mysql/bin:/opt:/opt/local/bin:/usr/local/git/bin:$PATH

# Node dev
export NODE_PATH="./node_modules:/usr/local/lib/node_modules"


# Misc. aliases (mostly for colored output)
alias ls='ls -hFG'
alias ll='ls -lhFG'
alias lla='ls -lahFG'
alias grep='grep -G'
alias updatedb='launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist'


# Binds
bind 'set completion-ignore-case on'
