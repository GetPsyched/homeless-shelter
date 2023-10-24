# list all the available recipes
default:
    @just --list --unsorted

# list all exisiting generations
list:
    @sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# build the configuration and make it the default boot option, but don't activate it until the next reboot
boot HOST:
    @sudo nixos-rebuild boot --flake .#{{HOST}} && reboot

# build the configuration and activate it, and make it the default boot option
switch HOST:
    @sudo nixos-rebuild switch --flake .#{{HOST}}

# build the configuration and activate it, but don't add it to the bootloader menu
test HOST:
    @sudo nixos-rebuild test --flake .#{{HOST}}

# don't build the new configuration, but use the previous generation instead
rollback HOST:
    @sudo nixos-rebuild boot --flake .#{{HOST}} --rollback

# garbage collect all older generations
yoink:
    @sudo nix-collect-garbage -d
