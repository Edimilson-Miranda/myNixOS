{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri
    ./packages.nix
  ];

  config = lib.mkIf config.myconfig.features.desktop {
    # programs.niri.enable = true;
    # programs.niri.package = pkgs.niri;

  
  };
}
