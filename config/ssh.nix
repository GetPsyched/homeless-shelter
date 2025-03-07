{
  services.openssh = {
    enable = true;

    authorizedKeysInHomedir = false;
    settings.PasswordAuthentication = false;
  };

  persist.data.directories = [ "/etc/ssh" ];
  persist.data.homeDirectories = [ ".ssh" ];
}
