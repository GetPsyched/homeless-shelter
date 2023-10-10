{ stdenvNoCC
, fetchurl
, lib
}:

stdenvNoCC.mkDerivation rec {
  pname = "banana-cursor-theme";
  version = "1.0.0";

  tar = fetchurl {
    url = "https://github.com/ful1e5/banana-cursor/releases/download/v1.0.0/Banana.tar.gz";
    sha256 = "5gGuWUbVwrOT6JCARUWzjExIYYj4ejP9rb50nnI7GT0=";
  };

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/icons

    tar -xvf ${tar}
    mv Banana $out/share/icons
  '';

  meta = with lib; {
    description = "The banana cursor.";
    homepage = "https://github.com/ful1e5/banana-cursor";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = [ maintainers.getpsyched ];
  };
}
