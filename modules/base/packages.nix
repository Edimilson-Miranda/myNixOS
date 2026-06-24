{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.pointerCursor = {
    enable = config.myconfig.features.desktop;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  home.packages =
    (with pkgs; [
      # Development Tools
      curl
      wget
      gcc
      gnumake
      unzip
      rustc
      cargo
      uv
      nodejs_24
      tree-sitter
      bat
      git
      lua-language-server
      nil
      vscodium
      firefox
      nemo
      teams-for-linux
      rclone
      opencode
      zed-editor
      fish
      bazaar
      gpu-screen-recorder
      gpu-screen-recorder-gtk
      mpv
      obs-studio
      zip
      kdePackages.ark
      dolphin
      kdePackages.dolphin # ou kde5.dolphin dependendo da versão
      kdePackages.qtsvg # ícones SVG no Dolphin
      kdePackages.breeze # fallback de estilo Qt
      libsForQt5.qt5ct # configurador Qt5 (se usar Qt5)
      kdePackages.qt6ct # configurador Qt6
      kvantum # motor de estilo Qt — essencial
      kdePackages.qqc2-desktop-style

      nixd
      biome
      # aider-chat-full

      # System Utilities
      fastfetch
      fzf
      fd
      nh
      ripgrep
      btop
      lsof
      trash-cli
      ghostscript
      mermaid-cli
      zoxide
    ])
    ++ lib.optionals config.myconfig.features.fonts (
      with pkgs;
      [
        cascadia-code
        nerd-fonts.jetbrains-mono
        inter
        noto-fonts
        noto-fonts-color-emoji
      ]
    )
    ++ lib.optionals config.myconfig.features.software (
      with pkgs;
      [
        wootility
        obsidian
      ]
    )
    ++ lib.optionals config.myconfig.features.desktop (
      with pkgs;
      [
        xwayland-satellite
        cosmic-wallpapers
        gnome-control-center
        nautilus
        papirus-icon-theme
        pavucontrol
        playerctl
        brightnessctl
        # gnomeExtensions.cloudflare-warp-toggle
      ]
    );
}
