{ appimageTools
, fetchurl
, lib
, makeDesktopItem
}:

let
  pname = "hoppscotch";
  version = "23.8.3";
  name = "${pname}-${version}";

  desktopItem = makeDesktopItem {
    categories = [ "Development" ];
    desktopName = "Hoppscotch";
    exec = pname;
    icon = pname;
    name = pname;
  };

  icon = fetchurl {
    url = "https://raw.githubusercontent.com/hoppscotch/hoppscotch/de725337d628d037e8597c02ef51be466bec3680/packages/hoppscotch-common/public/logo.svg";
    hash = "sha256-Njbc+RTKSOziXo0H2Mv7RyNI5CLZNkJLUr/PatyrK9E=";
  };
in
appimageTools.wrapType1 {
  inherit name version;

  src = fetchurl {
    url = "https://github.com/hoppscotch/releases/releases/download/v${version}-1/Hoppscotch_linux_x64.AppImage";
    hash = "sha256-YqvGYn3TrR4dvx3nKkGRfV7srTllDR4Q+dxttucklUM=";
  };
  extraPkgs = pkgs: with pkgs; [ libthai ];

  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}

    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp ${icon} $out/share/icons/hicolor/scalable/apps/${pname}.svg

    mkdir -p $out/share/applications
    cp -r ${desktopItem} $out/share/applications/${pname}.desktop
  '';

  meta = with lib; {
    description = "👽 Open-source API development ecosystem";
    longDescription = ''
      Hoppscotch is a lightweight, web-based API development suite. It was built
      from the ground up with ease of use and accessibility in mind providing
      all the functionality needed for API developers with minimalist,
      unobtrusive UI.
    '';
    homepage = "https://hoppscotch.com";
    downloadPage = "https://hoppscotch.com/downloads";
    changelog = "https://hoppscotch.com/changelog";
    license = licenses.mit;
    maintainers = with maintainers; [ getpsyched ];
    mainProgram = pname;
    platforms = platforms.all;
    sourceProvenance = [ sourceTypes.binaryNativeCode ];
  };
}
