{ pkgs, inputs, ... }:
let
  user = "kostis";
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in {
  users.users."${user}" = {
    name = "${user}";
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };

  # home-manager.backupFileExtension = "bak";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = [ unstable.vim ];
  # environment.shells = [ pkgs.zsh ];
  environment.variables.SHELL = "${pkgs.zsh}/bin/zsh";

#  environment.etc."sudoers.d/000-sudo-touchid" = {
#    text = ''
#      Defaults pam_service=sudo-touchid
#      Defaults pam_login_service=sudo-touchid
#    '';
#  };
#
#  environment.etc."pam.d/sudo-touchid" = {
#    text = ''
#      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
#      auth       sufficient     pam_tid.so
#      auth       sufficient     pam_smartcard.so
#      auth       required       pam_opendirectory.so
#      account    required       pam_permit.so
#      password   required       pam_deny.so
#      session    required       pam_permit.so
#    '';
#  };

  homebrew = {
    enable = true;
    global.brewfile = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    taps = [
      "homebrew/bundle"
      "homebrew/cask-fonts"
      "homebrew/services"
      "koekeishiya/formulae"
    ];

    brews = [ 
      "openjdk"
      "google-java-format"
      "jdtls"
      "koekeishiya/formulae/yabai"
    ];

    # whalebrews = [ "whalebrew/wget" ];

    casks = [
      "alfred"
      "basictex"
      "brave-browser"
      "docker"
      "firefox"
      "font-symbols-only-nerd-font"
      "hammerspoon"
      "karabiner-elements"
      "kitty"
      "logi-options-plus"
      "signal"
      "spotify"
      "whatsapp"
      "zoom"
    ];

#    masApps = {
#      "Dark Mode for Safari" = 1397180934;
#      Keynote = 409183694;
#      Numbers = 409203825;
#      Pages = 409201541;
#      Vimari = 1480933944;
#    };
  };

  networking.hostName = "kali";

  # programs.gnupg.agent.enable = true;
  # programs.gnupg.agent.enableSSHSupport = true;

  # system.defaults = { };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    configureBuildUsers = true;
    settings = {
      sandbox = true;
      extra-sandbox-paths = [ "/private/tmp" "/private/var/tmp" "/usr/bin/env" ];
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  # programs.nix-index.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Fonts
#  fonts.fonts = with pkgs; [
#    recursive
#    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
#  ];

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.bash.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    enableBashCompletion = false;
    promptInit = "";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}

