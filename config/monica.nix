{ config, lib, ... }:
{
  services.monica = {
    enable = true;

    appKeyFile = "${config.services.monica.dataDir}/app-key";

    database.createLocally = false;
    config = {
      DB_DATABASE = lib.mkForce "${config.services.monica.dataDir}/db.sqlite";
      DB_HOST = lib.mkForce "";
      DB_PORT = lib.mkForce "";
      DB_USERNAME = lib.mkForce "";
    };
  };

  persist.data.directories = [
    {
      directory = "${config.services.monica.dataDir}";
      user = config.services.monica.user;
    }
  ];
}
