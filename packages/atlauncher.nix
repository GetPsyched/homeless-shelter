{
  buildGradlePackage,
  fetchFromGitHub,
  gradle,
  jre,
  lib,
  makeWrapper,
  stdenvNoCC,

  gamemodeSupport ? stdenvNoCC.isLinux,
  textToSpeechSupport ? stdenvNoCC.isLinux,
  additionalLibs ? [ ],

  # dependencies
  flite,
  gamemode,
  libglvnd,
  libpulseaudio,
  udev,
  xorg,
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
buildGradlePackage {
  inherit pname version src;
  lockFile = ./gradle.lock;

  gradleFlags = [
    "build"
    "--exclude-task"
    "test"
    "--exclude-task"
    "createExe"
  ];

  nativeBuildInputs = [
    gradle
    makeWrapper
  ];

  installPhase =
    let
      runtimeLibraries =
        [
          libglvnd
          libpulseaudio
          udev
          xorg.libXxf86vm
        ]
        ++ lib.optional gamemodeSupport gamemode.lib
        ++ lib.optional textToSpeechSupport flite
        ++ additionalLibs;
    in
    ''
      runHook preInstall

      mkdir -p $out/bin $out/share/java
      cp dist/ATLauncher-${version}.jar $out/share/java/ATLauncher.jar

      makeWrapper ${jre}/bin/java $out/bin/atlauncher \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath runtimeLibraries}" \
        --add-flags "-jar $out/share/java/ATLauncher.jar" \
        --add-flags "--working-dir \"\''${XDG_DATA_HOME:-\$HOME/.local/share}/ATLauncher\"" \
        --add-flags "--no-launcher-update"

      runHook postInstall
    '';

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
