{ config, pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in {
  home.packages = with pkgs; [
    # niv # easy dependency management for nix projects
    # node
    # node2nix # generate Nix expressions to build NPM packages
    # statix # lints and suggestions for the Nix programming language
    bashInteractive
    bat
    boost
    cachix # adding/managing alternative binary caches hosted by Cachix
    cmake
    comma # run software from without installing it
    coreutils
    delta
    dos2unix
    fd
    fzf
    gdb
    git
    gnused
    go
    gotop
    htop
    jq
    lf
    libuv
    llvm
    lua54Packages.lua
    maven
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

  xdg.configFile."nix/nix.conf".text = ''
    auto-optimise-store = true
    experimental-features = nix-command flakes
    gc-keep-derivations = true
    gc-keep-outputs = true
    warn-dirty = false
  '';
}
