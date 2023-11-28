{ copyDesktopItems, fetchFromGitHub, lib, makeDesktopItem, stdenv }:

let
  icon = fetchurl {
    url = "https://raw.githubusercontent.com/hoppscotch/hoppscotch/de725337d628d037e8597c02ef51be466bec3680/packages/hoppscotch-common/public/logo.svg";
    hash = "sha256-Njbc+RTKSOziXo0H2Mv7RyNI5CLZNkJLUr/PatyrK9E=";
  };
in
stdenv.mkDerivation rec {
  pname = "hoppscotch";
  version = "2023.8.4";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = version;
    hash = "sha256-9zVd9L9j1RhCWhlTJxJw0z9Fe2nW6AWupfLJSLor5j4=";
  };

  nativeBuildInputs = [ copyDesktopItems ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp ${icon} $out/share/icons/hicolor/scalable/apps/${pname}.svg

    runHook postInstall
  '';

  desktopItem = makeDesktopItem {
    categories = [ "Development" ];
    desktopName = "Hoppscotch";
    exec = pname;
    icon = pname;
    name = pname;
  };

  meta = with lib; {
    description = "👽 Open-source API development ecosystem";
    longDescription = ''
      Hoppscotch is a lightweight, web-based API development suite. It was built
      from the ground up with ease of use and accessibility in mind providing
      all the functionality needed for API developers with minimalist,
      unobtrusive UI.
    '';
    homepage = "https://hoppscotch.com";
    downloadPage = "https://docs.hoppscotch.io/documentation/self-host/getting-started";
    changelog = "https://hoppscotch.com/changelog";
    license = licenses.mit;
    maintainers = with maintainers; [ getpsyched ];
    platforms = platforms.linux;
    sourceProvenance = [ sourceTypes.fromSource ];
  };
}
