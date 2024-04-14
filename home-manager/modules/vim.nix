{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/vim";
in {
  home.file.".vim".source = config.lib.file.mkOutOfStoreSymlink "${dir}/.vim";
  home.file.".vimrc".source = config.lib.file.mkOutOfStoreSymlink "${dir}/vimrc";
}
