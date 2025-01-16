{pkgs, ...}: let
  langAll = with pkgs; [
    tree-sitter
  ];
in
  langAll
