{ copyDesktopItems
, fetchFromGitHub
, fetchurl
, gradle
, jdk
, lib
, makeDesktopItem
, rsync
, stdenv
}:

stdenv.mkDerivation rec {
  pname = "atlauncher";
  version = "3.4.34.3";

  src = fetchFromGitHub {
    owner = "ATLauncher";
    repo = "ATLauncher";
    rev = "v${version}";
    sha256 = "sha256-2080rVGBBM3YZmmBVBfMhnCErLzxuRDDi4zmCniJYFY=";
  };

  env.ICON = fetchurl {
    url = "https://atlauncher.com/assets/images/logo.svg";
    hash = "sha256-XoqpsgLmkpa2SdjZvPkgg6BUJulIBIeu6mBsJJCixfo=";
  };

  gradle-zip = let gradle-version = "8.4"; in fetchurl {
    url = "https://services.gradle.org/distributions/gradle-${gradle-version}-bin.zip";
    sha256 = "sha256-PhrzrohpIMOsh/epH4FsDHxDbydqbu/bPaFSEA/vcq4=";
  };

  nativeBuildInputs = [ copyDesktopItems gradle jdk rsync ];

  preBuild = ''
    mkdir -p $out/bin $out/gradle/wrapper
    touch $out/gradle/wrapper/gradle-wrapper.properties
    rsync -r $src/* $out --exclude gradle/wrapper/gradle-wrapper.properties
    ls $out/gradle/wrapper
    awk -F= '
      { val= $0; sub("^[^=]+=", "", val) }
      $1 == "distributionUrl"   { val = "file://${gradle-zip}" }
      { print $1 "=" val }
    ' $src/gradle/wrapper/gradle-wrapper.properties > $out/gradle/wrapper/gradle-wrapper.properties
  '';

  buildPhase = ''
    runHook preBuild

    export GRADLE_USER_HOME=$(mktemp -d)
    $out/gradlew build --no-daemon --offline

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp $ICON $out/share/icons/hicolor/scalable/apps/${pname}.svg

    runHook postInstall
  '';

  desktopItems = [
    (makeDesktopItem {
      name = pname;
      exec = pname;
      icon = pname;
      desktopName = "ATLauncher";
      categories = [ "Game" ];
    })
  ];

  meta = with lib; {
    description = "A simple and easy to use Minecraft launcher which contains many different modpacks for you to choose from and play";
    downloadPage = "https://atlauncher.com/downloads";
    homepage = "https://atlauncher.com/";
    license = licenses.gpl3;
    maintainers = [ maintainers.getpsyched ];
    platforms = platforms.all;
  };
}
