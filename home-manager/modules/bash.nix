{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/bash";
in {
  home.file.".bashrc".source = config.lib.file.mkOutOfStoreSymlink "${dir}/.bashrc";
}

