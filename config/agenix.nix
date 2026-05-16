{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [inputs.agenix.packages.${config.nixpkgs.hostPlatform.system}.default];

  # Re-set the default identity paths to avoid accidental overriding when settings this elsewhere
  age.identityPaths = lib.optionals config.services.openssh.enable (
    map (e: e.path) (
      lib.filter (e: e.type == "rsa" || e.type == "ed25519") config.services.openssh.hostKeys
    )
  );
}
