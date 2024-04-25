{ pkgs, ... }: {
  # Common GUI apps
  imports = [
    ./firefox.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    gimp-with-plugins
    lagrange
    (unstable.obsidian)
    qFlipper
    remmina
  ];
}
