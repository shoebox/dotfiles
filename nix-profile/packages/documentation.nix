{ pkgs, ... }:
let
  docpkgs = with pkgs; [
    asciidoctor
    d2
    rubyPackages_3_3.rouge
    # vale
  ];
in
docpkgs
