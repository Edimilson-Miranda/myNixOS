{ inputs, ... }:
{
  imports = [
    inputs.niri.homeModules.niri
    ./wayland/packages.nix
  ];

  programs.niri.enable = true;
}
