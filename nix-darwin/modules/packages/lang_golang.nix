{ pkgs, ... }:
with pkgs;
[
  air
  delve
  gofumpt
  goimports-reviser
  golines
  gopls
  gotests
  gotestsum
  mockgen
]
