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
  programs.kitty.enable = true;
  home.packages = with pkgs; [
    hyprcursor
    xcur2png
    clickgen
    nodejs_24
    zip
    banana-cursor
    gtk3
    libnotify
    libadwaita
    steam-run
  ];

  xdg.configFile."wallpaper".source = ./wallpaper;

  wayland.windowManager.hyprland.enable = true;

  # Activation du plugin hyprsplit
  wayland.windowManager.hyprland.plugins = with pkgs; [
    hyprlandPlugins.hyprsplit
  ];

  wayland.windowManager.hyprland.settings = {
    # Variables
    "$mainMod" = "SUPER";
    "$term" = "kitty";
    "$browser" = "zen";
    "$ROFI_MENUS" = "~/.config/rofi/bin";

    # Monitor setup - On définit explicitement les positions pour la souris
    monitor = [ ", preferred, auto, 1" ];

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
      "XCURSOR_SIZE,48"
    ];

    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
      layout = "dwindle";
    };

    decoration = {
      rounding = 10;
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
      };
    };

    cursor = {
      hide_on_touch = true;
      enable_hyprcursor = false;
      inactive_timeout = 10;
      no_hardware_cursors = 0;
    };

    animations = {
      enabled = true;
    };

    input = {
      kb_layout = "us";
      kb_variant = "altgr-intl";
      kb_options = "lv3:ralt_switch,caps:swapescape";
      follow_mouse = 1;
      sensitivity = 0;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      mouse_move_enables_dpms = true;
      key_press_enables_dpms = true;
    };

    # Keybindings mis à jour pour le style DWM (hyprsplit)
    bind = [
      "$mainMod, Return, exec, $term"
      "$mainMod, B, exec, $browser"
      "$mainMod, Q, killactive,"
      "$mainMod, F, fullscreen,"
      "$mainMod, V, togglefloating,"

      # Focus window (Vim-style)
      "$mainMod, H, movefocus, l"
      "$mainMod, L, movefocus, r"
      "$mainMod, J, movefocus, d"
      "$mainMod, K, movefocus, u"

      # Déplacer la fenêtre (Vim-style)
      "$mainMod+Shift, H, movewindow, l"
      "$mainMod+Shift, L, movewindow, r"
      "$mainMod+Shift, J, movewindow, d"
      "$mainMod+Shift, K, movewindow, u"

      "$mainMod+Ctrl, H, resizeactive, -10 0"
      "$mainMod+Ctrl, L, resizeactive, 10 0"
      "$mainMod+Ctrl, J, resizeactive, 0 10"
      "$mainMod+Ctrl, K, resizeactive, 0 -10"

      # Focus Moniteurs (DWM style)
      "$mainMod, comma, focusmonitor, l"
      "$mainMod, period, focusmonitor, r"

      # Switch to local workspace 1-9 (Style DWM : indépendant par écran)
      "$mainMod, 1, split:workspace, 1"
      "$mainMod, 2, split:workspace, 2"
      "$mainMod, 3, split:workspace, 3"
      "$mainMod, 4, split:workspace, 4"
      "$mainMod, 5, split:workspace, 5"
      "$mainMod, 6, split:workspace, 6"
      "$mainMod, 7, split:workspace, 7"
      "$mainMod, 8, split:workspace, 8"
      "$mainMod, 9, split:workspace, 9"

      # Move focused window to local workspace 1-9
      "$mainMod+Shift, 1, split:movetoworkspace, 1"
      "$mainMod+Shift, 2, split:movetoworkspace, 2"
      "$mainMod+Shift, 3, split:movetoworkspace, 3"
      "$mainMod+Shift, 4, split:movetoworkspace, 4"
      "$mainMod+Shift, 5, split:movetoworkspace, 5"
      "$mainMod+Shift, 6, split:movetoworkspace, 6"
      "$mainMod+Shift, 7, split:movetoworkspace, 7"
      "$mainMod+Shift, 8, split:movetoworkspace, 8"
      "$mainMod+Shift, 9, split:movetoworkspace, 9"

      # Menus Rofi
      "$mainMod,       D, exec, $ROFI_MENUS/toggle_rofi $ROFI_MENUS/drun"
      "$mainMod+Shift, D, exec, $ROFI_MENUS/toggle_rofi $ROFI_MENUS/run"
      "$mainMod,       C, exec, $ROFI_MENUS/toggle_rofi $ROFI_MENUS/clipboard"
      "$mainMod+Shift, C, exec, $ROFI_MENUS/toggle_rofi $ROFI_MENUS/icons"
      "$mainMod,       E, exec, $ROFI_MENUS/toggle_rofi $ROFI_MENUS/filebrowser"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };

  services.hyprpaper.enable = true;
  services.hyprpaper.settings = {
    ipc = "on";
    splash = false;
    preload = [ "/home/thomas/.config/wallpaper/banana.png" ];
    wallpaper = [
      "DP-2,/home/thomas/.config/wallpaper/banana.png"
      "DP-3,/home/thomas/.config/wallpaper/banana.png"
      "DP-5,/home/thomas/.config/wallpaper/banana.png"
      "DP-6,/home/thomas/.config/wallpaper/banana.png"
      "DP-7,/home/thomas/.config/wallpaper/banana.png"
    ];
    mode = "fill";
  };
}
