{ inputs, ... }: {
  # neovim config largely lifted from https://github.com/GaetanLepage/nix-config/tree/master/home/modules/tui/neovim

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./autocmds.nix
    ./completion.nix
    ./keymaps.nix
    ./options.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;

    performance = {
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "hmts.nvim"
          "nvim-treesitter"
        ];
      };
      byteCompileLua.enable = true;
    };

    luaLoader.enable = true;
  };
}