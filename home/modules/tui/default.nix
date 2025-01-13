{ config, isWork, pkgs, ... }: {
  # Core CLI apps

  imports = [ ./git ./shell ./nix-index.nix ./neovim ./tmux.nix ];

  sops.secrets.ssh-config.sopsFile =
    if isWork then ./secrets-work.yaml else ./secrets-personal.yaml;

  home.packages = with pkgs; [
    apg # Automatic password generator
    cbonsai # Happy little trees
    dig # DNS lookup
    dos2unix # Convert DOS line endings to UNIX
    fast-cli # Netflix speed test
    fortune # Fortune cookies
    gping # Better ping
    gnupg1
    httpie # Better curl
    mtr # Better traceroute
    nmap # Network scanner
    pass # Standard unix password manager
    pigz # Multithreaded gzip
    powershell # Powershell
    python3 # Python 3
    rsync # Remote sync
    unzip # unzip it
    yq # YAML pretty printer and manipulator
    zip # zip it
  ];

  programs = {
    btop.enable = true; # prettier top
    home-manager.enable = true; # managerier home
    jq.enable = true; # json parser
    ssh = {
      enable = true;
      includes = [ "${config.sops.secrets.ssh-config.path}" ];
    };
  };
}
