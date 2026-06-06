{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.file.".config/niri/config.kdl" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/myNixOS/stow/niri/.config/niri/config.kdl";
  };

  home.packages = with pkgs; [
    # Terminal
    kitty
    

    # Launcher
    xdg-utils

    # Lock/idle/wallpaper
    swaylock
    swayidle
    swaybg

    # Notifications

    # Screenshot/region
    grim
    slurp

    # Clipboard
    wl-clipboard
    cliphist
  ];
}
