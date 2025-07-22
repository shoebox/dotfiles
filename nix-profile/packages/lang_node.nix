{ pkgs, ... }:
let
  nodepkgs = with pkgs; [
    # nodejs_22
    prettier
    prettierd
    # nodePackages_latest.browser-sync
  ];
in
nodepkgs
