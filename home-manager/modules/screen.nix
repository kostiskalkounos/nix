{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/screen";
in {
  home.file.".screenrc".source = config.lib.file.mkOutOfStoreSymlink "${dir}/screenrc";
}
