# MacOS

## Install Nix
sh <(curl -L https://nixos.org/nix/install)

## Install Nix-Darwin (Home Manager will be installed automatically with the Flake)
nix run --extra-experimental-features "nix-command flakes" nix-darwin -- switch --flake ~/.config/nix

### If there are `SSL` errors check if these certificates exist and replace them
ls -la /etc/ssl/certs/ca-certificates.crt
sudo rm /etc/ssl/certs/ca-certificates.crt
sudo ln -s /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt

## Upgrade
sudo -i sh -c 'nix-channel --update && nix-env --install --attr nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'

# Linux

## Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon

## Install Home Manager with a Flake
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install

home-manager switch -f ~/.config/nix/linux/home.nix

## Upgrade
nix-channel --update; nix-env --install --attr nixpkgs.nix nixpkgs.cacert; systemctl daemon-reload; systemctl restart nix-daemon
