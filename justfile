# list all the available recipes
default:
    @just --list --unsorted

# list all existing generations
list:
    @sudo darwin-rebuild --list-generations

# update the commit hashes in flake.lock
update:
    @nix flake update --commit-lock-file

# build the configuration
build:
    #!/bin/sh -e
    sudo darwin-rebuild build --option builders '' --option eval-cache false --flake .
    rm result

# build the configuration and activate it, but don't add it to the boot menu
test:
    @sudo darwin-rebuild check --option builders '' --option eval-cache false --flake .

# build the configuration, make it the default boot option, and immediately activate it
switch:
    @sudo darwin-rebuild switch --option builders '' --flake git+file:$PWD?ref=HEAD

# epic fail, rollback to the previous generation
rollback:
    @sudo nixos-rebuild boot --flake . --rollback

# say goodbye to all your older generations
yeet:
    @sudo nix-collect-garbage --delete-old

# build and flash a configuration ISO into a storage media
flash HOST DISK:
    #!/bin/sh -e
    nixos-rebuild --option builders '' build-image --image-variant iso-installer --flake .#{{HOST}}

    echo "Copying the ISO to the disk..."
    sudo cp result/iso/{{HOST}}.iso {{DISK}}
    rm result
