{ config, lib, pkgs, ... }:

let
  pam-watchid = pkgs.stdenv.mkDerivation {
    pname = "pam-watchid";
    version = "0.2.0";
    src = builtins.fetchGit {
      url = "https://github.com/mpwg/pam-watchid.git";
      rev = "e38c03fadcea463e583b879893a5032486b1b10a";
      ref = "main";
    };
    nativeBuildInputs = [ pkgs.swift ];
    buildPhase = ''
      runHook preBuild

      swiftc watchid-pam-extension.swift \
        -o pam_watchid.so \
        -emit-library \
        -Ounchecked

      runHook postBuild
    '';
    installPhase = ''
      runHook preInstall

      mkdir -p $out/lib
      cp pam_watchid.so $out/lib/pam_watchid.so

      runHook postInstall
    '';
    meta.platforms = lib.platforms.darwin;
  };
in
{
  options.security.pam.enableSudoWatchIdAuth = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = ''
      Enable sudo authentication with Apple Watch. When enabled, this option adds the following line
      to /etc/pam.d/sudo:

          auth sufficient pam_watchid.so "reason=execute a command as root"

      Note that macOS resets this file when doing a system update. As such, sudo
      authentication with Apple Watch won't work after a system update until the nix-darwin
      configuration is reapplied.
    '';
  };

  config.system.activationScripts.extraActivation.text =
    let
      pamFile = "/etc/pam.d/sudo";
      pamPath = "/usr/local/lib/pam";
      watchOption = "security.pam.enableSudoWatchIdAuth";
      watchPath = "${pamPath}/pam_watchid.so.2";
      sed = "${pkgs.gnused}/bin/sed";
    in
    ''
      echo "setting up sudo watchid authentication"
      ${
        if config.security.pam.enableSudoWatchIdAuth
        then ''
          if ! grep 'pam_watchid.so' ${pamFile} > /dev/null; then
            $DRY_RUN_CMD sudo mkdir --parents ${pamPath}
            $DRY_RUN_CMD sudo install -o root -g wheel -m 444 ${pam-watchid}/lib/pam_watchid.so ${watchPath}
            # shellcheck disable=SC2016
            $DRY_RUN_CMD ${sed} -i '2i\
          auth       sufficient     pam_watchid.so "reason=execute a command as root" # enabled by nix-darwin: `${watchOption}`
            ' ${pamFile}
          fi
        ''
        else ''
          if grep '${watchOption}' ${pamFile} > /dev/null; then
            $DRY_RUN_CMD sudo rm -f ${watchPath}
            $DRY_RUN_CMD ${sed} -i '/${watchOption}/d' ${pamFile}
          fi
        ''
      }
    '';
}
