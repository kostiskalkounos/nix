{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/nvim";
in {
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${dir}";
}
