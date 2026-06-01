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

alias y 'yarn'

alias pd 'pretty-diff'

cd ~/Code/whimsical
# cd ~/Code/website/frontend

set AWS_VAULT_KEYCHAIN_NAME login

# https://github.com/fish-shell/fish-shell/issues/5834
set -e fish_user_paths
# set -U fish_user_paths (yarn global bin /usr/local/sbin) $fish_user_paths

# https://stanislas.blog/2018/07/how-to-use-nvm-rbenv-pyenv-goenv-with-fish-shell/
# source (pyenv init - | psub)

set fish_greeting ""

# function fish_prompt
  # set_color purple
  # echo "◇◆ "
# end

# fish_add_path /usr/local/opt/python@3.8/bin

# pnpm
set -gx PNPM_HOME "/Users/dougavery/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# direnv hook fish | source
export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"

# nvm
set -U nvm_default_version v24.9.0

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
