{ config, pkgs, ... }:

let
  devices = {
    "brick".id = "SP2DQUY-XEVHP57-TOSHPSI-7OEZQUS-KZU2JD6-6XDCB5S-RFVQJCZ-2DCGMAP";
    "offset".id = "S5ZTTSP-KCYWBKD-57JVIEY-VS3ZSTD-BPI2Z53-W7GXATT-NJJG6N5-UTO2MQ5";
    "piglin".id = "XQUCHJF-43YRSWB-Y7QWQMK-5Z47VDA-66YPV7Y-YY2M27F-UAJDXIE-SZHKYAL";
    "s10plus".id = "N7A42Q4-GRDD3WR-4MLVLYK-2IIGL7I-Z73RJJ5-LJWVSTZ-Q2KOC4G-PSAX3AW";
  };
in
{
  environment.systemPackages = [ pkgs.syncthing ];
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "getpsyched";
    group = "users";
    configDir = "${config.users.users.primary.home}/.config/syncthing";
    dataDir = "${config.users.users.primary.home}/.local/share/syncthing";

    settings = {
      inherit devices;
      folders = {
        "aegis" = {
          id = "vbv22-v1s0v";
          label = "aegis";
          devices = [ "offset" ];
        };
        "documents" = {
          id = "neany-xwfew";
          label = "documents";
          devices = builtins.attrNames devices;
        };
        "notes" = {
          id = "hkce6-tvhkf";
          label = "notes";
          devices = builtins.attrNames devices;
        };
      };
    };
  };
  persist.data.homeDirectories = [ ".local/share/syncthing" ];
  persist.state.homeDirectories = [ ".config/syncthing" ];
}
