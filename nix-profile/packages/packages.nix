{pkgs ? import <nixpkgs> {}}: let
  appPkgs = import ./apps.nix {inherit pkgs;};
  basePkgs = import ./base.nix {inherit pkgs;};
  bashPkgs = import ./bash.nix {inherit pkgs;};
  docPkgs = import ./documentation.nix {inherit pkgs;};
  langAll = import ./lang.nix {inherit pkgs;};
  langGo = import ./lang_golang.nix {inherit pkgs;};
  langLua = import ./lang_lua.nix {inherit pkgs;};
  langNix = import ./lang_nix.nix {inherit pkgs;};
  langNode = import ./lang_node.nix {inherit pkgs;};
  networkingPkgs = import ./networking.nix {inherit pkgs;};
in
  basePkgs
  ++ appPkgs
  ++ bashPkgs
  ++ docPkgs
  ++ langAll
  ++ langGo
  ++ langLua
  ++ langNix
  ++ langNode
  ++ networkingPkgs
