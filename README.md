Setup:

- Move/rename this project's folder to ~/dotfiles
- Run the symlink commands. `ln` won't replace an existing file or folder, so move any existing target aside first (e.g. `mv ~/.config/fish ~/.config/fish.bak`).

```bash
ln -s ~/dotfiles/KeyBindings/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
ln -s ~/dotfiles/karabiner ~/.config/karabiner
ln -s ~/dotfiles/fish ~/.config/fish
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/zed/keymap.json ~/.config/zed/keymap.json
ln -s ~/dotfiles/zed/settings.json ~/.config/zed/settings.json
ln -s ~/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
```
