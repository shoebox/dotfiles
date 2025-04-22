{ pkgs, ... }:
let
  langAll = with pkgs; [
    nodejs_22
    hadolint
    tree-sitter
    yamllint
  ];
in
langAll
