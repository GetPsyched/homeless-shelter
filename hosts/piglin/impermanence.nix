{
  programs.fuse.userAllowOther = true;

  environment.persistence = {
    "/persist/sysstate" = {
      directories = [
        "/etc/NetworkManager"
        "/var/lib/cloudflare-warp"
      ];
    };
  };
}
