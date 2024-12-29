{ config, lib, pkgs, ... }:

let
  workspaces = {
    home = "🏠";
    work = "💻";
    admin = "💼";
    media = "📺";
    red = "🔴";
    blue = "🔵";
    orange = "🟠";
    yellow = "🟡";
    green = "🟢";
  };
in
{
  services.aerospace = {
    enable = true;
    package = pkgs.unstable.aerospace;
    settings = {
      on-focus-changed = [ "move-mouse window-lazy-center" ];
      mode.main.binding = {
        alt-shift-f = "fullscreen";
        alt-slash = "layout tiles horizontal vertical";
        alt-shift-semicolon = "mode service";

        # Focus
        alt-h = "focus left --ignore-floating --boundaries-action wrap-around-the-workspace";
        alt-j = "focus down --ignore-floating --boundaries-action wrap-around-the-workspace";
        alt-k = "focus up --ignore-floating --boundaries-action wrap-around-the-workspace";
        alt-l = "focus right --ignore-floating --boundaries-action wrap-around-the-workspace";

        # Move
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        # Resize
        alt-shift-0 = "balance-sizes";
        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";

        # Workspace
        alt-1 = "workspace ${workspaces.home}";
        alt-2 = "workspace ${workspaces.work}";
        alt-3 = "workspace ${workspaces.admin}";
        alt-4 = "workspace ${workspaces.media}";
        alt-5 = "workspace ${workspaces.red}";
        alt-6 = "workspace ${workspaces.blue}";
        alt-7 = "workspace ${workspaces.orange}";
        alt-8 = "workspace ${workspaces.yellow}";
        alt-9 = "workspace ${workspaces.green}";
        alt-shift-1 = "move-node-to-workspace --focus-follows-window ${workspaces.home}";
        alt-shift-2 = "move-node-to-workspace --focus-follows-window ${workspaces.work}";
        alt-shift-3 = "move-node-to-workspace --focus-follows-window ${workspaces.admin}";
        alt-shift-4 = "move-node-to-workspace --focus-follows-window ${workspaces.media}";
        alt-shift-5 = "move-node-to-workspace --focus-follows-window ${workspaces.red}";
        alt-shift-6 = "move-node-to-workspace --focus-follows-window ${workspaces.blue}";
        alt-shift-7 = "move-node-to-workspace --focus-follows-window ${workspaces.orange}";
        alt-shift-8 = "move-node-to-workspace --focus-follows-window ${workspaces.yellow}";
        alt-shift-9 = "move-node-to-workspace --focus-follows-window ${workspaces.green}";
      };
      mode.service.binding = {
        alt-shift-semicolon = "mode main";

        r = [ "flatten-workspace-tree" "mode main" ]; # Reset layout

        alt-shift-h = [ "join-with left" "mode main" ];
        alt-shift-j = [ "join-with down" "mode main" ];
        alt-shift-k = [ "join-with up" "mode main" ];
        alt-shift-l = [ "join-with right" "mode main" ];
      };
      on-window-detected = [
        {
          # 1Password
          "if".app-id = "com.1password.1password";
          run = [ "layout floating" ]; # Exclude
        }
        {
          # Alacritty
          "if".app-id = "org.alacritty";
          run = [ "move-node-to-workspace ${workspaces.work}" ];
        }
        {
          # Code
          "if".app-id = "com.microsoft.VSCode";
          run = [ "move-node-to-workspace ${workspaces.work}" ];
        }
        {
          # Cursor
          "if".app-id = "com.todesktop.230313mzl4w4u92";
          run = [ "move-node-to-workspace ${workspaces.work}" ];
        }
        {
          # Dictionary
          "if".app-id = "com.apple.Dictionary";
          run = [ "layout floating" ]; # Exclude
        }
        {
          # Ghostty
          "if".app-id = "com.mitchellh.ghostty";
          run = [ "move-node-to-workspace ${workspaces.work}" ];
        }
        {
          # Simulator
          "if".app-id = "com.apple.iphonesimulator";
          run = [ "layout floating" ]; # Exclude
        }
        {
          # System Settings
          "if".app-id = "com.apple.systempreferences";
          run = [ "layout floating" ]; # Exclude
        }
        {
          # Xcode
          "if".app-id = "com.apple.dt.Xcode";
          run = [ "move-node-to-workspace ${workspaces.work}" ];
        }
      ];
    };
  };
}
