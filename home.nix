{ username, ... }:
{
  imports = [
    ./modules/base/packages.nix
    ./modules/fonts.nix
    ./modules/base/shell.nix
    ./modules/base/cli-tools.nix
    ./modules/development.nix
    ./modules/applications.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
