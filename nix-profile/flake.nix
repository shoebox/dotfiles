{
  description = "shoebox profile";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    flakey-profile.url = "github:lf-/flakey-profile";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    flakey-profile,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfreePredicate = pkg:
              builtins.elem (nixpkgs.lib.getName pkg) [
                "slack"
                "spotify"
                # "terraform"
              ];
          };
        };

        systemPkgs = import ./packages/packages.nix {inherit pkgs;};
      in
        with pkgs; {
          packages.profile = flakey-profile.lib.mkProfile {
            inherit pkgs;
            paths = systemPkgs;
            pinned = {
              nixpkgs = toString nixpkgs;
            };
          };
        }
    );
}
