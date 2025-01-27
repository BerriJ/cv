with import <nixpkgs> {
  config.allowUnfree = true;
};
pkgs.mkShell rec {
  name = "R_environment";
  buildInputs = with pkgs; [

    # Must have
    R
    python312Packages.radian
    rPackages.languageserver
    rPackages.cli
    rPackages.crayon
    rPackages.httpgd
    rPackages.styler
    rPackages.lintr

    # Project specific
    chromium
    rPackages.tidyverse
    rPackages.rmarkdown
    rPackages.knitr
    rPackages.pagedown
    rPackages.googlesheets4

  ];

  shellHook = ''
    mkdir -p .bin
    ln -sf ${pkgs.python312Packages.radian}/bin/radian .bin/
  '';
}
