{ ... }:
{
  # Desktop/GUI applications - not needed for remote development
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
  };

  # Link wezterm config from stow directory
  home.file.".wezterm.lua".source = ../stow/wezterm/.wezterm.lua;

  programs.brave = {
    enable = true;
  };

  programs.discord = {
    enable = true;
  };

  programs.opencode = {
    enable = true;
  };

  # Link opencode config from stow directory
  xdg.configFile."opencode".source = ../stow/opencode/.config/opencode;
}
