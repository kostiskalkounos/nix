{ config, ... }:
let
  dir = "${config.home.homeDirectory}/.config/nix/home-manager/dotfiles/clang";
in {
  home.file.".clang-format".source = config.lib.file.mkOutOfStoreSymlink "${dir}/.clang-format";
}
