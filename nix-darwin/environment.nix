{ pkgs, ... }:
let
  systemPkgs = import ./modules/packages/packages.nix { inherit pkgs; };
in
{
  environment = {
    variables = {
      BROWSER = "/Applications/Firefox.app/Contents/MacOS/firefox";
      EDITOR = "nvim";
      PAGER = "less";
      XDG_CONFIG_HOME = "/Users/jme86/.config";
    };

    shellAliases = {
      ls = "eza --icons";
      vim = "nvim";
      cat = "bat";
    };

    systemPackages = systemPkgs;
    # with pkgs; [
    #
    #   # node
    #   nodejs_22
    #   nodePackages_latest.browser-sync
    #
    #   # bash related
    #   atuin
    #   bat
    #   eza
    #   jump
    #   zimfw
    #
    #   # networking
    #   curl
    #   wget
    #   gcc
    #
    #   # general utils
    #   m-cli
    #   lazygit
    #   slack
    #   spotify
    #
    #   # Golang
    #   air
    #   delve
    #   gofumpt
    #   goimports-reviser
    #   golines
    #   gopls
    #   gotests
    #   gotestsum
    #   mockgen
    #
    #   # Lua
    #   prettierd
    #   reftools
    #   stylua
    #
    #   # nix
    #   alejandra
    #   deadnix
    #   nixfmt-rfc-style
    #   nixpkgs-fmt
    #   statix
    # ];
  };
}
