{ config, lib, pkgs, username, ... }:

{
  launchd.user.agents.skhd = {
    path = [ config.environment.systemPath ];

    serviceConfig = {
      ProgramArguments = [ "${pkgs.skhd}/bin/skhd" "--verbose" ];
      KeepAlive = true;
      ProcessType = "Interactive";
      StandardOutPath = "/tmp/skhd_${username}.out.log";
      StandardErrorPath = "/tmp/skhd_${username}.err.log";
    };
  };

  # skhd requires Secure Keyboard Entry to be disabled.
  system.activationScripts.skhd.text = ''
    defaults write com.apple.Terminal SecureKeyboardEntry -bool false
  '';
}
