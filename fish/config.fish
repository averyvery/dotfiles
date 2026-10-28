# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/dougavery/.docker/bin"
# End of Docker Desktop section.

# dvorak party
alias g 'git'
alias gac 'git status; and git add --all; and git commit -m'
alias gacf 'git status; and git add --all; and git commit --no-verify -m'
alias gas 'git status; and git add --all; and git commit --amend'
alias gb 'git checkout -b'
alias gbd 'git branch -D'
alias gcb 'git checkout -b'
alias glo 'git pull origin HEAD'
alias glu 'git pull upstream HEAD'
alias gm 'git checkout master'
alias gpo 'git push origin HEAD'
alias gpu 'git push upstream HEAD'
alias gr 'git reset --soft HEAD~1; and git reset'
alias grh 'git reset --hard'
alias grhh 'git reset --hard; and git clean -f -d'
alias gpf 'git push origin HEAD --force'

alias pd 'pretty-diff'

set fish_greeting ""

set --universal nvm_default_version v26.12.1

fish_add_path ~/.local/bin

# cd ~/Code
cd ~/Code/treering-character-extraction
