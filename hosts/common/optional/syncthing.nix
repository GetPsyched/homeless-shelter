{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.syncthing ];
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;

    settings.devices = {
      fledgeling.id = "ROSBAAA-IFSFUTE-W6FWE25-J5Z34AP-HF5EILT-RPM7HJZ-YWZW2LO-LFNEXQ7";
      piglin.id = "SWIMYIX-BW27OQK-MJ53U5P-UFINS5D-BHELENA-OF6VIY6-A5DXG3E-D3RNDA3";
    };
  };

  persist.sysDataDirs = [ "/var/lib/syncthing" ];
}
