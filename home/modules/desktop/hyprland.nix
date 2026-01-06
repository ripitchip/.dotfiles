{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkEnableOption mkIf;
in
{
  programs.kitty.enable = true; # Required for default Hyprland config
  home.packages = with pkgs; [
    hyprcursor
    xcur2png
    clickgen
    nodejs_24
    yarn
    zip
  ];
  # home.pointerCursor =
  #   let
  #     getLocal = path: name: {
  #       gtk.enable = true;
  #       x11.enable = true;
  #       name = name;
  #       size = 24;
  #       package = pkgs.runCommand "banana-cursor-local" { } ''
  #         mkdir -p $out/share/icons
  #         cp -r ${path} $out/share/icons/${name}
  #       '';
  #     };
  #   in
  #   getLocal ./Banana-hyprcursor "Banana-hyprcursor";
  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.settings = {
    # Variables
    "$mainMod" = "SUPER";
    "$term" = "kitty";
    "$browser" = "zen";
    "$ROFI_MENUS" = "~/.config/rofi/bin";

    # Monitor setup
    monitor = [ ",preferred,auto,1" ];

    # Startup apps
    exec-once = [
      "waybar"
      "hyprpaper"
      "nm-applet"
      "wl-paste --watch cliphist store"
    ];

    exec = [
      "gsettings set org.gnome.desktop.interface color-scheme \"prefer-dark\""
      "gsettings set org.gnome.desktop.interface gtk-theme \"adw-gtk3-dark\""
    ];

    # Environment variables
    env = [
      "QT_QPA_PLATFORM=wayland"
      "GDK_BACKEND=wayland,x11"
      "XDG_CURRENT_DESKTOP=Hyprland"
      "XDG_SESSION_TYPE=wayland"
      "XCURSOR_THEME,Banana"
      # "HYPRCURSOR_THEME,Banana-hyprcursor"
      "XCURSOR_SIZE,48"
      # "HYPRCURSOR_SIZE,24"
    ];

    # General settings
    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
      layout = "dwindle";
    };

    # Decoration
    decoration = {
      rounding = 10;
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
      };
      # Removed drop_shadow, shadow_range, shadow_render_power
    };
    cursor = {
      hide_on_touch = true;
      enable_hyprcursor = false;
      inactive_timeout = 10;
      no_hardware_cursors = 0;
    };
    # Animations
    animations = {
      enabled = true;
    };

    # Input settings
    input = {
      kb_layout = "us";
      kb_variant = "altgr-intl";
      kb_options = "lv3:ralt_switch,caps:swapescape";
      follow_mouse = 1;
      touchpad = {
        natural_scroll = false;
      };
      sensitivity = 0;
    };

    # Misc settings
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
    };

    # Keybindings
    bind = [
      "$mainMod, Return, exec, $term"
      "$mainMod, B, exec, $browser"
      "$mainMod, Q, killactive,"
      "$mainMod, F, fullscreen,"
      "$mainMod, V, togglefloating,"

      # Vim-style window movement inside workspace
      "$mainMod, H, movewindow, l"
      "$mainMod, L, movewindow, r"
      "$mainMod, J, movewindow, d"
      "$mainMod, K, movewindow, u"

      # Vim-style window swap (optional, swaps positions with another window)
      "$mainMod+Shift, H, swapwindow, l"
      "$mainMod+Shift, L, swapwindow, r"
      "$mainMod+Shift, J, swapwindow, d"
      "$mainMod+Shift, K, swapwindow, u"

      "$mainMod+Ctrl, H, resizeactive, -10 0"
      "$mainMod+Ctrl, L, resizeactive, 10 0"
      "$mainMod+Ctrl, J, resizeactive, 0 10"
      "$mainMod+Ctrl, K, resizeactive, 0 -10"

      # Switch to workspace 1-9
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, Tab, workspace, previous"

      # Move focused window to workspace 1-9
      "$mainMod+Shift, 1, movetoworkspace, 1"
      "$mainMod+Shift, 2, movetoworkspace, 2"
      "$mainMod+Shift, 3, movetoworkspace, 3"
      "$mainMod+Shift, 4, movetoworkspace, 4"
      "$mainMod+Shift, 5, movetoworkspace, 5"
      "$mainMod+Shift, 6, movetoworkspace, 6"
      "$mainMod+Shift, 7, movetoworkspace, 7"
      "$mainMod+Shift, 8, movetoworkspace, 8"
      "$mainMod+Shift, 9, movetoworkspace, 9"
      "$mainMod+Shift, Tab, movetoworkspace, previous"

      "$mainMod,       D, exec, $ROFI_MENUS/toggle_rofi $ROFI_MENUS/drun"
      "$mainMod+Shift, D, exec, $ROFI_MENUS/toggle_rofi $ROFI_MENUS/run"
      "$mainMod,       C, exec, $ROFI_MENUS/toggle_rofi $ROFI_MENUS/clipboard"
      "$mainMod+Shift, C, exec, $ROFI_MENUS/toggle_rofi $ROFI_MENUS/icons"
      "$mainMod,       E, exec, $ROFI_MENUS/toggle_rofi $ROFI_MENUS/filebrowser"
      "$mainMod+Shift, E, exec, $ROFI_MENUS/toggle_rofi $SCRIPTS/bookmarks"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
  services.hyprpaper.enable = true;

  services.hyprpaper.settings = {
    # IPC allows hyprctl to communicate with hyprpaper
    ipc = "on";

    # Disable splash on startup
    splash = false;

    # Preload wallpapers (optional, faster switching)
    preload = [ "/home/thomas/images/banana.png" ];

    # Assign wallpaper to all monitors
    wallpaper = [
      "DP-7,/home/thomas/images/banana.png"
    ];

    # Scaling mode: fill, fit, stretch, center, tile
    mode = "fill";
  };
}
