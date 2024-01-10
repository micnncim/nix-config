{ config, lib, pkgs, ... }:

{
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Focus windows
      # If there is no window to focus, focus a window in the reverse direction.
      lalt - h : yabai -m window --focus west  || yabai -m window --focus east
      lalt - j : yabai -m window --focus south || yabai -m window --focus north
      lalt - k : yabai -m window --focus north || yabai -m window --focus south
      lalt - l : yabai -m window --focus east  || yabai -m window --focus west

      # Swap windows
      # If there is no window to swap, swap windows in the reverse direction.
      shift + lalt - h : yabai -m window --swap west  || yabai -m window --swap east
      shift + lalt - j : yabai -m window --swap south || yabai -m window --swap north
      shift + lalt - k : yabai -m window --swap north || yabai -m window --swap south
      shift + lalt - l : yabai -m window --swap east  || yabai -m window --swap west

      # Resize windows
      shift + cmd - h : yabai -m window west  --resize right:-20:0 2> /dev/null || yabai -m window --resize right:-20:0
      shift + cmd - j : yabai -m window north --resize bottom:0:20 2> /dev/null || yabai -m window --resize bottom:0:20
      shift + cmd - k : yabai -m window south --resize top:0:-20   2> /dev/null || yabai -m window --resize top:0:-20
      shift + cmd - l : yabai -m window east  --resize left:20:0   2> /dev/null || yabai -m window --resize left:20:0

      # Balance size of windows
      shift + lalt - 0 : yabai -m space --balance

      # Rotate tree
      lalt - r : yabai -m space --rotate 90

      # Toggle fullscreen
      shift + lalt - f : yabai -m window --toggle zoom-fullscreen

      # Toggle window split type
      lalt - e : yabai -m window --toggle split
    '';
  };

  system.activationScripts.skhd.text = ''
    ${pkgs.skhd}/bin/skhd -r
  '';
}
