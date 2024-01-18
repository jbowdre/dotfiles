{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf;
  hasPackage = pname: lib.any (p: p ? pname && p.name == pname) config.home.packages;
  hasKubectl = hasPackage "kubectl";
in
{
  programs.fish = {
    enable = true;

    shellAbbrs = rec {
      ccat = "egrep -v '^\s*(#|\\$)'";
      g = "git";
      ga = "git add";
      gc = "git commit";      # interactive commit
      gcm = "git commit -m";  # quick commit
      gg = "git graph";
      gs = "git status";
      jqless = "jq -C | less -r";
      k = mkIf hasKubectl "kubectl";
      n = "nix";
      sshpass = "ssh -o PubkeyAuthentication=no";
      tf = "terraform";
      tfyolo = "terraform apply -auto-approve";
      v = "vim";
      vi = "vim";
    };

    shellAliases = {
      htop = "btm";   # because I always forget the name
    };

    functions = {
      # Disable greeting
      fish_greeting = "";
      ssh = "TERM=xterm command ssh $argv";
      # Rebuild home-manager
      switch-home = "home-manager switch -b backup --flake ${config.home.homeDirectory}/.dotfiles#$USER@$(hostname -s)";
      switch-nix = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.dotfiles";
    };

    interactiveShellInit =
      # Launch tmux
      ''
        if not set -q TMUX
          tmux attach-session -t $(hostname -s) || tmux new-session -s $(hostname -s)
        end
      '' +
      # Open command buffer in vim when alt+e is pressed
      ''
        bind \ee edit_command_buffer
      '' +
      # Use vim bindings and cursors
      ''
        fish_vi_key_bindings
        set fish_cursor_default       block       blink
        set fish_cursor_insert        line        blink
        set fish_cursor_replace_one   underscore  blink
        set fish_cursor_visual        block
      '' +
      # Restore ctrl+f to accept suggestions
      ''
        bind -M insert \cf forward-char
        bind -M default \cf forward-char
        bind -M visual \cf forward-char
      '' +
      # Use terminal colors
      ''
        set -U fish_color_autosuggestion      brblack
        set -U fish_color_cancel              -r
        set -U fish_color_command             brgreen
        set -U fish_color_comment             brmagenta
        set -U fish_color_cwd                 green
        set -U fish_color_cwd_root            red
        set -U fish_color_end                 brmagenta
        set -U fish_color_error               brred
        set -U fish_color_escape              brcyan
        set -U fish_color_history_current     --bold
        set -U fish_color_host                normal
        set -U fish_color_match               --background=brblue
        set -U fish_color_normal              normal
        set -U fish_color_operator            cyan
        set -U fish_color_param               brblue
        set -U fish_color_quote               yellow
        set -U fish_color_redirection         bryellow
        set -U fish_color_search_match        'bryellow' '--background=brblack'
        set -U fish_color_selection           'white' '--bold' '--background=brblack'
        set -U fish_color_status              red
        set -U fish_color_user                brgreen
        set -U fish_color_valid_path          --underline
        set -U fish_pager_color_completion    normal
        set -U fish_pager_color_description   yellow
        set -U fish_pager_color_prefix        'white' '--bold' '--underline'
        set -U fish_pager_color_progress      'brwhite' '--background=cyan'
      '';
  };
}
