# list all the available recipes
default:
    @just --list --unsorted

# list all existing generations
list:
    @sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# build the configuration, make it the default boot option
boot:
    @hostname | sudo nixos-rebuild boot --flake .#$(cat)

# build the configuration, make it the default boot option, and reboot
reboot:
    #!/bin/sh -e
    hostname | sudo nixos-rebuild boot --flake .#$(cat)
    reboot

# build the configuration, make it the default boot option, and immediately activate it
switch:
    @hostname | sudo nixos-rebuild switch --flake .#$(cat)

# build the configuration and activate it, but don't add it to the boot menu
test:
    @hostname | sudo nixos-rebuild test --flake .#$(cat) --option eval-cache false

# epic fail, rollback to the previous generation
rollback:
    @hostname | sudo nixos-rebuild boot --flake .#$(cat) --rollback

# say goodbye to all your older generations
yoink:
    @sudo nix-collect-garbage -d

# build and flash a configuration ISO into a storage media
flash HOST DISK:
    #!/bin/sh -e
    nix build .#nixosConfigurations.{{HOST}}.config.system.build.isoImage

    echo "Copying the ISO to the disk..."
    sudo cp result/iso/{{HOST}}.iso {{DISK}}
    rm result

nixops HOST:
    nixops create -d {{HOST}} ./hosts/{{HOST}}/configuration.nix ./system/nixops.nix

nixops-deploy HOST:
    nixops deploy -d {{HOST}}
