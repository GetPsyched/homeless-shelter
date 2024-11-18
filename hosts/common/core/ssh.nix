{
  persist.data.directories = [ "/etc/ssh" ];
  # persist.data.homeDirectories = [ ".ssh" ];

  persist.data.homeDirectories = [
    ".ssh"
    "backgrounds"
    "dump"
    "iso"
    "obsidian-vault"
  ];
  persist.state.homeDirectories = [
    "src"
    ".config/mindmap"
    ".config/obsidian"
    ".config/spotify"
    ".local/share/zed"
    ".railway"
    ".rustup"
    ".config/heroic"
    ".config/PCSX2"
    ".local/share/applications"
    ".local/share/activitywatch"
    ".local/share/zoxide"
    ".local/share/direnv/allow"
    ".mozilla/firefox/main"
    ".thunderbird/main"
    ".local/state/wireplumber"
    ".local/share/bottles"
    ".local/share/icons/hicolor"
    ".local/share/Terraria"
    ".local/share/wineprefixes"
  ];
  persist.misc.homeDirectories = [
    ".local/share/ATLauncher"
    ".local/share/PCSX2"
    ".heroic"
    ".steam-games"
    "bottles"
    "My Games"
  ];
  persist.state.homeFiles = [
    ".bash_history"
    ".local/share/warp/accepted-tos.txt"
    ".config/gh/hosts.yml"
  ];
  persist.cache.homeDirectories = [ ".cache" ];
}
