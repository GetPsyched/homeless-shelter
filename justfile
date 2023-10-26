# list all the available recipes
default:
    @just --list --unsorted

# list all existing generations
list:
    @sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# build the configuration, make it the default boot option, and reboot
boot HOST:
    #!/bin/sh -e
    sudo nixos-rebuild boot --flake .#{{HOST}}
    reboot

# build the configuration, make it the default boot option, and immediately activate it
switch HOST:
    @sudo nixos-rebuild switch --flake .#{{HOST}}

# build the configuration and activate it, but don't add it to the boot menu
test HOST:
    @sudo nixos-rebuild test --flake .#{{HOST}}

# epic fail, rollback to the previous generation
rollback HOST:
    @sudo nixos-rebuild boot --flake .#{{HOST}} --rollback

# say goodbye to all your older generations
yoink:
    @sudo nix-collect-garbage -d
