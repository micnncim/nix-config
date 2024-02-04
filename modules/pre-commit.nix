{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    pre-commit
  ];

  # pre-commit doesn't support variable substitution in the config file
  # so we have to use a Nix expression to generate the config file.
  xdg.configFile."pre-commit/.pre-commit-config.yaml" = {
    text = ''
      repos:
      - repo: https://github.com/pre-commit/pre-commit-hooks
        rev: v3.2.0
        hooks:
        - id: check-added-large-files
        - id: check-case-conflict
        - id: check-json
        - id: check-merge-conflict
        - id: check-symlinks
        - id: check-toml
        - id: check-yaml
        - id: detect-private-key
        - id: end-of-file-fixer
        - id: forbid-new-submodules
        - id: mixed-line-ending
        - id: no-commit-to-branch
          stages: [commit, push]
          args:
          - -b=develop
          - -b=main
          - -b=master
          - -b=production
          - -b=staging
          - -b=trunk
          - -p=release/.*
        - id: trailing-whitespace

      - repo: https://github.com/sirwart/ripsecrets
        rev: v0.1.7
        hooks:
        - id: ripsecrets-system

      - repo: local
        hooks:
        - id: typos
          name: typos
          entry: bash -c 'typos --config ${config.xdg.configHome}/typos/typos.toml --write-changes'
          language: system
    '';
  };
}
