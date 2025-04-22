{
  pkgs ? import <nixpkgs> { },
}:
let
  basePkgs = with pkgs; [
    alacritty
    direnv
    neovim
    ripgrep
    bruno
    difftastic
    fzf
    libgccjit
    gh
    git
    gnupg
    go-task
    gopass
    graphviz # used by go pprof vizualisation
    k9s
    # kubectl
    htop
    lazygit
    nb
    neofetch
    oterm
    rectangle
    # sqlfluff
    yazi

    imagemagick
    luajitPackages.magick
  ];
in
basePkgs
