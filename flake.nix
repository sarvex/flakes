{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/?ref=nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/?ref=nyxpkgs-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    chaotic,
    ...
  }: {
    nixosConfigurations = {
      latitude = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix # Your system configuration.
          chaotic.nixosModules.default # OUR DEFAULT MODULE
        ];
      };
    };
  };
}
