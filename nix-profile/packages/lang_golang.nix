{pkgs, ...}: let
  langGolang = with pkgs; [
    air
    delve
    gofumpt
    goimports-reviser
    golines
    gopls
    gotests
    gotestsum
  ];
in
  langGolang
