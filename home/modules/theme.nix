{ pkgs, ... }: {
  # Qt-Anwendungen
  qt = {
    enable = true;

    platformTheme.name = "kde";
    style.name = "breeze";
  };

  # GTK-Anwendungen
  gtk = {
    enable = true;

    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
  };
}
