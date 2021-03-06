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

alias y 'yarn'

alias pd 'pretty-diff'

cd ~/Code/whimsical

set AWS_VAULT_KEYCHAIN_NAME login

set -U fish_user_paths (yarn global bin) $fish_user_paths

set fish_greeting ""

# function fish_prompt
  # set_color purple
  # echo "◇◆ "
# end
