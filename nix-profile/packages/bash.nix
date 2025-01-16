{pkgs, ...}: let
  bashpkgs = with pkgs; [
    atuin
    bat
    eza
    jump
    zimfw
  ];
in
  bashpkgs
