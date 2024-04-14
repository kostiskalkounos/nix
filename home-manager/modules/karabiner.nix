{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/karabiner";
in {
  xdg.configFile."karabiner".source = config.lib.file.mkOutOfStoreSymlink "${dir}";
}
