{
  description = "A Very Flakey Home Manager";

  # Initial layout shamelessly stolen from:
  # - https://github.com/Misterio77/nix-starter-configs/
  # - https://github.com/Misterio77/nix-config/

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's a working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'nix/overlays/default.nix'.

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware
    hardware.url = "github:nixos/nixos-hardware";

    # Firefox add-ons
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = nixpkgs.legacyPackages;
    in
    {
      inherit lib;
      nixosModules = import ./nix/modules/nixos;
      homeManagerModules = import ./nix/modules/home-manager;

      overlays = import ./nix/overlays { inherit inputs outputs; };

      packages = forEachSystem (pkgs: import ./nix/pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      nixosConfigurations = {
        # Pixelbook converted to NixOS
        pixnix = lib.nixosSystem {
          modules = [ ./nix/hosts/pixnix ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "john@penguin-fw" = lib.homeManagerConfiguration {
          modules = [ ./nix/home/john/penguin-fw.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "john@penguin-duet" = lib.homeManagerConfiguration {
          modules = [ ./nix/home/john/penguin-duet.nix ];
          pkgs = pkgsFor.aarch64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "john@pixnix" = lib.homeManagerConfiguration {
          modules = [ ./nix/home/john/pixnix.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
