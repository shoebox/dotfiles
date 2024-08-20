{ pkgs, ... }: {
  programs.tmux = {
    defaultCommand = "zsh";
    enable = true;
    enableSensible = false;
    extraConfig = ''
      source-file ~/.config/tmux/tmux.conf
    '';
  };
}
