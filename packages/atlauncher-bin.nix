{ copyDesktopItems
, fetchFromGitHub
, fetchurl
, lib
, makeDesktopItem
, makeWrapper
, stdenv

, # dependencies
  jre
, udev
, xorg
}:

let
  pname = "atlauncher";
  version = "3.4.35.5";

  srcs = {
    source = (fetchFromGitHub {
      owner = "ATLauncher";
      repo = "ATLauncher";
      rev = "v${version}";
      sha256 = "sha256-9jOvElwb3jmO18MZOFqbB/mF75SdKufZvM1oWLKZDII=";
    });
    jar = (fetchurl {
      url = "https://github.com/ATLauncher/ATLauncher/releases/download/v${version}/ATLauncher-${version}.jar";
      hash = "sha256-Y3Xe85Pte55ijIpJubOCfqIodSfpigJte2i/6eYzyO8=";
    });
  };

  src-meta-dir = "${srcs.source}/packaging/linux/_common";
in
stdenv.mkDerivation {
  inherit pname version;

  src = srcs.jar;
  dontUnpack = true;

  nativeBuildInputs = [ copyDesktopItems makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -D -m 444 $src $out/share/java/ATLauncher.jar

    makeWrapper ${jre}/bin/java $out/bin/atlauncher \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ xorg.libXxf86vm udev ]}" \
      --add-flags "-jar $out/share/java/ATLauncher.jar" \
      --add-flags "--working-dir \"\''${XDG_DATA_HOME:-\$HOME/.local/share}/ATLauncher\"" \
      --add-flags "--no-launcher-update"

    runHook postInstall
  '';

  postInstall = ''
    install -D -m 644 ${src-meta-dir}/atlauncher.svg $out/share/icons/hicolor/scalable/apps/atlauncher.svg
  '';

  desktopItems = [ "${src-meta-dir}/atlauncher.desktop" ];

  meta = with lib; {
    description = "A simple and easy to use Minecraft launcher which contains many different modpacks for you to choose from and play";
    downloadPage = "https://atlauncher.com/downloads";
    homepage = "https://atlauncher.com";
    license = licenses.gpl3;
    mainProgram = "atlauncher";
    maintainers = [ maintainers.getpsyched ];
    platforms = platforms.all;
    sourceProvenance = [ sourceTypes.binaryBytecode ];
  };
}
