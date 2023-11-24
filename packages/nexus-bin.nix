{ autoPatchelfHook
, copyDesktopItems
, fetchurl
, lib
, makeDesktopItem
, stdenv

  # libraries
, libz
}:

stdenv.mkDerivation rec {
  pname = "nexus";
  version = "0.4.1";

  src = fetchurl {
    url = "https://github.com/CharaChorder/nexus/releases/download/v${version}/nexus";
    hash = "sha256-n9UYlY2GqHKK+9X1+f5aH3BIucQ7vHzw1prZT031ulQ=";
  };

  env.ICON = fetchurl {
    url = "https://raw.githubusercontent.com/CharaChorder/nexus/v${version}/ui/images/icon.svg";
    hash = "sha256-ok80LNIficl1viJ66bnk2wjf1ODt7adp64F+XPv1l3Q=";
  };

  dontUnpack = true;

  buildInputs = [
    libz # libz.so.1
  ];
  nativeBuildInputs = [ autoPatchelfHook copyDesktopItems ];

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
