{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/yabai";
in {
  xdg.configFile."yabai".source = config.lib.file.mkOutOfStoreSymlink "${dir}";
}
