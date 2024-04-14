{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/hammerspoon";
in {
  home.file.".hammerspoon".source = config.lib.file.mkOutOfStoreSymlink "${dir}";
}

