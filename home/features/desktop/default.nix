{ pkgs, ... }: {
  # Common GUI apps
  imports = [
    ./firefox.nix
    ./gtk.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    obsidian
    qFlipper
  ];
}
