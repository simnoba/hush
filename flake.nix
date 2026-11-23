{
  description = "NixOS system configuration for hush server";

  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";

    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";

    tangled.url = "git+https://tangled.org/tangled.org/core";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-darwin" "x86_64-darwin" "x86_64-linux"];

      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
      ];

      flake = {
        nixosConfigurations = {
          # Server
          hush = inputs.nixpkgs.lib.nixosSystem rec {
            system = "x86_64-linux";
            pkgs = inputs.self.legacyPackages.${system};
            specialArgs = {inherit inputs;};
            modules = [
              inputs.agenix.nixosModules.default
              inputs.tangled.nixosModules.knot-rs
              ./machines/server.nix
              ./hardware/server.nix
            ];
          };
        };
      };

      perSystem = {
        pkgs,
        self',
        system,
        lib,
        ...
      }: {
        devShells.default = pkgs.mkShell {
          name = "nixd-shell";
          packages = [pkgs.nixd self'.formatter];
        };

        formatter = pkgs.alejandra;

        overlayAttrs = {};

        legacyPackages = pkgs;

        _module.args.pkgs = import inputs.nixpkgs {
          config.allowUnfree = true;
          config.permittedInsecurePackages = [
          ];
          hostPlatform = system;
          inherit system;
          overlays = let
            compose = f: g: x: f (g x);
            mkCustomPackage = pair: _final: prev: {
              "${pair.name}" = prev.callPackage (pair.package) {};
            };
            listNixFilesRecursive = path:
              builtins.filter (lib.hasSuffix ".nix") (map toString (lib.filesystem.listFilesRecursive path));
          in [];
          #map import (listNixFilesRecursive ./overlays)
          #++ map (compose mkCustomPackage import) (listNixFilesRecursive ./packages);
        };
      };
    };
}
