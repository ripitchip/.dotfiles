{ ... }:
{
  # Disable system-wide keyboard override if needed
  home.keyboard = {
    services.xserver.enable = true;
    services.xserver.layout = "us";
    services.xserver.xkbOptions = "lv3:ralt_switch,caps:swapescape";
  };
}
