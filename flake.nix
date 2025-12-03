{
  description = "R development shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "R_environment";
        buildInputs = with pkgs; [
          # Must have
          R
          radian
          rPackages.languageserver
          rPackages.cli
          rPackages.crayon
          rPackages.styler
          rPackages.lintr

          # Project specific
          chromium
          pandoc
          rPackages.tidyverse
          rPackages.rmarkdown
          rPackages.knitr
          rPackages.pagedown
          rPackages.googlesheets4

        ];

        # Creating a symlink to the radian binary in the .bin directory is certainly not ideal. There is an isue on that: "https://github.com/REditorSupport/vscode-R/issues/1347"
        # But it is the best way to make it work for now I guess.
        shellHook = ''
          mkdir -p .bin
          ln -sf ${pkgs.radian}/bin/radian .bin/
        '';
      };
    };
}
