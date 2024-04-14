{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/kitty";
in {
  xdg.configFile."kitty".source = config.lib.file.mkOutOfStoreSymlink "${dir}";
}

