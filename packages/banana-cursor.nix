{ stdenvNoCC
, fetchFromGitHub
, lib
}:

stdenvNoCC.mkDerivation rec {
  pname = "banana-cursor-theme";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "ful1e5";
    repo = "banana-cursor";
    rev = "v${version}";
    sha256 = "XabfKFyeII7Xl+ozzpPnc4xFH4B7GzCTLq4M1QPSZPw=";
  };

  installPhase = ''
    mkdir -p $out/share/icons

    tar -xvf Banana.tar.gz
    mv Banana $out/share/icons

    cp -r nordzy-dark/ $out/share/icons/banana
    mv $out/share/icons/banana-cursor/index.theme $out/share/icons/banana-cursor/cursor.theme
    mv $out/share/icons/banana-cursor/banana-cursor $out/share/icons/banana-cursor/cursors
    cp -r nordzy-white/ $out/share/icons/Nordzy-white-cursors
    mv $out/share/icons/Nordzy-white-cursors/index.theme $out/share/icons/Nordzy-white-cursors/cursor.theme
    mv $out/share/icons/Nordzy-white-cursors/Nordzy-white-cursors $out/share/icons/Nordzy-white-cursors/cursors
  '';

  meta = with lib; {
    description = "The banana cursor. ";
    homepage = "https://github.com/ful1e5/banana-cursor";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = [ maintainers.ful1e5 ];
  };
}
