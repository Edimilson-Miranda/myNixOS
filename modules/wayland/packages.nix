{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Terminal
    alacritty

    # Launcher
    fuzzel

    # Lock/idle/wallpaper
    swaylock
    swayidle
    swaybg

    # Notifications
    mako

    # Screenshot/region
    grim
    slurp

    # Clipboard
    wl-clipboard
  ];
}