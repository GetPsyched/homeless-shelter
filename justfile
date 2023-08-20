# list all the available recipes
default:
    @just --list --unsorted

# format all nix files
format:
    @nixpkgs-fmt **/*.nix **/**/*.nix **/**/**/*.nix

# list all exisiting generations
list:
    @sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# build the configuration and make it the default boot option, but don't activate it until the next reboot
boot:
    @sudo nixos-rebuild boot --flake .#potato && reboot

# build the configuration and activate it, and make it the default boot option
switch:
    @sudo nixos-rebuild switch --flake .#potato

# build the configuration and activate it, but don't add it to the bootloader menu
test:
    @sudo nixos-rebuild test --flake .#potato

# don't build the new configuration, but use the previous generation instead
rollback:
    @sudo nixos-rebuild boot --flake .#potato --rollback

# garbage collect all older generations
yoink:
    @sudo nix-collect-garbage -d
