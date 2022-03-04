source /usr/local/opt/asdf/asdf.fish

# dvorak party
alias aoeu 'asdf'

alias g 'git'
alias gac 'git status; and git add --all; and git commit -m'
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
alias gpf 'git push origin HEAD --force'

alias y 'yarn'

alias pd 'pretty-diff'

cd ~/Code/whimsical

set AWS_VAULT_KEYCHAIN_NAME login

# https://github.com/fish-shell/fish-shell/issues/5834
set -e fish_user_paths
set -U fish_user_paths (yarn global bin /usr/local/sbin) $fish_user_paths

set fish_greeting ""

function new
    cd ~/Code/whimsical
    git checkout -b dna/$argv[1]
    cd ~/Dropbox/Synced\ Notes/whimsical/tickets
    touch "$argv[1].md"
    echo "## [Card: \"\"]()" > "$argv[1].md"
end

# function fish_prompt
  # set_color purple
  # echo "◇◆ "
# end

# fish_add_path /usr/local/opt/python@3.8/bin
