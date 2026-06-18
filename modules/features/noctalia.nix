{
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.noctalia.homeModules.default ];

  config = lib.mkIf config.myconfig.features.desktop {
    programs.noctalia = {
      enable = true;
    };

    home.file.".config/noctalia" = {
      source = "${config.home.homeDirectory}/myNixOS/stow/noctalia/.config/noctalia";
      recursive = true;
    };
  };
}
