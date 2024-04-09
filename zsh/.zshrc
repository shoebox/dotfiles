source $HOME/.config/zsh/.zsh_profile
source $HOME/.config/zsh/zimfw.zsh
source $HOME/.config/zsh/alias.zsh
source $HOME/.config/zsh/catpuccin.zsh

export WORK=$HOME/Desktop/work/
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/bin"

# direnv
eval $(direnv hook bash)

export EDITOR="nvim"
export PAGER="less"
export BROWSER="firefox"

source $HOME/.config/zsh/nix.zsh

# Nix
fpath=($HOME/.nix-profile/share/zsh/site-functions $fpath)
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
export PATH="$PATH:/nix/var/nix/profiles/default/bin/"
export PATH="$PATH:$HOME/.nix-profile/bin/"
export PATH="$PATH:/Applications/Firefox.app/Contents/MacOS/"

alias nix="noglob nix"
# End Nix
#
export XDG_CONFIG_HOME="$HOME/.config"

# export ATUIN_NOBIND="true"
# eval "$(atuin init zsh)"
#
# bindkey '^r' _atuin_search_widget
#
# # depends on terminal mode
# bindkey '^[[A' _atuin_search_widget
# bindkey '^[OA' _atuin_search_widget
source $HOME/.config/zsh/atuin.zsh
source $HOME/.config/zsh/npm.zsh


