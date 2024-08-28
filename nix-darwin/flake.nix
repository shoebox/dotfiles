{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , nix-darwin
    , nixpkgs
    ,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          fonts.packages = with pkgs; [
            victor-mono
            nerdfonts
          ];

          # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          system = {
            configurationRevision = self.rev or self.dirtyRev or null;
          };

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";

          imports = [
            ./allow-unfree.nix
            ./tmux.nix
            ./environment.nix
            ./defaults.nix
            ./modules/zsh/zsh.nix
          ];

          # Add ability to used TouchID for sudo authentication
          security.pam.enableSudoTouchIdAuth = true;
        };
    in
    {
      # Build darwin flake using:
      darwinConfigurations."UKQL3QJ6QR16" = nix-darwin.lib.darwinSystem { modules = [ configuration ]; };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."UKQL3QJ6QR16".pkgs;
    };
}
