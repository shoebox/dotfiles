{ config, lib, pkgs, ... }:

{
  nixpkgs.config = {
    # allow some unfree packages to be installed
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "slack"
      "spotify"
    ];
  };
}
