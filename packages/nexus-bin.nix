{ copyDesktopItems
, fetchurl
, lib
, makeDesktopItem
, stdenv
}:

stdenv.mkDerivation rec {
  pname = "nexus";
  version = "0.4.0";

  src = fetchurl {
    url = "https://github.com/CharaChorder/nexus/releases/download/v${version}/nexus";
    hash = "sha256-5vVMyK6b957PywPVvLoGg0iKixoNnXw23KQEn0hOsaU=";
  };

  env.ICON = fetchurl {
    url = "https://raw.githubusercontent.com/CharaChorder/nexus/v${version}/ui/images/icon.svg";
    hash = "sha256-ok80LNIficl1viJ66bnk2wjf1ODt7adp64F+XPv1l3Q=";
  };

  dontUnpack = true;

  nativeBuildInputs = [ copyDesktopItems ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp $src $out/bin/${pname}
    chmod +x $out/bin/${pname}

    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp $ICON $out/share/icons/hicolor/scalable/apps/${pname}.svg

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      comment = "CharaChorder's all-in-one desktop app";
      desktopName = "Nexus";
      exec = pname;
      icon = pname;
      name = pname;
      startupNotify = true;
      startupWMClass = pname;
      terminal = false;
      type = "Application";
    })
  ];

  meta = with lib; {
    description = "CharaChorder's all-in-one desktop app";
    downloadPage = "https://github.com/CharaChorder/nexus/releases/tag/v${version}";
    homepage = "https://github.com/CharaChorder/nexus/";
    license = licenses.agpl3Only;
    maintainers = [ maintainers.getpsyched ];
    mainProgram = pname;
    platforms = platforms.linux;
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
}
