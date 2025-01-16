{pkgs ? import <nixpkgs> {}}: let
  apppkgs = with pkgs; [
    act
    hadolint
    slack
    spotify
  ];
in
  apppkgs
