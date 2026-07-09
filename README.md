Setup:

- Move/rename this project's folder to ~/dotfiles
- Run the symlink commands:

```bash
ln -s ~/dotfiles/KeyBindings/DefaultKeyBinding.dict ~/Library/Keybindings/DefaultKeyBinding.dict
ln -s ~/dotfiles/karabiner ~/.config

ln -s ~/dotfiles/fish ~/.config
ln -s ~/dotfiles/kitty ~/.config
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/ideavimrc ~/.ideavimrc

ln -s ~/dotfiles/zed/keymap.json ~/.config/zed/keymap.json
ln -s ~/dotfiles/zed/settings.json ~/.config/zed/settings.json
```
