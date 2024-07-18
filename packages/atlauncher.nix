{
  fetchFromGitHub,
  lib,
  stdenvNoCC,
}:

let
  pname = "atlauncher";
  version = "3.4.36.5";

  src = fetchFromGitHub {
    owner = "ATLauncher";
    repo = "ATLauncher";
    rev = "v${version}";
    hash = "sha256-cm1+JK+gFlZfnfdUOK8GH98C9CMWmIlTwfiO4L8dpbc=";
  };
in
stdenvNoCC.mkDerivation {
  inherit pname version src;

  postInstall =
    let
      packagingDir = "${src}/packaging/linux/_common";
    in
    ''
      install -D -m444 ${packagingDir}/atlauncher.png $out/share/pixmaps/atlauncher.png
      install -D -m444 ${packagingDir}/atlauncher.svg $out/share/icons/hicolor/scalable/apps/atlauncher.svg
      install -D -m444 ${packagingDir}/atlauncher.desktop $out/share/applications/atlauncher.desktop
    '';

  meta = {
    changelog = "https://github.com/ATLauncher/ATLauncher/blob/v${version}/CHANGELOG.md";
    description = "A simple and easy to use Minecraft launcher which contains many different modpacks for you to choose from and play";
    downloadPage = "https://atlauncher.com/downloads";
    homepage = "https://atlauncher.com";
    license = lib.licenses.gpl3;
    mainProgram = "atlauncher";
    maintainers = with lib.maintainers; [ getpsyched ];
    platforms = lib.platforms.all;
  };
}
