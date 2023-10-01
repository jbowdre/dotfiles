{ pkgs, ... }: {
  # Common GUI apps
  imports = [
    ./firefox.nix
    ./gtk.nix
    ./qt.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    obsidian
    qFlipper
  ];
}
