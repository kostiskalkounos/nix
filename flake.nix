{
  description = "Nix config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, home-manager, darwin, ... }@inputs:
  let
    system.work = "aarch64-darwin";
    user.work = "replace";
    system.home = "x86_64-darwin";
    user.home = "kostis";
    system.linux = "x86_64-linux";
    user.linux = "replace";
  in {
    darwinConfigurations = {
      kali = darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
            ./darwin/configuration.nix {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user.home}.imports = [
                    ./home-manager/home.nix
                    ./home-manager/modules/bash.nix
                    ./home-manager/modules/bat.nix
                    ./home-manager/modules/clang.nix
                    ./home-manager/modules/git.nix
                    ./home-manager/modules/hammerspoon.nix
                    ./home-manager/modules/karabiner.nix
                    ./home-manager/modules/kitty.nix
                    ./home-manager/modules/neovim.nix
                    ./home-manager/modules/ripgrep.nix
                    ./home-manager/modules/screen.nix
                    ./home-manager/modules/tmux.nix
                    ./home-manager/modules/vim.nix
                    ./home-manager/modules/yabai.nix
                    ./home-manager/modules/zsh.nix
                ];
                extraSpecialArgs = { inherit inputs; };
              };
            }
        ];
        specialArgs = { inherit inputs; };
        system = system.home;
      };

      work = darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
            ./darwin/configuration.nix {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user.work}.imports = [
                    ./home-manager/home.nix
                    ./home-manager/modules/bash.nix
                    ./home-manager/modules/bat.nix
                    ./home-manager/modules/hammerspoon.nix
                    ./home-manager/modules/karabiner.nix
                    ./home-manager/modules/kitty.nix
                    ./home-manager/modules/neovim.nix
                    ./home-manager/modules/ripgrep.nix
                    ./home-manager/modules/yabai.nix
                    ./home-manager/modules/zsh.nix
                ];
                extraSpecialArgs = { inherit inputs; };
              };
            }
        ];
        specialArgs = { inherit inputs; };
        system = system.work;
      };
    };
  };
}

