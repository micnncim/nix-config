final: prev: {
  _gctx = final.callPackage ../pkgs/gctx.nix { };
  _kubectl-reveal-secret = final.callPackage ../pkgs/kubectl-reveal-secret.nix { };
}
