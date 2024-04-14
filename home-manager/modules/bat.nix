{ config, pkgs, libs, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/bat";
in {
  xdg.configFile."bat".source = config.lib.file.mkOutOfStoreSymlink "${dir}";
}
