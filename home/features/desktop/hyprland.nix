{config, pkgs, ... }: {
  wayland.windowManager.hyprland.extraConfig = ''

    monitor=eDP-1,2400x1600,auto,1.0
    env = XCURSOR_SIZE,24

    input {
      kb_layout = us

      follow_mouse = 1

      touchpad {
        natural_scroll = yes
      }

      sensitivity = 0
    }

    general {
      gaps_in = 3
      gaps_out = 7
      border_size = 2
      col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
      col.inactive_border = rgba(595959aa)

      layout = dwindle
    }

    animations {
      enabled = yes
      bezier = myBezier, 0.05, 0.9, 0.1, 1.05
      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
    }

    dwindle {
      pseudotile = yes
      preserve_split = yes
    }

    master {
      new_is_master = true
    }

    gestures {
      workspace_swipe = off
    }

    device:epic-mouse-v1 {
      sensitivity = -0.5
    }

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    $mod = SUPER

    # Example binds, see https://wiki.hyprland.org/Configuring/Bind
    s/ for more
    bind = $mod, Q, exec, kitty
    bind = $mod, C, killactive,
    bind = $mod, M, exit,
    bind = $mod, E, exec, dolphin
    bind = $mod, V, togglefloating,
    bind = $mod, R, exec, wofi --show drun
    bind = $mod, P, pseudo, # dwindle
    bind = $mod, J, togglesplit, # dwindle

    # Move focus with mod + arrow keys
    bind = $mod, left, movefocus, l
    bind = $mod, right, movefocus, r
    bind = $mod, up, movefocus, u
    bind = $mod, down, movefocus, d

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

    # Scroll through existing workspaces with mod + scroll
    bind = $mod, mouse_down, workspace, e+1
    bind = $mod, mouse_up, workspace, e-1

    # Move/resize windows with mod + LMB/RMB and dragging
    bindm = $mod, mouse:272, movewindow
    bindm = $mod, mouse:273, resizewindow


  '';
}
