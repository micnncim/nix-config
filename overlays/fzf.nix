let sources = import ../nix/sources.nix;
in final: prev: {
  fzf = prev.fzf.overrideAttrs (_: rec {
    version = prev.lib.strings.removePrefix "v" sources.fzf.branch;
    src = sources.fzf;
    ldflags =
      [ "-s" "-w" "-X main.version=${version} -X main.revision=${src.rev}" ];
  });
}
