{ username, ... }:
{
  # Minimal configuration for remote development (CLI tools only)
  imports = [
    ./modules/packages.nix
    ./modules/shell.nix
    ./modules/cli-tools.nix
    ./modules/dev-tools.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
