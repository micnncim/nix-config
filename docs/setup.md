# Setup

## 1. Install Nix

> **Note**
> See also the [official document](https://nixos.org/download.html).

```console
// Install Nix
$ sh <(curl -L https://nixos.org/nix/install) --daemon
```

## 2. Set up configuration

```console
$ mkdir -p $HOME/.config/nix
$ cat <<EOF > $HOME/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

// Setup configurations
$ cd $HOME/.config
$ git clone https://github.com/micnncim/nix-config.git nixpkgs

// Workaround until this is addressed https://github.com/LnL7/nix-darwin/issues/149
$ sudo mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf
```

## 3. Install prerequisites

```console
$ nix-env -i jq
$ nix-env -iA cachix -f https://cachix.org/api/v1/install
// Homebrew for GUI apps
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 4. Build configuration

> **Note**
> You might need to rename a hostname before running the following commands.
> Run `scutil --set HostName <hostname>` for example.

> **Note**
> Some system preference might need restarting the machine.

```console
$ make build
$ make switch
```
