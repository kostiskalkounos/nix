{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/zsh";
in {
  home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${dir}/.zshrc";
}
