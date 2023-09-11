{ pkgs, ... }:
{
  xdg.desktopEntries = {
    libreoffice-writer = {
      categories = [ "Application" ];
      name = "LibreOffice Writer";
      exec = "${pkgs.libreoffice}/bin/libreoffice --writer";
      genericName = "Text Editor";
      icon = "${pkgs.libreoffice}/share/icons/hicolor/scalable/apps/writer.svg";
      mimeType = [
        "application/vnd.oasis.opendocument.text"
        "application/msword"
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      ];
      terminal = false;
    };
  };
}
