NIX_SHARE=$HOME/.nix-profile/share
fpath=($NIX_SHARE/share/zsh/site-functions $fpath)
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

export PATH="$PATH:/nix/var/nix/profiles/default/bin/"
export PATH="$PATH:$HOME/.nix-profile/bin/"
export PATH="$PATH:/Applications/Firefox.app/Contents/MacOS/"

