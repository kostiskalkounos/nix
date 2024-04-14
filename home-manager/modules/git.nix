{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/git";
in {
  home.file.".gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${dir}/.gitconfig";
  home.file.".gitignore".source = config.lib.file.mkOutOfStoreSymlink "${dir}/.gitignore";
}

