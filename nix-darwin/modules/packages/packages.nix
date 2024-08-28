{ pkgs, ... }:
with pkgs;
let
  apps = import ./networking.nix { inherit pkgs; };
  bash = import ./bash.nix { inherit pkgs; };
  docs = import ./documentation.nix { inherit pkgs; };
  lang_golang = import ./lang_golang.nix { inherit pkgs; };
  lang_lua = import ./lang_lua.nix { inherit pkgs; };
  lang_nix = import ./lang_nix.nix { inherit pkgs; };
  networking = import ./networking.nix { inherit pkgs; };
  node = import ./node.nix { inherit pkgs; };
  shared = import ./base.nix { inherit pkgs; };
in
shared ++ docs ++ node ++ bash ++ networking ++ apps ++ lang_golang ++ lang_lua ++ lang_nix
