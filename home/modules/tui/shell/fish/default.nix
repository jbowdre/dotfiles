{ pkgs, ... }: {
  imports = [
    ./abbrs.nix
    ./functions.nix
    ./shell-init.nix
  ];

  programs = {
    fish = {
      enable = true;

      plugins = [
        {
          name = "plugin-git";
          src = pkgs.fishPlugins.plugin-git.src;
        }
        {
          name = "bass";
          src = pkgs.fishPlugins.bass.src;
        }
      ];
    };

  };
}