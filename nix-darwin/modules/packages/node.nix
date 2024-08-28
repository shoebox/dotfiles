{ pkgs, ... }:
with pkgs;
[
  nodejs_22
  nodePackages_latest.browser-sync
]
