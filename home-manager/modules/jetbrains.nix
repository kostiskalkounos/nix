{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/jetbrains";
in {
  xdg.configFile."jetbrains".source = config.lib.file.mkOutOfStoreSymlink "${dir}";
}
