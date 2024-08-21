{ pkgs, ... }: {
  programs = {
    zsh = {
      enable = true;
      enableCompletion = false;
      enableSyntaxHighlighting = false;
      shellInit = ''
        source $HOME/.config/zsh/.zshrc
      '';
    };
  };
}
