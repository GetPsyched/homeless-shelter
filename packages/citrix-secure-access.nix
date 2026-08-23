{
  lib,
  requireFile,
  stdenv,

  autoPatchelfHook,
  dpkg,

  # runtime deps
  curl,
  glib,
  gpgme_1,
  gtk3,
  libarchive,
  libayatana-appindicator,
  libnl,
  libnotify,
  libproxy,
  libx11,
  libxml2_13,
  libxscrnsaver,
  networkmanager,
  openssl,
  pugixml,
  util-linux,
  webkitgtk_4_1,
  zlib,
  ...
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "citrix-secure-access";
  version = "25.8.2";

  src = requireFile rec {
    name = "nsginstaller64.deb";
    sha256 = "1cq95i3i3bd67aknwxz4bdkqfj288dp0fvsa80w7g166jma0klsn";

    message = ''
      In order to use Citrix Workspace, you need to comply with the Citrix EULA and download
      the 64-bit binaries, .deb from:

      https://www.citrix.com/downloads/citrix-secure-access/plug-ins/Citrix-Gateway-VPN-EPA-Clients-Ubuntu.html

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
    autoPatchelfHook
  ];

  buildInputs = [
    curl # libcurl.so.4
    glib # libglib-2.0.so.0, libgobject-2.0.so.0, libgio-2.0.so.0
    gpgme_1 # libgpgme.so.11
    gtk3 # libgtk-3.so.0
    libarchive # libarchive.so.13
    libayatana-appindicator # libayatana-appindicator3.so.1
    libnl # libnl-3.so.200, libnl-route-3.so.200
    libnotify # libnotify.so.4
    libproxy # libproxy.so.1
    libx11 # libX11.so.6
    libxml2_13 # libxml2.so.2
    libxscrnsaver # libXss.so.1
    networkmanager # libnm.so.0
    openssl # libssl.so.3, libcrypto.so.3
    (pugixml.override { shared = true; }) # libpugixml.so.1
    stdenv.cc.cc.lib # libstdc++.so.6, libgcc_s.so.1
    util-linux # libuuid.so.1
    webkitgtk_4_1 # libwebkit2gtk-4.1.so.0
    zlib # libz.so.1
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"/{bin,opt/Citrix}
    cp -r root/opt/Citrix/* "$out"/opt/Citrix/

    substituteInPlace "$out"/opt/Citrix/NSGClient/bin/nsgclient.desktop \
      --replace-fail "/opt/Citrix/NSGClient/bin/NSGClient" "nsgclient" \
      --replace-fail "/opt/Citrix/NSGClient/resx" "$out/opt/Citrix/NSGClient/resx"
    install -Dm 444 "$out"/opt/Citrix/NSGClient/bin/nsgclient.desktop -t "$out"/share/applications
    ln -s "$out"/opt/Citrix/NSGClient/bin/NSGClient "$out"/bin/nsgclient
    ln -s "$out"/opt/Citrix/NSGClient/bin/nsgtsb.sh "$out"/bin/nsgtsb.sh

    runHook postInstall
  '';

  postFixup = ''
    find "$out"/opt/Citrix/{EPA,NSGClient} -maxdepth 1 -type f -executable -o -name '*.so*' \
      | while read -r f; do
          autoPatchelf "$f" || true
        done
  '';

  meta = {
    description = "Citrix Endpoint Analysis";
    homepage = "https://www.citrix.com/downloads/citrix-endpoint-analysis/plug-ins/EPA-Clients-Linux.html";
    license = lib.licenses.unfree;
    mainProgram = "nsgclient";
    platforms = [ "x86_64-linux" ];
  };
})
