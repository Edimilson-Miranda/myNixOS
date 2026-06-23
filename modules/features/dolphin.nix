{
  lib,
  config,
  pkgs,
  ...
}:

{
  config = lib.mkIf config.myconfig.features.desktop {

    ############################
    # Pacotes KDE necessários
    ############################

    home.packages = with pkgs; [

      kdePackages.dolphin
      kdePackages.konsole

      kdePackages.kio
      kdePackages.kio-extras

      kdePackages.kservice
      kdePackages.kded

      kdePackages.kdialog
      kdePackages.kde-cli-tools

      kdePackages.plasma-integration

      kdePackages.breeze
      kdePackages.breeze-icons

      qt6.qtwayland

      qt6Packages.qt6ct
    ];

    ############################
    # KDE fora do Plasma
    ############################

    qt = {

      enable = true;

      platformTheme.name = "qt6ct";

      style = {

        name = "breeze";

        package = pkgs.kdePackages.breeze;

      };
    };

    ############################
    # Tema Catppuccin
    ############################

    xdg.configFile."kdeglobals".text = ''

      [General]

      ColorScheme=CatppuccinMocha

      Name=Catppuccin Mocha



      [UiSettings]

      ColorScheme=CatppuccinMocha



      [Icons]

      Theme=breeze-dark



      [WM]

      BlurBehind=true

      Translucency=true

    '';

    ############################
    # MIME / Abrir com
    ############################

    xdg = {

      enable = true;

      mime.enable = true;

      mimeApps.enable = true;

      mimeApps.defaultApplications = {

        "inode/directory" = "org.kde.dolphin.desktop";

      };

      configFile."menus/applications.menu".text = ''

        <?xml version="1.0" encoding="UTF-8"?>


        <!DOCTYPE Menu PUBLIC
        "-//freedesktop//DTD Menu 1.0//EN"
        "http://www.freedesktop.org/standards/menu-spec/menu.dtd">


        <Menu>

          <Name>Applications</Name>


          <DefaultAppDirs/>

          <DefaultDirectoryDirs/>


          <Include>

            <All/>

          </Include>


          <DefaultLayout>

            <Merge type="menus"/>

            <Merge type="files"/>

          </DefaultLayout>


          <DefaultMergeDirs/>


        </Menu>

      '';

    };

    ############################
    # Cache KDE
    ############################

    systemd.user.services.kbuildsycoca6 = {

      Unit = {

        Description = "KDE Application Cache";

        Before = [ "kded.service" ];

      };

      Service = {

        Type = "oneshot";

        ExecStart = "${pkgs.kdePackages.kservice}/bin/kbuildsycoca6 --noincremental";

      };

      Install = {

        WantedBy = [ "graphical-session.target" ];

      };

    };

    ############################
    # KDE daemon
    ############################

    systemd.user.services.kded = {

      Unit = {

        Description = "KDE daemon";

        After = [ "graphical-session.target" ];

        Requires = [ "kbuildsycoca6.service" ];

      };

      Service = {

        ExecStart = "${pkgs.kdePackages.kded}/bin/kded6";

        Restart = "on-failure";

      };

      Install = {

        WantedBy = [ "graphical-session.target" ];

      };

    };

    ############################
    # Variáveis Qt/KDE
    ############################

    home.sessionVariables = {

      XDG_CURRENT_DESKTOP = "KDE";

      QT_QPA_PLATFORMTHEME = "qt6ct";

      QT_STYLE_OVERRIDE = "breeze";

      QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    };

  };

}
