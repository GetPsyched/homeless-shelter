{ pkgs }:

pkgs.buildFHSEnv {
  name = "nsgcepa";

  targetPkgs =
    pkgs: with pkgs; [
      curl # libcurl.so.4
      glib # libglib-2.0, libgobject-2.0, libgio-2.0
      (callPackage ./gpgme.nix { }) # libgpgme.so.11
      gtk3 # libgtk-3.so.0
      libayatana-appindicator # libayatana-appindicator3.so.1
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
    ];

  extraBwrapArgs = [
    "--ro-bind"
    "${pkgs.citrix-endpoint-analysis-unwrapped}/opt/Citrix/Browser-EPA"
    "/opt/Citrix/Browser-EPA"
    "--ro-bind"
    "${pkgs.citrix-secure-access}/opt/Citrix/EPA"
    "/opt/Citrix/EPA"
    "--ro-bind"
    "${pkgs.citrix-secure-access}/opt/Citrix/NSGClient"
    "/opt/Citrix/NSGClient"
  ];

  runScript = "/opt/Citrix/Browser-EPA/nsgcepa";

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp ${pkgs.citrix-endpoint-analysis-unwrapped}/share/applications/nsgcepa.desktop $out/share/applications
    cp ${pkgs.citrix-secure-access}/share/applications/nsgclient.desktop $out/share/applications
  '';
}
