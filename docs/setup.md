# Setup

```console
// Install Nix
$ sh <(curl -L https://nixos.org/nix/install) --daemon
$ mkdir -p $HOME/.config/nix
$ cat <<EOF > $HOME/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

// Setup configurations
$ cd $HOME/.config
$ git clone https://github.com/micnncim/nix-config.git nixpkgs

// Workaround until this is addressed https://github.com/LnL7/nix-darwin/issues/149
$ sudo mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf

$ make build
$ make switch
```
