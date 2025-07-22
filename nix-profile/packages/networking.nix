{ pkgs, ... }:
let
  networkingpkgs = with pkgs; [
    awscli2
    curl
    gcc
    # google-cloud-sdk
    jq
    # nginx
    # terraform
    grpcurl
    grpcui
    k6
    vegeta
    wget
  ];
in
networkingpkgs
