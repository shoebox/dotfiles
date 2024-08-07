{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, mac-app-util }:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment = {
          variables = {
            BROWSER = "/Applications/Firefox.app/Contents/MacOS/firefox";
            EDITOR = "nvim";
            PAGER = "less";
            XDG_CONFIG_HOME = "/Users/jme86/.config";
          };

          shellAliases = {
            ls = "eza --icons";
            vim = "nvim";
            cat = "bat";
          };

          systemPackages = with pkgs; [
            alacritty
            direnv
            neovim
            ripgrep

            # tools
            ollama
            gnupg
            gh
            gh-dash
            graphviz # used by go pprof vizualisation
            gopass
            go-task
            htop
            m-cli
            nb
            neofetch

            # documentation
            antora
            vale

            # node
            nodejs_22
            nodePackages_latest.browser-sync

            # bash related
            atuin
            bat
            eza
            jump
            zimfw

            rectangle

            # networking
            curl
            wget
            gcc

            # general utils
            slack
            spotify
            m-cli
            lazygit

            # Golang
            air
            delve
            gofumpt
            goimports-reviser
            golines
            gopls
            gotests
            gotestsum
            mockgen

            prettierd
            reftools
            stylua

            # nix
            deadnix
            nixfmt
            nixpkgs-fmt
            statix
          ];
        };

        fonts.packages = with pkgs; [ victor-mono nerdfonts ];

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        programs = {
          # tmux.enable = true;
          zsh = {
            enable = true; # default shell on catalina
            enableCompletion = false;
            enableSyntaxHighlighting = false;
          };
        };

        system = {
          configurationRevision = self.rev or self.dirtyRev or null;
          defaults = {
            NSGlobalDomain = {
              "com.apple.swipescrolldirection" = true;
              AppleInterfaceStyle = "Dark";
              _HIHideMenuBar = true;
            };

            dock = {
              autohide = true;
              show-recents = false;
              static-only = true;
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

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

        system.activationScripts.alacritty.enable = true;

        imports = [ ./allow-unfree.nix ./tmux.nix ];

        # Add ability to used TouchID for sudo authentication
        security.pam.enableSudoTouchIdAuth = true;
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#UKQL3QJ6QR16
      darwinConfigurations."UKQL3QJ6QR16" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          # mac-app-util.darwinModules.default
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."UKQL3QJ6QR16".pkgs;

      # (import ./copy-application.nix { inherit pkgs;});
    };
}
