{
  lib,
  requireFile,
  stdenv,

  dpkg,
  gnupg,
  ...
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "citrix-endpoint-analysis";
  version = "26.2.3";

  src = requireFile rec {
    name = "nsepa.deb";
    sha256 = "0m02z73mffqckhrdlrhg4a4nzrb3pg8mg67bhindm0vvrabkyrj7";

    message = ''
      In order to use Citrix Workspace, you need to comply with the Citrix EULA and download
      the 64-bit binaries, .deb from:

      https://www.citrix.com/downloads/citrix-endpoint-analysis/plug-ins/EPA-Clients-Linux.html

      Once you have downloaded the file, please use the following command and re-run the
      installation:

      nix-prefetch-url file://$PWD/${name}
    '';
  };

  dontBuild = true;
  dontConfigure = true;
  strictDeps = true;
  __structuredAttrs = true;
  sourceRoot = ".";
  preferLocalBuild = true;

  nativeBuildInputs = [
    dpkg
    gnupg
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"/opt/Citrix/Browser-EPA
    cp -r root/opt/Citrix/Browser-EPA/* "$out"/opt/Citrix/Browser-EPA/

    substituteInPlace root/opt/Citrix/Browser-EPA/nsgcepa.desktop \
      --replace-fail "/opt/Citrix/Browser-EPA/nsgcepa" "nsgcepa"
    install -Dm 444 root/opt/Citrix/Browser-EPA/nsgcepa.desktop -t "$out"/share/applications

    runHook postInstall
  '';

  doInstallCheck = true;
  installCheckPhase = ''
    GNUPGHOME_TMP="$(mktemp -d)"
    gpg --homedir "$GNUPGHOME_TMP" --import "$out"/opt/Citrix/Browser-EPA/pubkey.asc
    gpg --homedir "$GNUPGHOME_TMP" --verify "$out"/opt/Citrix/Browser-EPA/LinuxClientLibrary.so.sig "$out"/opt/Citrix/Browser-EPA/LinuxClientLibrary.so
  '';

  meta = {
    description = "Citrix Endpoint Analysis";
    homepage = "https://www.citrix.com/downloads/citrix-endpoint-analysis/plug-ins/EPA-Clients-Linux.html";
    license = lib.licenses.unfree;
    mainProgram = "nsgcepa";
    platforms = [ "x86_64-linux" ];
  };
})
