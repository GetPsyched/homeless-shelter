{
  hostName,
  inputs,
  outputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./hardware.nix
    ./nix.nix
    ./tailscale.nix
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    sharedModules = [ (import ../../../modules/home-manager) ];
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  networking.hostName = hostName;
  networking.hostId = builtins.substring 0 8 (builtins.hashString "md5" hostName);

  users.mutableUsers = false;

  persist.sysDataDirs = [ "/etc/ssh" ];
}
