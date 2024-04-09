NIX_SHARE=$HOME/.nix-profile/share
fpath=($NIX_SHARE/share/zsh/site-functions $fpath)
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
