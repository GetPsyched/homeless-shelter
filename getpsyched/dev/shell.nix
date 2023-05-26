{ pkgs, ... }: {
  programs = {
    bash.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
