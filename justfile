# dry-run this config
default:
    sudo nixos-rebuild dry-activate --flake .#potato

# format all nix files
format:
    nixpkgs-fmt **/*.nix
