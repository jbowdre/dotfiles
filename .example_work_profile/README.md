# Work profile overlay

_Inspired by the post [Published my Nix Dotfiles](https://www.chrisportela.com/posts/published-nix-dotfiles/) by [@chrisportela](https://github.com/chrisportela)._

This repo demonstrates how I use a private repo to overlay my work-specific configurations on top of my personal ones. To use it, I just:
1. Clone the private repo to my machine.
2. `cd` into the private repo.
3. Run `home-manager switch --flake .#<username>@<hostname>` to activate the work profile (and then use the `switch-home` function to (re)activate it in the future).

When the public `dotfiles` repo gets updated, I use the `update-dotfiles` function to pull in the changes (`nix flake lock --update-input dotfiles ${config.home.homeDirectory}/.dotfiles/`) and reapply the config (`switch-home`).