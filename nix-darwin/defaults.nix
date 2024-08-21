{ pkgs, ... }: {
  system = {
    defaults = {
      NSGlobalDomain = {
        "com.apple.swipescrolldirection" = true;
        AppleInterfaceStyle = "Dark";
        _HIHideMenuBar = true;
      };

      dock = {
        appswitcher-all-displays = true;
        autohide = true;
        autohide-delay = 0.1;
        show-recents = false;
        static-only = false;
        # https://github.com/LnL7/nix-darwin/issues/789
        persistent-apps = [
          "${pkgs.alacritty}/Applications/Alacritty.app/"
          "${pkgs.spotify}/Applications/Spotify.app/"
          "${pkgs.slack}/Applications/Slack.app/"
        ];
      };

      finder = {
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        FXPreferredViewStyle = "clmv";
        _FXShowPosixPathInTitle = true;
        QuitMenuItem = true;
        ShowStatusBar = true;
        ShowPathbar = true;
      };
    };
  };
}
