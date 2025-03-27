# Config files

> [!NOTE]
> This project has [moved](https://git.vim.wtf/wq/dotfiles).

## Nix
I've started the process of leveraging [Nix](https://nixos.org/explore.html) to manage my system configurations. This repo holds files used for managing user environments with [Home Manager](https://github.com/nix-community/home-manager), largely adapted from the wonderful examples at [nix-starter-configs](https://github.com/Misterio77/nix-starter-configs) and the same author's more advanced [nix-config](https://github.com/Misterio77/nix-config), with later work borroweed from [GaetanLepage/nix-config](https://github.com/GaetanLepage/nix-config).

The [.example_work_profile](./.example_work_profile) directory demonstrates how I use a private repo to overlay my work-specific configurations on top of my personal ones.

*I've preserved my previous configs in the [.legacy_dotfiles](./.legacy_dotfiles) directory, but I'm not actively maintaining them anymore.*
