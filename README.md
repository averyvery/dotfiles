Setup:

- Move/rename this project's folder to ~/dotfiles
- Install Butler
- Install BetterTouchTool
- Run the symlink commands:

```bash
ln -s ~/dotfiles/KeyBindings/DefaultKeyBinding.dict ~/Library/Keybindings/DefaultKeyBinding.dict
sudo ln -s ~/dotfiles/Keyboard\ Layouts /Library/
ln -s ~/dotfiles/karabiner ~/.config

ln -s ~/dotfiles/fish ~/.config
ln -s ~/dotfiles/kitty ~/.config
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/xvimrc ~/.xvimrc
ln -s ~/dotfiles/ideavimrc ~/.ideavimrc

rm -rf ~/Library/Application\ Support/BetterTouchTool
ln -s ~/dotfiles/BetterTouchTool ~/Library/Application\ Support

ln -s ~/dotfiles/iTerm/com.googlecode.iterm2.plist ~/Library/Preferences
``
