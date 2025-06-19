{
  outputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../config/nix.nix
  ];

  environment.systemPackages = [
    pkgs.helix
    (pkgs.symlinkJoin {
      inherit (pkgs.git) name;
      paths = [ pkgs.git ];
      buildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/git --set XDG_CONFIG_HOME "${
          pkgs.runCommand "config" { } ''
            mkdir -p $out/git

            cat > $out/git/config <<EOF
            ${lib.generators.toGitINI (
              lib.recursiveUpdate
                outputs.nixosConfigurations.piglin.config.home-manager.users.primary.programs.git.extraConfig
                {
                  diff.external = lib.getExe pkgs.difftastic;
                  user.signingKey = "/Users/getpsyched/.ssh/id_ed25519.pub";
                }
            )}
            EOF
          ''
        }"
      '';
    })
    pkgs.firefox
    pkgs.kitty
  ];

  services.tailscale.enable = true;

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.buildPlatform = "aarch64-darwin";
}
