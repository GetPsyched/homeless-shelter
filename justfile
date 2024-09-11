# list all the available recipes
default:
    @just --list --unsorted

# list all existing generations
list:
    @sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# update the commit hashes in flake.lock
update:
    @nix flake update --commit-lock-file

# build the configuration, make it the default boot option
boot:
    @sudo nixos-rebuild boot --flake git+file:$PWD?ref=HEAD

# build the configuration, make it the default boot option, and reboot
reboot:
    #!/bin/sh -e
    sudo nixos-rebuild boot --flake git+file:$PWD?ref=HEAD
    reboot

# build the configuration, make it the default boot option, and immediately activate it
switch:
    @sudo nixos-rebuild switch --flake git+file:$PWD?ref=HEAD

# build the configuration and activate it, but don't add it to the boot menu
test:
    @sudo nixos-rebuild test --flake . --option eval-cache false

# epic fail, rollback to the previous generation
rollback:
    @sudo nixos-rebuild boot --flake . --rollback

# say goodbye to all your older generations
yeet:
    @sudo nix-collect-garbage --delete-old

# build and flash a configuration ISO into a storage media
flash HOST DISK:
    #!/bin/sh -e
    nix build .#nixosConfigurations.{{HOST}}.config.system.build.isoImage

    echo "Copying the ISO to the disk..."
    sudo cp result/iso/{{HOST}}.iso {{DISK}}
    rm result
