{pkgs, ...}: let
  langLua = with pkgs; [
    prettierd
    reftools
    stylua
  ];
in
  langLua
