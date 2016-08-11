# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/averyavery/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/Users/averyavery/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# https://github.com/edc/bass
bass source ~/.nvm/nvm.sh

alias g 'git'
alias gpo 'git push origin HEAD'
alias gpu 'git push upstream HEAD'
alias glo 'git pull origin HEAD'
alias glu 'git pull upstream HEAD'
alias gac 'git status; and git add --all; and git commit -m'
alias gas 'git status; and git add --all; and git commit --amend'

alias pd 'pretty-diff'

alias nvm-use 'bass source ~/.nvm/nvm.sh ";" nvm use'
alias nvm-install 'bass source ~/.nvm/nvm.sh ";" nvm install'

alias api 'cd /Volumes/Havenly/vagrantbox/src/api'
alias app 'cd /Volumes/Havenly/vagrantbox/src/app'
alias cli 'cd /Volumes/Havenly/vagrantbox/src/client'
alias cms 'cd /Volumes/Havenly/vagrantbox/src/cms'
alias domain 'cd /Volumes/Havenly/vagrantbox/src/domain-model'

alias sshv 'cd /Volumes/Havenly/vagrantbox; and vagrant ssh'
alias up 'cd /Volumes/Havenly/vagrantbox; and vagrant up; and echo ""; and figlet -f "Doom" "Yap that fool!"; and echo ""; and vagrant ssh'
alias down 'cd /Volumes/Havenly/vagrantbox; and vagrant halt'

alias pull_all 'cd /Volumes/Havenly/vagrantbox/src/api; and git pull upstream master; and cd /Volumes/Havenly/vagrantbox/src/app; and git checkout tmp; and git pull upstream master; and cd /Volumes/Havenly/vagrantbox/src/cms; and git pull upstream master'

alias ni 'npm install'
alias nis 'npm install --save --save-exact'
alias nid 'npm install --save-dev --save-exact'
alias nsw 'npm shrinkwrap'

alias chrome-disable '/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-web-security --user-data-dir=/Users/averyavery/Documents/Work/ChromeWithNoSecurity'
alias chrome '/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'

alias dbdev '/usr/local/bin/mysql --defaults-group-suffix=development'

alias flush 'sudo killall -HUP mDNSResponder'

function gz
    gzip -c $argv | wc -c
end

cd /Volumes/Havenly/vagrantbox
