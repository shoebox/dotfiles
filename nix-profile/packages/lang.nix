{ pkgs, ... }:
let
  langAll = with pkgs; [
    nodejs_22
    hadolint
    mermaid-cli
    taplo
    tree-sitter
    yamlfmt
    yamllint
  ];
in
langAll
