{ config, pkgs, inputs, ... }:
let
  isLinux = pkgs.stdenv.isLinux;
in {
  home.username = "k";
  home.homeDirectory = "/home/k";

  home.packages = with pkgs; [
    arandr
    bashInteractive
    bat
    boost
    cachix # adding/managing alternative binary caches hosted by Cachix
    cmake
    comma # run software from without installing it
    coreutils
    delta
    dmenu
    dos2unix
    fd
    fzf
    gcc
    gdb
    git
    gnused
    go
    gotop
    htop
    i3
    i3blocks
    jq
    kitty
    lf
    libuv
    llvm
    lua54Packages.lua
    lxappearance
    neovim
    ninja
    nix-output-monitor # get additional information while building packages
    nix-tree # interactively browse dependency graphs of Nix derivations
    nix-update # swiss-knife for updating nix packages
    nixpkgs-review # review pull-requests on nixpkgs
    nodejs_22
    pkg-config
    qemu
    ripgrep
    rofi
    stow
    stylua
    tmux
    tree
    unibilium
    zsh
    zsh-syntax-highlighting
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

#  programs.fzf.enableZshIntegration = true;
#  programs.zsh.syntaxHighlighting.enable = true;

  # home.username = builtins.getEnv "USER";
  # home.homeDirectory = builtins.getEnv "HOME";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "$EDITOR";
    # PAGER = "nvim -R";
    # MANPAGER = "nvim +Man!";
    # LESS = "-R --use-color Du+b";
    # MANPAGER="less -R --use-color -Dd+r -Du+b";
  };

  home.stateVersion = "24.05";

  xdg.enable = true;

  xdg.configFile."nix/nix.conf".text = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    gc-keep-derivations = true
    gc-keep-outputs = true
    warn-dirty = false
  '';

  home.file."nvim" = {
    target = ".config/nvim";
    source = ../home-manager/dotfiles/nvim;
    recursive = true;
  };

  home.file."kitty" = {
    target = ".config/kitty";
    source = ../home-manager/dotfiles/kitty;
    recursive = true;
  };

  home.file = {
    ".bashrc".source = ../home-manager/dotfiles/bash/.bashrc;
    ".zshrc".source = ../home-manager/dotfiles/zsh/.zshrc;
    ".tmux.conf".source = ../home-manager/dotfiles/tmux/.tmux.conf;
  };
}
