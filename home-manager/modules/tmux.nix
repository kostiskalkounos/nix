{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/tmux";
in {
  home.file.".tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "${dir}/.tmux.conf";
}
