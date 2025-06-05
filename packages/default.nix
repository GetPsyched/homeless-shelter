{ pkgs }:
{
  # FIXME: Cache miss for qt6.full
  # cc-nexus = pkgs.python311Packages.callPackage ../packages/nexus.nix {
  #   pyside6-essentials = (pkgs.python311Packages.callPackage ../packages/pyside6-essentials.nix { });
  # };
  mindmap = pkgs.callPackage ./mindmap.nix { };

  wifi-qr = pkgs.writeShellApplication {
    name = "wifi-qr";
    runtimeInputs = with pkgs; [
      gawk
      zbar
    ];
    text = ''
      QR_CODE=$(zbarcam --raw --oneshot)
      SSID=$(echo "$QR_CODE" | awk -F 'S:' '{print $2}' | awk -F ';' '{print $1}')
      PASSWORD=$(echo "$QR_CODE" | awk -F 'P:' '{print $2}' | awk -F ';' '{print $1}')
      nmcli dev wifi rescan
      nmcli dev wifi connect "$SSID" password "$PASSWORD"
    '';
  };
}
