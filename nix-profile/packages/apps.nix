{ pkgs ? import <nixpkgs> { }
,
}:
let
  apppkgs = with pkgs; [
    actionlint
    # act
    # asciinema
    # asciinema-agg
    # localstack
    # spotify
    dive
    duc
    pinentry_mac
    # scrcpy
  ];
in
apppkgs
