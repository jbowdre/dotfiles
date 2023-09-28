{config, pkgs, ... }: {
  wayland.windowManager.hyprland.extraConfig = ''
    $mod = SUPER

    bind = $mod, F, exec, firefox
    bind = , Print, exec, grimblast copy area
    bind = $mod, Q, exec, kitty
    bind = $mod, C, killactive,
    bind = $mod, M, exit

    input {
      touchpad {
        natural_scroll = yes
      }
    }

    # workspaces
    # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
    ${builtins.concatStringsSep "\n" (builtins.genList (
        x: let
          ws = let
            c = (x + 1) / 10;
          in
            builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $mod, ${ws}, workspace, ${toString (x + 1)}
          bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        ''
      )
      10)}

  '';
}
