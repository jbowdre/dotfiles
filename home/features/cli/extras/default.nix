{ pkgs, ... }: {
  # Extra CLI apps

  imports = [
    ../default.nix
    ./direnv.nix
    ./go.nix
  ];

  home.packages = with pkgs; [
    android-tools # Android SDK
    awscli # AWS CLI
    envsubst # Envvar substitution for Go
    google-cloud-sdk # GCP CLI
    kubectl # Container wrangler
    nil # Nix LSP
    nixfmt-classic # Nix formatter (old, stable one until the new one is stableish)
    vault # Hashicorp vault
  ];

  programs.fish = {
    shellAbbrs = rec {
      k = "kubectl";
    };

    functions = {
      nugo = "hugo new content/posts/$argv/index.md";
    };
  };
}