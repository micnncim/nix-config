# Setup

## 1. Install Nix

See [nix-installer](https://github.com/DeterminateSystems/nix-installer).

## 2. Set up configuration

Clone the repository:

```console
git clone https://github.com/micnncim/nix-config.git
```

Workaround until <https://github.com/LnL7/nix-darwin/issues/149> is addressed:

```console
sudo mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf
```

## 3. Install prerequisites

```console
nix-env -i jq
nix-env -iA cachix -f https://cachix.org/api/v1/install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 4. Build configuration

> **Note**
> You might need to rename a hostname before running the following commands.
> Run `scutil --set HostName <hostname>` for example.

> **Note**
> Some system preference might need restarting the machine.

```console
make build
make switch
```
