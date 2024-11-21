{
  config,
  lib,
  pkgs,
  ...
}:
{
  home-manager.users.${config.mainuser}.xdg.desktopEntries =
    let
      common = {
        categories = [ "Application" ];
        genericName = "Text Editor";
        terminal = false;
      };
    in
    {
      libreoffice-writer = common // {
        name = "LibreOffice Writer";
        exec = "${lib.getExe pkgs.libreoffice} --writer";
        icon = "${pkgs.libreoffice}/share/icons/hicolor/scalable/apps/writer.svg";
        mimeType = [
          "application/vnd.oasis.opendocument.text"
          "application/msword"
          "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        ];
      };

      libreoffice-calc = common // {
        name = "LibreOffice Calc";
        exec = "${lib.getExe pkgs.libreoffice} --calc";
        icon = "${pkgs.libreoffice}/share/icons/hicolor/scalable/apps/calc.svg";
        mimeType = [
          "application/vnd.oasis.opendocument.spreadsheet"
          "application/vnd.ms-excel"
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
          "text/csv"
        ];
      };

      libreoffice-impress = common // {
        name = "LibreOffice Impress";
        exec = "${lib.getExe pkgs.libreoffice} --impress";
        icon = "${pkgs.libreoffice}/share/icons/hicolor/scalable/apps/impress.svg";
        mimeType = [
          "application/vnd.oasis.opendocument.presentation"
          "application/vnd.ms-powerpoint"
          "application/vnd.openxmlformats-officedocument.presentationml.presentation"
        ];
      };
    };
}
