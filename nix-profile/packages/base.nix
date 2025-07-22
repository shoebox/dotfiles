{ pkgs ? import <nixpkgs> { }
,
}:
let
  basePkgs = with pkgs; [
    alacritty
    direnv
    neovim
    ripgrep
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
    rectangle
    # sqlfluff
    yazi

    # imagemagick
    # luajitPackages.magick
  ];
in
basePkgs
