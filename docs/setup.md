# Setup

## 1. Install Nix

See [nix-installer](https://github.com/DeterminateSystems/nix-installer).

## 2. Set up configuration

Clone the repository:

```console
git clone https://github.com/micnncim/nix-config
cd nix-config
```

Workaround until <https://github.com/LnL7/nix-darwin/issues/149> is addressed:

```console
sudo mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf
```

## 3. Install prerequisites

Install packages with `direnv`:

```console
nix profile install nixpkgs#direnv
nix profile install nixpkgs#nix-direnv
direnv allow
```

Install Homebrew:

```console
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 4. Build configuration

> **Note**
> You might need to rename a hostname before running the following commands.
> Run `scutil --set HostName <hostname>` for example.

> **Note**
> Some system settings might need restarting a machine.

```console
make
```
