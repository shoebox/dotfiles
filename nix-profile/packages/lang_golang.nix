{ pkgs, ... }:
let
  langGolang = with pkgs; [
    air
    delve
    go
    gofumpt
    goimports-reviser
    golines
    gopls
    gotests
    gotestsum
  ];
in
langGolang
