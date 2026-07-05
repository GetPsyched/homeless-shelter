{ config, ... }: {
  users.users.actual = {
    group = config.users.groups.actual.name;
    isSystemUser = true;
  };
  users.groups.actual = { };

  services.actual = {
    enable = true;

    user = config.users.users.actual.name;
    group = config.users.users.actual.group;
  };

  persist.data.directories = [ config.services.actual.settings.dataDir ];
}
