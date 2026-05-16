{
  programs.ssh.knownHosts = builtins.mapAttrs (n: v: { publicKey = v; }) (import ../keys.nix).hosts;

  services.openssh = {
    enable = true;

    authorizedKeysInHomedir = false;
    settings.PasswordAuthentication = false;
  };

  persist.data.directories = [ "/etc/ssh" ];
  persist.data.homeDirectories = [ ".ssh" ];
}
