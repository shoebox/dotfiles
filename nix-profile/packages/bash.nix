{pkgs, ...}: let
  bashpkgs = with pkgs; [
    atuin
    bat
    chafa
    eza
    jump
    zimfw
  ];
in
  bashpkgs
