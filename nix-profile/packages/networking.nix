{pkgs, ...}: let
  networkingpkgs = with pkgs; [
    curl
    gcc
    # google-cloud-sdk
    jq
    # nginx
    # terraform
    wget
  ];
in
  networkingpkgs
