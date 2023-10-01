{ pkgs, ... }: {
  # Common GUI apps
  imports = [
    ./firefox.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    obsidian
    qFlipper
  ];
}
