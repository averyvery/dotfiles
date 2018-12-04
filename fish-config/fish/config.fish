source /usr/local/opt/asdf/asdf.fish

# dvorak party
alias aoeu 'asdf'

alias g 'git'
alias gpo 'git push origin HEAD'
alias gpu 'git push upstream HEAD'
alias glo 'git pull origin HEAD'
alias glu 'git pull upstream HEAD'
alias gac 'git status; and git add --all; and git commit -m'
alias gas 'git status; and git add --all; and git commit --amend'

alias pd 'pretty-diff'

function gz
  gzip -c $argv | wc -c
end

cd ~/Sites
