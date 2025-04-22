{ pkgs, ... }:
let
  langLua = with pkgs; [
    lua-language-server
    prettierd
    reftools
    stylua
  ];
in
langLua
