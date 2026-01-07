{
  description = "Thomas NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
        # to have it up-to-date or simply don't specify the nixpkgs input
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      zen-browser,
      ...
    }:
    let
      system = "x86_64-linux";
      host = "nixos";
      username = "thomas";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs-zen-browser = import zen-browser {
        inherit system;
      };
    in
    {
      nixosConfigurations = {
        ${host} = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              system
              username
              host
              pkgs-unstable
              pkgs-zen-browser
              inputs
              ;
          };

          modules = [
            (
              { ... }:
              {
              }
            )
            ./features.nix
            ./nix/configuration.nix
            home-manager.nixosModules.home-manager
          ];
        };
      };
    };
}
