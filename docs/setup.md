# Setup

## 1. Install Nix

See [nix-installer](https://github.com/DeterminateSystems/nix-installer).

## 2. Set up configuration

Clone the repository:

```console
git clone https://github.com/micnncim/nix-config
cd nix-config
```

## 3. Install prerequisites

Install packages:

```console
nix profile install nixpkgs#jq
nix profile install nixpkgs#cachix
```

Also set up a Cachix auth token:

```console
export CACHIX_AUTH_TOKEN="..."
```

## 4. Build configuration

### 4.1. Rename hostname (optional)

You might need to rename a hostname of your machine.

#### macOS

```console
scutil --set ComputerName <hostname>
scutil --set LocalHostName <hostname>
scutil --set HostName <hostname>
```

### 4.2. Build and apply configurations

> **Note**
> Some system settings might need restarting a machine to be applied.

#### macOS

Take a workaround until <https://github.com/LnL7/nix-darwin/issues/149> is addressed:

```console
sudo mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf
```

#### Build and apply

```console
make
```
