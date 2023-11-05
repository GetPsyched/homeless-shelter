[
  {
    name = "profiles";
    bookmarks = [
      { name = "GitHub"; url = "https://github.com/GetPsyched"; }
      { name = "LeetCode"; url = "https://leetcode.com/GetPsyched"; }
      { name = "LinkedIn"; url = "https://www.linkedin.com/in/priyanshutr"; }
    ];
    toolbar = true;
  }
  {
    name = "nksss";
    bookmarks =
      let
        base-url = "https://github.com/nkss-dev";
        github = name: project: {
          inherit name;
          url = "${base-url}/${project}";
        };
      in
      [
        (github "gh-main" "")
        (github "gh-atlas" "atlas")
        (github "gh-breadboard" "breadboard")
        (github "gh-lighthouse" "lighthouse")
        (github "gh-project-hyperlink" "project-hyperlink")
        (github "gh-node-modules" "node-modules")
        { name = "nkss-drive"; url = "https://drive.google.com/drive/folders/1U2taK5kEhOiUJi70ZkU2aBWY83uVuMmD"; }
        { name = "railway"; url = "https://railway.app/project/69531a0b-78b7-4a71-9df4-3a8db9703b69"; }
        { name = "design"; url = "https://www.figma.com/file/RbT3UiwKwbN71GwU8Zz5HS/NKSSS?node-id=321%3A154"; }
      ];
    toolbar = true;
  }
  {
    name = "discord.py";
    bookmarks = [
      { name = "repo"; url = "https://github.com/Rapptz/discord.py"; }
      { name = "bot"; url = "https://github.com/Rapptz/RoboDanny"; }
      {
        name = "docs";
        bookmarks =
          let
            base-url = "https://discordpy.readthedocs.io/en/latest";
          in
          [
            { name = "main"; url = "${base-url}/api.html"; }
            { name = "interactions"; url = "${base-url}/interactions/api.html"; }
            { name = "ext/commands"; url = "${base-url}/ext/commands/api.html"; }
            { name = "ext/tasks"; url = "${base-url}/ext/tasks/index.html"; }
          ];
      }
    ];
  }
  {
    name = "image-utils";
    bookmarks = [
      { name = "color-picker"; url = "https://imagecolorpicker.com"; }
      { name = "free-svgs"; url = "https://www.svgrepo.com"; }
      { name = "palette"; url = "https://www.hexcolortool.com"; }
    ];
  }
]
