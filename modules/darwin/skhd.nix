{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.skhd ];

  services.skhd = {
    enable = true;
    skhdConfig = ''
      # Focus windows
      # If there is no window to focus, focus a window in the reverse direction.
      lalt - h : yabai -m window --focus west  2> /dev/null || yabai -m window --focus east
      lalt - j : yabai -m window --focus south 2> /dev/null || yabai -m window --focus north
      lalt - k : yabai -m window --focus north 2> /dev/null || yabai -m window --focus south
      lalt - l : yabai -m window --focus east  2> /dev/null || yabai -m window --focus west

      # Swap windows
      # If there is no window to swap, swap windows in the reverse direction.
      shift + lalt - h : yabai -m window --swap west  2> /dev/null || yabai -m window --swap east
      shift + lalt - j : yabai -m window --swap south 2> /dev/null || yabai -m window --swap north
      shift + lalt - k : yabai -m window --swap north 2> /dev/null || yabai -m window --swap south
      shift + lalt - l : yabai -m window --swap east  2> /dev/null || yabai -m window --swap west

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
}
