{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/ripgrep";
in {
  xdg.configFile."ripgrep".source = config.lib.file.mkOutOfStoreSymlink "${dir}";
}
