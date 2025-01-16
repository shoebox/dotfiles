{pkgs, ...}: let
  langNix = with pkgs; [
    alejandra
    deadnix
    nixfmt-rfc-style
    nixpkgs-fmt
    statix
  ];
in
  langNix
