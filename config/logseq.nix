{ pkgs, ... }:
{
  users.users.primary.packages = [ pkgs.logseq ];

  persist.data.homeDirectories = [ "logseq" ];
  persist.state.homeDirectories = [
    ".config/Logseq"
    ".logseq"
  ];
}
