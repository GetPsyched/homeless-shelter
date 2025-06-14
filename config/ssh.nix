{
  programs.ssh.knownHosts = {
    fledgeling.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKRAnt3jVeTeAPgX8ZUkSWxfGJas2iMbr9ggLyM9gqZ8";
    piglin.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAMOdZlxk+2X1nn0i6coQGyXBv+vPxfm0yPGAZ9srSUU";
  };

  services.openssh = {
    enable = true;

    authorizedKeysInHomedir = false;
    settings.PasswordAuthentication = false;
  };

  persist.data.directories = [ "/etc/ssh" ];
  persist.data.homeDirectories = [ ".ssh" ];
}
