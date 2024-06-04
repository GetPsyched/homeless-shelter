{ flakey-devShell-pkgs, pkgs }:

with pkgs; mkShell {
  nativeBuildInputs = [
    just
    nil

    flakey-devShell-pkgs.default
    (flakey-devShell-pkgs.vscodium.override {
      extensions = with vscode-extensions; [
        foxundermoon.shell-format
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "rasi";
          publisher = "dlasagno";
          version = "1.0.0";
          sha256 = "sha256-s60alej3cNAbSJxsRlIRE2Qha6oAsmcOBbWoqp+w6fk=";
        }
        {
          name = "vscode-parinfer";
          publisher = "shaunlebron";
          version = "0.6.2";
          sha256 = "sha256-zev0oomPf9B+TaNRnp4xcmEWJBaa+IHgysbX2G0mm0A=";
        }
        {
          name = "yuck";
          publisher = "eww-yuck";
          version = "0.0.3";
          sha256 = "sha256-DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
        }
      ];
    })
  ];
}
