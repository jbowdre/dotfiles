{ pkgs, inputs, outputs, lib, ... }: {
  home.packages = with pkgs.unstable; [
    obsidian
  ];
}