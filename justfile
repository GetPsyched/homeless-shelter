# list all the available recipes
default:
    @just --list --unsorted

# list all existing generations
list:
    @nixos-rebuild list-generations

# update the commit hashes in flake.lock
update:
    @nix flake update --commit-lock-file

# build the configuration
build specialisation="":
    #!/bin/sh -e
    if [ -z "{{specialisation}}" ]; then
        sudo nixos-rebuild build --option builders '' --option eval-cache false --flake .
    else
        sudo nixos-rebuild build --option builders '' --option eval-cache false --specialisation {{specialisation}} --flake .
    fi
    rm result

# build the configuration and activate it, but don't add it to the boot menu
test specialisation="":
    #!/bin/sh -e
    if [ -z "{{specialisation}}" ]; then
        sudo nixos-rebuild switch --option builders '' --option eval-cache false --flake .
    else
        sudo nixos-rebuild switch --option builders '' --option eval-cache false --specialisation {{specialisation}} --flake .
    fi

# build the configuration, make it the default boot option, and immediately activate it
switch specialisation="":
    #!/bin/sh -e
    if [ -z "{{specialisation}}" ]; then
        sudo nixos-rebuild switch --option builders '' --flake git+file:$PWD?ref=HEAD
    else
        sudo nixos-rebuild switch --option builders '' --specialisation {{specialisation}} --flake git+file:$PWD?ref=HEAD
    fi

# build the configuration, make it the default boot option
boot:
    @sudo nixos-rebuild boot --flake git+file:$PWD?ref=HEAD --option builders ''

# build the configuration, make it the default boot option, and reboot
reboot:
    #!/bin/sh -e
    sudo nixos-rebuild boot --flake git+file:$PWD?ref=HEAD --option builders ''
    reboot

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
