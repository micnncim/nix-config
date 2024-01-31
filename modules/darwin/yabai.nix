{ config, lib, pkgs, ... }:

let
  jq = "${pkgs.jq}/bin/jq";
in
{
  services.yabai = {
    enable = true;
    config = {
      layout = "bsp";

      window_placement = "second_child";
      window_opacity = "off";

      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 10;
      external_bar = "all:45:0";

      focus_follows_mouse = "autoraise";
      mouse_follows_focus = "on";

      mouse_modifier = "alt";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";

      debug_output = "on";
    };
    extraConfig = ''
      yabai -m rule --add app='^1Password$' manage=off grid=2:4:2:0:1:2
      yabai -m rule --add app='^Calculator$' manage=off
      yabai -m rule --add app='^coreautha$' manage=off
      yabai -m rule --add app='^Dictionary$' manage=off grid=2:4:2:0:1:2
      yabai -m rule --add app='^Okta Verify$' manage=off
      yabai -m rule --add app='^Raycast$' manage=off
      yabai -m rule --add app='^Spark$' manage=off grid=1:2:1:0:1:1
      yabai -m rule --add app='^System Information$' manage=off
      yabai -m rule --add app='^System Settings$' manage=off grid=2:4:2:0:1:2
      yabai -m rule --add app='^Tailscale$' manage=off
    '';
  };
}
