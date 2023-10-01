{ ouputs, cofig, lib, pkgs, ... }:
let
  cat = "${pkgs.coreutils}/bin/cat";
  cut = "${pkgs.coreutils}/bin/cut";
  find = "${pkgs.findutils}/bin/find";
  grep = "${pkgs.gnugrep}/bin/grep";
  journalctl = "${pkgs.systemd}/bin/journalctl";
  jq = "${pkgs.jq}/bin/jq";
  pgrep = "${pkgs.procps}/bin/pgrep";
  ping = "${pkgs.iputils}/bin/ping";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld  = "${pkgs.playerctl}/bin/playerctld";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  tail = "${pkgs.coreutils}/bin/tail";
  timeout = "${pkgs.coreutils}/bin/timeout";
  wc = "${pkgs.coreutils}/bin/wc";
  wofi = "${pkgs.wofi}/bin/wofi";
  xargs = "${pkgs.findutils}/bin/xargs";

  jsonOutput = name: { pre ? "", text ? "", tooltip ? "", alt? "", class ? "", percentage ? "" }: "${pkgs.writeShellScriptBin "waybar-${name}" ''
    set -euo pipefail
    ${pre}
    ${jq} -cn \
      --arg text "${text}" \
      --arg tooltip "${tooltip}" \
      --arg alt "${alt}" \
      --arg class "${class}" \
      --arg percentage "${percentage}" \
      '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
    ''}/bin/waybar-${name}";
in
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
    systemd.enable = true;
    settings = {
      primary = {
        mode = "dock";
        layer = "top";
        position = "top";
        height = 24;
        margin = "6";
      };
    };
  };
}