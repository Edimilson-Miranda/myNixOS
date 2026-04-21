{ ... }:
{
  # Desktop/GUI applications - not needed for remote development
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.brave = {
    enable = true;
  };

  programs.discord = {
    enable = true;
  };

  programs.opencode = {
    enable = true;
  };
}
