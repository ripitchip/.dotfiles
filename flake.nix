{
  description = "Thomas NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-staging-next.url = "github:NixOS/nixpkgs/staging-next-25.11";

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
      nixpkgs-staging-next,
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

      pkgs-staging-next = import nixpkgs-staging-next {
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
              pkgs-staging-next
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
