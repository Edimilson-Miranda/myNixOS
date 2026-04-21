{ ... }:
{
  # Pure CLI tools and utilities - suitable for remote development
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--smart-case"
      "--hidden"
      "--glob=!.git/"
      "--glob=!node_modules/"
    ];
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Dracular";
      style = "numbers,changes,header";
      paging = "never";
    };
  };

  programs.tmux = {
    enable = true;
  };

  # Link tmux config from stow directory
  home.file.".tmux.conf".source = ../stow/tmux/.tmux.conf;
}
